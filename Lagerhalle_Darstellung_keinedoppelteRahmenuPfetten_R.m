clear all, clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Input Window
prompt = {'L�nge:','Breite:', 'H�he','Unterkannt', 'Abstand','ProfS','ProfT'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'30','27','3','0','4','0.2','0.3',''}; % Zahlenwerte k�nnen 'zwischen' entfert werden nur platzhalter
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
l= str2num(answer{1});
b= str2num(answer{2});
h= str2num(answer{3});
BedH=str2num(answer{4});
a= str2num(answer{5});
ProfS= str2num(answer{6});
ProfT= str2num(answer{7});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Textausgabe, Gesammtspannweite �berschreitet einzelspannweiten der Tr�ger.
%Berechnung kann nicht weiter ausgef�hrt werden.
if b > 39
    msgbox('Die gew�hlte Gesammtspannweite der Lagerhalle [Breite], �berschreitet die zul�ssige maximalspannweite von 39m. Berechnung mit mehr als 4 St�tzenreihen bzw. 3 B�gen ist zur zeit nicht m�glich.',...
        'Infobox')
    return 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if BedH==0        % Festlegung ob Hallenh�he unter oder oberkannte Balken ist... 0= Unterkannte, 1= Oberkannte
    h=h+2*ProfS
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set axis and figure
clf;
figure(1)
format compact
myaxes =axes('xlim', [0, b], 'ylim', [0, l], 'zlim', [0, h]);
axis equal
view(3)  %Erzeugung der 3D darstellung
grid on
xlabel('x - Breite')
ylabel('y - L�nge')
zlabel('z - H�he')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ba= b-ProfS           % Breite Achsabstand
%hI=h*(IT/IS)        %Vergleichsh�he f�r St�tze
%dx= 10              %Teilungsfaktor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Datenbank
ProfSb=ProfS;
ProfSt= ProfS/2;
ProfTh= ProfT;
ProfTb= ProfT/2;
%L�ngsbinder in Hallenbreite mit while schleife legen
a1= 1; %L�ngsbinderabstand 1,0...4,0m

% nur f�r testrechnung effektieve werte m�ssen abgef�llt werden f�r IPE un
% HEA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Anzahl Pfetten abh�ngig von Breite
%Pfettenabstand
n1=(b/a1);               %Anzahl Pfetten, wenn Abstand 1.0m
a15=1.5;                 %Definition von a15; Pfettenabstand 1.5m
n15=(b/a15);             %Anzahl Pfetten, wenn Abstand 1.5m
npres=0;                 %entg�ltige Anzahl an Pfetten, um dann weiterzurechnen

if n15==round(n15)      %Wenn n15 ganze Zahl, 
    npres=n15+1         %+1 weil Endst�tze hinzukommt
elseif n1==round(n1)    %Wenn n1 ganze Zahl,
    npres=n1+1          %+1 weil Endst�tze hinzukommt
else n15~=round(n15)    %Wenn n15 keine ganze Zahl,
    npres=ceil(n15)+1   %Aufrunden, dass n15 ganz wird (+1 weil Endst�tze hinzukommt)
end
apres=(b/(npres-1));      %resultierender Pfettenabstand (variert zwischen 1 und 1.5)

%Anzahl Binder abh�ngig von L�nge und Abstand
nr=(l/a);               %Anzahl Rahmen, gegeben durch (L�nge/Abstand) von Benutzer gew�hlt
nrres=0;                %Anzahl Rahmen, um dann weiterzurechnen

if nr==round(nr)       %Wenn nl ganze Zahl, 
    nrres=nr+1         %+1 weil Endrahmen hinzukommt

else nr~=round(nr)     %Wenn nl keine ganze Zahl,
    nrres=ceil(nr)+1;   %Aufrunden, dass n15 gerade wird (+1 weil Endst�tze hinzukommt)
                       %Ver�ndert den eingegebenen Abstand, damit eine
                       %ganze Anzahl an Rahmen entseht
end
arres=(l/(nrres-1));     %resultierender Abstand der Rahmen
                       %weicht vom eingegebenen a ab, wenn (L�nge/Abstand)
                       %keine ganze Zahl ergibt
                       
%Ende Aufbau der Abst�nde (Pfetten und Rahmen) und Anahl (Pfetten und
%Rahmen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Laengstraeger 1
vert1= [0 0 (h-ProfTh); ProfTb 0 (h-ProfTh); ProfTb 0 h; 0 0 h; ProfTb l h; 0 l h; 0 l (h-ProfTh); ProfTb l (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
fac= [1 2 3 4; 4 3 5 6; 6 7 8 5; 1 2 8 7; 6 7 1 4; 2 3 5 8];    % Welche Eckpunkte werden als eine Polygonfl�che eingef�rbt
patch('Faces', fac,'Vertices',vert1,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Laengstraeger 2
vert2= [(b-ProfTb) 0 (h-ProfTh); b 0 (h-ProfTh); b 0 h; (b-ProfTb) 0 h; b l h; (b-ProfTb) l h; (b-ProfTb) l (h-ProfTh); b l (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert2,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 1
vert3= [0 0 0; 0 ProfSt 0; ProfSb ProfSt 0; ProfSb 0 0; ProfSb ProfSt (h-2*ProfTh); ProfSb 0 (h-2*ProfTh); 0 0 (h-2*ProfTh); 0 ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 2
vert4= [b 0 0; b ProfSt 0; (b-ProfSb) ProfSt 0; (b-ProfSb) 0 0; (b-ProfSb) ProfSt (h-2*ProfTh); (b-ProfSb) 0 (h-2*ProfTh); b 0 (h-2*ProfTh); b ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert4,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 3
vert5= [0 (l-ProfSt) 0; 0 l 0; ProfSb l 0; ProfSb (l-ProfSt) 0; ProfSb l (h-2*ProfTh); ProfSb (l-ProfSb) (h-2*ProfTh); 0 (l-ProfSt) (h-2*ProfTh); 0 l (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 4
vert6= [b (l-ProfSt) 0; b l 0; (b-ProfSb) l 0; (b-ProfSb) (l-ProfSt) 0; (b-ProfSb) l (h-2*ProfTh); (b-ProfSb) (l-ProfSt) (h-2*ProfTh); b (l-ProfSt) (h-2*ProfTh); b l (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert6,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Wenn Hallenbreite gr�sser 13m ist wird eine weiter Sttzenreihe bei 1/2
%erg�nzt
%St�tzen anfang und ende
if b > 13 & b < 26
   SMb= (b/2) -(ProfSb/2);           %Hilfsgr�sse% Pos X (also St�tzenabstand) der St�zte. Einmitung auf Achsmass der St�tze
  
%Stuetze VM 
vert3= [SMb 0 0; SMb ProfSt 0; (SMb+ProfSb) ProfSt 0; (SMb+ProfSb) 0 0; (SMb+ProfSb) ProfSt (h-2*ProfTh); (SMb+ProfSb) 0 (h-2*ProfTh); SMb 0 (h-2*ProfTh); SMb ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze HM
vert5= [SMb (l-ProfSt) 0; SMb l 0; (SMb+ProfSb) l 0; (SMb+ProfSb) (l-ProfSt) 0; (SMb+ProfSb) l (h-2*ProfTh); (SMb+ProfSb) (l-ProfSt) (h-2*ProfTh); SMb (l-ProfSt) (h-2*ProfTh); SMb l (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)
end

% Wen Hallenbreite gr�sser 26m ist werden weiter St�tzenreihe bei 1/3 und 2/3
% erg�nzt
if b > 26
    S1b= (b/3) -(ProfSb/2);
    S2b= (2*b/3) -(ProfSb/2);
%Stuetze VM 1/3
vert3= [S1b 0 0; S1b ProfSt 0; (S1b+ProfSb) ProfSt 0; (S1b+ProfSb) 0 0; (S1b+ProfSb) ProfSt (h-2*ProfTh); (S1b+ProfSb) 0 (h-2*ProfTh); S1b 0 (h-2*ProfTh); S1b ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze HM 1/3
vert5= [S1b (l-ProfSt) 0; S1b l 0; (S1b+ProfSb) l 0; (S1b+ProfSb) (l-ProfSt) 0; (S1b+ProfSb) l (h-2*ProfTh); (S1b+ProfSb) (l-ProfSt) (h-2*ProfTh); S1b (l-ProfSt) (h-2*ProfTh); S1b l (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze VM 2/3
vert3= [S2b 0 0; S2b ProfSt 0; (S2b+ProfSb) ProfSt 0; (S2b+ProfSb) 0 0; (S2b+ProfSb) ProfSt (h-2*ProfTh); (S2b+ProfSb) 0 (h-2*ProfTh); S2b 0 (h-2*ProfTh); S2b ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze HM 2/3
vert5= [S2b (l-ProfSt) 0; S2b l 0; (S2b+ProfSb) l 0; (S2b+ProfSb) (l-ProfSt) 0; (S2b+ProfSb) l (h-2*ProfTh); (S2b+ProfSb) (l-ProfSt) (h-2*ProfTh); S2b (l-ProfSt) (h-2*ProfTh); S2b l (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Querbalken Anfang
vert7= [0 0 (h-2*ProfTh); 0 0 (h-ProfTh); 0 ProfTb (h-ProfTh); 0 ProfTb (h-2*ProfTh); b ProfTb (h-ProfTh); b ProfTb (h-2*ProfTh); b 0 (h-2*ProfTh); b 0 (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert7,'FaceColor','g');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Querbalken Ende
vert8= [0 (l-ProfTb) (h-2*ProfTh); 0 (l-ProfTb) (h-ProfTh); 0 l (h-ProfTh); 0 l (h-2*ProfTh); b l (h-ProfTh); b l (h-2*ProfTh); b (l-ProfTb) (h-2*ProfTh); b (l-ProfTb) (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert8,'FaceColor','g');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Linker teil
j=0;
while j< (b-(apres))
    j=j+apres;
  XMRL = (j-(ProfTb/2));      %Hilfsgr�sse% Achsabstand der L�ngsbinder in While Schleife

vert13= [XMRL 0 (h-ProfTh); (XMRL+ProfTb) 0 (h-ProfTh); (XMRL+ProfTb) 0 h; XMRL 0 h; (XMRL+ProfTb) l h; XMRL l h; XMRL l (h-ProfTh); (XMRL+ProfTb) l (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert13,'FaceColor','m');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Binderi i St�tzen und Querbalken
i1=0;
while i1 < l-arres; 
       i1= i1 +arres;
   XMVQ = (i1-(ProfSt/2));           %Hilfsgr�sse% Achsabstand der St�tze in While Schleife

%Querbalken 
vert9= [0 XMVQ (h-2*ProfTh); 0 XMVQ (h-ProfTh); 0 (XMVQ+ProfSt) (h-ProfTh); 0 (XMVQ+ProfSt) (h-2*ProfTh); b (XMVQ+ProfSt) (h-ProfTh); b (XMVQ+ProfSt) (h-2*ProfTh); b XMVQ (h-2*ProfTh); b XMVQ (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze A
vert10= [0 XMVQ 0; 0 (XMVQ+ProfSt) 0; ProfSb (XMVQ+ProfSt) 0; ProfSb XMVQ 0; ProfSb (XMVQ+ProfSt) (h-2*ProfTh); ProfSb XMVQ (h-2*ProfTh); 0 XMVQ (h-2*ProfTh); 0 (XMVQ+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze B
vert11= [b XMVQ 0; b (XMVQ+ProfSt) 0; (b-ProfSb) (XMVQ+ProfSt) 0; (b-ProfSb) XMVQ 0; (b-ProfSb) (XMVQ+ProfSt) (h-2*ProfTh); (b-ProfSb) XMVQ (h-2*ProfTh); b XMVQ (h-2*ProfTh); b (XMVQ+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

% unter if bedingung eine while funktion definieren welche variabel die
% hallenaufteilung vornimmt
if b >13 & b < 26
%Stuetze VM
vert3= [SMb XMVQ 0; SMb (XMVQ+ProfSt) 0; (SMb+ProfSb) (XMVQ+ProfSt) 0; (SMb+ProfSb) XMVQ 0; (SMb+ProfSb) (XMVQ+ProfSt) (h-2*ProfTh); (SMb+ProfSb) XMVQ (h-2*ProfTh); SMb XMVQ (h-2*ProfTh); SMb (XMVQ+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)
end

if b > 26
%Stuetze VM 1/3
vert3= [S1b XMVQ 0; S1b (XMVQ+ProfSt) 0; (S1b+ProfSb) (XMVQ+ProfSt) 0; (S1b+ProfSb) XMVQ 0; (S1b+ProfSb) (XMVQ+ProfSt) (h-2*ProfTh); (S1b+ProfSb) XMVQ (h-2*ProfTh); S1b XMVQ (h-2*ProfTh); S1b (XMVQ+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)
%Stuetze VM 2/3
vert3= [S2b XMVQ 0; S2b (XMVQ+ProfSt) 0; (S2b+ProfSb) (XMVQ+ProfSt) 0; (S2b+ProfSb) XMVQ 0; (S2b+ProfSb) (XMVQ+ProfSt) (h-2*ProfTh); (S2b+ProfSb) XMVQ (h-2*ProfTh); S2b XMVQ (h-2*ProfTh); S2b (XMVQ+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)   
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
hf1= 1
bf1= 0.6

vert1= [-((bf1/2)-(IPE/2)) -((bf1/2)-(IPE/2)) -hf1; (bf1/2) -((bf1/2)-(IPE/2)) -hf1; (bf1/2) -((bf1/2)-(IPE/2)) 0; -((bf1/2)-(IPE/2)) -((bf1/2)-(IPE/2)) 0;...
    (bf1/2) (l + ((bf1/2)-(IPE/2))) 0; -((bf1/2)-(IPE/2)) (l + ((bf1/2)-(IPE/2))) 0; -((bf1/2)-(IPE/2)) (l+ ((bf1/2)-(IPE/2))) -hf1; (bf1/2) (l+ ((bf1/2)-(IPE/2))) -hf1]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert1,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Fundament -Variante 2 Einzelfundament

vert1= [(b-(bf1/2)) -((bf1/2)-(IPE/2)) -hf1; (b+(bf1/2)-(IPE/2)) -((bf1/2)-(IPE/2)) -hf1; (b+(bf1/2)-(IPE/2)) -((bf1/2)-(IPE/2)) 0; (b-(bf1/2)) -((bf1/2)-(IPE/2)) 0;...
    (b+(bf1/2)) ((bf1/2)-(IPE/2)) 0; (b-((bf1/2)-(IPE/2))) ((bf1/2)-(IPE/2)) 0; (b-((bf1/2)-(IPE/2))) ((bf1/2)-(IPE/2)) -hf1; (b+(bf1/2)) ((bf1/2)-(IPE/2)) -hf1]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert1,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%}