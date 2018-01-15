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

%Fundamente Rahmen
ksm=40000   %Ton weich
sm=0.005    %5mm Setzung
o2=ksm*sm   %Randspannung=Bettungsmodul*Setzung

N=2000      %Normalkraft
M=1000      %Moment  
H=0         %Horizontalkraft
hf=1        %Einbindetiefe

bf1=((M+H*hf)/N)*6   %Breite aufgrund von Kernpunkt
if bf1<=0.4          %Mindesbreite
    bf1=0.4          
else bf1=((M+(H*hf))/N)*6 %grösser als Mindesbreite
end

tf1=2*N/(o2*bf)      %Länge aufgrund Einwirkung
if tf1<=0.4          %Mindeslänge
    tf1=0.4
else tf1=2*N/(o2*bf)      %Länge aufgrund Einwirkung
end

bf2=((M+H*hf)/N)*6   %Breite aufgrund von Kernpunkt
if bf2<=0.4          %Mindesbreite
    bf2=0.4          
else bf2=((M+(H*hf))/N)*6 %grösser als Mindesbreite
end

tf2=2*N/(o2*bf)      %Länge aufgrund Einwirkung
if tf2<=0.4          %Mindeslänge
    tf2=0.4
else tf2=2*N/(o2*bf)      %Länge aufgrund Einwirkung
end

%hf= 1.0;    %Höhe Fundament
%bf= 0.4;    %Breite Fundament
%tf= 0.4;    %Länge Fundament

%N=2000     %Fiktive Normalkraft
%M=10       %Fiktives Moment
%H=900      %Fiktive Horizontalkraft

%Fundamente Pendelstütze (Kein Moment)
om=ksm*sm  %Bodenspannung Mitte

%om=Kraft /Fläche

FAM=N/om    %Fläche um Normalkraft aufzunehmen

blm=sqrt(FAM) %quadratisches Fundament