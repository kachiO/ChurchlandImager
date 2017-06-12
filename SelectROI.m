function [ROIposition] = SelectROI(obj)


% global dir

%%stop preview and grab image

hChooseROI = figure('Toolbar','none',...
       'Menubar','none',...
       'NumberTitle','off',...
       'Name','ChooseROI');
   
snap = getsnapshot(obj);
stoppreview(obj);  
imshow(snap,[]);

%select ROI and crop image

[ROIimage, ROIposition] = imcrop(hChooseROI);
if ~isempty(ROIposition)
    hROIfig = figure('Toolbar','none','Menubar','none','NumberTitle','off','Name','SelectedROI');
    hROI = imshow(ROIimage, []);
    
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
close(hChooseROI)


    function saveROI(obj,event,ROIposition,hROI)
        
        start_dir = get(findobj('Tag','datatxt'),'String');
        animal = get(findobj('Tag','animaltxt'),'String');
        exptnum = get(findobj('Tag','expttxt'),'String');
        dir = [start_dir '\' animal '\' date '\ROI\'  exptnum '\' ];
        if ~isdir(dir)
            mkdir(dir)
        end
        
        cd(dir)
        [ROIfilename,usercancelled]=imsave(hROI);
%         [ROIfilename,ext,usercancelled]=imputfile;
        
        
        if ~usercancelled 
%             imwrite(hROI,ROIfilename,ext);
            
            ROIposition_filename = [ROIfilename '_position.mat'];
            save(ROIposition_filename,'ROIposition');
            
%             set(get(findobj('Tag','datatxt')),'String',dir)
        end
        

%         close(hSelectedROI);
    end

end
