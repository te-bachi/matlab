
classdef Robot < handle
    
    properties
        q1
        q2
        q3
        l1
        l2
        l3
        A1
        A2
        A3
        A4
        B1
        B2
        B3
        B4
        T_0_1
        T_1_2 
        T_2_3 
        T_3_4
        origin
        p0
        p1
        p2
        p3
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
            obj.q1 = deg2rad(60);
            obj.l1 = 6;

            obj.q2 = deg2rad(-110);
            obj.l2 = 4;

            obj.q3 = deg2rad(-110);
            obj.l3 = 2;
            
            %--------------------------------------------------------------
            % Nullpunkt
            obj.origin = [
                0;      % x
                0;      % y
                0;      % z
                1;      % homogen (nur zum rechnen)
            ];

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
                 0,    obj.l1; % x
                 0,     0; % y
                 0,     0; % z
                 0,     0; % homogen (nur zum rechnen)
            ];

            obj.A2 = [
                 0,    obj.l2;
                 0,     0;
                 0,     0;
                 0,     0;
            ];

            obj.A3 = [
                 0,    obj.l3;
                 0,     0;
                 0,     0;
                 0,     0;
            ];

            obj.A4 = [
                 0,     0;
                 0,     0;
                 0,     0;
                 0,     0;
            ];
        
            %--------------------------------------------------------------
            % Homogene Transformationsmatrizen
            obj.T_0_1 = [
                cos(obj.q1),   -sin(obj.q1),          0,    0;
                sin(obj.q1),    cos(obj.q1),          0,    0;
                      0,          0,          1,    0;
                      0,          0,          0,    1;
            ];

            obj.T_1_2 = [
                cos(obj.q2),   -sin(obj.q2),          0,    obj.l1;
                sin(obj.q2),    cos(obj.q2),          0,    0;
                      0,          0,          1,    0;
                      0,          0,          0,    1;
            ];

            obj.T_2_3 = [
                cos(obj.q3),   -sin(obj.q3),          0,    obj.l2;
                sin(obj.q3),    cos(obj.q3),          0,    0;
                      0,          0,          1,    0;
                      0,          0,          0,    1;
            ];

            obj.T_3_4 = [
                      1,          0,          0,    obj.l3;
                      0,          1,          0,    0;
                      0,          0,          1,    0;
                      0,          0,          0,    1;
            ];
        end
        
        function transform(obj)
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
            obj.B1   =                                 obj.T_0_1                                     * obj.A1;
            obj.B2   = [obj.B1(:,2) obj.B1(:,2)]    + (obj.T_0_1 * obj.T_1_2                         * obj.A2);
            obj.B3   = [obj.B2(:,2) obj.B2(:,2)]    + (obj.T_0_1 * obj.T_1_2 * obj.T_2_3             * obj.A3);
            obj.B4   = [obj.B3(:,2) obj.B3(:,2)]    + (obj.T_0_1 * obj.T_1_2 * obj.T_2_3 * obj.T_3_4 * obj.A4);
            
            
            %--------------------------------------------------------------
            % Nullpunkt transformieren
            obj.p0 = obj.T_0_1                                      * obj.origin;
            obj.p1 = obj.T_0_1 * obj.T_1_2                          * obj.origin;
            obj.p2 = obj.T_0_1 * obj.T_1_2 * obj.T_2_3              * obj.origin;
            obj.p3 = obj.T_0_1 * obj.T_1_2 * obj.T_2_3 * obj.T_3_4  * obj.origin;
        end
        
        function plotArms(obj)
            %--------------------------------------------------------------
            % Plotte Arme
            %         Anfang Ende       Anf Ende       Anf Ende
            %              | |            | |            | |
            obj.h_arm_1 = plot3(obj.B1(1,1:2), obj.B1(2,1:2), obj.B1(3,1:2), 'Color', 'red');
            obj.h_arm_2 = plot3(obj.B2(1,1:2), obj.B2(2,1:2), obj.B2(3,1:2), 'Color', 'green');
            obj.h_arm_3 = plot3(obj.B3(1,1:2), obj.B3(2,1:2), obj.B3(3,1:2), 'Color', 'blue');
            obj.h_arm_4 = plot3(obj.B4(1,1:2), obj.B4(2,1:2), obj.B4(3,1:2), 'Color', 'red');
            %            |              |              |
            %            x              y              z
        end
        
        function plotPoints(obj)
            obj.h_point_1 = scatter3(obj.p0(1), obj.p0(2), obj.p0(3), 'MarkerEdgeColor', orange);
            obj.h_point_2 = scatter3(obj.p1(1), obj.p1(2), obj.p1(3), 'MarkerEdgeColor', 'blue');
            obj.h_point_3 = scatter3(obj.p2(1), obj.p2(2), obj.p2(3), 'MarkerEdgeColor', 'blue');
            obj.h_point_4 = scatter3(obj.p3(1), obj.p3(2), obj.p3(3), 'MarkerEdgeColor', 'red');
        end
        
        function reset(obj)
            delete(obj.h_arm_1);
            delete(obj.h_arm_2);
            delete(obj.h_arm_3);
            delete(obj.h_arm_4);
            delete(obj.h_point_1);
            delete(obj.h_point_2);
            delete(obj.h_point_3);
            delete(obj.h_point_4);
        end
        
    end
end