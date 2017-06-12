function chooseROI(obj)


ROI = imrect(gca);
ROIposition = getPosition(ROI);
set(obj,'ROIposition',ROIposition);

