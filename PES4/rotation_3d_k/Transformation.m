
classdef Transformation < handle
    properties
        m
    end
    
    methods
        function obj = Transformation(varargin)
            
            obj.m               = zeros(4,4);
            obj.m(4,4)          = 1;
            
            % 4x4 Matrix
            if nargin == 1
                obj.m           = varargin{1};
                
            % Vector + Quaternion
            elseif nargin == 2
                t               = varargin{1};
                q               = varargin{2};
                obj.m(1:3,4)    = t;
                obj.m(1:3,1:3)  = quat2rotm(q);
                
            % Vector + Euler Angle (Roll, Pitch, Yaw)
            elseif nargin == 4
                t               = varargin{1};
                roll            = varargin{2};
                pitch           = varargin{3};
                yaw             = varargin{4};
                obj.m(1:3,4)    = t;
                obj.m(1:3,1:3)  = angle2dcm(yaw, pitch, roll);
            else
                %
            end
                    
        end
        
        function c = mtimes(a, b)
            c = Transformation(a.m * b.m);
        end
        
    end
    
end