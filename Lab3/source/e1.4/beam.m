function res = beam (d, N, ths, th, w)
    ans = (pi/180)*th;
    tmp = (w/(2*340))*d*(cos(ans)-cos(ths));
    res = (1/N)*sin(N*tmp)./sin(tmp);
end