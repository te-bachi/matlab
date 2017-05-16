%
% coord als Matrix
% coord = [  0,     1,       0,     0;     <-- x
%            0,     0,       1,     0;     <-- y
%            0,     0,       0,     1;     <-- z
%            0,     0,       0,     0;  ]; <-- homogen
%            |      |        |      |
%            | x-Koordinate  |  z-Koordinate
%           Null         y-Koordinate
%

classdef Coordinate < handle
    
    properties (Constant)
        WIDTH_NORMAL = 2.0
        WIDTH_THIN   = 0.25
        WIDTH_BOLD   = 3.0
    end
    
    properties
        origin
        coord
        h1
        h2
        h3
    end
    
    methods
        
        function obj = Coordinate()
            obj.origin = [
                 0,     100,     0,     0; % x
                 0,     0,     100,     0; % y
                 0,     0,     0,     100; % z
                 0,     0,     0,     0; % h
            ];
            obj.coord = obj.origin;
        end
        
        function transform(obj, trans, rot)
            obj.coord = [trans, trans, trans, trans] + rot * obj.origin;
        end
        
        function plot(obj, style)

            % Argument behandel
            switch nargin
                case 2
                    if (style == 'b')
                        width = obj.WIDTH_NORMAL;
                    elseif (style == 's')
                        width = obj.WIDTH_THIN;
                    end
                otherwise
                    width = obj.WIDTH_NORMAL;
            end

            % X Koordinate
            obj.h1 = plot3([obj.coord(1,1) obj.coord(1,2)],...  % x Vektor
                           [obj.coord(2,1) obj.coord(2,2)],...  % y Vektor
                           [obj.coord(3,1) obj.coord(3,2)],...  % z Vektor
                           'Color', 'r', 'LineWidth', width);

            % Y Koordinate
            obj.h2 = plot3([obj.coord(1,1) obj.coord(1,3)],...
                           [obj.coord(2,1) obj.coord(2,3)],...
                           [obj.coord(3,1) obj.coord(3,3)],...
                           'Color', 'g', 'LineWidth', width);

            % Z Koordinate
            obj.h3 = plot3([obj.coord(1,1) obj.coord(1,4)],...
                           [obj.coord(2,1) obj.coord(2,4)],...
                           [obj.coord(3,1) obj.coord(3,4)],...
                           'Color', 'b', 'LineWidth', width);
        end
        
        function reset(obj)
            delete(obj.h1);
            delete(obj.h2);
            delete(obj.h3);
        end
        
        function delete(obj)
            reset(obj);
        end
    end
end