% exercise 3
[signal,Fs]= wavread ('speech.wav');
signal(279563:280320)=0; %zero-padding for the # of windows
%windows: 20ms shift:10ms
buffered_signal=buffer(signal,960, 480); 
%windows for the final spectrogram
w=hamming(960); 
load ('pitch.mat')
%zeropadding sto pitch
pitch_zp = [pitch zeros(1,size(buffered_signal,2)-length(pitch))]; 
for i= 1:size(buffered_signal,2)
    s=buffered_signal(:,i);
    %lcp_order=48 (kHz)+4
    [a,G,lpc_error,speech_frame_est]=lpc_analysis(s,52);
    %find a,G linear prediction coefficients nad gain
    %autocorrelation for the error to find b M
    Autocorrelation_matrix=xcorr(lpc_error); 
    Autocorrelation_matrix=Autocorrelation_matrix'; %
    %because of its symmetry search after the known maximum
    %in 960 search after 100 samples
    b_M=Autocorrelation_matrix(1060:1919);
   [MaxR,MaxInd]=max(b_M); %se olo to R<<=========
    M=MaxInd+100;
    b(1:960)=0;
    b(M)=Autocorrelation_matrix(M)/Autocorrelation_matrix(960); 
    %pass the windows through  H(z)=G/[1-Óa*z^(-i)]
    f = pitch_zp(i);
    u = ugenerator(f,960,Fs);
    final_frames(i,:)=filter(G,a,u);
    %and the filter of ltp analysis 1/1-b*z^-M
    final_frames(i,:)=filter(1,[1 -b],final_frames(i,:));
    %find some errors in voiced and unvoiced frames
    if i>85 && i<90
        estimationofltp=final_frames(i,:)';
        ltp_error=s-estimationofltp;
        figure; 
        subplot (3,1,1);
        plot(lpc_error);
        title ('error by lpc analysis')
        subplot (3,1,2);
        plot(ltp_error);
        title ('error by ltp analysis')
        subplot (3,1,3);
        plot (s);
        title('original windowed frame');
     end
end
count=1;
%reconstruct of the voice
final_frames=final_frames';%(necessary change for synthesis)
for i=1:280320
    final_sign(i)=0; %final_sign= zeros(1,280320);
end
helper=1;
for i=1:584
 current_frame=final_frames(:,i);
 windowedframe=w.*current_frame;
 %length(windowedframe)
 signal_start=helper;
 signal_end=signal_start+960-1;
 if i==584
    signal_end=280320;
    signal_start=280320-959;
 end
  %length(segend)
  %length(segstart)

 final_sign(signal_start:signal_end)= final_sign(signal_start:signal_end) + windowedframe'; 
 helper=helper+480;
end
%scaling and normalising
final_sign = final_sign/max(final_sign); 
figure;

wavwrite (final_sign',48000,'synthesis_lpc_long') ;
figure;
[S,F,T,P] = spectrogram(final_sign, 960, 480, nextpow2(length(signal)), 48000);
surf(T,F,10*log10(P),'edgecolor','none'); axis tight; 
view(0,90);
title('Spectogram of Reconstructed Voice');
xlabel('Time (Seconds)'); ylabel('Hz');
figure;
plot (final_sign');