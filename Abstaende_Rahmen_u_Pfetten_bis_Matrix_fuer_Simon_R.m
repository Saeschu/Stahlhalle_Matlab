

%Dokument 'Lagerhalle_Darstellung' öffnen (Ausgangswerte enthalten)
%und einmal 'Run', damit Ausgangswerte in Workspace

%Anzahl Pfetten abhängig von Breite
%Pfettenabstand
n1=(b/a1)               %Anzahl Pfetten, wenn Abstand 1.0m
a15=1.5                 %Definition von a15; Pfettenabstand 1.5m
n15=(b/a15)             %Anzahl Pfetten, wenn Abstand 1.5m
npres=0                 %entgültige Anzahl an Pfetten, um dann weiterzurechnen

if n15==round(n15)      %Wenn n15 ganze Zahl, 
    npres=n15+1         %+1 weil Endstütze hinzukommt
elseif n1==round(n1)    %Wenn n1 ganze Zahl,
    npres=n1+1          %+1 weil Endstütze hinzukommt
else n15~=round(n15)    %Wenn n15 keine ganze Zahl,
    npres=ceil(n15)+1   %Aufrunden, dass n15 ganz wird (+1 weil Endstütze hinzukommt)
end
apres=(b/(npres-1))      %resultierender Pfettenabstand (variert zwischen 1 und 1.5)


%Anzahl Binder abhängig von Länge und Abstand
nr=(l/a)               %Anzahl Rahmen, gegeben durch (Länge/Abstand) von Benutzer gewählt
nrres=0                %Anzahl Rahmen, um dann weiterzurechnen

if nr==round(nr)       %Wenn nl ganze Zahl, 
    nrres=nr+1         %+1 weil Endrahmen hinzukommt

else nr~=round(nr)     %Wenn nl keine ganze Zahl,
    nrres=ceil(nr)+1   %Aufrunden, dass n15 gerade wird (+1 weil Endstütze hinzukommt)
                       %Verändert den eingegebenen Abstand, damit eine
                       %ganze Anzahl an Rahmen entseht
end
arres=(l/(nrres-1))     %resultierender Abstand der Rahmen
                       %weicht vom eingegebenen a ab, wenn (Länge/Abstand)
                       %keine ganze Zahl ergibt
                       
%Ende Aufbau der Abstände (Pfetten und Rahmen) und Anahl (Pfetten und
%Rahmen)

%Beginn Aufteilung der Flächenlast auf Pfetten -> erster und letzter Rahmen
%Grundlage für Matrix für Simon
                      
q=10                            %Flächenlast (nicht offiziel, ändern nach Saschas Eingabefenster)
F1PA=(q*(apres/2)*(arres/2))    %Flächenlast auf dem ersten Rahmnen, erste Pfette
                                %Namensgebung: F=Kraft,1=Erster Rahmen,
                                %PA=erste Pfette
F1PB=(q*apres*(arres/2))        %Flächenlast auf dem ersten Rahmnen, erste Pfette
                                %Namensgebung: F=Kraft,1=Erster Rahmen,
                                %PB=zweite Pfette oder alle mittlere
                                %Pfetten (alle gleich)

for w=0:(npres-2)               %w=Anzahl Mittelpfetten abhängig von der eingegebenen Breite
    w=w
end

Anz1PMi=linspace(F1PB,F1PB,w)   %Voraufbau für Matrix
FR1=[F1PA,Anz1PMi,F1PA]         %Matrix für alle Kräfte auf ersten Rahmen 

%Aufbau für Matrix 'Distanz x'

u=(npres-2)                     %u=Anzahl Mittelpfetten
uapres=u*apres                  %uapres=Höchste Distanz der Mittelpfette
aMittelstueke=linspace(apres,uapres,u)  %Normalverteilung der Abstände der Mittelpfetten)
Distanzx=[0,aMittelstueke,b]    %Distanzmatrix

%Aufteilung der Flächenlast auf Pfetten -> mittlere Rahmen (alle gleich)
FMPA=(q*(apres/2)*arres)        %Aufbau Name: F=Kraft, M=Mittlere Rahmen PA=erste Pfette 
FMPB=(q*apres*arres)            %Aufbau Name: F=Kraft, M=Mittlere Rahmen PA=mittlere Pfette

for v=0:(npres-2)               %Anzahl mittlere Pfetten
    v=v                         %Merke erst jetzt, dass auch w gehen würde, sorry (oben definiert)
end 

                                %AnzahlMitteRahm=v
AnzMiPMi=linspace(FMPB,FMPB,v)  %Anzahl Mittlere Pfetten, generierung für Matrix
FR2=[FMPA,AnzMiPMi,FMPA]       %Matrix Kräfte auf mittleren Rahmen


%Aufbau Mastermatrix
AA{1,1} = 'Rahmen1 und letzter'; %Name des ersten und letzen Rahmens
AA{1,2} = FR1;                   %Matrix mit Kräften des ersten Rahmens
AA{1,3} = Distanzx;              %Matrix mit den Distanzen der Pfetten von links

BB{1,1} = 'Rahmen Mitte';        %Name der mittleren Rahmen, alle identisch
BB{1,2} = FR2;                   %Matrix mit Kräften der mittleren Rahmen
BB{1,3} = Distanzx;              %Matrix mit den Distanzen der Pfetten von links

EinwirkungenaufRahmen = cat(3,AA,BB);    %Generiung der Matrix in Matrix
