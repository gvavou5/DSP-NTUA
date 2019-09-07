%Exercise 4.1
clear all;
[signal, Fs] = wavread('speech.wav');
%windows:30ms shift:20ms
buffered_signal = buffer(signal,1440,960);
w=hamming(1440);
load ('pitch.mat');
%zero pad in pitch from 580 to 583
pitch(length(pitch)+1:size(buffered_signal,2)) = 0;
%for loop:every frame till the end of the signal
for i = 1:size(buffered_signal,2)
	signals_frames(:,i) = buffered_signal(:,i).*w;
	%find linear prediction coefficients and gain to quantize later
	[a(i,:), G(i), lpc_error,speech_frame_est] = lpc_analysis(signals_frames(:,i), 52);
	%find reflection coeffficients
	k(i,:) = poly2rc(a(i,:));
	%calculate log-area-ratios
	g(i,:) = log10((1-k(i,:))./(1+k(i,:)));
	%voiced or unvoiced sound?
	if pitch(i) ~= 0
		Pitch_Check(i) = 1;
    else
        Pitch_Check(i) = 0;
	end
end
%functions for quantization(levels of quantization)
gi_Quant = linearQuantizer(g,5);
Pitch_Quant = linearQuantizer(pitch,6);
Tone_Quant = linearQuantizer(Pitch_Check,1);
Gain_Quant = 10.^(linearQuantizer(log10(G),5));
%quantization of lpc and rpc
for i = 1:size(buffered_signal,2)
	ki_Quant(i,:) = (1-10.^gi_Quant(i,:))./(1+10.^gi_Quant(i,:));
	ai_Quant(i,:) = rc2poly(ki_Quant(i,:));
end
%send to modified vocoder
final_voice = Quantized_Values_Vocoder(279563, Fs ,0.030*48000,0.020*48000,Pitch_Check,Gain_Quant,ai_Quant,583);

%Normalize so to have right size for wavwrite
final_voice = final_voice/(max(abs(final_voice)));

wavwrite(final_voice, Fs, 'synthesis_encoded_lpc.wav');
