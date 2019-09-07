function [enrg]= energy_find (x_voice, ms)
%Samples=N= ms / Ts 
nn=ms/0.0625;
%create hamming window with lenght=nn
w_hamming = hamming (nn);
l=length(x_voice);
%orizw 2 nea shmata kai xrhsimopoiw thn idiothta tous DFT:
%(suneliksh sto xrono)---->(ginomeno sto pedio ths suxnothtas)
%kai eframozw ton antistrofo met/smo gia na vrw thn energeia.
x_new= x_voice.*x_voice;
w_new= w_hamming.*w_hamming;
Dft_x_new= fft(x_new, l+nn-1);
Dft_w_new= fft(w_new, l+nn-1);
Enrg_frq= Dft_x_new.*Dft_w_new;
enrg= ifft(Enrg_frq);
end