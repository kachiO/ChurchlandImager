function h = histogramdisplay(obj,event,hImage)
%updates displayed frame and the histogram

set(hImage,'CData',event.Data);

histh = getappdata(hImage,'DisplayHist');

[count,x] = imhist(event.Data,128); %plot histogram, with 128 bin size'
h = stem(histh,x,count);
drawnow  %refresh the display
