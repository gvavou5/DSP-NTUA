%to erwthma 2.1 apanth8hke sth synarthsh dft_manual pou uparxei sto arxeio 

%% Erwthma 2.2

L=256;
N=256;
n=1:256;
%8etw tis arxikes kyklikes syxnothtes opws dinetai apo thn askhsh
w1=pi/9;
w2=pi/5;
%orizw ay8aireta tis faseis ph1=pi/5 kai ph2=pi/36
ph1=pi/5; 
ph2=pi/36; 
%orizw ta shmata pou dinontai apo thn ekfwnhsh
x1=1*exp(1j*(w1*n+ph1));
x2=0.8*exp(1j*(w2*n+ph2));
window=hamming(256);
%dhmiourgw to para8yro hamming
%gia na prokypsei to y[n] pairnw to anastrofo tou para8yrou hamming
%epeidh einai dianysma sthlh kai to pollaplasiazw kata stoixeio me to x1+x2 
y=window'.*(x1+x2);
%ypologizw kai sxediazw ton DFT tou y
Y=fft(y);
figure;
plot (abs(Y))
xlabel('k')
ylabel('|Y(k)|')
%twra 8eloume na checkaroume th diakritikh ikanothta tou systhmatos mas.
%gia to logo ayto 8a arxisoume na elattwnoume th syxnothta w2 me mikra
%vhmata. epilegoume ay8aireta ayto na ginei se 30 epanalhpseis epomenws to
%vhma pou 8a xrhsimopoihsoume 8a einai (pi/5-pi/9)/30=0.0093. epeidh ayth
%th routina 8a th xrhsimopoihsoume kai parakatw dhmiourgoume th synarthsh
%plot_maker pou pairnei ws orismata ton ari8mo N twn shmeiwn tou DFT pou
%8eloume, thn arxikh syxnothta pou metaballoume kai elegxoume, to shma x1
%kai to bhma. me ka8e nea syxnothta sxediazoume ton dft tou shmatos Y kai
%para8etoume ta apotelesmata apo ta grafhmata ola mazi opws exoume pra3ei
%kai sthn anafora prokeimenou na diakrinoume thn oriakh diafora twn
%syxnothtwn Dw
plot_maker(N,w2,x1,0.0093)

%% Erwthma 2.3

%edw 8eloume idia diadikasia me parapanw mono pou o ari8mos twn deigmatwn
%tou DFT 8a einai axika 512 kai meta 1024 giaytoo prepei na checkaroume gia
%na kanoume to zero-padding tou shmatos
l=length(y); 
%zero-padding gia na ftasei to shma ta 512 deigmata
if l<N
    for j=(l+1):N
        y(j)=0;
    end
end
Y=fft(y);
figure;
plot (abs(Y))
xlabel('k')
ylabel('|Y(k)|')
plot_maker(512,w2,x1,0.0093)
%zero-padding gia na ftasei to shma ta 1024 deigmata
l=length(y); 
if l<N
    for j=(l+1):N
        y(j)=0;
    end
end
Y=fft(y);
figure;
plot (abs(Y))
xlabel('k')
ylabel('|Y(k)|')
plot_maker(1024,w2,x1,0.0093)

%% Erwthma 2.4

%oriakh diafora syxnoththtwn me vash ta parapanw diagrammata einai Dw~0.056
%gia shma pou pernaei apo para8yro me mhkos L=512 kai syxnothta w2=w1+0.056
%xrhsimopoiw pali plot_maker alla ayth th fora me vhma 0.056/30~0.00186 
n=1:512;
w1=pi/9;
w2=w1+0.056;
ph1=pi/5; 
ph2=pi/36;
x1=1*exp(1j*(w1*n+ph1));
x2=0.8*exp(1j*(w2*n+ph2));
window=hamming(512);
y=window'.*(x1+x2);
Y=fft(y);
figure;
plot (abs(Y))
xlabel('k')
ylabel('|Y(k)|')
xlim([0 150])
plot_maker(512,w2,x1,0.00186)
%epanalambanw th diadikasia ayth th fora gia shma pou pernaei apo para8yro me mhkos L=1024
n=1:1024;
x1=1*exp(1j*(w1*n+ph1));
x2=0.8*exp(1j*(w2*n+ph2));
window=hamming(1024);
y=window'.*(x1+x2);
Y=fft(y);
figure;
plot (abs(Y))
xlabel('k')
ylabel('|Y(k)|')
xlim([0 150])
plot_maker(1024,w2,x1,0.00186)

%% Erwthma 2.5

%dhmiourgw ta shmata mhkous 256 pou zhtaei h ekfwnhsh ka8ws kai ta para8yra
%mhkous 256
n=1:256;
w1=0.5*pi;
w2=0.6*pi;
ph1=pi/5; 
ph2=pi/36;
x1=1*exp(1j*(w1*n+ph1));
x2=0.1*exp(1j*(w2*n+ph2));
w_rect= ones(1,256);
w_ham=hamming(256);
y1=w_rect.*(x1+x2);
y2=w_ham'.*(x1+x2);
%ypologizw tous DFT twn parapanw 2 shmatwn tou prwtou me to tetragwniko
%para8yro kai tou deyterou me to para8yro typou hamming
%sxediazw ta katallhla plots
Y1=fft(y1,1024); %h synarthsh fft kanei monh ths zero-padding
Y2=fft(y2,1024);
%sxediazw ta dyo plots twn shmatwn 
%prwta ayto pou perase apo tetragwniko para8yro
figure;
plot (abs(Y1))
xlabel('k')
ylabel('|Y1(k)|')
%kai deytero aytou pou perase apo para8yro Hamming
figure;
plot (abs(Y2))
xlabel('k')
ylabel('|Y2(k)|')
