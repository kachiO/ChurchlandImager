function livehistogram_display(obj,event,hImage)
%updates displayed frame and the histogram

set(hImage,'CData',event.Data);


imhist(event.Data,128) %plot histogram, with 128 bin size
% drawnow  %refresh the display
