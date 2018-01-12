function mygui()
f1= figure('Name', 'Inpunt Window', 'NumberTitle', 'off','position', [573 438 750 420])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
txtTittel = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10 390 180 30],...
        'String','InputWindow', 'FontSize', 16); 

txtArbTit = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10 60 140 20],...
        'String','Kr�ftefluss in einer Stahlhalle');
    
txtDatum = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10  40 140 20],...
        'String','Letze �nderung: 25.01.2017');    

txtAutor = uicontrol('Style','text',...
        'Position',[10 20 140 40],...
        'String','Raphael Eichenberger, Simon Baumann, Sascha Hostettler');   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
%Inof 'Position', [left bottom width height]

%Eingabe L�nge 
txtLaenge = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10 367 120 20],...
        'String','L�nge [m]'); 
EditLaenge = uicontrol('style','edit',...
            'units','pixels',...
             'position',[105 367 100 25])       

%Eingabe Breite      
txtBreit = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10 337 120 20],...
        'String','Breite [m]'); 
EditBreite = uicontrol('style','edit',...
            'units','pixels',...
            'position',[105 337 100 25])
InfoBreit = uicontrol('Style','text',...
        'Position',[220 337 420 40],'HorizontalAlignment', 'left',...
        'String','Ab einer Spannweite �ber 13m bzw. 26m wird die Geasmtspannweite mittels St�tzen gew�hrleistet. Maximalespannweite zwischen den St�zten betr�gt 13m, maximale Gesammtspannweite betr�gt 39m');
    
%Eingabe H�he
txtHoehe = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10 307 120 20],...
        'String','H�he [m]'); 
EditHoehe = uicontrol('style','edit',...
            'units','pixels',...
            'position',[105 307 100 25])  
            
%Eingabe Binderabstand
txtBabst = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[0 277 120 20],...
        'String','Binderabstand [m]'); 
EditBabst = uicontrol('style','edit',...
            'units','pixels',...
            'position',[105 277 100 25])
        
%Eingabe Bauteildimension
%Tr�ger
txtBauDimT = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[0 245 120 20],...
        'String','Profil Tr�ger'); 
DdownBauDimT= uicontrol('Style', 'popup',...
             'String', {'IPE200', 'IPE220', 'IPE240', 'IPE270', 'HEA200', 'HEA220', 'HEA240', 'HEA260'},...
             'Position', [105 247 100 20],'background','w');
%St�tze         
txtBauDimS = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[0 220 120 20],...
        'String','Profil St�tze'); 
DdownBauDimS= uicontrol('Style', 'popup',...
             'String', {'IPE200', 'IPE220', 'IPE240', 'IPE270', 'HEA200', 'HEA220', 'HEA240', 'HEA260'},...
             'Position', [105 220 100 20],'background','w');
% Fl�chenlast
txtq = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[170 100 120 20],...
        'String','Fl�chenlast [kN/m2]'); 
Editq = uicontrol('style','edit',...
            'units','pixels',...
            'position',[300 100 100 25])
%Bodenklassifikation
txtBodK = uicontrol('Style', 'text','HorizontalAlignment', 'left',...
        'Position',[285 220 120 20],...
        'String', 'Bodenklassifikation');
DdownBodK = uicontrol('Style', 'popup',...
        'String', {'Ton, weich','Sand, dicht','Kies, grob mit Sand'},...
        'Position', [405 220 100 20],'background','w');
    
%Setzungen
txtBodK = uicontrol('Style', 'text',...
        'Position',[285 190 120 20],...
        'String', 'zul�ssige Setzungen');
DdownBodK = uicontrol('Style', 'popup',...
        'String', {'5mm','10mm','15mm'},...
        'Position', [405 190 100 20],'background','w');
% Festlegung ob Hallenh�e unter oder oberkannte Balken gesetzt werden soll
% 1== Unterkannte, 2== Oberkannte
txtBedH = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[300 245 120 20],...
        'String','Profil Tr�ger'); 
DdownBedH= uicontrol('Style', 'popup',...
             'String', {'Unterkannte', 'Oberkannte'},...
             'Position', [405 247 100 20],'background','w');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
%Bauteilprofiele    %[H�he Breite Iy]
elementBP= [0.2 0.1 19.4e6;...        %IPE200
          0.22 0.11 27.7e6;...      %IPE220
          0.24 0.12 38.9e6;...      %IPE240
          0.27 0.135 57.9e6;...     %IPE270
          0.2 0.19 36.9e6;...       %HEA200
          0.22 0.21 54.1e6;...      %HEA220
          0.24 0.23 77.6e6;...      %HEA240
          0.26 0.25 104.5e6];        %HEA260
%Bodenklasifikation
elementBK= [40000;...               %Ton, weich [MN/m3]
          100000;...                %Sand, dicht [MN/m3] 
          240000];                  %Kies, grob mit Sand [MN/m3]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%StarButton
PushbuttonStart = uicontrol('style','pushbutton',...
            'units','pixels',...
            'position',[430 20 100 25],...
            'string','Start',...
            'foregroundcolor','b',...
            'callback',{@Startbutton,}); 
        
        function Startbutton(hObject, eventdata) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
%�bernahme Input        
%Editfield
l= (str2num(get(EditLaenge, 'String')))
b= (str2num(get(EditBreite, 'string')))
h= (str2num(get(EditHoehe, 'String')))
a= (str2num(get(EditBabst, 'String')))
q= (str2num(get(Editq, 'String')))

%Inpunt dropdown Profiele
ProfS= get(DdownBauDimS, 'Value') %Profiel St�tze
ProfSb= elementBP(ProfS, 1) 
ProfSt= elementBP(ProfS, 2)
IS= elementBP(ProfS, 3)

ProfT= get(DdownBauDimT, 'Value') %Profiel Tr�ger
ProfTh= elementBP(ProfT, 1) 
ProfTb= elementBP(ProfT, 2)
IT= elementBP(ProfT, 3)

BedH= get(DdownBedH, 'Value')  % 1== Unterkannte, 2== Oberkannte 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
%set(f1,'position', [10 438 750 420])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
%Darstellung
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
%Textausgabe, Gesammtspannweite �berschreitet einzelspannweiten der Tr�ger.
%Berechnung kann nicht weiter ausgef�hrt werden.
if b > 39
    msgbox('Die gew�hlte Gesamtspannweite der Lagerhalle [Breite], �berschreitet die zul�ssige maximalspannweite von 39m. Berechnung mit mehr als 4 St�tzenreihen bzw. 3 B�gen ist zur zeit nicht m�glich.',...
        'Infobox')
    return 
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Festlegung ob Hallenh�he unter oder oberkannte Balken ist... 1= Unterkannte, 2= Oberkannte
if BedH==1        
    h=h+2*ProfTh
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set axis and figure
clf;
f2=figure()
format compact
myaxes =axes('xlim', [-1, b+1], 'ylim', [-1, l+1], 'zlim', [-1, h],'Position', [0.1 0.1 1 1]);
axis equal
view(3)  %Erzeugung der 3D darstellung
grid on
xlabel('x - Breite')
ylabel('y - L�nge')
zlabel('z - H�he')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(f2,'Name', 'Darstellung Lagerhalle 3D', 'NumberTitle', 'off','position', [800 438 900 420])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Legende
%Inof 'Position', [left bottom width height]
legTittel = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10 390 180 30],...
        'String','Legende Lagerhalle', 'FontSize', 13);

legLaenge = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10 367 110 20],...
        'String','Lagerhallen L�nge');
legNumLaenge = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[120 367 80 20],...
        'String',[num2str(l) ' m']); 
    
legBreite = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10 347 110 20],...
        'String','Lagerhallen Breite');
legNumBreite = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[120 347 80 20],...
        'String',[num2str(b) ' m']);
    
legHoehe = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10 327 110 20],...
        'String','Lagerhallen H�he');
legNumHoehe = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[120 327 80 20],...
        'String',[num2str(h) ' m']);

legBabst = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10 307 110 20],...
        'String','Binderabst�nde');
legNumBabst = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[120 307 80 20],...
        'String',[num2str(a) ' m']);
    
legEditq = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10 287 110 20],...
        'String','Fl�chenlast');
legNumEditq = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[120 287 80 20],...
        'String',[num2str(q) ' kN/m2']);
    
legBauDimT = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10 267 110 20],...
        'String','Fl�chenlast');
legBauDimT = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[120 267 80 20],...
        'String',get(DdownBauDimS, 'Value') );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Datenbank
%ba= b-ProfS         %Breite Achsabstand
%hI=h*(IT/IS)        %Vergleichsh�he f�r St�tze
%dx= 10              %Teilungsfaktor
azb= 1;               %Anzahl B�gen

hf= 0.5;
bf= 0.5;
tf= 0.5;

%L�ngsbinder in Hallenbreite mit while schleife legen
a1= 1; %L�ngsbinderabstand 1,0...4,0m

% nur f�r testrechnung effektieve werte m�ssen abgef�llt werden f�r IPE un
% HEA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%Pfette A
vert1= [ProfSb/2-ProfTb/2 0 (h-ProfTh); ProfSb/2+ProfTb/2 0 (h-ProfTh); ProfSb/2+ProfTb/2 0 h; ProfSb/2-ProfTb/2 0 h; ProfTb l h; ProfSb/2-ProfTb/2 l h; ProfSb/2-ProfTb/2 l (h-ProfTh); ProfSb/2+ProfTb/2 l (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
fac= [1 2 3 4; 4 3 5 6; 6 7 8 5; 1 2 8 7; 6 7 1 4; 2 3 5 8];    % Welche Eckpunkte werden als eine Polygonfl�che eingef�rbt
patch('Faces', fac,'Vertices',vert1,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Pfette B
vert2= [(b-ProfSb/2-ProfTb/2) 0 (h-ProfTh); b-ProfSb/2+ProfTb/2 0 (h-ProfTh); b-ProfSb/2+ProfTb/2 0 h; (b-ProfSb/2-ProfTb/2) 0 h; b-ProfSb/2+ProfTb/2 l h; (b-ProfSb/2-ProfTb/2) l h; (b-ProfSb/2-ProfTb/2) l (h-ProfTh); b-ProfSb/2+ProfTb/2 l (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert2,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 1
vert3= [0 0 0; 0 ProfSt 0; ProfSb ProfSt 0; ProfSb 0 0; ProfSb ProfSt (h-2*ProfTh); ProfSb 0 (h-2*ProfTh); 0 0 (h-2*ProfTh); 0 ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament 1
vert14= [ProfSb/2-bf/2 ProfSt/2-tf/2 0; ProfSb/2-bf/2 ProfSt/2+tf/2 0; ProfSb/2+bf/2 ProfSt/2+tf/2 0; ProfSb/2+bf/2 ProfSt/2-tf/2 0;...
        ProfSb/2+bf/2 ProfSt/2+tf/2 -hf; ProfSb/2+bf/2 ProfSt/2-tf/2 -hf; ProfSb/2-bf/2 ProfSt/2-tf/2 -hf; ProfSb/2-bf/2 ProfSt/2+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert14,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 2
vert4= [b 0 0; b ProfSt 0; (b-ProfSb) ProfSt 0; (b-ProfSb) 0 0; (b-ProfSb) ProfSt (h-2*ProfTh); (b-ProfSb) 0 (h-2*ProfTh); b 0 (h-2*ProfTh); b ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert4,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament 2
vert15= [b-(ProfSb/2-bf/2) ProfSt/2-tf/2 0; b-(ProfSb/2-bf/2) ProfSt/2+tf/2 0; b-(ProfSb/2+bf/2) ProfSt/2+tf/2 0; b-(ProfSb/2+bf/2) ProfSt/2-tf/2 0;...
        b-(ProfSb/2+bf/2) ProfSt/2+tf/2 -hf; b-(ProfSb/2+bf/2) ProfSt/2-tf/2 -hf; b-(ProfSb/2-bf/2) ProfSt/2-tf/2 -hf; b-(ProfSb/2-bf/2) ProfSt/2+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert15,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)


%Stuetze 3
vert5= [0 (l-ProfSt) 0; 0 l 0; ProfSb l 0; ProfSb (l-ProfSt) 0; ProfSb l (h-2*ProfTh); ProfSb (l-ProfSt) (h-2*ProfTh); 0 (l-ProfSt) (h-2*ProfTh); 0 l (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament 3
vert16= [ProfSb/2-bf/2 l-(ProfSt/2-tf/2) 0; ProfSb/2-bf/2 l-(ProfSt/2+tf/2) 0; ProfSb/2+bf/2 l-(ProfSt/2+tf/2) 0; ProfSb/2+bf/2 l-(ProfSt/2-tf/2) 0;...
        ProfSb/2+bf/2 l-(ProfSt/2+tf/2) -hf; ProfSb/2+bf/2 l-(ProfSt/2-tf/2) -hf; ProfSb/2-bf/2 l-(ProfSt/2-tf/2) -hf; ProfSb/2-bf/2 l-(ProfSt/2+tf/2) -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert16,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 4
vert6= [b (l-ProfSt) 0; b l 0; (b-ProfSb) l 0; (b-ProfSb) (l-ProfSt) 0; (b-ProfSb) l (h-2*ProfTh); (b-ProfSb) (l-ProfSt) (h-2*ProfTh); b (l-ProfSt) (h-2*ProfTh); b l (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert6,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament 4
vert17= [b-(ProfSb/2-bf/2) l-(ProfSt/2-tf/2) 0; b-(ProfSb/2-bf/2) l-(ProfSt/2+tf/2) 0; b-(ProfSb/2+bf/2) l-(ProfSt/2+tf/2) 0; b-(ProfSb/2+bf/2) l-(ProfSt/2-tf/2) 0;...
        b-(ProfSb/2+bf/2) l-(ProfSt/2+tf/2) -hf; b-(ProfSb/2+bf/2) l-(ProfSt/2-tf/2) -hf; b-(ProfSb/2-bf/2) l-(ProfSt/2-tf/2) -hf; b-(ProfSb/2-bf/2) l-(ProfSt/2+tf/2) -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Querbalken Anfang
vert7= [0 ProfSt/2-ProfTb/2 (h-2*ProfTh); 0 ProfSt/2-ProfTb/2 (h-ProfTh); 0 ProfSt/2+ProfTb/2 (h-ProfTh); 0 ProfSt/2+ProfTb/2 (h-2*ProfTh); b ProfSt/2+ProfTb/2 (h-ProfTh); b ProfSt/2+ProfTb/2 (h-2*ProfTh); b ProfSt/2-ProfTb/2 (h-2*ProfTh); b 0 (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert7,'FaceColor','g');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Querbalken Ende
vert8= [0 (l-ProfSt/2-ProfTb/2) (h-2*ProfTh); 0 (l-ProfSt/2-ProfTb/2) (h-ProfTh); 0 l-ProfSt/2+ProfTb/2 (h-ProfTh); 0 l-ProfSt/2+ProfTb/2 (h-2*ProfTh); b l-ProfSt/2+ProfTb/2 (h-ProfTh); b l-ProfSt/2+ProfTb/2 (h-2*ProfTh); b (l-ProfSt/2-ProfTb/2) (h-2*ProfTh); b (l-ProfSt/2-ProfTb/2) (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert8,'FaceColor','g');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Wenn Hallenbreite gr�sser 13m ist wird eine weiter Sttzenreihe bei 1/2
%erg�nzt
%St�tzen anfang und ende
if b > 13 & b < 26
    azb=2;                            % Anzahl B�gen
   SMb= (b/2) -(ProfSb/2);           %Hilfsgr�sse% Pos X (also St�tzenabstand) der St�zte. Einmitung auf Achsmass der St�tze
  
%Stuetze VM 
vert3= [SMb 0 0; SMb ProfSt 0; (SMb+ProfSb) ProfSt 0; (SMb+ProfSb) 0 0; (SMb+ProfSb) ProfSt (h-2*ProfTh); (SMb+ProfSb) 0 (h-2*ProfTh); SMb 0 (h-2*ProfTh); SMb ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament VM
vert15= [(b/2-bf/2) ProfSt/2-tf/2 0; (b/2-bf/2) ProfSt/2+tf/2 0; (b/2+bf/2) ProfSt/2+tf/2 0; (b/2+bf/2) ProfSt/2-tf/2 0;...
        (b/2+bf/2) ProfSt/2+tf/2 -hf; (b/2+bf/2) ProfSt/2-tf/2 -hf; (b/2-bf/2) ProfSt/2-tf/2 -hf; (b/2-bf/2) ProfSt/2+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert15,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze HM
vert5= [SMb (l-ProfSt) 0; SMb l 0; (SMb+ProfSb) l 0; (SMb+ProfSb) (l-ProfSt) 0; (SMb+ProfSb) l (h-2*ProfTh); (SMb+ProfSb) (l-ProfSt) (h-2*ProfTh); SMb (l-ProfSt) (h-2*ProfTh); SMb l (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament HM
vert17= [(b/2-bf/2) l-(ProfSt/2-tf/2) 0; (b/2-bf/2) l-(ProfSt/2+tf/2) 0; (b/2+bf/2) l-(ProfSt/2+tf/2) 0; (b/2+bf/2) l-(ProfSt/2-tf/2) 0;...
        (b/2+bf/2) l-(ProfSt/2+tf/2) -hf; (b/2+bf/2) l-(ProfSt/2-tf/2) -hf; (b/2-bf/2) l-(ProfSt/2-tf/2) -hf; (b/2-bf/2) l-(ProfSt/2+tf/2) -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

end

% Wen Hallenbreite gr�sser 26m ist werden weiter St�tzenreihe bei 1/3 und 2/3
% erg�nzt
if b > 26
     azb=3;                             % Anzahl B�gen
    S1b= (b/3) -(ProfSb/2);
    S2b= (2*b/3) -(ProfSb/2);
%Stuetze V 1/3
vert3= [S1b 0 0; S1b ProfSt 0; (S1b+ProfSb) ProfSt 0; (S1b+ProfSb) 0 0; (S1b+ProfSb) ProfSt (h-2*ProfTh); (S1b+ProfSb) 0 (h-2*ProfTh); S1b 0 (h-2*ProfTh); S1b ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament V 1/3
vert15= [(b/3-bf/2) ProfSt/2-tf/2 0; (b/3-bf/2) ProfSt/2+tf/2 0; (b/3+bf/2) ProfSt/2+tf/2 0; (b/3+bf/2) ProfSt/2-tf/2 0;...
        (b/3+bf/2) ProfSt/2+tf/2 -hf; (b/3+bf/2) ProfSt/2-tf/2 -hf; (b/3-bf/2) ProfSt/2-tf/2 -hf; (b/3-bf/2) ProfSt/2+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert15,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze H 1/3
vert5= [S1b (l-ProfSt) 0; S1b l 0; (S1b+ProfSb) l 0; (S1b+ProfSb) (l-ProfSt) 0; (S1b+ProfSb) l (h-2*ProfTh); (S1b+ProfSb) (l-ProfSt) (h-2*ProfTh); S1b (l-ProfSt) (h-2*ProfTh); S1b l (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament H 1/3
vert17= [(b/3-bf/2) l-(ProfSt/2-tf/2) 0; (b/3-bf/2) l-(ProfSt/2+tf/2) 0; (b/3+bf/2) l-(ProfSt/2+tf/2) 0; (b/3+bf/2) l-(ProfSt/2-tf/2) 0;...
        (b/3+bf/2) l-(ProfSt/2+tf/2) -hf; (b/3+bf/2) l-(ProfSt/2-tf/2) -hf; (b/3-bf/2) l-(ProfSt/2-tf/2) -hf; (b/3-bf/2) l-(ProfSt/2+tf/2) -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze V 2/3
vert3= [S2b 0 0; S2b ProfSt 0; (S2b+ProfSb) ProfSt 0; (S2b+ProfSb) 0 0; (S2b+ProfSb) ProfSt (h-2*ProfTh); (S2b+ProfSb) 0 (h-2*ProfTh); S2b 0 (h-2*ProfTh); S2b ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament V 2/3
vert15= [((2*b/3)-bf/2) ProfSt/2-tf/2 0; ((2*b/3)-bf/2) ProfSt/2+tf/2 0; ((2*b/3)+bf/2) ProfSt/2+tf/2 0; ((2*b/3)+bf/2) ProfSt/2-tf/2 0;...
        ((2*b/3)+bf/2) ProfSt/2+tf/2 -hf; ((2*b/3)+bf/2) ProfSt/2-tf/2 -hf; ((2*b/3)-bf/2) ProfSt/2-tf/2 -hf; ((2*b/3)-bf/2) ProfSt/2+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert15,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze H 2/3
vert5= [S2b (l-ProfSt) 0; S2b l 0; (S2b+ProfSb) l 0; (S2b+ProfSb) (l-ProfSt) 0; (S2b+ProfSb) l (h-2*ProfTh); (S2b+ProfSb) (l-ProfSt) (h-2*ProfTh); S2b (l-ProfSt) (h-2*ProfTh); S2b l (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament H 2/3
vert17= [((2*b/3)-bf/2) l-(ProfSt/2-tf/2) 0; ((2*b/3)-bf/2) l-(ProfSt/2+tf/2) 0; ((2*b/3)+bf/2) l-(ProfSt/2+tf/2) 0; ((2*b/3)+bf/2) l-(ProfSt/2-tf/2) 0;...
        ((2*b/3)+bf/2) l-(ProfSt/2+tf/2) -hf; ((2*b/3)+bf/2) l-(ProfSt/2-tf/2) -hf; ((2*b/3)-bf/2) l-(ProfSt/2-tf/2) -hf; ((2*b/3)-bf/2) l-(ProfSt/2+tf/2) -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pfetten dazwischen
j=0;
while j< (b-(apres))
    j=j+apres;
  XMRL = (j-(ProfTb/2));      %Hilfsgr�sse% Achsabstand der L�ngsbinder in While Schleife
vert13= [XMRL 0 (h-ProfTh); (XMRL+ProfTb) 0 (h-ProfTh); (XMRL+ProfTb) 0 h; XMRL 0 h; (XMRL+ProfTb) l h; XMRL l h; XMRL l (h-ProfTh); (XMRL+ProfTb) l (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert13,'FaceColor','m');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)  
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Binderi St�tzen und Querbalken dazwischen
i1=0;
while i1 < l-arres; 
       i1= i1 +arres;
   XMVQS = (i1-(ProfSt/2));           %Hilfsgr�sse% Achsabstand der St�tze in While-schleife
   XMVQT=  (i1-(ProfTb/2));           %Hilfsgr�sse% Achsabstand der Balken in While-schleife

%Querbalken 
vert9= [0 XMVQT (h-2*ProfTh); 0 XMVQT (h-ProfTh); 0 (XMVQT+ProfTb) (h-ProfTh); 0 (XMVQT+ProfTb) (h-2*ProfTh); b (XMVQT+ProfTb) (h-ProfTh); b (XMVQT+ProfTb) (h-2*ProfTh); b XMVQT (h-2*ProfTh); b XMVQT (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze iA
vert10= [0 XMVQS 0; 0 (XMVQS+ProfSt) 0; ProfSb (XMVQS+ProfSt) 0; ProfSb XMVQS 0; ProfSb (XMVQS+ProfSt) (h-2*ProfTh); ProfSb XMVQS (h-2*ProfTh); 0 XMVQS (h-2*ProfTh); 0 (XMVQS+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament iA
vert16= [ProfSb/2-bf/2 i1-tf/2 0; ProfSb/2-bf/2 i1+tf/2 0; ProfSb/2+bf/2 i1+tf/2 0; ProfSb/2+bf/2 i1-tf/2 0;...
        ProfSb/2+bf/2 i1+tf/2 -hf; ProfSb/2+bf/2 i1-tf/2 -hf; ProfSb/2-bf/2 i1-tf/2 -hf; ProfSb/2-bf/2 i1+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert16,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze iB
vert11= [b XMVQS 0; b (XMVQS+ProfSt) 0; (b-ProfSb) (XMVQS+ProfSt) 0; (b-ProfSb) XMVQS 0; (b-ProfSb) (XMVQS+ProfSt) (h-2*ProfTh); (b-ProfSb) XMVQS (h-2*ProfTh); b XMVQS (h-2*ProfTh); b (XMVQS+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament iB
vert17= [b-(ProfSb/2-bf/2) i1-tf/2 0; b-(ProfSb/2-bf/2) i1+tf/2 0; b-(ProfSb/2+bf/2) i1+tf/2 0; b-(ProfSb/2+bf/2) i1-tf/2 0;...
        b-(ProfSb/2+bf/2) i1+tf/2 -hf; b-(ProfSb/2+bf/2) i1-tf/2 -hf; b-(ProfSb/2-bf/2) i1-tf/2 -hf; b-(ProfSb/2-bf/2) i1+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%St�tzenreihen bei gr�sseren Spannweiten >13
if b >13 & b < 26
%Stuetze iM
vert3= [SMb XMVQS 0; SMb (XMVQS+ProfSt) 0; (SMb+ProfSb) (XMVQS+ProfSt) 0; (SMb+ProfSb) XMVQS 0; (SMb+ProfSb) (XMVQS+ProfSt) (h-2*ProfTh); (SMb+ProfSb) XMVQS (h-2*ProfTh); SMb XMVQS (h-2*ProfTh); SMb (XMVQS+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament iM
vert17= [(b/2-bf/2) i1-tf/2 0; (b/2-bf/2) i1+tf/2 0; (b/2+bf/2) i1+tf/2 0; (b/2+bf/2) i1-tf/2 0;...
        (b/2+bf/2) i1+tf/2 -hf; (b/2+bf/2) i1-tf/2 -hf; (b/2-bf/2) i1-tf/2 -hf; (b/2-bf/2) i1+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

end

%St�ztenreihen bei gr�sseren Spannweiten >26
if b > 26
%Stuetze i1/3
vert3= [S1b XMVQS 0; S1b (XMVQS+ProfSt) 0; (S1b+ProfSb) (XMVQS+ProfSt) 0; (S1b+ProfSb) XMVQS 0; (S1b+ProfSb) (XMVQS+ProfSt) (h-2*ProfTh); (S1b+ProfSb) XMVQS (h-2*ProfTh); S1b XMVQS (h-2*ProfTh); S1b (XMVQS+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament i1/3
vert17= [(b/3-bf/2) i1-tf/2 0; (b/3-bf/2) i1+tf/2 0; (b/3+bf/2) i1+tf/2 0; (b/3+bf/2) i1-tf/2 0;...
        (b/3+bf/2) i1+tf/2 -hf; (b/3+bf/2) i1-tf/2 -hf; (b/3-bf/2) i1-tf/2 -hf; (b/3-bf/2) i1+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze i2/3
vert3= [S2b XMVQS 0; S2b (XMVQS+ProfSt) 0; (S2b+ProfSb) (XMVQS+ProfSt) 0; (S2b+ProfSb) XMVQS 0; (S2b+ProfSb) (XMVQS+ProfSt) (h-2*ProfTh); (S2b+ProfSb) XMVQS (h-2*ProfTh); S2b XMVQS (h-2*ProfTh); S2b (XMVQS+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)   

%Einzelfundament i2/3
vert17= [((2*b/3)-bf/2) i1-tf/2 0; ((2*b/3)-bf/2) i1+tf/2 0; ((2*b/3)+bf/2) i1+tf/2 0; ((2*b/3)+bf/2) i1-tf/2 0;...
        ((2*b/3)+bf/2) i1+tf/2 -hf; ((2*b/3)+bf/2) i1-tf/2 -hf; ((2*b/3)-bf/2) i1-tf/2 -hf; ((2*b/3)-bf/2) i1+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            

        end
    
        end