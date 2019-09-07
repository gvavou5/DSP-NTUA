%% Erwthma 3.1

x_voice=wavread('speech_utterance.wav');
%Find energy for 3 different window duration with 
%help of function energy_find
e= energy_find (x_voice,20);
figure;
plot (e);
e= energy_find (x_voice,40);
figure;
plot (e);
e= energy_find (x_voice,60);
figure;
plot (e);

%Find zero crossing rate for 3 different window duration 
%with help of function zcr
za= zcr (x_voice,20);
figure;
plot (za);
za= zcr (x_voice,40);
figure;
plot (za);
za= zcr (x_voice,60);
figure;
plot (za);

%% Erwtham 3.2 

%It's same as question 1, the only difference is the wav file

x_voice1=wavread('music.wav');
%energy
e1= energy_find (x_voice1,20);
figure;
plot (e1);
e1= energy_find (x_voice1,40);
figure;
plot (e1);
e1= energy_find (x_voice1,60);
figure;
plot (e1);

%zero crossing rate
za1= zcr (x_voice1,20);
figure;
plot (za1);
za1= zcr (x_voice1,40);
figure;
plot (za1);
za1= zcr (x_voice1,120);
figure;
plot (za1);
