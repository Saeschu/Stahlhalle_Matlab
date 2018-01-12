%Fundamente 

%Für Auswahlfenster
%zulässige Setzungen sm
%5mm Setzung ->  sm=0.005 [m]
%10mm Setzung -> sm=0.01 [m]
%15mm Setzung -> sm=0.015 [m]

%Bettungsmodule ksm
%Ton,weich= 40 [MN/m3]
%Sand, dicht= 100 [MN/m3]
%Kies, grob mit Sand= 240 [MN/m3]

ksm=40000
sm=0.005
o2=ksm*sm   %Randspannung=Bettungsmodul*Setzung

N=2000
M=1000
H=0
hf=1        %Einbindetiefe

bf=((M+H*hf)/N)*6   %Breite aufgrund von Kernpunkt
if bf<=0.4          %Mindesbreite
    bf=0.4          
else bf=((M+(H*hf))/N)*6 %grösser als Mindesbreite
end

tf=2*N/(o2*bf)      %Länge aufgrund Einwirkung
if tf<=0.4          %Mindeslänge
    tf=0.4
else tf=2*N/(o2*bf)      %Länge aufgrund Einwirkung
end



%hf= 1.0;    %Höhe Fundament
%bf= 0.4;    %Breite Fundament
%tf= 0.4;    %Länge Fundament


%N=2000       %Fiktive Normalkraft
%M=10       %Fiktives Moment
%H=900       %Fiktive Horizontalkraft