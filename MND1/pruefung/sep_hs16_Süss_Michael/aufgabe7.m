clc,clear close all

%A7 SEP 24.01.17
n =7;
M =eye(n-1)*-1+diag(-ones(1,n-2),1)+diag(-ones(1,n-2),-1);

