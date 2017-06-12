function DataOut = Widefield_ShrinkStack_v1(DataIn,bin,tbin)
% Quick function to downsample an image stack, based on averaging through a symmetric box filter.
% Usage: DataOut = Widefield_ShrinkStack_v1(DataIn,bin)
% DataIn = x*y*samples matrix to be downsampled
% bin = size of the box filter. Downsampled image will consist of averages
% of squares of the size bin*bin. If DataIn can not be divided by bin, the
% downsampled image will not contain the lower and right edges of DataIn 
% that are above the highest divider.
% tbin = Average frames together. If the stack does not contain a divider
% of tbin frames, the remaing frames are averaged together. not used if unassigend.

if ~exist('tbin','var')
    tbin = 1;
end

if bin ==1 && tbin == 1
    DataOut = DataIn;
    return;
end

DataOut = zeros(floor(size(DataIn,1)/bin),floor(size(DataIn,1)/bin),ceil(size(DataIn,3)/tbin)); %pre-allocate output matrix
boxFilter = ones(bin,bin); % Make a box filter to average all the values within a 'bin' by 'bin' window.
boxFilter = boxFilter ./ bin^2; %make sure results are an average rather then sum
Cnt = 1;

for iFrames = 1:tbin:size(DataIn,3)
    if iFrames > size(DataIn,3)-tbin+1 %check if enough frames are left or use remaining frames otherwise
        temp1 = squeeze(mean(DataIn(:,:,iFrames:end),3));
    else
        temp1 = squeeze(mean(DataIn(:,:,iFrames:iFrames+tbin-1),3));
    end
    temp2 = conv2(double(temp1), boxFilter); %convolve original matrix with box filter
    DataOut(:,:,Cnt) = temp2(bin:bin:(end-(bin-1)), bin:bin:(end-(bin-1))); %pick parts of the downsampled image that are non-overlapping     
    Cnt = Cnt+1;
end

