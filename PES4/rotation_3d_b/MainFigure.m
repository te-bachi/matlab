classdef MainFigure < handle
    properties (Constant)
        TIMER_PERIOD = 0.1
    end
    
    properties
        Figure
        Timer
        CoordInst
        RobotInst
    end
    
    methods
        function obj = MainFigure()
            
            %--------------------------------------------------------------
            obj.Figure = figure();
            
            hold on;
            box  on;

            axis equal;
            grid on;
            grid minor;

            set(gca,'CameraViewAngleMode','manual');
            set(gca,'CameraViewAngle',10);
            set(gca,'CameraPosition', [14.0, 35.0, 35.0]);
            set(gca,'DataAspectRatio',[1 1 1]);
            
            %--------------------------------------------------------------
            obj.CoordInst = Coordinate();
            obj.RobotInst = Robot();
            
            %--------------------------------------------------------------
            obj.Timer = timer();
            set(obj.Timer, 'TimerFcn', {@TimerFcn, obj});
            set(obj.Timer, 'StartDelay', 1);
            set(obj.Timer, 'Period', obj.TIMER_PERIOD);
            set(obj.Timer, 'ExecutionMode', 'fixedRate');
            %start(obj.Timer);
            
            % Set callbacks at the end,
            % so that all properties are valid
            set(obj.Figure, 'KeyPressFcn', @obj.KeyPressEvent);
            set(obj.Figure, 'CloseRequestFcn', @obj.CloseRequestEvent);
        
            function TimerFcn(src, event, obj)
                TimerEvent(obj, src, event);
            end
        end
        
        function update(obj)
            obj.RobotInst.transform();
            obj.RobotInst.plotArms();
            obj.RobotInst.plotPoints();
        end
        
        function TimerEvent(obj, src, event)
            fprintf('Running...\n');
        end
        
        function KeyPressEvent(obj, src, event)
            delete(obj)
        end
        
        function CloseRequestEvent(obj, src, event)
            delete(obj)
        end
        
        function delete(obj)
            stop(obj.Timer);
            delete(obj.Timer);
            delete(obj.Figure);
            delete(obj.CoordInst);
            delete(obj.RobotInst);
        end
    end
    
end

