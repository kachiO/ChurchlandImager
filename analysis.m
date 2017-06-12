clear 

set(0,'DefaultFigureWindowStyle','docked')
for i  = 1:17
 filename =  ['ki000_14-Feb-2014_004_' num2str(i-1) '_data.mat'];
load(filename)
data = IntrinsicData.data;

prestimFrames = data(:,:,:,1:20);
poststimFrames = data(:,:,:,101:end);
stimFrames = data(:,:,:,21:100);


avgStim = mean(stimFrames,4);
avgPost = mean(poststimFrames,4);

new = avgStim - avgPost;

figure
imshow(new)

end

set(0,'DefaultFigureWindowStyle','normal')