

classdef myplot < handle
	properties
        fig                 % figure handler
		M                   % width
        N                   % height
        i                   % subplot index
        useCustomAxis       % use custom axis
        customAxis          % axis limits
    end
    
	methods
		function obj = myplot(M, N, title)
            
            set(groot, 'defaultAxesTickLabelInterpreter',   'latex');
            set(groot, 'defaultLegendInterpreter',          'latex');
            set(groot, 'defaultTextInterpreter',            'latex');

            if nargin >= 3
                obj.fig = figure('Name', title, 'NumberTitle', 'off');
            else
                obj.fig = figure();
            end

            obj.M = M;
            obj.N = N;
            obj.i = 1;
            
            obj.useCustomAxis = false;
        end
        
        function setAxis(obj, ax)
            obj.useCustomAxis = true;
            obj.customAxis = ax;
        end
        
        function plot(obj, x, y, label, i)
            set(groot, 'CurrentFigure', obj.fig)
            
            % Create or reuse subplot
            if nargin >= 5
                subplot(obj.M, obj.N, i);
            else
                subplot(obj.M, obj.N, obj.i);
                obj.i = obj.i + 1;
            end
            
            p = plot(x, y);
            hold on;
            grid on;
            grid minor;
            
            % Set custom axis
            if obj.useCustomAxis
                axis(obj.customAxis);
            end
            
            % Add coordinate system
            line(xlim, [0 0], 'Color', 'black');
            line([0 0], ylim, 'Color', 'black');
            
            % Replot
            delete(p);
            plot(x, y);
            
            % Set title and label
            if nargin >= 4
                % isstring (MATLAB 2017)
                % label is a cell array
                if iscell(label)
                    if length(label) >= 1
                        title(label(1));
                    end
                    if length(label) >= 2
                        xlabel(label(2));
                    end
                    if length(label) >= 3
                        ylabel(label(3));
                    end
                    
                % label is string
                else
                    title(label);
                end
            end
            
            
        end
        
        function delete(obj)
            
        end
	end
end


