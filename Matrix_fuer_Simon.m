AR=ceil(l/a)+1
AK=ceil(b/a1)+1


z=1:((b/a1)-1)

x1= [0 j (j+(a1*(z))) b]


%Anzahl Pfetten abhängig von Breite
%Pfettenabstand
n1=(b/a1)               %Anzahl Knoten, wenn Abstand 1.0m
n15=(b/a15)             %Anzahl Knoten, wenn Abstand 1.5m
n1<=nfix>n15                  %Anzahl Knoten, um dann weiterzurechnen

if n15==round(n15)      %Wenn n15 gerade Zahl, 
    nfix=n15+1          %+1 weil Endstütze hinzukommt
elseif n1==round(n1)    %Wenn n1 gerade Zahl,
    nfix=n1+1           %+1 weil Endstütze hinzukommt
else n15~=round(n15)    %Wenn n15 keine gerade Zahl,
    nfix=ceil(n15)+1    %Aufrunden, dass n15 gerade wird (+1 weil Endstütze hinzukommt)
end
afix=(b/(nfix-1))       %resultierender Pfettenabstand