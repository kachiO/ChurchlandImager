% % %preview prep before starting intrinsic imaging to make sure

% % %features:
% %     % prep snapshot
        % select ROI -not yet implemented
        % intensity histogram? -partially implemented, although not sure if necessary
        
% % %adapted from example tutorial http://www.mathworks.com/help/imaq/previewing-data.html#f11-76072

%Written by Kachi O 10Jan2014

%%
clc
imaqreset
clear all
close all

% Device Properties.
adaptorName = 'bitflow';
deviceID = 1;
vidFormat = 'PhotonFocus-MVD1024-28-E1.r64';
tag = '';

% Search for existing video input objects.
existingObjs1 = imaqfind('DeviceID', deviceID, 'VideoFormat', vidFormat, 'Tag', tag);

if isempty(existingObjs1)
    % If there are no existing video input objects, construct the object.
    vidObj = videoinput(adaptorName, deviceID, vidFormat);
else
     % There are existing video input objects in memory that have the same
    % DeviceID, VideoFormat, and Tag property values as the object we are
    % recreating. If any of those objects contains the same AdaptorName
    % value as the object being recreated, then we will reuse the object.
    % If more than one existing video input object contains that
    % AdaptorName value, then the first object found will be reused. If
    % there are no existing objects with the AdaptorName value, then the
    % video input object will be created.

    % Query through each existing object and check that their adaptor name
    % matches the adaptor name of the object being recreated.
    for i = 1:length(existingObjs1)
        % Get the object's device information.
        objhwinfo = imaqhwinfo(existingObjs1{i});
        % Compare the object's AdaptorName value with the AdaptorName value
        % being recreated.
        if strcmp(objhwinfo.AdaptorName, adaptorName)
            % The existing object has the same AdaptorName value as the
            % object being recreated. So reuse the object.
            vidObj = existingObjs1{i};
            % There is no need to check the rest of existing objects.
            % Break out of FOR loop.
            break;
        elseif(i == length(existingObjs1))
            % We have queried through all existing objects and no
            % AdaptorName values matches the AdaptorName value of the
            % object being recreated. So the object must be created.
            vidObj = videoinput(adaptorName, deviceID, vidFormat);
        end %if
    end %for
end %if
    
hFig = figure('Toolbar','none',...
    'Menubar','none',...
    'NumberTitle','off',...
    'Name','Intrinsic Previewer');

% add push buttons
uicontrol('String','Start Preview',...
    'Callback','preview(vidObj)',...
    'Units','normalized',...
    'Position',[0 0 0.15 0.07]);

uicontrol('String','Stop Preview',...
    'Callback','stoppreview(vidObj)',...
    'Units','normalized',...
    'Position',[0.17 0 0.15 0.07]);

uicontrol('String','SnapShot!',...
    'Callback','snapshot(vidObj)',...
    'Units','normalized',...
    'Position',[0.34 0 0.15 0.07]);

% uicontrol('String','ChooseROI',...
%     'Callback','chooseROI(vidObj)',...
%     'Units','normalized',...
%     'Position',[0.51 0 0.15 0.07]);

uicontrol('String','Close Window',...
    'Callback','close(gcf)',...
    'Units','normalized',...
    'Position',[0.68 0 0.15 0.07]);

% % hTextlabel = uicontrol('style','text','string','TimeStamp',...
% %     'units','normalized',...
% %     'position',[0.85 -0.04 0.15 0.08]);

vidRes = get(vidObj,'VideoResolution');
nbands = get(vidObj','NumberOfBands');
imHeight = vidRes(2);
imWidth = vidRes(1);

subplot(1,2,1)
hImage = image(zeros(imHeight,imWidth,nbands));
axis image


% setappdata(hImage,'UpdatePreviewWindowFcn',@preview_fcn);
% setappdata(hImage,'HandleToTimestampLabel',hTextlabel);
h = subplot(1,2,2); 
setappdata(hImage,'UpdatePreviewWindowFcn',@livehistogram_display)

preview(vidObj,hImage);



