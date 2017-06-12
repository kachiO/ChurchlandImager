function framesPerTrigger = updateFramesPerTrigger(frameRate,acquiretime)
    
%(22-jan-2013) commented other bits of code b/c I set the camera frame rate
%to 10 fps
  
%     if frameRate <= 27.5
        framesPerTrigger = round(frameRate * acquiretime);
%     else
%         framesPerTrigger = Inf;
%         disp('. The entered frame rate exceeds the maximum frame rate for the camera. Frames per trigger has been set to Inf')
%     end
%      
end
