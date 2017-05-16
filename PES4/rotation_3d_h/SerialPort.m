classdef SerialPort < handle
    properties (Constant)
    end
    
    properties
        q1_old
        q2_old
        s
    end
    
    methods
        function obj = SerialPort(varargin)
            q_old = [0; 0; 0; 0];
            
            % Without argument: use the first
            if nargin == 0
                serialInfo = instrhwinfo('serial');
                obj.s = serial(serialInfo.AvailableSerialPorts{1}, 'BaudRate', 115200);
                
            % Use a specific port
            elseif nargin == 1
                obj.s = serial(varargin{1}, 'BaudRate', 115200);
                
            else
                
            end
            
            status = obj.s.Status;
            if (strcmp(status, 'open'))
               disp('Open');
            else
                disp('Closed');
                try
                    fopen(obj.s);
                catch ME
                    disp('Cannot open serial');
                    rethrow(ME);
                end
            end
        end
        
        function [q1, q2] = read(obj)
            if obj.s.BytesAvailable > 0
                % acceleration, quaternion
                [rxBuf, count, msg] = fscanf(obj.s, '[ %f, %f, %f, %f ] [ %f, %f, %f, %f ]\n');
                q1 = rxBuf(1:4)';
                q2 = rxBuf(5:8)';
                
                obj.q1_old = q1;
                obj.q2_old = q2;
            else
                q1 = obj.q1_old;
                q2 = obj.q2_old;
            end
        end
        
        function delete(obj)
            fclose(obj.s);
        end
    end
    
end
