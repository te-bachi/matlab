
classdef Robot < handle
    
    properties (Constant)
        ARM_1_LENGTH = 5
        ARM_2_LENGTH = 3
        
        ARM_1_ORIENT_X = -45
        ARM_1_ORIENT_Y = 0
        ARM_1_ORIENT_Z = -30
        
        ARM_2_ORIENT_X = 45
        ARM_2_ORIENT_Y = 0
        ARM_2_ORIENT_Z = 0
    end
    
    properties
        q1_x_degree  % Winkel [Grad]
        q1_y_degree  % Winkel [Grad]
        q1_z_degree  % Winkel [Grad]
        q2_x_degree  % Winkel [Grad]
        q2_y_degree  % Winkel [Grad]
        q2_z_degree  % Winkel [Grad]
        
        q1           % Winkel [Radian]
        q2           % Winkel [Radiant]
        l1
        l2
        A1
        A2
        A3
        A4
        B1
        B2
        B3
        B4
        origin
        p0
        p1
        p2
        p3
        c0
        c1
        c2
        c3
        c4
        h_arm_1
        h_arm_2
        h_arm_3
        h_arm_4
        h_point_1
        h_point_2
        h_point_3
        h_point_4
    end
    
    methods
        function obj = Robot()
            
            %--------------------------------------------------------------
            % Roboter mit Armlängen und Gelenken
            obj.q1_x_degree = obj.ARM_1_ORIENT_X;
            obj.q1_y_degree = obj.ARM_1_ORIENT_Y;
            obj.q1_z_degree = obj.ARM_1_ORIENT_Z;
            obj.q1          = deg2rad(obj.q1_x_degree);
            obj.l1          = obj.ARM_1_LENGTH;

            obj.q2_x_degree = obj.ARM_2_ORIENT_X;
            obj.q2_y_degree = obj.ARM_2_ORIENT_Y;
            obj.q2_z_degree = obj.ARM_2_ORIENT_Z;
            obj.q2          = deg2rad(obj.q2_x_degree);
            obj.l2          = obj.ARM_2_LENGTH;
            
            %--------------------------------------------------------------
            % Nullpunkt
            obj.origin = [
                0;      % x
                0;      % y
                0;      % z
                1;      % homogen (nur zum rechnen)
            ];
            
            %--------------------------------------------------------------
            % Koordinatensystem
            obj.c0 = Coordinate();
            obj.c1 = Coordinate();
            obj.c2 = Coordinate();
            obj.c3 = Coordinate();

            %--------------------------------------------------------------
            % Roboter Arme
            %
            % Linie muss Anfang und Ende haben:
            %
            % (x1/y1)          (x2/y2)
            %
            %    x----------------x
            %

            % Anfang   Ende
            %    |      |
            obj.A1 = [
                 0,       0; % x
                 0,       0; % y
                 0, -obj.l1; % z
                 0,       0; % homogen (nur zum rechnen)
            ];

            obj.A2 = [
                 0,       0;
                 0,       0;
                 0, -obj.l2;
                 0,       0;
            ];

            obj.A3 = [
                 0,       0;
                 0,       0;
                 0,       0;
                 0,       0;
            ];
        end
        
        function transform(obj, q)
            
            %--------------------------------------------------------------
            % Homogene Transformationsmatrizen
%             obj.q1_x_degree = obj.q1_x_degree + 1;
%             obj.q1          = deg2rad(obj.q1_x_degree);
%             
%             obj.q2_x_degree = obj.q2_x_degree + 5;
%             obj.q2          = deg2rad(obj.q2_x_degree);
%             
%             T_0_1 = Transformation([    0; 0; 0], 0, obj.q1, 0);
%             T_1_2 = Transformation(obj.A1(1:3,2), 0, obj.q2, 0);
%             T_2_3 = Transformation(obj.A2(1:3,2), 0,      0, 0);
        
            %--------------------------------------------------------------
            % Homogene Transformationsmatrizen
            T_0_1 = Transformation([    0; 0; 0], deg2rad(obj.q1_x_degree), deg2rad(obj.q1_y_degree), deg2rad(obj.q1_z_degree));
            T_1_2 = Transformation(obj.A1(1:3,2), deg2rad(obj.q2_x_degree), deg2rad(obj.q2_y_degree), deg2rad(obj.q2_z_degree));
            T_2_3 = Transformation(obj.A2(1:3,2), 0, 0, 0);
            
            T01 = T_0_1;
            T02 = T_0_1 * T_1_2;
            T03 = T_0_1 * T_1_2 * T_2_3;
            
            T01 = T01.m;
            T02 = T02.m;
            T03 = T03.m;
            
            %--------------------------------------------------------------
            % Arme transformieren

            % Beispiel:
            % A1(:,2) = A(Zeile,Spalte) = A(alle Zeilen, Spalte 2)
            %
            %             Spalte 2
            %               |
            %       [  a,  *b  ]                 [ b ]
            %   A = [  d,  *e  ]    =>  A(:,2) = [ e ]
            %       [  g,  *h  ]                 [ h ]


            % (x1/y1)          (x2/y2)
            %    |       A1       |       A2
            %    x----------------x----------------x------...
            %                     |                |
            %                  (x1/y1)          (x2/y2)

            %         Translation vom 
            %         Ursprung zu den Punkten
            %         für Anfang (1. Spalte)
            %         und Ende (2. Spalte)
            %         (darum Matrix erzeugen)
            obj.B1   =                                (T01 * obj.A1);
            obj.B2   = [obj.B1(:,2) obj.B1(:,2)]    + (T02 * obj.A2);
            obj.B3   = [obj.B2(:,2) obj.B2(:,2)]    + (T03 * obj.A3);
            
            
            %--------------------------------------------------------------
            % Nullpunkt transformieren
            obj.p0 = T01 * obj.origin;
            obj.p1 = T02 * obj.origin;
            obj.p2 = T03 * obj.origin;
            
            %--------------------------------------------------------------
            % Koordinatensystem transformieren
            obj.c1.transform(obj.origin,  T01);
            obj.c2.transform(obj.B1(:,2), T02);
            obj.c3.transform(obj.B2(:,2), T03);
            
        end
        
        function plotArms(obj)
            %--------------------------------------------------------------
            % Plotte Arme
            %         Anfang Ende       Anf Ende       Anf Ende
            %              | |            | |            | |
            obj.h_arm_1 = plot3(obj.B1(1,1:2), obj.B1(2,1:2), obj.B1(3,1:2), 'Color', 'red');
            obj.h_arm_2 = plot3(obj.B2(1,1:2), obj.B2(2,1:2), obj.B2(3,1:2), 'Color', 'green');
            obj.h_arm_3 = plot3(obj.B3(1,1:2), obj.B3(2,1:2), obj.B3(3,1:2), 'Color', 'blue');
            %            |              |              |
            %            x              y              z
        end
        
        function plotPoints(obj)
            obj.h_point_1 = scatter3(obj.p0(1), obj.p0(2), obj.p0(3), 'MarkerEdgeColor', orange);
            obj.h_point_2 = scatter3(obj.p1(1), obj.p1(2), obj.p1(3), 'MarkerEdgeColor', 'blue');
            obj.h_point_3 = scatter3(obj.p2(1), obj.p2(2), obj.p2(3), 'MarkerEdgeColor', 'blue');
        end
        
        function plotCoordinates(obj)
            obj.c0.plot('s');
            obj.c1.plot();
            obj.c2.plot();
            obj.c3.plot();
        end
        
        function reset(obj)
            delete(obj.h_arm_1);
            delete(obj.h_arm_2);
            delete(obj.h_arm_3);
            delete(obj.h_point_1);
            delete(obj.h_point_2);
            delete(obj.h_point_3);
            
            obj.c0.reset();
            obj.c1.reset();
            obj.c2.reset();
            obj.c3.reset();
        end
        
        function delete(obj)
            obj.reset();
            
            delete(obj.c0);
            delete(obj.c1);
            delete(obj.c2);
            delete(obj.c3);
        end
        
    end
end