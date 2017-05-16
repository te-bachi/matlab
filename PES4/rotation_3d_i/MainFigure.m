classdef MainFigure < handle
    properties (Constant)
        TIMER_DELAY  = 2.0
        TIMER_PERIOD = 0.1
    end
    
    properties
        Figure
        StartDelayTimer
        UpdateTimer
        RobotInst
        Serial
        QuatOriginUpper
        QuatOriginLower
        
        timeStart
        fp
    end
    
    methods
        function obj = MainFigure()
            
            %--------------------------------------------------------------
            obj.Serial = SerialPort();
            
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
            % Open file
            t             = datetime('now');
            obj.timeStart = posixtime(t) * 1000;
            date_str      = datestr(t, 'yyyy_MM_dd_HH_mm_ss');
            filename      = [ 'q_' date_str '.txt' ];
            obj.fp        = fopen(filename, 'w');
            if obj.fp == -1
                throw(MException('MainFigure', ...
                                 'Can not create file %s', filename));
            end
            
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
                [obj.QuatOriginLower, obj.QuatOriginUpper] = obj.Serial.read();
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
            [qLower, qUpper] = obj.Serial.read();
            qUpperDiff = quatmultiply(qUpper, obj.QuatOriginUpper);
            qLowerDiff = quatmultiply(qLower, obj.QuatOriginLower);
            obj.RobotInst.transform(qUpperDiff, qLowerDiff);
            obj.RobotInst.plotArms();
            obj.RobotInst.plotPoints();
            obj.RobotInst.plotCoordinates();
            
            
            timeEnd = posixtime(datetime('now')) * 1000;
            timeDiff = timeEnd - obj.timeStart;
            %fprintf('%s - %s = %s\n', num2str(timeEnd), num2str(obj.timeStart), num2str(timeDiff));
            fprintf(obj.fp, '[ %s ] [ %f, %f, %f, %f ] [ %f, %f, %f, %f ]\n',...
            num2str(timeDiff),...
            qUpper(1), qUpper(2), qUpper(3), qUpper(4),...
            qLower(1), qLower(2), qLower(3), qLower(4));
            
            %fprintf(obj.fp, '[%f,%f,%f,%f] [%f,%f,%f] [%f,%f,%f,%f] [%f,%f,%f]\n',...
            %qUpper(1), qUpper(2), qUpper(3), qUpper(4),...
            %obj.RobotInst.p1(1), obj.RobotInst.p1(2), obj.RobotInst.p1(3),...
            %qLower(1), qLower(2), qLower(3), qLower(4),...
            %obj.RobotInst.p2(1), obj.RobotInst.p2(2), obj.RobotInst.p2(3));
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
            fclose(obj.fp);
            delete(obj.StartDelayTimer);
            delete(obj.UpdateTimer);
            delete(obj.Figure);
            delete(obj.RobotInst);
            delete(obj.Serial);
        end
    end
    
end

