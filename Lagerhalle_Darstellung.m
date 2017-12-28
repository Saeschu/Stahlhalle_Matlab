clear all, clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Input Window
prompt = {'Länge:','Breite:', 'Höhe','Unterkannt', 'Abstand','ProfS','ProfT'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'30','20','3','0','4','0.2','0.3',''}; % Zahlenwerte können 'zwischen' entfert werden nur platzhalter
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
l= str2num(answer{1});
b= str2num(answer{2});
h= str2num(answer{3});
BedH=str2num(answer{4});
a= str2num(answer{5});
ProfS= str2num(answer{6});
ProfT= str2num(answer{7});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if BedH==0        % Festlegung ob Hallenhöhe unter oder oberkannte Balken ist... 0= Unterkannte, 1= Oberkannte
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
ylabel('y - Länge')
zlabel('z - Höhe')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ba= b-ProfS           % Breite Achsabstand
%hI=h*(IT/IS)        %Vergleichshöhe für Stütze
%dx= 10              %Teilungsfaktor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Datenbank
ProfSb=ProfS;
ProfSt= ProfS/2;
ProfTh= ProfT;
ProfTb= ProfT/2;
% nur für testrechnung effektieve werte müssen abgefüllt werden für IPE un
% HEA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Laengstraeger 1
vert1= [0 0 (h-ProfTh); ProfTb 0 (h-ProfTh); ProfTb 0 h; 0 0 h; ProfTb l h; 0 l h; 0 l (h-ProfTh); ProfTb l (h-ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
fac= [1 2 3 4; 4 3 5 6; 6 7 8 5; 1 2 8 7; 6 7 1 4; 2 3 5 8];    % Welche Eckpunkte werden als eine Polygonfläche eingefärbt
patch('Faces', fac,'Vertices',vert1,'FaceColor','b');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Laengstraeger 2
vert2= [(b-ProfTb) 0 (h-ProfTh); b 0 (h-ProfTh); b 0 h; (b-ProfTb) 0 h; b l h; (b-ProfTb) l h; (b-ProfTb) l (h-ProfTh); b l (h-ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert2,'FaceColor','b');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 1
vert3= [0 0 0; 0 ProfSt 0; ProfSb ProfSt 0; ProfSb 0 0; ProfSb ProfSt (h-2*ProfTh); ProfSb 0 (h-2*ProfTh); 0 0 (h-2*ProfTh); 0 ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','r');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 2
vert4= [b 0 0; b ProfSt 0; (b-ProfSb) ProfSt 0; (b-ProfSb) 0 0; (b-ProfSb) ProfSt (h-2*ProfTh); (b-ProfSb) 0 (h-2*ProfTh); b 0 (h-2*ProfTh); b ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert4,'FaceColor','r');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 3
vert5= [0 (l-ProfSt) 0; 0 l 0; ProfSb l 0; ProfSb (l-ProfSt) 0; ProfSb l (h-2*ProfTh); ProfSb (l-ProfSb) (h-2*ProfTh); 0 (l-ProfSt) (h-2*ProfTh); 0 l (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','r');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 4
vert6= [b (l-ProfSt) 0; b l 0; (b-ProfSb) l 0; (b-ProfSb) (l-ProfSt) 0; (b-ProfSb) l (h-2*ProfTh); (b-ProfSb) (l-ProfSt) (h-2*ProfTh); b (l-ProfSt) (h-2*ProfTh); b l (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert6,'FaceColor','r');            % Erzeugen der Gefärbten Flächen (Polygonen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Wenn Hallenbreite grösser 13m ist wird weine weitere Stützenreie in die
%Mitte geleg
%Stützen anfang und ende
if b > 13
   SMb= (b/2) -(ProfSb/2);           %Hilfsgrösse% Pos X (also Stützenabstand) der Stüzte. Einmitung auf Achsmass der Stütze
  
   %Stuetze VM
vert3= [SMb 0 0; SMb ProfSt 0; (SMb+ProfSb) ProfSt 0; (SMb+ProfSb) 0 0; (SMb+ProfSb) ProfSt (h-2*ProfTh); (SMb+ProfSb) 0 (h-2*ProfTh); SMb 0 (h-2*ProfTh); SMb ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze HM
vert5= [SMb (l-ProfSt) 0; SMb l 0; (SMb+ProfSb) l 0; (SMb+ProfSb) (l-ProfSt) 0; (SMb+ProfSb) l (h-2*ProfTh); (SMb+ProfSb) (l-ProfSt) (h-2*ProfTh); SMb (l-ProfSt) (h-2*ProfTh); SMb l (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','c');            % Erzeugen der Gefärbten Flächen (Polygonen)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Querbalken Anfang
vert7= [0 0 (h-2*ProfTh); 0 0 (h-ProfTh); 0 ProfTb (h-ProfTh); 0 ProfTb (h-2*ProfTh); b ProfTb (h-ProfTh); b ProfTb (h-2*ProfTh); b 0 (h-2*ProfTh); b 0 (h-ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert7,'FaceColor','g');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Querbalken Ende
vert8= [0 (l-ProfTb) (h-2*ProfTh); 0 (l-ProfTb) (h-ProfTh); 0 l (h-ProfTh); 0 l (h-2*ProfTh); b l (h-ProfTh); b l (h-2*ProfTh); b (l-ProfTb) (h-2*ProfTh); b (l-ProfTb) (h-ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert8,'FaceColor','g');            % Erzeugen der Gefärbten Flächen (Polygonen)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Längsbinder in Hallenbreite mit while schleife legen
a1= 1; %Längsbinderabstand 1,0...4,0m
%Linker teil
j= (b/2);
while j> a1
    j=j-a1;
  XMRL = (j-(ProfTb/2));      %Hilfsgrösse% Achsabstand der Längsbinder in While Schleife

vert13= [XMRL 0 (h-ProfTh); (XMRL+ProfTb) 0 (h-ProfTh); (XMRL+ProfTb) 0 h; XMRL 0 h; (XMRL+ProfTb) l h; XMRL l h; XMRL l (h-ProfTh); (XMRL+ProfTb) l (h-ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert13,'FaceColor','m');            % Erzeugen der Gefärbten Flächen (Polygonen)   
end
%rechter teil
j1=-a1;
while j1<=(b/2)-a1-ProfTb
    j1=j1+a1;
 XMLL = ((b/2)+j1-(ProfTb/2));      %Hilfsgrösse% Achsabstand der Längsbinder in While Schleife

 vert12= [XMLL 0 (h-ProfTh); (XMLL+ProfTb) 0 (h-ProfTh); (XMLL+ProfTb) 0 h; XMLL 0 h; (XMLL+ProfTb) l h; XMLL l h; XMLL l (h-ProfTh); (XMLL+ProfTb) l (h-ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert12,'FaceColor','m');            % Erzeugen der Gefärbten Flächen (Polygonen)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Binderi i Stützen und Querbalken
%Aufbau von der Mitte aus um Anfang und Endabstand Binder-Stütze gleich
%gross zu halten
%Hinterteil
i=-a;
while i <= (l/2)-a-ProfSt;         
      i= i + a;
   XMHQ = ((l/2)+i-(ProfSt/2));      %Hilfsgrösse% Achsabstand der Stützen in While Schleife

%Querbalken 
vert9= [0 XMHQ (h-2*ProfTh); 0 XMHQ (h-ProfTh); 0 (XMHQ+ProfSt) (h-ProfTh); 0 (XMHQ+ProfSt) (h-2*ProfTh); b (XMHQ+ProfSt) (h-ProfTh); b (XMHQ+ProfSt) (h-2*ProfTh); b XMHQ (h-2*ProfTh); b XMHQ (h-ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze A
vert10= [0 XMHQ 0; 0 (XMHQ+ProfSt) 0; ProfSb (XMHQ+ProfSt) 0; ProfSb XMHQ 0; ProfSb (XMHQ+ProfSt) (h-2*ProfTh); ProfSb (XMHQ+ProfSt) (h-2*ProfTh); 0 XMHQ (h-2*ProfTh); 0 (XMHQ+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze B
vert11= [b XMHQ 0; b (XMHQ+ProfSt) 0; (b-ProfSb) (XMHQ+ProfSt) 0; (b-ProfSb) XMHQ 0; (b-ProfSb) (XMHQ+ProfSt) (h-2*ProfTh); (b-ProfSb) XMHQ (h-2*ProfTh); b XMHQ (h-2*ProfTh); b (XMHQ+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

if b >13
    %Stuetze VM   
vert3= [SMb XMHQ 0; SMb (XMHQ+ProfSt) 0; (SMb+ProfSb) (XMHQ+ProfSt) 0; (SMb+ProfSb) XMHQ 0; (SMb+ProfSb) (XMHQ+ProfSt) (h-2*ProfTh); (SMb+ProfSb) XMHQ (h-2*ProfTh); SMb XMHQ (h-2*ProfTh); SMb (XMHQ+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gefärbten Flächen (Polygonen)

end

end
%Vordeteil
i1=l/2;
while i1 >= a; 
       i1= i1 - a;
   XMVQ = (i1-(ProfSt/2));           %Hilfsgrösse% Achsabstand der Stütze in While Schleife

%Querbalken 
vert9= [0 XMVQ (h-2*ProfTh); 0 XMVQ (h-ProfTh); 0 (XMVQ+ProfSt) (h-ProfTh); 0 (XMVQ+ProfSt) (h-2*ProfTh); b (XMVQ+ProfSt) (h-ProfTh); b (XMVQ+ProfSt) (h-2*ProfTh); b XMVQ (h-2*ProfTh); b XMVQ (h-ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze A
vert10= [0 XMVQ 0; 0 (XMVQ+ProfSt) 0; ProfSb (XMVQ+ProfSt) 0; ProfSb XMVQ 0; ProfSb (XMVQ+ProfSt) (h-2*ProfTh); ProfSb XMVQ (h-2*ProfTh); 0 XMVQ (h-2*ProfTh); 0 (XMVQ+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze B
vert11= [b XMVQ 0; b (XMVQ+ProfSt) 0; (b-ProfSb) (XMVQ+ProfSt) 0; (b-ProfSb) XMVQ 0; (b-ProfSb) (XMVQ+ProfSt) (h-2*ProfTh); (b-ProfSb) XMVQ (h-2*ProfTh); b XMVQ (h-2*ProfTh); b (XMVQ+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

% unter if bedingung eine while funktion definieren welche variabel die
% hallenaufteilung vornimmt
if b >13
    %Stuetze VM
vert3= [SMb XMVQ 0; SMb (XMVQ+ProfSt) 0; (SMb+ProfSb) (XMVQ+ProfSt) 0; (SMb+ProfSb) XMVQ 0; (SMb+ProfSb) (XMVQ+ProfSt) (h-2*ProfTh); (SMb+ProfSb) XMVQ (h-2*ProfTh); SMb XMVQ (h-2*ProfTh); SMb (XMVQ+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gefärbten Flächen (Polygonen)
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
hf1= 1
bf1= 0.6

vert1= [-((bf1/2)-(IPE/2)) -((bf1/2)-(IPE/2)) -hf1; (bf1/2) -((bf1/2)-(IPE/2)) -hf1; (bf1/2) -((bf1/2)-(IPE/2)) 0; -((bf1/2)-(IPE/2)) -((bf1/2)-(IPE/2)) 0;...
    (bf1/2) (l + ((bf1/2)-(IPE/2))) 0; -((bf1/2)-(IPE/2)) (l + ((bf1/2)-(IPE/2))) 0; -((bf1/2)-(IPE/2)) (l+ ((bf1/2)-(IPE/2))) -hf1; (bf1/2) (l+ ((bf1/2)-(IPE/2))) -hf1]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert1,'FaceColor','b');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Fundament -Variante 2 Einzelfundament

vert1= [(b-(bf1/2)) -((bf1/2)-(IPE/2)) -hf1; (b+(bf1/2)-(IPE/2)) -((bf1/2)-(IPE/2)) -hf1; (b+(bf1/2)-(IPE/2)) -((bf1/2)-(IPE/2)) 0; (b-(bf1/2)) -((bf1/2)-(IPE/2)) 0;...
    (b+(bf1/2)) ((bf1/2)-(IPE/2)) 0; (b-((bf1/2)-(IPE/2))) ((bf1/2)-(IPE/2)) 0; (b-((bf1/2)-(IPE/2))) ((bf1/2)-(IPE/2)) -hf1; (b+(bf1/2)) ((bf1/2)-(IPE/2)) -hf1]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert1,'FaceColor','b');            % Erzeugen der Gefärbten Flächen (Polygonen)

%}
