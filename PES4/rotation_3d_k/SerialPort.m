classdef SerialPort < handle
    properties (Constant)
    end
    
    properties
        q1_old
        q2_old
        p1_old
        p2_old
        s
    end
    
    methods
        function obj = SerialPort(varargin)
            obj.q1_old = [0; 0; 0; 0];
            obj.q2_old = [0; 0; 0; 0];
            obj.p1_old = [0; 0; 0];
            obj.p2_old = [0; 0; 0];
            
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
        
        function [q1, p1, q2, p2] = read(obj)
            if obj.s.BytesAvailable > 0
                % acceleration, quaternion
                [rxBuf, count, msg] = fscanf(obj.s, '[ %d ] [ %f, %f, %f, %f ] [ %f, %f, %f ] [ %f, %f, %f, %f ]  [ %f, %f, %f ]\n');
                q1 = rxBuf(2:5)';
                p1 = rxBuf(6:8)';
                q2 = rxBuf(9:12)';
                p2 = rxBuf(13:15)';
                
                obj.q1_old = q1;
                obj.p1_old = p1;
                obj.q2_old = q2;
                obj.p2_old = p2;
            else
                q1 = obj.q1_old;
                p1 = obj.p1_old;
                q2 = obj.q2_old;
                p2 = obj.p2_old;
            end
        end
        
        function delete(obj)
            fclose(obj.s);
        end
    end
    
end
