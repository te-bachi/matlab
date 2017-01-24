function y=BSplineBasis(order, nodes,j, x)
if(order == 1)
    if(nodes(j+1) == nodes(j+2))
        y=(nodes(j)<=x).*(x<=nodes(j+1));   % letztes Intervall inkl. Endpunkt!
    else
        y=(nodes(j)<=x).*(x<nodes(j+1));
    end
else
    y=zeros(1,length(x));
    if((nodes(j+order-1)-nodes(j)) ~= 0)
        y=(x-nodes(j))/(nodes(j+order-1)-nodes(j)).*BSplineBasis(order-1,nodes,j,x);
    end
    if((nodes(j+order)-nodes(j+1)) ~= 0)
        y=y+(nodes(j+order)-x)/(nodes(j+order)-nodes(j+1)).*BSplineBasis(order-1,nodes,j+1,x);
    end
end

    