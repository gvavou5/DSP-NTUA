function [b,M] = ltp(lpc_error)
%autocorr and find b M like part 3
Autocorrelation_matrix = xcorr(lpc_error);
Autocorrelation_matrix=Autocorrelation_matrix'; 
Where_to_Search=Autocorrelation_matrix(1540:2879);
[MaxR,MaxInd]=max(Where_to_Search); 
 M=MaxInd+100; 
 b(1:1440)=0;
 b(M)=Autocorrelation_matrix(M)/Autocorrelation_matrix(1440); 