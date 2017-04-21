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
        Serial
        QuatOrigin
    end
    
    methods
        function obj = MainFigure()
            
            %--------------------------------------------------------------
            obj.Serial      = SerialPort();
            
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
                obj.QuatOrigin  = obj.Serial.read();
                disp('obj.QuatOrigin = ');
                disp(obj.QuatOrigin);
                %obj.QuatOrigin  = quatinv(obj.QuatOrigin);
                obj.QuatOrigin  = quatinv(obj.QuatOrigin);
                
            end
            function UpdateTimerFcn(src, event, obj)
                TimerEvent(obj, src, event);
            end
        end
        
        function update(obj)
            q = obj.Serial.read();
            qdiff = quatmultiply(q, obj.QuatOrigin);
            obj.RobotInst.transform(qdiff);
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
            delete(obj.Serial);
        end
    end
    
end

