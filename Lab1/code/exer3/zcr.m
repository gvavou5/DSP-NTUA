function [out]= zcr(x,ms)
ll= length(x);
NN= ms/0.0625;
w_hamming = hamming (NN);
y=sign(x);
%Dhmiourgw to shma yt=|sgn[x(m)]-sgn[x(m-1)]|
for i= 2:ll 
    yt(i-1)= abs(y(i)-y(i-1));
end
%Efarmozw thn idia idiothta tou DFT :
%(suneliksh sto xrono)--->(ginomeno sto pedio ths suxnothtas)
%kai efarmozw antistrofo met/smo gia na parw to zero crossing rate
ww= fft(w_hamming,ll+NN-2);
yt= fft(yt, ll+NN-2);
%Ebala ll+NN-2 afou pairnw diafores se pinaka ll stoixeiwn
Z= yt.*ww';
out= ifft(Z);
end