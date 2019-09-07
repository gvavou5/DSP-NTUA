%Erwthma 2.1: Eyresh DFT N shmeiwn
function [Manual_DFT]=dft_manual(x,N)
%checkarw an to shma x einai mikrotero se mhkos apo N
%an einai efarmozw zero-padding
l=length(x);
if l<N
    for j=(l+1):N
        x(j)=0;
    end
end
%logw ths deiktodothshs pinakwn sto matlab trexw to k apo 1 mexri N 
for k=1:N
    Manual_DFT(k)=0;
    for n=1:N
        %efarmozw ton orismo tou DFT mono pou anti gia k bazw k-1 kai anti
        %gia n bazw n-1 logw tou tropou deiktodothshs pinakwn sto matlab
        Manual_DFT(k)=Manual_DFT(k)+x(n)*exp(-1j*2*pi*(n-1)*(k-1)/N);
    end
    fft(x);
    %vazw edw th synarthsh ayth gia na checkarw an ta apotelesmata ths dikhs 
    %mou synarthshs sympiptoun me th synarthsh fft tou matlab pragma pou isxyei 
    %(gia na to checkarw apla afairw to semicolumn apo thn entolh fft(x);)
end

    