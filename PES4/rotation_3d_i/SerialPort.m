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
                % [ 1162460 ] [ 0.0607, -0.9977, 0.0289, -0.0078 ] [ 0.4371, -0.0198, -0.3667, -0.8210 ]  record=0 start=0
                [rxBuf, count, msg] = fscanf(obj.s, '[ %d ] [ %f, %f, %f, %f ] [ %f, %f, %f, %f ]  record=%d start=%d\n');
                q1 = rxBuf(2:5)';
                q2 = rxBuf(6:9)';
                
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
