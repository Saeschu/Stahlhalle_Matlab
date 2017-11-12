function ZeichneFachwerk3D(knoten,staebe,lager,belastungen)

%interne Hilfsfunktion
    function ZeichneBunteLinie(A,B,Farbe)
        line([A(1) B(1)],[A(2) B(2)],[A(3) B(3)],'Color',Farbe)
    end

%Beginn Hauptfunktion
close all                   % schliesse alle Fenster

K=size(knoten,1);           % Anzahl Knoten = Anzahl Zeilen (1. Dimension) von knoten
N=size(staebe,1);           % Anzahl Stäbe
M=size(lager,1);            % Anzahl Lagerkräfte
L=size(belastungen,1);      % Anzahl Lastkräfte

hold on                     % damit gezeichnete Linien nicht gleich wieder gelöscht werden
axis equal;                 % gleicher Massstab auf beiden Achsen
pfeillaenge = 0.3;          % kann angepasst werden

% Stäbe zeichnen

for i=1:N
   startknoten = staebe(i,1);             % Knotennummer Startknoten
   endknoten   = staebe(i,2);             % Knotennummer Endknoten
   stabanfang = knoten(startknoten, :);   % Koordinaten Stabanfang
   stabende   = knoten(endknoten  , :);   % Koordinaten Stabende
   ZeichneBunteLinie(stabanfang, stabende, 'black')
   % Stäbe mittig beschriften
   Mx=(stabanfang(1)+stabende(1))/2;
   My=(stabanfang(2)+stabende(2))/2;
   Mz=(stabanfang(3)+stabende(3))/2;
   text(Mx,My,Mz,strcat('S',num2str(i)),'FontSize',14)
end

%Knoten beschriften

for i=1:K
   Kx=knoten(i,1);
   Ky=knoten(i,2);
   Kz=knoten(i,3);
   text(Kx,Ky,Kz,strcat('K',num2str(i)),'FontSize',14)
end

% Lagerkräfte zeichnen

for i=1:M
   lagerknoten=lager(i,1);
   if(lager(i,2)==1)     % in x-Richtung
       pfeilstart=knoten(lagerknoten,:) - [1,0,0] * pfeillaenge;
       pfeilende =knoten(lagerknoten,:) + [1,0,0] * pfeillaenge;
   end
   if(lager(i,2)==2)     % in y-Richtung
       pfeilstart=knoten(lagerknoten,:) - [0,1,0] * pfeillaenge;
       pfeilende =knoten(lagerknoten,:) + [0,1,0] * pfeillaenge;
   end
   if(lager(i,2)==3)     % in z-Richtung
       pfeilstart=knoten(lagerknoten,:) - [0,0,1] * pfeillaenge;
       pfeilende =knoten(lagerknoten,:) + [0,0,1] * pfeillaenge;
   end
   ZeichneBunteLinie(pfeilstart, pfeilende, 'green')
end

% Lastkräfte zeichnen

for i=1:L
   lastknoten=belastungen(i,1);
   if(belastungen(i,2)==1)   % in x-Richtung
       pfeilstart=knoten(lastknoten,:) - [1,0,0] * pfeillaenge;
       pfeilende =knoten(lastknoten,:) + [1,0,0] * pfeillaenge;
   end
   if(belastungen(i,2)==2)  % in y-Richtung
       pfeilstart=knoten(lastknoten,:) - [0,1,0] * pfeillaenge;
       pfeilende =knoten(lastknoten,:) + [0,1,0] * pfeillaenge;
   end
   if(belastungen(i,2)==3)  % in z-Richtung
       pfeilstart=knoten(lastknoten,:) - [0,0,1] * pfeillaenge;
       pfeilende =knoten(lastknoten,:) + [0,0,1] * pfeillaenge;
   end
   ZeichneBunteLinie(pfeilstart, pfeilende, 'red')
   %Wert der Lastkraft eintragen, Pos. je nach Vorz
   if belastungen(i,3)>0
       text(pfeilende(1),pfeilende(2),pfeilende(3),num2str(belastungen(i,3)),'FontSize',14)
   else
       text(pfeilstart(1),pfeilstart(2),pfeilstart(3),num2str(belastungen(i,3)),'FontSize',14)
   end
end
end