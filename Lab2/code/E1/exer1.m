[x,fs]= wavread ('speech.wav');
y=buffer(x,0.030*48000, 0.020*48000); %eksetazw to shma mou se mikra 
%epikaluptomena para8ura
w=hamming(0.030*48000); %create a hamming window
%andrikh fwnh => 50 ews 250 Hz
down=48000/50;
up=48000/250;

for i= 1:size(y,2)
   vv=y(:,i).*w ;
   ceps=rceps(vv);
   cepstrum1=ceps(up:down); % kobw to cepstrum gia na parw auta pou 8elw
   [maximum(i),index(i)]=max(abs(cepstrum1));%gia ka8e i vriskw to maximum
   %ka8ws kai thn 8esh autou
end

for j=1:580
    if abs(maximum(j))<0.0595 
        %h timh 0.0595 bre8hke oti dinei to kalutero
        %apotelesma se oti afora to grafhma pou paradidoume.
        freq_matrix(j)=0;
    else
        freq_matrix(j)=fs/(index(j)+191); %191 einai ta deigmata pou pareleipsa
    end
end

freq1=medfilt1(freq_matrix,9);
load('pitch.mat');
plot(t,freq1,'color','g'); hold on; 
plot(t,pitch','color','r'); hold off;
title ('Autocorrelation-method(red) , Cepstrum-method(green)');