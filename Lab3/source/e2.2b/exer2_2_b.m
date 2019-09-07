clc;
clear;
s = wavread('source.wav');
scentr = wavread('sensor_3.wav');
Len=length(s);

%30ms window, overlap 50%

s(171272:171360)=0;
scentr(171272:171360)=0; 
%zero-padding 

%u^2 apo to 1o para8yro(mono 8oruvos), mporousa kai apo to 2o alla den exei
%shmasia

noise=s(1:1440);
psnoise = pwelch(noise,480,240,1440,48000,'twosided');

%beam-former gia monokanaliko IIR Wiener 

N = 7; 
d = 0.08;
c = 340;
signsm = 0;
gwnia = pi/2;
for i=0:(N-1)
sensor = ['sensor_' num2str(i) '.wav']; 
sign = wavread(sensor);
shiftv = -(i-(N-1)/2)*d*cos(gwnia)/c;
shifteds = timeShift(sign , shiftv); %xronikh metatopish 
signsm = signsm + shifteds;
end
signsm = signsm/N;  
signalr = wavread('source.wav');
diff = real(signsm) - signalr; %vriskw th diafora 


s=real(signsm);

%para8yropoihsw kai 8a filtrarw to shma ayto me wiener filtro

wind=hamming(1440);


%zero-padding
s(171273:171360)=0;
index=1;
final(1:171360)=0;
final=final';
for (i=1:238)
    if (i~=238)
    windowed_frame=wind.*s(index:index+1440-1);
    pswindow_beam = pwelch(windowed_frame,480,240,1440,48000,'twosided');
    Hw=1-(psnoise./pswindow_beam);
    framedft = fft(windowed_frame);
    dfrwien = Hw.*framedft; %wiener filtrarisma
    eks = ifft(dfrwien);
    final(index:index+1440-1)=final(index:index+1440-1)+eks;
    index=index+720;
    end

end

wavwrite(final, 48000,'real_mmse.wav');

figure;
real_sign= wavread('source.wav');
subplot(221);
plot(real_sign);
title('Καθαρό Σήμα Φωνής');

subplot(222);
central_mic = wavread('sensor_3.wav');
plot(central_mic);
title('Θορυβώδες Σήμα Στο Κεντρικό Μικρόφωνο');


subplot(223);
plot(s);
title('Eisodos του Wiener Filtrou');

subplot(224);
plot(final);
title('Έξοδος του Wiener φίλτρου');

figure;
spectrogram(real_sign,960,480);
title('Καθαρό Σήμα Φωνής');

figure;
spectrogram(central_mic,960,480);
title('Θορυβώδες Σήμα Στο Κεντρικό Μικρόφωνο');

figure;
spectrogram(s,960,480);
title('Είσοδος του Wiener Φίλτρου')

figure;
spectrogram (final,960,480);
title('Έξοδος του Wiener Φίλτρου');

SSNR_before_Wiener_Filter=findSSNR(s,100) %100 para8yra gia beltisto apotelesma
SSNR_after_Wiener_Filter=findSSNR(final,100) %100 para8yra gia beltisto apotelesma

ssnrsum=0;
for i=0:(N-1)
    sensor = ['sensor_' num2str(i) '.wav'];
    signal = wavread(sensor);
    ssnrsum=findSSNR(signal,100)+ssnrsum;
end
ssnrsum=ssnrsum+SSNR_before_Wiener_Filter; 
meanSSNR=ssnrsum/8