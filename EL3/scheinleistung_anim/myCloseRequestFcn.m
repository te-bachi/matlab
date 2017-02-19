function myCloseRequestFcn(src,callbackdata)
    global CLOSE_FIGURE;
    CLOSE_FIGURE = 1;
    delete(gcf);
end