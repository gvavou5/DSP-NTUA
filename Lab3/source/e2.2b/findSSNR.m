function [ssnr] = findSSNR(voice,M)
%computes snr of 'voice' in each one of the M frames
%after take the average of the SSNR.
L1 = length(voice);
L = floor(L1/M);
u = sum(voice(1:L).^2);
sum2 = 0;
for m=0:(M-1)
svoice = sum(voice((L*m+1):(L*m+L)).^2);
s = svoice - u;
temp = s/u;
if (temp>0)
    snr = 10*log10(temp);
    if (snr<-20) M=M-1;  
    elseif (snr>35)sum2 = sum2 +35;
    else sum2 = sum2 + snr;
    end
    else M = M-1;
end
end
ssnr = sum2/M;