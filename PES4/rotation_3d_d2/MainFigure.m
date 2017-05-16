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
            obj.Figure = figure();
            
            win = [ -600, 600, -600, 600, -600, 600];
            axis equal;
            axis(win);
    
            hold on;
            box  on;
            
            grid on;
            grid minor;

            set(gca,'CameraViewAngleMode','manual');
            set(gca,'CameraViewAngle',10);
            %set(gca,'CameraPosition', [60.0, 60.0, 35.0]);
            %set(gca,'CameraPosition', [6300.0, 7300.0, 3700.0]);
            set(gca,'CameraPosition', [4700.0, 5500.0, 2800.0]);
            set(gca,'DataAspectRatio',[1 1 1]);
            
            %--------------------------------------------------------------
            obj.RobotInst = Robot();
            
            %--------------------------------------------------------------
            obj.UpdateTimer = timer();
            set(obj.UpdateTimer, 'TimerFcn', {@UpdateTimerFcn, obj});
            set(obj.UpdateTimer, 'StartDelay', obj.TIMER_DELAY);
            set(obj.StartDelayTimer, 'ExecutionMode', 'singleShot');
            %set(obj.UpdateTimer, 'Period', obj.TIMER_PERIOD);
            %set(obj.UpdateTimer, 'ExecutionMode', 'fixedRate');
            start(obj.UpdateTimer);
            
            % Set callbacks at the end,
            % so that all properties are valid
            set(obj.Figure, 'KeyPressFcn', @obj.KeyPressEvent);
            set(obj.Figure, 'CloseRequestFcn', @obj.CloseRequestEvent);
        
            function UpdateTimerFcn(src, event, obj)
                TimerEvent(obj, src, event);
            end
        end
        
        function update(obj)
            obj.RobotInst.transform([0 0 0 0]);
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

