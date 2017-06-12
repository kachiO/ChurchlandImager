function newImageSequence = reBinImageSequence(imageSequence,acqFPS,newFPS)

% imageSequence  : m by n by t matrix,  where m and n represent a single frame image, and t subsequent frames in the image sequence
% acqFPS         : acquisition frames per second. 
% newFPS         : new frames per second
% best to use even multiples, if you don't want to miss frames. 
% Needs improvement for non-multiples

%Written 18-Sept-2014 by Kachi O
newImageSequence = imageSequence;

if acqFPS > newFPS
    newImageSequence = [];
    
    factor = floor(acqFPS/newFPS);
    
    m = size(imageSequence,1);
    n = size(imageSequence,2);
    t = size(imageSequence,3);
    
    Tnew = floor(t/factor);
    nTrim = rem(t,Tnew);
    
    reshapeImageSeq = reshape(imageSequence(:,:,1:t-nTrim),m,n,factor,Tnew);
    
    newImageSequence = squeeze(mean(reshapeImageSeq,3));

end


% k =1;

