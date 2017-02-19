sol=[];
k=1;

for N = [10]
    dx=1/N;
    x=(0:dx:1)';

    b=2+x.^2;
    A=diag((2/(dx^2)+1)*ones(1,N-1))+diag(-1/(dx^2)*ones(1,N-2),1)+diag(-1/(dx^2)*ones(1,N-2),-1);

    [l,r]=lrtridiag(A);
    y=forward(l,b(2:N));
    u=[0,backward(r,y)',0]'
   
  


    k=k+1;
end
