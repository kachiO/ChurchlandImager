function snapshot(obj)

%%stop preview and grab image
stoppreview(obj);  

figure('Toolbar','none',...
       'Menubar','none',...
       'NumberTitle','off',...
       'Name','SnapShot');
   
snap = getsnapshot(obj);

imshow(snap);
% axis off
% colormap(gray)

% name and save image
uicontrol('String','Save',...
    'Callback','imsave',...
    'units','normalized',...
    'position',[0 0 0.15 0.07]);

uicontrol('String','Close',...
    'Callback','close(gcf)',...
    'units','normalized',...
    'position',[0.17 0 0.15 0.07]);

end
