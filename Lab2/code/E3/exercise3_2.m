% exercise 3.2
[signal,Fs]= wavread ('speech.wav');
signal(279563:280320)=0; %zero-padding
%windows :20ms shift:10ms
buffered_signal=buffer(signal,960, 480); 
%for the spectrogram
w=hamming(960); 
%creating the codebook

for k = 1:1024
        %construct random rayleigh numbers for amplitude
        ck= raylrnd(1,1,480) ; 
        %construct random uniform numbers for phase
        fi=2*pi*rand(1,480); 
        for n=1:960%2N-1
            Vn(k,n)=0;
            for j = 1:480%N=480
                Vn(k,n)=Vn(k,n)+ck(j) * cos(pi*(j-1)*(n-1)/52+fi(j));
            end
        end
end

for i= 1:size(buffered_signal,2)
    s=buffered_signal(:,i);
    %lcp_order=48 (kHz)+4
    [a,G,lpc_error,speech_frame_est]=lpc_analysis(s,52);
    %find a,G and pass the lpc_errors for autocorrelation
    R=xcorr(lpc_error);
    %necessary transformation for max search
    R=R';
    %find b,M exactly like 3.1 with the symmetry
    Autocorr_matrix=R(1060:1919);
    [MaxR,MaxInd]=max(Autocorr_matrix); 
    M=MaxInd+100;
    b(1:960)=0;
    b(M)=R(M)/R(960); 
    %filter codebook 1/1-b*z^-M
    %find the minimum energy from the codebook  
    for j=1:1024
        Vn_final(j,:)=filter(1,[1 -b],Vn(j,:));
        Vn_final(j,:)=filter(G,a,Vn_final(j,:));
        energy_matrix=(s-Vn_final(j,:)').^2; 
        energy(j)=sum(energy_matrix);
      end
     %find the minimum energy and save the best function(stohastic) from 
     %the codebook
	[elaxisth_energy(i),index]=min(energy);
    Pulse(i,:)=Vn_final(index,:);
    
end
%reconstruct of the voice
Pulse=Pulse';
%overlap and add
for i=1:280320
    final_signal(i)=0; %final_sign= zeros(1,280320);
end
helper=1;
for i=1:584
 current_frame=Pulse(:,i);
 windowedframe=w.*current_frame;
 %length(windowedframe)
 signal_start=helper;
 signal_end=signal_start+960-1;
 if i==584
    signal_end=280320;
    signal_start=280320-959;
 end
  final_signal(signal_start:signal_end)= final_signal(signal_start:signal_end) + windowedframe'; 
 %fix the step for the next overlap and add
  helper=helper+480;
end
%scaling and normalising
final_signal = final_signal/max(final_signal); 
figure;

wavwrite (final_signal',48000,'synthesis_celp') ;
figure;
[S,F,T,P] = spectrogram(final_signal, 960, 480, nextpow2(length(signal)), Fs);
surf(T,F,10*log10(P),'edgecolor','none'); axis tight; 
view(0,90);
title('Spectogram of Reconstructed Voice');
xlabel('Time (Seconds)'); ylabel('Hz');
figure;
plot (final_signal');