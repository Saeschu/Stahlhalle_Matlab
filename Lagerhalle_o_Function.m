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
prompt = {'Länge:','Breite:', 'Höhe', 'Abstand','Dim'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'20','15','3','4','0.2'}; % Zahlenwerte können 'zwischen' entfert werden nur platzhalter
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
l= str2num(answer{1});
b= str2num(answer{2});
h= str2num(answer{3});
a= str2num(answer{4});
Dim= str2num(answer{5});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
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

%Laengstraeger 1
vert1= [0 0 (h-Dim); Dim 0 (h-Dim); Dim 0 h; 0 0 h; Dim l h; 0 l h; 0 l (h-Dim); Dim l (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
fac= [1 2 3 4; 4 3 5 6; 6 7 8 5; 1 2 8 7; 6 7 1 4; 2 3 5 8];    % Welche Eckpunkte werden als eine Polygonfläche eingefärbt
patch('Faces', fac,'Vertices',vert1,'FaceColor','b');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Laengstraeger 2
vert2= [(b-Dim) 0 (h-Dim); b 0 (h-Dim); b 0 h; (b-Dim) 0 h; b l h; (b-Dim) l h; (b-Dim) l (h-Dim); b l (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert2,'FaceColor','b');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 1
vert3= [0 0 0; 0 Dim 0; Dim Dim 0; Dim 0 0; Dim Dim (h-Dim); Dim 0 (h-Dim); 0 0 (h-Dim); 0 Dim (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','r');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 2
vert4= [b 0 0; b Dim 0; (b-Dim) Dim 0; (b-Dim) 0 0; (b-Dim) Dim (h-Dim); (b-Dim) 0 (h-Dim); b 0 (h-Dim); b Dim (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert4,'FaceColor','r');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 3
vert5= [0 (l-Dim) 0; 0 l 0; Dim l 0; Dim (l-Dim) 0; Dim l (h-Dim); Dim (l-Dim) (h-Dim); 0 (l-Dim) (h-Dim); 0 l (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','r');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 4
vert6= [b (l-Dim) 0; b l 0; (b-Dim) l 0; (b-Dim) (l-Dim) 0; (b-Dim) l (h-Dim); (b-Dim) (l-Dim) (h-Dim); b (l-Dim) (h-Dim); b l (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert6,'FaceColor','r');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Querbalken Anfang
vert7= [Dim 0 (h-Dim); Dim 0 h; Dim Dim h; Dim Dim (h-Dim); (b-Dim) Dim h; (b-Dim) Dim (h-Dim); (b-Dim) 0 (h-Dim); (b-Dim) 0 h]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert7,'FaceColor','g');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Querbalken Ende
vert8= [Dim (l-Dim) (h-Dim); Dim (l-Dim) h; Dim l h; Dim l (h-Dim); (b-Dim) l h; (b-Dim) l (h-Dim); (b-Dim) (l-Dim) (h-Dim); (b-Dim) (l-Dim) h]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert8,'FaceColor','g');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Binderi i Stützen und Querbalken
%Aufbau von der Mittea aus um Anfang und Endabstand Binder-Stütze gleich
%gross zu halten
i=-a;
while i <= (l/2)-2*a;         
      i= i + a;
%Querbalken 
vert9= [Dim ((l/2)+i-(Dim/2)) (h-Dim); Dim ((l/2)+i-(Dim/2)) h; Dim (((l/2)+i-(Dim/2))+Dim) h; Dim (((l/2)+i-(Dim/2))+Dim) (h-Dim); (b-Dim) (((l/2)+i-(Dim/2))+Dim) h; (b-Dim) (((l/2)+i-(Dim/2))+Dim) (h-Dim); (b-Dim) ((l/2)+i-(Dim/2)) (h-Dim); (b-Dim) ((l/2)+i-(Dim/2)) h]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze A
vert10= [0 ((l/2)+i-(Dim/2)) 0; 0 (((l/2)+i-(Dim/2))+Dim) 0; Dim (((l/2)+i-(Dim/2))+Dim) 0; Dim ((l/2)+i-(Dim/2)) 0; Dim (((l/2)+i-(Dim/2))+Dim) (h-Dim); Dim ((l/2)+i-(Dim/2)) (h-Dim); 0 ((l/2)+i-(Dim/2)) (h-Dim); 0 (((l/2)+i-(Dim/2))+Dim) (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze B
vert11= [b ((l/2)+i-(Dim/2)) 0; b (((l/2)+i-(Dim/2))+Dim) 0; (b-Dim) (((l/2)+i-(Dim/2))+Dim) 0; (b-Dim) ((l/2)+i-(Dim/2)) 0; (b-Dim) (((l/2)+i-(Dim/2))+Dim) (h-Dim); (b-Dim) ((l/2)+i-(Dim/2)) (h-Dim); b ((l/2)+i-(Dim/2)) (h-Dim); b (((l/2)+i-(Dim/2))+Dim) (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)
end
k=l/2;
while k >= 2*a;         
      k= k - a;
%Querbalken 
vert9= [Dim (k-(Dim/2)) (h-Dim); Dim (k-(Dim/2)) h; Dim ((k-(Dim/2))+Dim) h; Dim ((k-(Dim/2))+Dim) (h-Dim); (b-Dim) ((k-(Dim/2))+Dim) h; (b-Dim) ((k-(Dim/2))+Dim) (h-Dim); (b-Dim) (k-(Dim/2)) (h-Dim); (b-Dim) (k-(Dim/2)) h]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze A
vert10= [0 (k-(Dim/2)) 0; 0 ((k-(Dim/2))+Dim) 0; Dim ((k-(Dim/2))+Dim) 0; Dim (k-(Dim/2)) 0; Dim ((k-(Dim/2))+Dim) (h-Dim); Dim (k-(Dim/2)) (h-Dim); 0 (k-(Dim/2)) (h-Dim); 0 ((k-(Dim/2))+Dim) (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze B
vert11= [b (k-(Dim/2)) 0; b ((k-(Dim/2))+Dim) 0; (b-Dim) ((k-(Dim/2))+Dim) 0; (b-Dim) (k-(Dim/2)) 0; (b-Dim) ((k-(Dim/2))+Dim) (h-Dim); (b-Dim) (k-(Dim/2)) (h-Dim); b (k-(Dim/2)) (h-Dim); b ((k-(Dim/2))+Dim) (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)
end



%Aussteifungen Kreuzverband Dach

%Aussteifungen Kreuzverband Wand Y=0

%Aussteifungen Kreuzverband Wand Y=l

