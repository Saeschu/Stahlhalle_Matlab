

%Dokument 'Lagerhalle_Darstellung' �ffnen (Ausgangswerte enthalten)
%und einmal 'Run', damit Ausgangswerte in Workspace

%Anzahl Pfetten abh�ngig von Breite
%Pfettenabstand
n1=(b/a1)               %Anzahl Pfetten, wenn Abstand 1.0m
a15=1.5                 %Definition von a15; Pfettenabstand 1.5m
n15=(b/a15)             %Anzahl Pfetten, wenn Abstand 1.5m
npres=0                 %entg�ltige Anzahl an Pfetten, um dann weiterzurechnen

if n15==round(n15)      %Wenn n15 ganze Zahl, 
    npres=n15+1         %+1 weil Endst�tze hinzukommt
elseif n1==round(n1)    %Wenn n1 ganze Zahl,
    npres=n1+1          %+1 weil Endst�tze hinzukommt
else n15~=round(n15)    %Wenn n15 keine ganze Zahl,
    npres=ceil(n15)+1   %Aufrunden, dass n15 ganz wird (+1 weil Endst�tze hinzukommt)
end
apres=(b/(npres-1))      %resultierender Pfettenabstand (variert zwischen 1 und 1.5)


%Anzahl Binder abh�ngig von L�nge und Abstand
nr=(l/a)               %Anzahl Rahmen, gegeben durch (L�nge/Abstand) von Benutzer gew�hlt
nrres=0                %Anzahl Rahmen, um dann weiterzurechnen

if nr==round(nr)       %Wenn nl ganze Zahl, 
    nrres=nr+1         %+1 weil Endrahmen hinzukommt

else nr~=round(nr)     %Wenn nl keine ganze Zahl,
    nrres=ceil(nr)+1   %Aufrunden, dass n15 gerade wird (+1 weil Endst�tze hinzukommt)
                       %Ver�ndert den eingegebenen Abstand, damit eine
                       %ganze Anzahl an Rahmen entseht
end
arres=(l/(nrres-1))     %resultierender Abstand der Rahmen
                       %weicht vom eingegebenen a ab, wenn (L�nge/Abstand)
                       %keine ganze Zahl ergibt
                       
%Ende Aufbau der Abst�nde (Pfetten und Rahmen) und Anahl (Pfetten und
%Rahmen)

%Beginn Aufteilung der Fl�chenlast auf Pfetten -> erster und letzter Rahmen
%Grundlage f�r Matrix f�r Simon
                      
q=10                            %Fl�chenlast (nicht offiziel, �ndern nach Saschas Eingabefenster)
F1PA=(q*(apres/2)*(arres/2))    %Fl�chenlast auf dem ersten Rahmnen, erste Pfette
                                %Namensgebung: F=Kraft,1=Erster Rahmen,
                                %PA=erste Pfette
F1PB=(q*apres*(arres/2))        %Fl�chenlast auf dem ersten Rahmnen, erste Pfette
                                %Namensgebung: F=Kraft,1=Erster Rahmen,
                                %PB=zweite Pfette oder alle mittlere
                                %Pfetten (alle gleich)

for w=0:(npres-2)               %w=Anzahl Mittelpfetten abh�ngig von der eingegebenen Breite
    w=w
end

Anz1PMi=linspace(F1PB,F1PB,w)   %Voraufbau f�r Matrix
FR1=[F1PA,Anz1PMi,F1PA]         %Matrix f�r alle Kr�fte auf ersten Rahmen 

%Aufbau f�r Matrix 'Distanz x'

u=(npres-2)                     %u=Anzahl Mittelpfetten
uapres=u*apres                  %uapres=H�chste Distanz der Mittelpfette
aMittelstueke=linspace(apres,uapres,u)  %Normalverteilung der Abst�nde der Mittelpfetten)
Distanzx=[0,aMittelstueke,b]    %Distanzmatrix

%Aufteilung der Fl�chenlast auf Pfetten -> mittlere Rahmen (alle gleich)
FMPA=(q*(apres/2)*arres)        %Aufbau Name: F=Kraft, M=Mittlere Rahmen PA=erste Pfette 
FMPB=(q*apres*arres)            %Aufbau Name: F=Kraft, M=Mittlere Rahmen PA=mittlere Pfette

for v=0:(npres-2)               %Anzahl mittlere Pfetten
    v=v                         %Merke erst jetzt, dass auch w gehen w�rde, sorry (oben definiert)
end 

                                %AnzahlMitteRahm=v
AnzMiPMi=linspace(FMPB,FMPB,v)  %Anzahl Mittlere Pfetten, generierung f�r Matrix
FR2=[FMPA,AnzMiPMi,FMPA]       %Matrix Kr�fte auf mittleren Rahmen


%Aufbau Mastermatrix
AA{1,1} = 'Rahmen1 und letzter'; %Name des ersten und letzen Rahmens
AA{1,2} = FR1;                   %Matrix mit Kr�ften des ersten Rahmens
AA{1,3} = Distanzx;              %Matrix mit den Distanzen der Pfetten von links

BB{1,1} = 'Rahmen Mitte';        %Name der mittleren Rahmen, alle identisch
BB{1,2} = FR2;                   %Matrix mit Kr�ften der mittleren Rahmen
BB{1,3} = Distanzx;              %Matrix mit den Distanzen der Pfetten von links

EinwirkungenaufRahmen = cat(3,AA,BB);    %Generiung der Matrix in Matrix
