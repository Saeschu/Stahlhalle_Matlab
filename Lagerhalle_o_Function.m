clear all, clc
%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dim=0.2         %Dimension der Stahltrager  - zurzeitn Quadrate
l=20         %Länge
b=16           %Breite zwischen den Stützen
h=3             %Höhe
a=1.5          %Binderabstand

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Input Window
prompt = {'Länge:','Breite:', 'Höhe','Unterkannt', 'Abstand','Dim','Flaechenlast'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'30','20','3','0','4','0.2','20',''}; % Zahlenwerte können 'zwischen' entfert werden nur platzhalter
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
l= str2num(answer{1});
b= str2num(answer{2});
h= str2num(answer{3});
unterkannt=str2num(answer{4});
a= str2num(answer{5});
Dim= str2num(answer{6});
Flaechenlast= str2num(answer{7});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if unterkannt==1        % Festlegung ob Hallenhöhe unter oder oberkannte Balken ist
    h=h+2*Dim
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


%Laengstraeger 1
vert1= [0 0 (h-Dim); Dim 0 (h-Dim); Dim 0 h; 0 0 h; Dim l h; 0 l h; 0 l (h-Dim); Dim l (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
fac= [1 2 3 4; 4 3 5 6; 6 7 8 5; 1 2 8 7; 6 7 1 4; 2 3 5 8];    % Welche Eckpunkte werden als eine Polygonfläche eingefärbt
%patch('Faces', fac,'Vertices',vert1,'FaceColor','b');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Laengstraeger 2
vert2= [(b-Dim) 0 (h-Dim); b 0 (h-Dim); b 0 h; (b-Dim) 0 h; b l h; (b-Dim) l h; (b-Dim) l (h-Dim); b l (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
%patch('Faces', fac,'Vertices',vert2,'FaceColor','b');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 1
vert3= [0 0 0; 0 Dim 0; Dim Dim 0; Dim 0 0; Dim Dim (h-2*Dim); Dim 0 (h-2*Dim); 0 0 (h-2*Dim); 0 Dim (h-2*Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','r');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 2
vert4= [b 0 0; b Dim 0; (b-Dim) Dim 0; (b-Dim) 0 0; (b-Dim) Dim (h-2*Dim); (b-Dim) 0 (h-2*Dim); b 0 (h-2*Dim); b Dim (h-2*Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert4,'FaceColor','r');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 3
vert5= [0 (l-Dim) 0; 0 l 0; Dim l 0; Dim (l-Dim) 0; Dim l (h-2*Dim); Dim (l-Dim) (h-2*Dim); 0 (l-Dim) (h-2*Dim); 0 l (h-2*Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','r');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 4
vert6= [b (l-Dim) 0; b l 0; (b-Dim) l 0; (b-Dim) (l-Dim) 0; (b-Dim) l (h-2*Dim); (b-Dim) (l-Dim) (h-2*Dim); b (l-Dim) (h-2*Dim); b l (h-2*Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert6,'FaceColor','r');            % Erzeugen der Gefärbten Flächen (Polygonen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Wenn Hallenbreite grösser 13m ist wird weine weitere Stützenreie in die
%Mitte geleg
%Stützen anfang und ende
if b > 13
   SM= (b/2) -(Dim/2);           %Hilfsgrösse% Pos X (also Stützenabstand) der Stüzte. Einmitung auf Achsmass der Stütze

%Stuetze VM
vert3= [SM 0 0; SM Dim 0; (SM+Dim) Dim 0; (SM+Dim) 0 0; (SM+Dim) Dim (h-2*Dim); (SM+Dim) 0 (h-2*Dim); SM 0 (h-2*Dim); SM Dim (h-2*Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze HM
vert5= [SM (l-Dim) 0; SM l 0; (SM+Dim) l 0; (SM+Dim) (l-Dim) 0; (SM+Dim) l (h-2*Dim); (SM+Dim) (l-Dim) (h-2*Dim); SM (l-Dim) (h-2*Dim); SM l (h-2*Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','c');            % Erzeugen der Gefärbten Flächen (Polygonen)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Querbalken Anfang
vert7= [0 0 (h-2*Dim); 0 0 (h-Dim); 0 Dim (h-Dim); 0 Dim (h-2*Dim); b Dim (h-Dim); b Dim (h-2*Dim); b 0 (h-2*Dim); b 0 (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert7,'FaceColor','g');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Querbalken Ende
vert8= [0 (l-Dim) (h-2*Dim); 0 (l-Dim) (h-Dim); 0 l (h-Dim); 0 l (h-2*Dim); b l (h-Dim); b l (h-2*Dim); b (l-Dim) (h-2*Dim); b (l-Dim) (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert8,'FaceColor','g');            % Erzeugen der Gefärbten Flächen (Polygonen)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Längsbinder in Hallenbreite mit while schleife legen
a1= 1; %Längsbinderabstand 1,0...4,0m
%Linker teil
j= (b/2);
while j> a1
    j=j-a1;
  XMRL = (j-(Dim/2));      %Hilfsgrösse% Achsabstand der Längsbinder in While Schleife

vert13= [XMRL 0 (h-Dim); (XMRL+Dim) 0 (h-Dim); (XMRL+Dim) 0 h; XMRL 0 h; (XMRL+Dim) l h; XMRL l h; XMRL l (h-Dim); (XMRL+Dim) l (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert13,'FaceColor','m');            % Erzeugen der Gefärbten Flächen (Polygonen)   
end
%rechter teil
j1=-a1;
while j1<=(b/2)-a1-Dim
    j1=j1+a1;
 XMLL = ((b/2)+j1-(Dim/2));      %Hilfsgrösse% Achsabstand der Längsbinder in While Schleife

 vert12= [XMLL 0 (h-Dim); (XMLL+Dim) 0 (h-Dim); (XMLL+Dim) 0 h; XMLL 0 h; (XMLL+Dim) l h; XMLL l h; XMLL l (h-Dim); (XMLL+Dim) l (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert12,'FaceColor','m');            % Erzeugen der Gefärbten Flächen (Polygonen)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Binderi i Stützen und Querbalken
%Aufbau von der Mitte aus um Anfang und Endabstand Binder-Stütze gleich
%gross zu halten
%Hinterteil
i=-a;
while i <= (l/2)-a-Dim;         
      i= i + a;
   XMHQ = ((l/2)+i-(Dim/2));      %Hilfsgrösse% Achsabstand der Stützen in While Schleife

%Querbalken 
vert9= [0 XMHQ (h-2*Dim); 0 XMHQ (h-Dim); 0 (XMHQ+Dim) (h-Dim); 0 (XMHQ+Dim) (h-2*Dim); b (XMHQ+Dim) (h-Dim); b (XMHQ+Dim) (h-2*Dim); b XMHQ (h-2*Dim); b XMHQ (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze A
vert10= [0 XMHQ 0; 0 (XMHQ+Dim) 0; Dim (XMHQ+Dim) 0; Dim XMHQ 0; Dim (XMHQ+Dim) (h-2*Dim); Dim XMHQ (h-2*Dim); 0 XMHQ (h-2*Dim); 0 (XMHQ+Dim) (h-2*Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze B
vert11= [b XMHQ 0; b (XMHQ+Dim) 0; (b-Dim) (XMHQ+Dim) 0; (b-Dim) XMHQ 0; (b-Dim) (XMHQ+Dim) (h-2*Dim); (b-Dim) XMHQ (h-2*Dim); b XMHQ (h-2*Dim); b (XMHQ+Dim) (h-2*Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

if b >13
    %Stuetze VM   
vert3= [SM XMHQ 0; SM (XMHQ+Dim) 0; (SM+Dim) (XMHQ+Dim) 0; (SM+Dim) XMHQ 0; (SM+Dim) (XMHQ+Dim) (h-2*Dim); (SM+Dim) XMHQ (h-2*Dim); SM XMHQ (h-2*Dim); SM (XMHQ+Dim) (h-2*Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gefärbten Flächen (Polygonen)

end

end
%Vordeteil
i1=l/2;
while i1 >= a; 
       i1= i1 - a;
   XMVQ = (i1-(Dim/2));           %Hilfsgrösse% Achsabstand der Stütze in While Schleife

%Querbalken 
vert9= [0 XMVQ (h-2*Dim); 0 XMVQ (h-Dim); 0 (XMVQ+Dim) (h-Dim); 0 (XMVQ+Dim) (h-2*Dim); b (XMVQ+Dim) (h-Dim); b (XMVQ+Dim) (h-2*Dim); b XMVQ (h-2*Dim); b XMVQ (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze A
vert10= [0 XMVQ 0; 0 (XMVQ+Dim) 0; Dim (XMVQ+Dim) 0; Dim XMVQ 0; Dim (XMVQ+Dim) (h-2*Dim); Dim XMVQ (h-2*Dim); 0 XMVQ (h-2*Dim); 0 (XMVQ+Dim) (h-2*Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze B
vert11= [b XMVQ 0; b (XMVQ+Dim) 0; (b-Dim) (XMVQ+Dim) 0; (b-Dim) XMVQ 0; (b-Dim) (XMVQ+Dim) (h-2*Dim); (b-Dim) XMVQ (h-2*Dim); b XMVQ (h-2*Dim); b (XMVQ+Dim) (h-2*Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

% unter if bedingung eine while funktion definieren welche variabel die
% hallenaufteilung vornimmt
if b >13
    %Stuetze VM
vert3= [SM XMVQ 0; SM (XMVQ+Dim) 0; (SM+Dim) (XMVQ+Dim) 0; (SM+Dim) XMVQ 0; (SM+Dim) (XMVQ+Dim) (h-2*Dim); (SM+Dim) XMVQ (h-2*Dim); SM XMVQ (h-2*Dim); SM (XMVQ+Dim) (h-2*Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gefärbten Flächen (Polygonen)
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


