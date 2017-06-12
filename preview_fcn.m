function preview_fcn(obj,event,himage)



tstampstr = event.Timestamp;  %frame time stamp

hTextlabel = getappdata(himage,'HandleToTimestampLabel');  %get handle to text label uicontrol

set(hTextlabel,'String',tstampstr);  %set value of the text label

set(himage,'CData',event.Data)  %display image data





