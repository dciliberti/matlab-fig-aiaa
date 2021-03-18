% Edit figures to apply AIAA journal style
close all; clearvars; clc

disp('Program start')
list = dir;

%% MANUAL INSPECTION AND EDITING
% Just open and inspect all figures to perform manual editings
% Comment this section when done
%
% for c = 3:length(list) % first two items are . and ..  
%     % operate only on MATLAB figures
%     if strcmp(list(c).name(end-2:end),'fig') 
%         f = openfig(list(c).name,'visible');
%     end
% end

%% Automatically reduce font size and save
disp('Looping over MATLAB figures...')
for c = 3:length(list) % first two items are . and ..
    
    % operate only on MATLAB figures
    if strcmp(list(c).name(end-2:end),'fig')
        
        n = list(c).name;
        
        f = openfig(list(c).name,'invisible');
        
        % eventually get children like boxplot lines
        box = findobj(f,'Type','line');
        for k = 1:length(box)
            box(k).LineWidth = 1;
        end
        
        % eventually set contour label font size
        cont = findobj(f,'Type','contour');
        for ct = 1:length(cont)
            clabel(cont.ContourMatrix,cont,'FontSize',8);
        end
        
        chart = findobj(f,'Type','axes');      
        for ax = 1:length(chart)
            
            % reset X-, Y-, Z-label position and style
            % useful if you manually resized the chart
            temp = chart(ax).XLabel.String;
            delete(chart(ax).XLabel)
            xlabel(temp)
            
            temp = chart(ax).YLabel.String;
            delete(chart(ax).YLabel)
            ylabel(temp)
            
            temp = chart(ax).ZLabel.String;
            delete(chart(ax).ZLabel)
            zlabel(temp)
            
            chart(ax).LineWidth = 1;
            chart(ax).FontSize = 8;
%             chart(ax).Title.FontSize = 8;
            chart(ax).Title.String = ' ';
            
            if ~isempty(chart(ax).Legend)
                chart(ax).Legend.FontSize = 8;
            end
            
        end
        
        f.PaperUnits = 'inches';
        f.PaperPosition = [0.25, 0.25, 3.0, 1.75]; % left bottom width height
        f.PaperSize = [3.25, 2.0];
        
        % savefig(f,['_resized_',n(1:end-4)])
        print([n(1:end-3),'pdf'],'-dpdf','-r300') % save the figure as pdf
    end
end

disp('END')