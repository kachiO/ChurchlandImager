vid = videoinput('bitflow', 1, 'PhotonFocus-MVD1024-28-E1.r64');
src = getselectedsource(vid);

vid.FramesPerTrigger = 1;

vid.FramesPerTrigger = Inf;

preview(vid);

src.GPOut0 = 1;

src.GPOut0 = 0;

src.CLSerialBaudRate = '230400';

src.GPOut1 = 1;

vid.LoggingMode = 'disk&memory';

diskLogger = VideoWriter('C:\Users\Dell\Documents\Instrinsic Data\experiment000_0001.avi', 'Uncompressed AVI');

vid.DiskLogger = diskLogger;

src.GPOut1 = 0;

src.CLSerialQueueLen = 256;

src.CLSerialQueueLen = 6784;

src.CLSerialQueueLen = 32503;

src.CLSerialReadLen = 8601;

src.CLSerialReadLen = 9870;

src.CLSerialReadLen = 65535;

src.CLSerialReadLen = 37505;

src.CLSerialQueueLen = 25975;

src.CLSerialQueueLen = 32109;

triggerconfig(vid, 'hardware', 'fallingEdge', 'FEN');

triggerconfig(vid, 'hardware', 'fallingEdge', 'TTL');

triggerconfig(vid, 'immediate');

src.CLSerialReadLen = 33162;

stoppreview(vid);

preview(vid);

stoppreview(vid);

vid.ROIPosition = [143 286 787 686];

preview(vid);

imaqmem(2000000000);

stoppreview(vid);

preview(vid);

stoppreview(vid);

