

%syms phi_x phi_y phi_z;
phi_x = deg2rad(45);
phi_y = deg2rad(45);
phi_z = deg2rad(30);

Rx = [
          1,           0,          0;
          0,    cos(phi_x),  -sin(phi_x);
          0,    sin(phi_x),   cos(phi_x);
];

Ry = [
   cos(phi_y),           0,   sin(phi_y);
          0,           1,          0;
  -sin(phi_y),           0,   cos(phi_y);
];

Rz = [
   cos(phi_z),   -sin(phi_z),          0;
   sin(phi_z),    cos(phi_z),          0;
          0,           0,          1;
];


Rz * Rx