

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
afix=(b/(npres-1))      %resultierender Pfettenabstand (variert zwischen 1 und 1.5)


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
ares=(l/(nrres-1))     %resultierender Abstand der Rahmen
                       %weicht vom eingegebenen a ab, wenn (Länge/Abstand)
                       %keine ganze Zahl ergibt
                      
