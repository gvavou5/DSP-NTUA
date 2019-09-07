%exer 2.2
[x,fs]= wavread('speech.wav') ;
load('pitch.mat');
r=lpc_vocoder(x,48000,1440,960,pitch);
wavwrite (r,48000,'synthesis') ;
%einai polu aplo auto pou kanw afou h douleia ginetai apo thn
%dosmenh sunarthsh lpc_vocoder