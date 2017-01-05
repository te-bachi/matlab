
A = [ 1 0; 1 1; 1 2];
e = eye(3);
w = A(:,1) + norm(A(:,1))*e(:,1);
H = e - 2*w*w'/(w'*w);

A1 = H*A;
w2 = A1(2:3,2) + norm(A1(2:3,2))*e(2:3,2);
H2 = e(2:3,2:3) - 2*w2*w2'/(w2'*w2);

Q2 = e;
Q2(2:3,2:3) = H2;
A2 = Q2*A1;
