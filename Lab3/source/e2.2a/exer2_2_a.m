%----------- Delay-and-sum beamforming--------------------
clear all; close all; clc;
N = 7;
d = 0.08;
c = 340;
summ = 0;
gwnia = pi/2;
for i=0:(N-1)
foo = ['sensor_' num2str(i) '.wav'];
sign = wavread(foo);
shiftv = -(i-(N-1)/2)*d*cos(gwnia)/c;
Shiftedsign = timeShift(sign , shiftv);
foo2 = ['sign' num2str(i) '.wav'];
summ = summ + Shiftedsign;
end
summ = summ/N;
wavwrite(real(summ), 48000,'real_ds.wav');
corr = wavread('source.wav');
diff = real(summ) - corr;

%----------2.2.2------------------------

subplot(221);
plot(corr);
title('Καθαρό σήμα φωνής');

subplot(222);
central = wavread('sensor_3.wav');
plot(central);
title('Θορυβώδες σήμα στο κεντρικό μικρόφωνο');

subplot(223);
plot(real(summ));
title('Έξοδος του delay-and-sum beamformer');

subplot(224);
plot(diff);
title('Διαφορά σημάτων');
figure(2);
spectrogram(corr,960,480);
title('Καθαρό σήμα φωνής');
figure(3);
spectrogram(central,960,480);
title('Θορυβώδες σήμα στο κεντρικό μικρόφωνο');
figure(4);
spectrogram(summ,960,480);
title('Έξοδος του delay-and-sum beamformer')

%---------2.2.3-------------

%Yπολογισμός SSNR
ssnrCentral = findSSNR(central,100)
ssnrOutput  = findSSNR(real(summ),100)

