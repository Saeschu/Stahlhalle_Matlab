clear all, clc
%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dim=0.2         %Dimension der Stahltrager  - zurzeitn Quadrate
l=20         %L�nge
b=16           %Breite zwischen den St�tzen
h=3             %H�he
a=1.5          %Binderabstand

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%}
%test%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Input Window
prompt = {'L�nge:','Breite:', 'H�he', 'Abstand','Dim','FL�chenlast [kn/m2]'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'30','20','3','4','0.2','10'}; % Zahlenwerte k�nnen 'zwischen' entfert werden nur platzhalter
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
l= str2num(answer{1});
b= str2num(answer{2});
h= str2num(answer{3});
a= str2num(answer{4});
Dim= str2num(answer{5});
q= str2num(answer{6});
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

%Flaechenlast
vert100= [0 0 h; b 0 h; b l h; 0 l h;] % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
fac= [1 2 3 4];    % Welche Eckpunkte werden als eine Polygonfl�che eingef�rbt
patch('Faces', fac,'Vertices',vert100,'FaceColor','r');

%Laengstraeger 1
vert1= [0 0 (h-Dim); Dim 0 (h-Dim); Dim 0 h; 0 0 h; Dim l h; 0 l h; 0 l (h-Dim); Dim l (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
fac= [1 2 3 4; 4 3 5 6; 6 7 8 5; 1 2 8 7; 6 7 1 4; 2 3 5 8];    % Welche Eckpunkte werden als eine Polygonfl�che eingef�rbt
patch('Faces', fac,'Vertices',vert1,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Laengstraeger 2
vert2= [(b-Dim) 0 (h-Dim); b 0 (h-Dim); b 0 h; (b-Dim) 0 h; b l h; (b-Dim) l h; (b-Dim) l (h-Dim); b l (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert2,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 1
vert3= [0 0 0; 0 Dim 0; Dim Dim 0; Dim 0 0; Dim Dim (h-Dim); Dim 0 (h-Dim); 0 0 (h-Dim); 0 Dim (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 2
vert4= [b 0 0; b Dim 0; (b-Dim) Dim 0; (b-Dim) 0 0; (b-Dim) Dim (h-Dim); (b-Dim) 0 (h-Dim); b 0 (h-Dim); b Dim (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert4,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 3
vert5= [0 (l-Dim) 0; 0 l 0; Dim l 0; Dim (l-Dim) 0; Dim l (h-Dim); Dim (l-Dim) (h-Dim); 0 (l-Dim) (h-Dim); 0 l (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 4
vert6= [b (l-Dim) 0; b l 0; (b-Dim) l 0; (b-Dim) (l-Dim) 0; (b-Dim) l (h-Dim); (b-Dim) (l-Dim) (h-Dim); b (l-Dim) (h-Dim); b l (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert6,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Querbalken Anfang
vert7= [Dim 0 (h-Dim); Dim 0 h; Dim Dim h; Dim Dim (h-Dim); (b-Dim) Dim h; (b-Dim) Dim (h-Dim); (b-Dim) 0 (h-Dim); (b-Dim) 0 h]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert7,'FaceColor','g');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Querbalken Ende
vert8= [Dim (l-Dim) (h-Dim); Dim (l-Dim) h; Dim l h; Dim l (h-Dim); (b-Dim) l h; (b-Dim) l (h-Dim); (b-Dim) (l-Dim) (h-Dim); (b-Dim) (l-Dim) h]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert8,'FaceColor','g');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if b > 13
   SM= (b/2) -(Dim/2);           %Hilfsgr�sse% Pos X (also St�tzenabstand) der St�zte. Einmitung auf Achsmass der St�tze

%Stuetze VM
vert3= [SM 0 0; SM Dim 0; (SM+Dim) Dim 0; (SM+Dim) 0 0; (SM+Dim) Dim (h-Dim); (SM+Dim) 0 (h-Dim); SM 0 (h-Dim); SM Dim (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze HM
vert5= [SM (l-Dim) 0; SM l 0; (SM+Dim) l 0; (SM+Dim) (l-Dim) 0; (SM+Dim) l (h-Dim); (SM+Dim) (l-Dim) (h-Dim); SM (l-Dim) (h-Dim); SM l (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)
end

%Binderi i St�tzen und Querbalken
%Aufbau von der Mittea aus um Anfang und Endabstand Binder-St�tze gleich
%gross zu halten
i=-a;
while i <= (l/2)-a;         
      i= i + a;
   XMH = ((l/2)+i-(Dim/2));      %Hilfsgr�sse% Achsabstand der St�tzen in While Schleife

%Querbalken 
vert9= [Dim XMH (h-Dim); Dim XMH h; Dim (XMH+Dim) h; Dim (XMH+Dim) (h-Dim); (b-Dim) (XMH+Dim) h; (b-Dim) (XMH+Dim) (h-Dim); (b-Dim) XMH (h-Dim); (b-Dim) XMH h]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze A
vert10= [0 XMH 0; 0 (XMH+Dim) 0; Dim (XMH+Dim) 0; Dim XMH 0; Dim (XMH+Dim) (h-Dim); Dim XMH (h-Dim); 0 XMH (h-Dim); 0 (XMH+Dim) (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze B
vert11= [b XMH 0; b (XMH+Dim) 0; (b-Dim) (XMH+Dim) 0; (b-Dim) XMH 0; (b-Dim) (XMH+Dim) (h-Dim); (b-Dim) XMH (h-Dim); b XMH (h-Dim); b (XMH+Dim) (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

if b >13
    %Stuetze VM   
vert3= [SM XMH 0; SM (XMH+Dim) 0; (SM+Dim) (XMH+Dim) 0; (SM+Dim) XMH 0; (SM+Dim) (XMH+Dim) (h-Dim); (SM+Dim) XMH (h-Dim); SM XMH (h-Dim); SM (XMH+Dim) (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Laengstraeger M        %Zur Zeit durchlaufend noch keine unterbr�cke bei den
%S�tzen oder Binder
vert1= [SM 0 (h-Dim); (SM+Dim) 0 (h-Dim); (SM+Dim) 0 h; SM 0 h; (SM+Dim) l h; SM l h; SM l (h-Dim); (SM+Dim) l (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
fac= [1 2 3 4; 4 3 5 6; 6 7 8 5; 1 2 8 7; 6 7 1 4; 2 3 5 8];    % Welche Eckpunkte werden als eine Polygonfl�che eingef�rbt
patch('Faces', fac,'Vertices',vert1,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)
end

end
k=l/2;
while k >= a; 
       k= k - a;
   XMV = (k-(Dim/2));           %Hilfsgr�sse% Achsabstand der St�tze in While Schleife

%Querbalken 
vert9= [Dim XMV (h-Dim); Dim XMV h; Dim (XMV+Dim) h; Dim (XMV+Dim) (h-Dim); (b-Dim) (XMV+Dim) h; (b-Dim) (XMV+Dim) (h-Dim); (b-Dim) XMV (h-Dim); (b-Dim) XMV h]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze A
vert10= [0 XMV 0; 0 (XMV+Dim) 0; Dim (XMV+Dim) 0; Dim XMV 0; Dim (XMV+Dim) (h-Dim); Dim XMV (h-Dim); 0 XMV (h-Dim); 0 (XMV+Dim) (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze B
vert11= [b XMV 0; b (XMV+Dim) 0; (b-Dim) (XMV+Dim) 0; (b-Dim) XMV 0; (b-Dim) (XMV+Dim) (h-Dim); (b-Dim) XMV (h-Dim); b XMV (h-Dim); b (XMV+Dim) (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

if b >13
    %Stuetze VM
vert3= [SM XMV 0; SM (XMV+Dim) 0; (SM+Dim) (XMV+Dim) 0; (SM+Dim) XMV 0; (SM+Dim) (XMV+Dim) (h-Dim); (SM+Dim) XMV (h-Dim); SM XMV (h-Dim); SM (XMV+Dim) (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Aussteifungen Kreuzverband Dach

%Aussteifungen Kreuzverband Wand Y=0

%Aussteifungen Kreuzverband Wand Y=l


%Variante Sascha f�r b>13
NSA=q*(b/4)*(k/2)    %Normalkraft Aussenst�tzen/Eckst�tzen
NSAM=q*(b/2)*(k/2)   %Normalkraft Mittelst�tzen aussen
NSAR=q*(b/4)*a       %Normalkraft St�tze aussen
NSIM=q*(b/2)*a       %Normalkraft Mittelst�tze innen
QAE=q*(b/2)*(k/2)    %Querkraft Querbalken Anfang/Ende (L�nge Querbalken=b/2)
QI=q*(b/2)*a         %Querkraft Querbalken innen
NS1R=q*(b/4)*((k/2)+(a/2)) %Normalkraft 1 St�tze von Rand entfernt
NS1M=q*(b/2)*((k/2)+(a/2)) %Normalkraft 1 St�tze von Mittelst�tze entfernt

%Variante Simon f�r b>13
vert200=[(q*(a/2)*(k/2)) (k/4)];





%Fundament
%W�rfelfundament, damit dritte Wurzel geszogen werden kann


