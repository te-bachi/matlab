
a = deg2rad(60);

t1 = Transformation([0;0;0], 0, 0, a);

t2 = [
    cos(a),   -sin(a),          0,    0;
    sin(a),    cos(a),          0,    0;
         0,         0,          1,    0;
         0,         0,          0,    1;
];


t1.m
t2
