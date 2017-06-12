
masterIP = '143.48.140.172';
%close any exiting communication with stimulus computer
port = instrfindall('RemoteHost',masterIP);
if isempty(port) > 0; 
    fclose(port); 
    delete(port);
    clear port;
end


%listen to data from stimulus computer (located on stimulusIP on
%RemotePort,8866) on this computer's local port 8844
udpobjhandle = udp(masterIP,'RemotePort',8844,'LocalPort',8866);

fopen(udpobjhandle);

fprintf(udpobjhandle,'Stimulus computer ready for communication')
