function [Right_Shifted] = timeShift(Signal, synt)
DFT_signal = fft(Signal);
w1 = linspace(0,2*pi,length(DFT_signal)); 
w = w1*48000; 
Hd = exp(-1i*w*synt);
Right_Shifted = ifft(DFT_signal .* Hd');