% erwtima 1
y = wavread('source.wav');
y1 = wavread('sensor_3.wav');
s = y(36000:37440)';
s1 = y1(36000:37440)';
flin = linspace(1,8000,240);
Ps = pwelch(s,480,240,1441,48000,'twosided');
Px = pwelch(s1,480,240,1441,48000,'twosided');
dif = s1-s;
Pdif = pwelch(dif,480,240,1441,48000,'twosided');
Hsw = 1-(Pdif./Px)';
figure(1);
plot(flin,10*log10(Hsw(1:240)));

% erwtima 2
nsd = (abs(1-Hsw)).^2;
figure(2);
plot(flin, 10*log10(nsd(1:240)));

% erwtima 3
X = fft(s1);
Zxx = Hsw.*X;
iiz = ifft(Zxx);
Piiz = pwelch(iiz,480,240,1441,48000,'twosided');
figure(3);
plot(flin, 10*log10(Ps(1:240)),'b');
hold on;
plot(flin, 10*log10(Px(1:240)),'y');
plot(flin, 10*log10(Piiz(1:240)),'c');
plot(flin, 10*log10(Pdif(1:240)),'r');

% erwtima 4
a1 = ifft(Hsw.*fft(s));
b1 = ifft(Hsw.*fft(dif));
snrOfVoiceSignal = 10*log10(mean(s.^2)/mean(dif.^2))
snrOfWienerOutput = 10*log10(mean(a1.^2)/mean(b1.^2))
N = 7;
d = 0.04;
c = 340;
sum2 = 0;
thita = pi/4;
for i=0:(N-1)
    sns = ['sensor_' num2str(i) '.wav'];
    sign = wavread(sns);
    shiftv = -(i-(N-1)/2)*d*cos(thita)/c;
    Shiftedsign = timeShift(sign , shiftv);
    sum2 = sum2 + Shiftedsign;
end
sum2 = sum2/N;
sum2 = sum2(36000:37440)';
Pbeam = pwelch(sum2,480,240,1441,48000,'twosided');
figure(4);
plot(flin, 20*log(Ps(1:240)),'b');
hold on;
plot(flin, 20*log(Px(1:240)),'y');
plot(flin, 20*log(Piiz(1:240)),'c');
plot(flin, 20*log(Pbeam(1:240)),'r');
ubeam = real(sum2) - s;
snrOfDNSBeamformerOutput = 10*log10(mean(s.^2)/mean(ubeam.^2))
