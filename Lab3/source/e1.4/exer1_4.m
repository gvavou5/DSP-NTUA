w = 2*pi*2000;
gwnia_s = pi/2;

%erwtima 1
d = 0.04;
N = 4;
gwnia = linspace(0,180,2000);
B = beam(d, N, gwnia_s, gwnia, w);
figure(1);
plot(gwnia, 20*log(abs(B)),'r');
hold on;
N = 8;
B = beam(d, N, gwnia_s, gwnia, w);
plot(gwnia, 20*log(abs(B)),'g');
N = 16;
B = beam(d, N, gwnia_s, gwnia, w);
plot(gwnia,20*log(abs(B)),'b');

%erwtima 2
N = 8;
d = 0.04;
B = beam(d, N, gwnia_s, gwnia, w);
figure(2);
plot(gwnia, 20*log(abs(B)),'r');
hold on;
d = 0.08;
B = beam(d, N, gwnia_s, gwnia, w);
plot(gwnia, 20*log(abs(B)),'g');
d = 0.16;
B = beam(d, N, gwnia_s, gwnia, w);
plot(gwnia,20*log(abs(B)),'b');

% erwtima 3
N = 8;
w = 2*pi*1500;
d = 0.04;
gwnia = 0;
gwnia = linspace(-180,180,4000);
gwnia_s = 0;
B= beam(d,N,gwnia_s,gwnia,w);
figure(3);
semilogr_polar(linspace(-pi,pi,4000), (abs(B)).^2, 'r');
hold on;
gwnia_s = pi/4;
B= beam(d,N,gwnia_s,gwnia,w);
semilogr_polar(linspace(-pi,pi,4000), (abs(B)).^2, 'g');
gwnia_s = pi/2;
B= beam(d,N,gwnia_s,gwnia,w);
semilogr_polar(linspace(-pi,pi,4000), (abs(B)).^2, 'b');