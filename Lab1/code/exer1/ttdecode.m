function [Vector] = ttdecode (signIn)
%Skopos ths sunarthshs ttdecode einai na parei ena toniko shma kai na dwsei
%sthn eksodo ena dianusma me ta pshfia tou shmatos.
N=length(signIn);
i=1;
j=1;
%8ewrw oti ena toniko shma exei mhkos 1000 samples.
%O pinakas ShowBegin periexei 8a thn arxh ka8e tonou.
while i<N
    if ( signIn(i)~= 0 )
        ShowBegin(j)= i ;
        j=j+1;
        i=i+999;
    end
    i=i+1;
end
%Twra exw pou einai to prwto deigma ka8e tonou kai sunolika exw j-1 tonous.
N=j-1;
for i= 1:N
    m=1;
    e=0;
    %Ka8e tono ton bazw mesa ston pinaka ToneArray gia na ton epeksergastw.
    for b= (ShowBegin(i)):(ShowBegin(i)+999)
        ToneArray(m) = signIn(b);
        m=m+1;
    end
    ToneDft= abs(fft(ToneArray));
    ToneDft= ToneDft(1:500);
    %Pairnw apo 1:500 gia ton idio logo me auton tou erwthmatos 1.5
    p= find(ToneDft.^2>70000);
    as=p(1);
    ad=p(2);
    Sear(i)=  Search(as, ad); 
end
Vector = Sear ;
