classdef MainFigure < handle
    properties (Constant)
        TIMER_DELAY  = 1.0
        TIMER_PERIOD = 0.1
    end
    
    properties
        Figure
        StartDelayTimer
        UpdateTimer
        RobotInst
        SerialUpper
        SerialLower
        QuatOriginUpper
        QuatOriginLower
    end
    
    methods
        function obj = MainFigure()
            
            %--------------------------------------------------------------
            obj.SerialUpper = SerialPort('COM7');
            obj.SerialLower = SerialPort('COM3');
            
            %--------------------------------------------------------------
            obj.Figure = figure();
            
            win = [ -8, 8, -8, 8, -8, 8];
            axis equal;
            axis(win);
    
            hold on;
            box  on;
            
            grid on;
            grid minor;

            set(gca,'CameraViewAngleMode','manual');
            set(gca,'CameraViewAngle',10);
            set(gca,'CameraPosition', [60.0, 60.0, 35.0]);
            set(gca,'DataAspectRatio',[1 1 1]);
            
            %--------------------------------------------------------------
            obj.RobotInst = Robot();
            
            %--------------------------------------------------------------
            obj.StartDelayTimer = timer();
            set(obj.StartDelayTimer, 'TimerFcn', {@StartDelayTimerFcn, obj});
            set(obj.StartDelayTimer, 'StartDelay', obj.TIMER_DELAY / 2);
            set(obj.StartDelayTimer, 'ExecutionMode', 'singleShot');
            start(obj.StartDelayTimer);
            
            obj.UpdateTimer = timer();
            set(obj.UpdateTimer, 'TimerFcn', {@UpdateTimerFcn, obj});
            set(obj.UpdateTimer, 'StartDelay', obj.TIMER_DELAY);
            set(obj.UpdateTimer, 'Period', obj.TIMER_PERIOD);
            set(obj.UpdateTimer, 'ExecutionMode', 'fixedRate');
            start(obj.UpdateTimer);
            
            % Set callbacks at the end,
            % so that all properties are valid
            set(obj.Figure, 'KeyPressFcn', @obj.KeyPressEvent);
            set(obj.Figure, 'CloseRequestFcn', @obj.CloseRequestEvent);
        
            function StartDelayTimerFcn(src, event, obj)
                disp('StartDelayTimerFcn');
                obj.QuatOriginUpper  = obj.SerialUpper.read();
                obj.QuatOriginLower  = obj.SerialLower.read();
                disp('obj.QuatOriginUpper = ');
                disp(obj.QuatOriginUpper);
                disp('obj.QuatOriginLower = ');
                disp(obj.QuatOriginLower);
                
                obj.QuatOriginUpper  = quatinv(obj.QuatOriginUpper);
                obj.QuatOriginLower  = quatinv(obj.QuatOriginLower);
                
            end
            function UpdateTimerFcn(src, event, obj)
                TimerEvent(obj, src, event);
            end
        end
        
        function update(obj)
            qUpper = obj.SerialUpper.read();
            qUpperDiff = quatmultiply(qUpper, obj.QuatOriginUpper);
            qLower = obj.SerialLower.read();
            qLowerDiff = quatmultiply(qLower, obj.QuatOriginLower);
            obj.RobotInst.transform(qUpperDiff, qLowerDiff);
            obj.RobotInst.plotArms();
            obj.RobotInst.plotPoints();
            obj.RobotInst.plotCoordinates();
        end
        
        function TimerEvent(obj, src, event)
            %fprintf('Running...\n');
            obj.RobotInst.reset();
            obj.update();
        end
        
        function KeyPressEvent(obj, src, event)
            delete(obj)
        end
        
        function CloseRequestEvent(obj, src, event)
            delete(obj)
        end
        
        function delete(obj)
            stop(obj.UpdateTimer);
            delete(obj.StartDelayTimer);
            delete(obj.UpdateTimer);
            delete(obj.Figure);
            delete(obj.RobotInst);
            delete(obj.SerialUpper);
            delete(obj.SerialLower);
        end
    end
    
end

