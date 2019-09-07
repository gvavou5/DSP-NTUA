function [s_celp] = Quantized_Values_Celp_Vocoder (siglen,Fs,winlen,winovlp,G_Quantized,a_Quantized,b,nw,s)

% s       : speech signal
% Fs      : sampling Frequency
% pitch   : pitch values (Hz), random noise excitation where 0
% winlen  : length of analysis window
% winovlp : overlap between windows

% s_lpc   : reconstructed speech

% Digital Signal Processing, Lab2
% LPC vocoder
% CVSP implementation (April 2015)

%% Signal framming
% Window step
winstep = winlen - winovlp;   
% Construct a hamming window, the same length with analysis window
w=hamming(winlen);  
%Check overlap-add
ola(winlen,winstep,siglen)
% Initialize the voice reconstruction buffer with zeros 
s_celp = zeros(1,siglen);
% Define a counter for the begining sample of the moving window 
helper=1;
%creating the codebook
for i= 1:1024
    for j=1:960%583
        Vn(i,j)=0;
    end
end
for k = 1:1024
        Ck= raylrnd(1,1,960) ; 
        Fk=2*pi*rand(1,960);  
        for n=1:1440
            Vn(k,n)=0;
            for j = 1:960
                Vn(k,n)=Vn(k,n)+Ck(j) * cos(pi*(j-1)*(n-1)/52+Fk(j));
            end
        end
end
for i=1:nw             
      for j=1:1024
        Vn_filtered(j,:)=filter(1,[1 -b(i,:)],Vn(j,:));
        Vn_filtered(j,:)=filter(G_Quantized(i),a_Quantized(i,:),Vn_filtered(j,:));
        energy_find=(s(:,i)-Vn_filtered(j,:)').^2; 
        energy(j)=sum(energy_find);
      end
   
	[min_energy(i),index]=min(energy);
    Pulse(i,:)=Vn_filtered(index,:);
end    

%reconstruct of the voice
Pulse=Pulse';
%overlap and add
helper=1;
for i=1:583
 current_frame=Pulse(:,i);
 windowedframe=w.*current_frame;
 %length(windowedframe)
 signalstart = helper;
 signalend = min((signalstart+winlen-1),siglen);
 seglen = signalend - signalstart + 1;
 windowedframe=windowedframe';
 s_celp(signalstart:signalend) = s_celp(signalstart:signalend) + windowedframe(1:seglen);
 helper = helper + 480;
end


%% Amplitude Normalization of reconstructed speech
% Scale/Normalize the synthetic voice signal in [-1 1]
s_celp = s_celp/max(s_celp); 

%% Plots
t = [0:(siglen-1)] / Fs;

figure(1);
plot(t ,s_celp);grid on;
title('Reconstructed Voice (quantization)');
xlabel('Time (Seconds)');

figure(2)
% Spectogram usage: [S,F,T,P] = spectrogram(x,window,noverlap,nfft,fs)
[S,F,T,P] = spectrogram(s_celp, hamming(winlen), winovlp, nextpow2(siglen), Fs);
surf(T,F,10*log10(P),'edgecolor','none'); axis tight;
view(0,90);
title('Spectogram of Reconstructed Voice (Quantization/Encoder)');
xlabel('Time (Seconds)'); ylabel('Hz');
