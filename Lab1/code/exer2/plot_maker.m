function plot_maker(N,w,x1,adder)
figure;
for i=1:30
    %se ka8e vhma meiwnw to w wste na plhsiazei to w1 kata to vhma=adder
    w=w-adder;
    %ypologizw to neo w
    w_diff=w-pi/9;
    %vriskw th diafora tou w2-w1 kai ksanaorizw to shma
    l=length(x1);
    n=0:(l-1);
    x2=0.8*exp(1j*(w*n+pi/36));
    window=hamming(l);
    y=window'.*(x1+x2);
    %checkarw thn periptwsh pou xreiazetai zero-padding
    if l<N
        for k=(l+1):N
            y(k)=0;
        end
    end
    %ypologizw ton DFT toy shmatos y
    Y=fft(y);
    if i==16
        figure;
    end
    if i>15
        subplot(3,5,i-15);
    else
        subplot(3,5,i);
    end
    plot (abs(Y))
    %gia na einai pio emfanh ta apotelesmata orizw mhkos tou a3ona x apo  0 ews 150
    %epeidh 8elw 30 epanalhpseis orizw 2 para8yra me 15 plots to ka8e ena wste ta 
    %apotelesmata na einai pio 3eka8ara
    xlim([0 150])
    title(w_diff)
end
    