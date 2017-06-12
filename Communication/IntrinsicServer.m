
function IntrinsicServer(varargin)

global tcpServer 

stimulusIP = '143.48.31.5';

mode = varargin{1};

switch mode
    
    
    case 'init'
        %E.g. usage 
        % IntrinsicServer('init')

        %first check to see that there are no open ports
        openports = instrfindall('RemoteHost',stimulusIP);
        
        if length(openports) > 0
            fclose(openports);
            delete(openports);
            clear openports
        end
        
        %open TCP/IP communication with stimulus (mac) computer 
        tcpServer = tcpip(stimulusIP,50500,'NetworkRole','Server'); %receive messages from coming from stimulus ip 
        set(tcpServer,'OutputBufferSize',1000000) %set output buffer size to 1MB
        set(tcpServer,'InputBufferSize',1000000) %set output buffer size to 1MB
        tcpServer.Terminator = '~'; 
        tcpServer.BytesAvailableFcnMode = 'Terminator';
        tcpServer.BytesAvailableFcn = @readmessage;
        
        fopen(tcpServer);  %waits indefinitely to establish connection with stimulus computer
        disp(['connection established with stimulus computer on ' stimulusIP])
        
%         tcpServerClient = tcpip(stimulusIP,50501,'NetworkRole','Client'); %listen for bytes coming from stimulus ip address and port, the port has to be enabled to traverse firewall (go to control panel->firewall->advanced settings)
%         set(tcpServerClient,'OutputBufferSize',1000000) %set output buffer size to 1MB
%         set(tcpServerClient,'InputBufferSize',10000000) %set output buffer size to 1MB
%         tcpServerClient.Terminator = '~'; 
%         tcpServerClient.BytesAvailableFcnMode = 'Terminator';
%         tcpServerClient.BytesAvailableFcn = @readmessage;
%         fopen(tcpServerClient);
        
    case 'read'  %check for messages from stimulus computer
        %E.g. usage
        % IntrinsicServer('read')
        
        if strcmp(tcpServer.status,'closed')
            fopen(tcpServer);
        end
        
        nbytes = tcpServer.BytesAvailable;
        
        if nbytes > 0 
            incomingMessage = char(fread(tcpServer,nbytes)');  
            disp(incomingMessage);
        end
        
        
    case 'send'  %send message to stimulus compute
        %E.g. usage
        % IntrinsicServer('send',sendmessage)
        
        sendmessage = varargin{2};
        
        %open connection if closed
        if strcmp(tcpServer.status,'closed')
            fopen(tcpServer);
        end
        
        fwrite(tcpServer,sendmessage,'char');
    
    case 'prep'  %prep for stimulus
        
    case 'play'  %play stimulus
        
        
    case 'close' %close connection
        
        fclose(instrfindall('RemoteHost',stimulusIP));
        delete(instrfindall('RemoteHost',stimulusIP));
               
        disp('closed connection with stimulus computer.')
        
end

function readmessage(tcpServer,~)
IntrinsicServer('read')





