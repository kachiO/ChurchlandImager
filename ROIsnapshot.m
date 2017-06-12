function [ROIposition] = ROIsnapshot(obj)

global dir

dir = get(findobj('Tag','datatxt'),'String');

%%stop preview and grab image
stoppreview(obj);  

hChooseROI = figure('Toolbar','none',...
       'Menubar','none',...
       'NumberTitle','off',...
       'Name','ChooseROI');
   
snap = getsnapshot(obj);
imshow(snap);

%select ROI and crop image
[ROIimage ROIposition] = imcrop(hChooseROI);

if ~isempty(ROIposition)
    hROIfig = figure('Toolbar','none','Menubar','none','NumberTitle','off','Name','SelectedROI');
    hROI = imshow(ROIimage);
    
    % user buttons
    uicontrol('String','Save',...
        'Callback',{@saveROI,ROIposition,hROI},...
        'units','normalized',...
        'position',[0 0 0.15 0.07]);
    
    uicontrol('String','Close',...
        'Callback','close(gcf)',...
        'units','normalized',...
        'position',[0.17 0 0.15 0.07]);
    
end


    function saveROI(obj,event,ROIposition,hROI)
        
        cd(dir)
        [ROIfilename,usercancelled]=imsave(hROI);
        
        if ~usercancelled 
            ROIposition_filename = [ROIfilename '_position.mat'];
            save(ROIposition_filename,'ROIposition');
            
        end
        
%         close(hSelectedROI);
    end

end
