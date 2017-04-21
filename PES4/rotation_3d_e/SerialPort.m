classdef SerialPort < handle
    properties (Constant)
    end
    
    properties
        q_old
        s
    end
    
    methods
        function obj = SerialPort()
            q_old = [0; 0; 0; 0];
            
            serialInfo = instrhwinfo('serial');
            obj.s = serial(serialInfo.AvailableSerialPorts{1}, 'BaudRate', 115200);
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
        
        function q = read(obj)
            if obj.s.BytesAvailable > 0
                % acceleration, quaternion
                [rxBuf, count, msg] = fscanf(obj.s, '%f, %f, %f, %f, %f, %f, %f\n');
                a = rxBuf(1:3)';
                q = rxBuf(4:7)';
                
                obj.q_old = q;
            else
                q = obj.q_old;
            end
        end
        
        function delete(obj)
            fclose(obj.s);
        end
    end
    
end
