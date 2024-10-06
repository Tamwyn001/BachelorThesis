classdef Console
    properties (Constant)
        barLength = 35; % Length of the progress bar
    end
    methods (Static)
        function progressBar(currentParticle, totalParticles)
            % Function to display a custom progress bar in the format [======= 45/300 =======]
            
            % Progress bar settings
            barLength = 50; % Define a fixed bar length
            
            % Calculate progress
            progress = currentParticle / totalParticles;
            numBars = round(progress * barLength);
            
            % Generate the progress bar string
            barStr = sprintf('[%s%s| %d/%d ]', repmat('=', 1, numBars), ...
                             repmat(' ', 1, barLength - numBars), currentParticle, totalParticles);
            % Print the progress bar
            if currentParticle == 1
                fprintf('%s', barStr); % Print the first progress bar
            else
                fprintf(repmat('\b', 1, 2*length(barStr))); % Remove the previous bar
                fprintf('%s', barStr); % Print the updated progress bar
            end
        
            % Add a new line after reaching the total count
            if currentParticle == totalParticles
                fprintf('\n');
            end
        end
    end  
end