[x,fs]= wavread ('speech.wav');
%8a xrhsimopoihsw ena mono frame to opoio epilegw au8aireta
xx=x(1001:2440);
[a1, G1, lpc_error1, speech_frame_est1]=lpc_analysis (xx ,52 );
[a, G, lpc_error2, speech_frame_est]=lpc_analysis (xx ,26);

figure (1);
subplot(1,2,1) ; 
plot(lpc_error1,'color','green');
title ('LPC error , p=52');
subplot (1,2,2);
plot(lpc_error2,'color','red');
title ('LPC error , p=26');

%se koino diagramma exw to ekshs :
figure (2);
plot(lpc_error1,'color','green'); hold on; 
plot(lpc_error2,'color','red'); hold off;
title ('LPC error , p=52(green), p=26(red)');


%fasma lpc analysis kai fasma x[n] gia p=52
lpc_fasma= abs(fft(speech_frame_est1));
figure (3);
subplot(1,2,1) ; 
plot(20*log10(lpc_fasma), 'color' ,'green');
title ('20log10(|H(ejù)|)');
xx_fasma=abs((fft(xx)));
subplot (1,2,2);
plot(20*log10(xx_fasma), 'color', 'red');
title ('20log10(|X(ejù)|)');
%se koino diagramma
figure (4);
plot (20*log10(lpc_fasma),'color', 'green') ;
hold on;
plot (20*log10(xx_fasma), 'color', 'red') ;
hold off;
title ('20log10(|H(ejù)|)(green) , 20log10(|X(ejù)|)(red) ');


%fasma lpc analysis kai fasma x[n] gia p=26
lpc_fasma= abs(fft(speech_frame_est));
figure (5);
subplot(1,2,1) ; 
plot(20*log10(lpc_fasma), 'color' ,'green');
title ('20log10(|H(ejù)|)');
xx_fasma=abs((fft(xx)));
subplot (1,2,2);
plot(20*log10(xx_fasma), 'color', 'red');
title ('20log10(|X(ejù)|)');
%se koino diagramma
figure (6);
plot (20*log10(lpc_fasma),'color', 'green') ;
hold on;
plot (20*log10(xx_fasma), 'color', 'red') ;
hold off;
title ('20log10(|H(ejù)|)(green) , 20log10(|X(ejù)|)(red) ');