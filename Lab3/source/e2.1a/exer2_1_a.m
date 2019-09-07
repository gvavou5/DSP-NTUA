%2.1.a 
clear all; 
close all; 
clc;
N = 7;
d = 0.04;
c = 340;
summ = 0;
gwnia = pi/4;
for i=0:(N-1)
sensor = ['sensor_' num2str(i) '.wav']; 
%to ekana to i string gia na to katalabei to matlab

sign = wavread(sensor);
shiftv = -(i-(N-1)/2)*d*cos(gwnia)/c;
shifted = timeShift(sign , shiftv); %xronikh metatopish
summ = summ + shifted;
end
summ = summ/N; 
wavwrite(real(summ), 48000,'sim_ds.wav');
real_signal = wavread('source.wav');
diff = real(summ) - real_signal; %diafora tou kanonikou shmatos apo auto pou upologisa


subplot(221);
plot(real_signal);
title('Καθαρό σήμα φωνής');

subplot(222);
central_mic = wavread('sensor_3.wav'); 
plot(central_mic);
title('Θορυβώδες σήμα στο κεντρικό μικρόφωνο');

subplot(223);
plot(real(summ));
title('Έξοδος του delay-and-sum beamformer');

subplot(224);
plot(real(diff));
title('Διαφορά σημάτων');

figure(2);
spectrogram(real_signal,512,500);
title('Καθαρό σήμα φωνής');

figure(3);
spectrogram(central_mic,512,500);
title('Θορυβώδες σήμα στο κεντρικό μικρόφωνο');

figure(4);
spectrogram(summ,512,500);
title('Έξοδος του delay-and-sum beamformer');

%Ypologismos SNR 
rssq = sum(real_signal.^2); 
sqdiff = sum(diff.^2);
sqcentrediff = sum((real(central_mic)-real_signal).^2);
snrbeam = 10*log10(rssq/sqdiff) 
snrcentral = 10*log10(rssq/sqcentrediff)