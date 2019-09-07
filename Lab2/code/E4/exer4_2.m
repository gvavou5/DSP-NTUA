clear all;
close all;
%the first few steps are equivalent to 4_1
load ('pitch.mat');
[signal, Fs] = wavread('speech.wav');
buffered_signal= buffer(signal,0.030*48000,0.020*48000);
w=hamming(0.030*48000);
load ('pitch.mat');
pitch(length(pitch)+1:size(buffered_signal,2)) = 0;
for i = 1:size(buffered_signal,2)
	s(:,i) = buffered_signal(:,i).*w;
	[a(i,:), G(i), lpc_error,speech_frame_est] = lpc_analysis(s(:,i), 52);
	k(i,:) = poly2rc(a(i,:));
	g(i,:) = log10((1-k(i,:))./(1+k(i,:)));
	if pitch(i) ~= 0
		Pitch_Check(i) = 1;
    else
        Pitch_Check(i) = 0;
    end
    [b(i,:),M(i)] = ltp(lpc_error);
end
log_area_ratio_quant = linearQuantizer(g,5);
pitch_quant = linearQuantizer(pitch,6);
Tone_Quant = linearQuantizer(Pitch_Check,1);
Gain_Quant = 10.^(linearQuantizer(log10(G),5));
bi_Quant=linearQuantizer(b,5);
Mi_Quant=10.^(linearQuantizer(log10(M),5));
for i = 1:size(buffered_signal,2)
	ki_Quant(i,:) = (1-10.^log_area_ratio_quant(i,:))./(1+10.^log_area_ratio_quant(i,:));
	ai_Quant(i,:) = rc2poly(ki_Quant(i,:));
    b_Quant(i,1) = 1;
	b_Quant(i,(2:M(i))) = 0;
	b_Quant(i,(M(i)+1)) = (-1)*bi_Quant(i); 
end
synthesized_voice = Quantized_Values_Celp_Vocoder(279563, Fs ,0.030*48000,0.020*48000,Gain_Quant,ai_Quant,b_Quant,583,s);

%Normalize so to have right size for wavwrite
synthesized_voice = synthesized_voice/(max(abs(synthesized_voice)));

wavwrite(synthesized_voice, Fs, 'synthesis_encoded_celp.wav');
