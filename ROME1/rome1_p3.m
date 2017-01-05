
% startup_rvc;

%{
% === 1 ===
R = rotx(pi/2);
tranimate(R);

% === 2 ===
R = rotz(0.2)*roty(-0.3)*rotz(0.5);
tranimate(R);

% === 3 ===
tr2eul(R);

%}

%{
>> R = eye(3)
     1     0     0
     0     1     0
     0     0     1

>> tr2eul(R)
     0     0     0
%}

%{
___---=== EULER ===---___
 
=== X ===
R = rotx(pi/2)
    1.0000         0         0
         0    0.0000   -1.0000
         0    1.0000    0.0000

>> tr2eul(R)
   -1.5708    1.5708    1.5708

=== Y ===

R = roty(pi/2)
    0.0000         0    1.0000
         0    1.0000         0
   -1.0000         0    0.0000

>> tr2eul(R)
         0    1.5708         0

=== Z ===

>> R = rotz(pi/2)
    0.0000   -1.0000         0
    1.0000    0.0000         0
         0         0    1.0000

>> tr2eul(R)
         0         0    1.5708
%}

%{
___---=== Quaternion ===---___
 
=== X ===
R = rotx(pi/2)
    1.0000         0         0
         0    0.0000   -1.0000
         0    1.0000    0.0000

>> Quaternion(R)
0.70711 < 0.70711, 0, 0 >

=== Y ===

R = roty(pi/2)
    0.0000         0    1.0000
         0    1.0000         0
   -1.0000         0    0.0000

>> Quaternion(R)
0.70711 < 0, 0.70711, 0 >

=== Z ===

>> R = rotz(pi/2)
    0.0000   -1.0000         0
    1.0000    0.0000         0
         0         0    1.0000

>> Quaternion(R)
0.70711 < 0, 0, 0.70711 >

=== X 45° / Y 45° ===

>> R = rotx(pi/4)*roty(pi/4)
    0.7071         0    0.7071
    0.5000    0.7071   -0.5000
   -0.5000    0.7071    0.5000

>> Quaternion(R)
0.85355 < 0.35355, 0.35355, 0.14645 >

%}

%{
R1 = [  1  0  0 0.8
        0 -1  0 0.0
        0  0 -1 0.5
        0  0  0   0 ];
    
q1 = scara.ikine(R1, [0 1 0 1], [1 1 1 0 0 1], 'alpha', 0.1);
% -1.0472    2.0944   -1.0472    0.5000


R2 = [  1  0  0 0.8
        0 -1  0 0.8
        0  0 -1 0.2
        0  0  0   0 ];
q2 = scara.ikine(R2, [0 1 0 1], [1 1 1 0 0 1], 'alpha', 0.1);

R3 = [  1  0  0 1.0
        0 -1  0 1.0
        0  0 -1 0.8
        0  0  0   0 ];
q3 = scara.ikine(R3, [0 1 0 1], [1 1 1 0 0 1], 'alpha', 0.1);


R4 = [  1  0  0  1.0
        0 -1  0 -1.0
        0  0 -1  0.7
        0  0  0    0 ];
q4 = scara.ikine(R4, [0 1 0 1], [1 1 1 0 0 1], 'alpha', 0.1);
%}
%


%startup_rvc;

%            ?, d,     a,     alpha, sigma
L(1) = Link([0, 0.290, 0.000, 0,     0], 'modified');
L(2) = Link([0, 0.000, 0.000, -pi/2, 0], 'modified');
L(3) = Link([0, 0.000, 0.270, 0,     0], 'modified');
L(4) = Link([0, 0.374, 0.070, -pi/2, 0], 'modified');
L(5) = Link([0, 0.000, 0.000, pi/2,  0], 'modified');
L(6) = Link([0, 0.000, 0.000, -pi/2, 0], 'modified');

L(2).offset = -pi/2; % für theta


k = pi/180;
L(1).qlim = [k*-165, k*165];
L(2).qlim = [k*-110, k*110];
L(3).qlim = [k*-110, k*70];
L(4).qlim = [k*-160, k*160];
L(5).qlim = [k*-120, k*120];
L(6).qlim = [k*-400, k*400];

irb120 = SerialLink(L, 'name', 'irb120');
irb120.tool(3,4) = 0.172;
%irb120.plot([0 0 0 0 pi/4 0]);

T = irb120.fkine([0 0 0 0 pi/4 0]);
q = irb120.ikine(T, [0 0 0 0 pi/4 0], 'alpha', 0.1);

R1 = [  1  0  0 0.5
        0 -1  0 0.0
        0  0 -1 0.0
        0  0  0   0 ];
    
R2 = [  1  0  0 0.0
        0 -1  0 0.5
        0  0 -1 0.0
        0  0  0   0 ];
    
R3 = [  1  0  0 0.5
        0 -1  0 0.3
        0  0 -1 0.0
        0  0  0   0 ];
    
R4 = [  1  0  0  0.2
        0 -1  0 -0.0
        0  0 -1  0.2
        0  0  0    0 ];
    
q_first = [0 pi/4 0 0 pi/4 0];
q1 = irb120.ikine(R1, q_first, 'alpha', 0.1);
q2 = irb120.ikine(R2, q_first, 'alpha', 0.1);
q3 = irb120.ikine(R3, q_first, 'alpha', 0.1);
q4 = irb120.ikine(R4, q_first, 'alpha', 0.1);
q5 = [0 0 0 0 0 0];
q6 = [0 0 0 0 pi/4 0];

jacobian1 = irb120.jacob0(q1);
jacobian2 = irb120.jacob0(q2);
jacobian3 = irb120.jacob0(q3);
jacobian4 = irb120.jacob0(q4);
jacobian5 = irb120.jacob0(q5);
jacobian6 = irb120.jacob0(q6);

%{
det(jacobian1)
det(jacobian2)
det(jacobian3)
det(jacobian4)
det(jacobian5)
det(jacobian6)
%}

T1 = [1 0 0 0.3; 0 -1 0 0.5; 0 0 -1 0; 0 0 0 1];
T2 = [1 0 0 0.3; 0 -1 0 -0.5; 0 0 -1 0; 0 0 0 1];

t = [0:0.05:4]';
q_ja = irb120.ikine(T1, [pi/4 pi/4 0 0 pi/4 0], 'alpha', 0.1);
q_jb = irb120.ikine(T2, [-pi/4 pi/4 0 0 pi/4 0], 'alpha', 0.1);
q_j = jtraj(q1, q2, t);

T3 = ctraj(T1, T2, 40);
q_c = irb120.ikine(T3, [0 pi/7 0 0 pi/4 0], 'alpha', 0.1);
irb120.plot(q_c);
