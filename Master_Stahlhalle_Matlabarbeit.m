function mygui()
f1= figure('Name', 'Inpunt Window', 'NumberTitle', 'off','MenuBar', 'None','position', [550 450 770 420], 'color', 'w', 'resize', 'off', 'nextPlot', 'new')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
txtTittel = uicontrol('Style','text','HorizontalAlignment', 'Center',...
        'Position',[230 380 300 30],'BackgroundColor','w',...
        'String','Kr�ftefluss in einer Stahlhalle', 'FontSize', 16); 

txtArbTit = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[15 35 250 15],'BackgroundColor','w','Fontsize', 7,...
        'String','Semesterarbeit Matlab Stand: 25.01.2017');
    
txtAutor = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[15 20 255 15],'BackgroundColor','w', 'fontsize', 7,...
        'String','Raphael Eichenberger, Simon Baumann, Sascha Hostettler');   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
%Info 'Position', [left bottom width height]
%Tittel Abmessungen
txtTitAbm = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[20 360 100 17],'BackgroundColor','w', 'fontsize', 10,...
        'String','Abmessungen');
%Eingabe L�nge 
txtLaenge = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[20 329 100 20],'BackgroundColor', 'w',...
        'String','L�nge [m] :'); 
EditLaenge = uicontrol('style','edit',...
        'units','pixels',...
        'position',[130 330 100 22])       
%Eingabe Breite      
txtBreit = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[20 304 100 20],'BackgroundColor', 'w',...
        'String','Breite [m] :'); 
EditBreite = uicontrol('style','edit',...
        'units','pixels',...
        'position',[130 305 100 22])
InfoBreit = uicontrol('Style','text','BackgroundColor', 'w',...
        'Position',[20 215 733 30],'HorizontalAlignment', 'left','fontsize', 8.5,...
        'String','Ab einer Spannweite �ber 13 m wird die Geasmtspannweite mittels St�tzen gew�hrleistet. Maximalespannweite zwischen den St�zten betr�gt 13 m, maximale Gesammtspannweite betr�gt 26 m.');
    
%Eingabe H�he
txtHoehe = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[20 279 100 20],'BackgroundColor', 'w',...
        'String','H�he [m] :'); 
EditHoehe = uicontrol('style','edit',...
        'units','pixels',...
        'position',[130 280 100 22]) 
        
%Eingabe Binderabstand
txtBabst = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[20 254 100 20],'BackgroundColor', 'w',...
        'String','Binderabstand [m] :'); 
EditBabst = uicontrol('style','edit',...
        'units','pixels',...
        'position',[130 255 100 22])
        
%Eingabe Bauteildimension  
%Tr�ger
txtBauDimT = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[265 329 100 20], 'BackgroundColor', 'w',...
        'String','Profil Tr�ger :'); 
DdownBauDimT= uicontrol('Style', 'popup',...
        'String', {'IPE200', 'IPE220', 'IPE240', 'IPE270', 'HEA200', 'HEA220', 'HEA240', 'HEA260'},...
        'Position', [375 330 100 22],'background','w');
%St�tze         
txtBauDimS = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[265 304 100 20],'BackgroundColor', 'w',...
        'String','Profil St�tze :'); 
DdownBauDimS= uicontrol('Style', 'popup',...
        'String', {'IPE200', 'IPE220', 'IPE240', 'IPE270', 'HEA200', 'HEA220', 'HEA240', 'HEA260'},...
        'Position', [375 305 100 22],'background','w');
    
% Festlegung ob Hallenh�e unter oder oberkannte Balken gesetzt werden soll
% 1== Unterkannte, 2== Oberkannte
txtBedH = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[505 329 100 20],'BackgroundColor', 'w',...
        'String','Bezugsh�he :'); 
DdownBedH= uicontrol('Style', 'popup',...
             'String', {'Unterkannte Binder', 'Oberkannte Pfette'},...
             'Position', [625 330 120 22],'background','w');    
         
%Tittel Einwirkungen
txtTitAbm = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[20 180 100 17],'BackgroundColor','w', 'fontsize', 10,...
        'String','Einwirkungen');

% Fl�chenlast
txtq = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[20 149 100 20], 'BackgroundColor','w',...
        'String','Fl�chenlast [kN/m2] :'); 
Editq = uicontrol('style','edit',...
        'units','pixels',...
        'position',[130 150 100 22])

%Tittel Weitere Angaben
txtTitAbm = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[215 180 150 17],'BackgroundColor','w', 'fontsize', 10,...
        'String','Weitere Angaben');     
      
%Bodenklassifikation
txtBodK = uicontrol('Style', 'text','HorizontalAlignment', 'right',...
        'Position',[265 149 100 20],'BackgroundColor','w',...
        'String', 'Bodenklassifikation :');
DdownBodK= uicontrol('Style', 'popup',...
        'String', {'Ton, weich','Sand, dicht','Kies, grob mit Sand'},...
        'Position', [375 150 100 22],'background','w');
    
%Setzungen
txtSet = uicontrol('Style', 'text','HorizontalAlignment', 'right',...
        'Position',[260 124 105 20],'BackgroundColor','w',...
        'String', 'zul�ssige Setzungen :');
DdownSet = uicontrol('Style', 'popup',...
        'String', {'5 mm','10 mm','15 mm'},...
        'Position', [375 125 100 20],'background','w');
    
%Info 'Position', [left bottom width height]
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

%Setzungen
elementSE=[0.005;...                %5mm Setzung
           0.01;...                 %10mm Setzung
           0.015];                  %15mm Setzung
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%StarButton
PushbuttonStart = uicontrol('style','pushbutton',...
            'units','pixels',...
            'position',[620 20 100 25],...
            'string','Start',...
            'foregroundcolor','k','fontsize', 11,...
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

Bodenk=get(DdownBodK, 'Value') %Bodenklassifikation
ksm=elementBK(Bodenk)

Setzungen=get(DdownSet, 'Value') %Setzungen
sm=elementSE (Setzungen)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
%set(f1,'position', [10 438 750 420])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
%Darstellung
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
%Textausgabe, Gesammtspannweite �berschreitet einzelspannweiten der Tr�ger.
%Berechnung kann nicht weiter ausgef�hrt werden.
if b > 26
    msgbox('Die gew�hlte Gesamtspannweite der Lagerhalle [Breite], �berschreitet die zul�ssige maximalspannweite von 26m. Berechnung mit mehr als 3 St�tzenreihen bzw. 2 Rahmen ist zur zeit nicht m�glich.',...
        'Infobox')
    return 
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Festlegung ob Hallenh�he unter oder oberkannte Balken ist... 1= Unterkannte, 2= Oberkannte
if BedH==1        
    h=h+2*ProfTh
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f2=figure('Name', 'Darstellung Lagerhalle 3D', 'NumberTitle', 'off', 'InnerPosition', [250 150 800 600])
format compact
myaxes =axes('xlim', [-1, b+1], 'ylim', [-1, l+1], 'zlim', [-1, h], 'box', 'on', 'boxstyle', 'back', 'linewidth', 1, 'Position', [0.27 0.1 0.7 0.9]); % , 'Position',[0.4 0.25 0.5 0.6]
axis equal 
view(3)  %Erzeugung der 3D darstellung
grid on
xlabel('x - Breite')
ylabel('y - L�nge')
zlabel('z - H�he')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Legende
%Inof 'Position', [left bottom width height]
legTitel = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10 560 160 30],...
        'String','Legende Lagerhalle', 'FontSize', 13);

legLaenge = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[10 537 100 20],...
        'String','Lagerhallen L�nge :');
legNumLaenge = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[120 537 50 20],...
        'String',[num2str(l) ' m']); 
    
legBreite = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[10 517 100 20],...
        'String','Lagerhallen Breite :');
legNumBreite = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[120 517 50 20],...
        'String',[num2str(b) ' m']);
    
legHoehe = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[10 497 100 20],...
        'String','Lagerhallen H�he :');
legNumHoehe = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[120 497 50 20],...
        'String',[num2str(h) ' m']);

legBabst = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[10 477 100 20],...
        'String','Binderabst�nde :');
legNumBabst = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[120 477 50 20],...
        'String',[num2str(a) ' m']);
    
legEditq = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[10 457 100 20],...
        'String','Fl�chenlast :');
legNumEditq = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[120 457 70 20],...
        'String',[num2str(q) ' kN/m2']);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Datenbank
ba= b-ProfS         %Breite Achsabstand
hI=h*(IT/IS)        %Vergleichsh�he f�r St�tze
dx= 10              %Teilungsfaktor
AZB= 1;             %Anzahl B�gen

%hf= 0.5;
%bf= 0.5;
%tf= 0.5;

%Anzahl Rahmen f�r Unbestimtheit
AZB = 1;
if b > 13 & b < 26
    AZB=2;
end

%L�ngsbinder in Hallenbreite mit while schleife legen
a1= 1; %L�ngsbinderabstand 1,0...4,0m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Anzahl Pfetten abh�ngig von Breite
%Pfettenabstand
n1=(b/a1)               %Anzahl Pfetten, wenn Abstand 1.0m
a15=1.5                 %Definition von a15; Pfettenabstand 1.5m
n15=(b/a15)             %Anzahl Pfetten, wenn Abstand 1.5m
npres=0                 %entg�ltige Anzahl an Pfetten, um dann weiterzurechnen

if n15==round(n15)      %Wenn n15 ganze Zahl, 
    npres=n15+1         %+1 weil Endst�tze hinzukommt
elseif n1==round(n1)    %Wenn n1 ganze Zahl,
    npres=n1+1          %+1 weil Endst�tze hinzukommt
else n15~=round(n15)    %Wenn n15 keine ganze Zahl,
    npres=ceil(n15)+1   %Aufrunden, dass n15 ganz wird (+1 weil Endst�tze hinzukommt)
end
apres=(b/(npres-1))      %resultierender Pfettenabstand (variert zwischen 1 und 1.5)


%Anzahl Binder abh�ngig von L�nge und Abstand
nr=(l/a)               %Anzahl Rahmen, gegeben durch (L�nge/Abstand) von Benutzer gew�hlt
nrres=0                %Anzahl Rahmen, um dann weiterzurechnen

if nr==round(nr)       %Wenn nl ganze Zahl, 
    nrres=nr+1         %+1 weil Endrahmen hinzukommt

else nr~=round(nr)     %Wenn nl keine ganze Zahl,
    nrres=ceil(nr)+1   %Aufrunden, dass n15 gerade wird (+1 weil Endst�tze hinzukommt)
                       %Ver�ndert den eingegebenen Abstand, damit eine
                       %ganze Anzahl an Rahmen entseht
end
arres=(l/(nrres-1))     %resultierender Abstand der Rahmen
                       %weicht vom eingegebenen a ab, wenn (L�nge/Abstand)
                       %keine ganze Zahl ergibt
                       
%Ende Aufbau der Abst�nde (Pfetten und Rahmen) und Anahl (Pfetten und
%Rahmen)

%Beginn Aufteilung der Fl�chenlast auf Pfetten -> erster und letzter Rahmen
%Grundlage f�r Matrix f�r Simon
                      
                            
F1PA=(q*(apres/2)*(arres/2))    %Fl�chenlast auf dem ersten Rahmnen, erste Pfette
                                %Namensgebung: F=Kraft,1=Erster Rahmen,
                                %PA=erste Pfette
F1PB=(q*apres*(arres/2))        %Fl�chenlast auf dem ersten Rahmnen, erste Pfette
                                %Namensgebung: F=Kraft,1=Erster Rahmen,
                                %PB=zweite Pfette oder alle mittlere
                                %Pfetten (alle gleich)

for w=0:(npres-2)               %w=Anzahl Mittelpfetten abh�ngig von der eingegebenen Breite
    w=w
end

Anz1PMi=linspace(F1PB,F1PB,w)   %Voraufbau f�r Matrix
FR1=[F1PA,Anz1PMi,F1PA]         %Matrix f�r alle Kr�fte auf ersten Rahmen 

%Aufbau f�r Matrix 'Distanz x'

u=(npres-2)                     %u=Anzahl Mittelpfetten
uapres=u*apres                  %uapres=H�chste Distanz der Mittelpfette
aMittelstueke=linspace(apres,uapres,u)  %Normalverteilung der Abst�nde der Mittelpfetten)
Distanzx=[0,aMittelstueke,b]    %Distanzmatrix

%Aufteilung der Fl�chenlast auf Pfetten -> mittlere Rahmen (alle gleich)
FMPA=(q*(apres/2)*arres)        %Aufbau Name: F=Kraft, M=Mittlere Rahmen PA=erste Pfette 
FMPB=(q*apres*arres)            %Aufbau Name: F=Kraft, M=Mittlere Rahmen PA=mittlere Pfette

for v=0:(npres-2)               %Anzahl mittlere Pfetten
    v=v                         %Merke erst jetzt, dass auch w gehen w�rde, sorry (oben definiert)
end 

                                %AnzahlMitteRahm=v
AnzMiPMi=linspace(FMPB,FMPB,v)  %Anzahl Mittlere Pfetten, generierung f�r Matrix
FR2=[FMPA,AnzMiPMi,FMPA]       %Matrix Kr�fte auf mittleren Rahmen


%Aufbau Mastermatrix
AA{1,1} = 'Rahmen1 und letzter'; %Name des ersten und letzen Rahmens
AA{1,2} = FR1;                   %Matrix mit Kr�ften des ersten Rahmens
AA{1,3} = Distanzx;              %Matrix mit den Distanzen der Pfetten von links

BB{1,1} = 'Rahmen Mitte';        %Name der mittleren Rahmen, alle identisch
BB{1,2} = FR2;                   %Matrix mit Kr�ften der mittleren Rahmen
BB{1,3} = Distanzx;              %Matrix mit den Distanzen der Pfetten von links

EinwirkungenaufRahmen = cat(3,AA,BB);    %Generiung der Matrix in Matrix

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ Auflagermatrix, MMX,QMX,NMX ] = Funktion_Berechnung_Stahlhalle( K,AZB,EinwirkungenaufRahmen,ba,h,hI )
%Berechnet die Auflagerkraftematrix und die Plot Linien f�r die Bogen
%   Input:
%   K                               Kennzahl f�r EinwirkungaufRahmen Matrix 
%                                        -   1 = Ersten + Letzten Rahmen  
%                                        -   2 = Mittlere Rahmen
%   AZB
%   EinwirkungaufRahmen
%   ba
%   hI
%
%   Output:
%   Auflagermatrix
%   MMX     Matrix Momentenverlauf f�r Plot MSupSL, MSupSR ,MSupSO
%   QMX     Matrix Querkraftverlauf f�r Plot VSupSL, VSupSR ,VSupSO
%   NMX     Matrix Normalkraftverlauf f�r Plot NSupSL, NSupSR ,NSupSO, NSupS1, NSupS2


%Wert aus EinwirkungaufRahmen Matrix lesen
F=EinwirkungenaufRahmen{1,2,K}
x=EinwirkungenaufRahmen{1,3,K}


   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funktion f�r Bogen 2 bis 4 St�tzen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Auflagerkr�fte von 0 Zustand
Av0=(1.-(x./ba)).*F
Bv0=(x./ba).*F

% Verschiebungsgr�ssen (�berlagerung der Momente - Kraftgr�ssenverfahren mit Werte aus Integrationstabelle)
a10=0.5.*Av0.*x.*1.*ba                              % 0 mit 1 Zustand
    
a20=(1/6).*(1+(1-(x./ba))).*(Av0.*x).*1.*ba         % 0 mit 2 Zustand

a30=-a20                                            % 0 mit 3 Zustand

a11=1*1*1*ba+2*((1/3)*1*1*hI)                       % 1 mit 1 Zustand

a12=0.5*1*1*ba+0.5*1*1*hI                           % 1 mit 2 Zustand

a13=(1/3)*1*-1*hI+(1/2)*1*-1*ba+(1/6)*1*1*hI        % 1 mit 3 Zustand

a22=(1/3)*1*1*ba+1*1*1*hI                           % 2 mit 2 Zustand

a23=0.5*1*-1*hI+(1/3)*-1*1*ba                       % 2 mit 3 Zustand

a33=(1/3)*-1*-1*hI+(1/3)*-1*-1*ba+(1/3)*1*1*hI      % 3 mit 3 Zustand



if AZB == 1 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ___________ %%%%%%%%%%%%%
%   Berechnung (n=3) mit 2 St�tzen aussen      �           �            %                          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Matrix der Verschiebungsgr�ssen [B A] * X = [0;0;0]
A=[a11,a12,a13;a12,a22,a23;a13,a23,a33]
B=[-a10;-a20;-a30]

X=A\B

X1=X(1,:)
X2=X(2,:)
X3=X(3,:)

% Auflagerkr�fte in A
Av=Av0+0*X1+(-1/ba)*X2+(1/ba)*X3
Ah=0+(-1/h)*X1+0*X2+(1/h)*X3
Ma=0+0*X1+1*X2+0*X3

% Auflagerkr�fte in B
Bv=Bv0+0*X1+(1/ba)*X2+(-1/ba)*X3
Bh=0+(1/h)*X1+0*X2+(-1/h)*X3
Mb=0+0*X1+0*X2+1*X3

% Moment bei Kraft F
Mf=Av0.*x+1.*X1+(1-(x./ba)).*X2+(1-(x./ba)).*X3.*(-1)

% Moment Ecke Links oben
Ml=0+1.*X1+1.*X2+-1.*X3

% Moment Ecke Rechts oben
Mr=0+1.*X1+0.*X2+0.*X3


% Werte Moment f�r Superposition
dx=1000                                                 % Teilungsfaktor Stab Oben(St�cke pro Meter)
dT=(ba*dx)                                              % Anzahl Teilst�cke des Verlaufs vom Tr�ger
dS=1                                                    % Anzahl Teilst�cke des Verlaufs der St�be (dS=1, generiert ein Wert -> ausreichend )

MSupSL=linspace(sum(Ml),sum(Ma),dS)                     % Superposition Stab Links Moment
MSupSR=linspace(sum(Mb),sum(Mr),dS)                     % Superposition Stab Rechts Moment

MSupSO=zeros(1,dT)                                      % 0 Vektor mit Anzahl Eintr�gen wie MSO f�r Addition
 for z=[1:length(F)]
    if x(z)== 0 
    MSO{z}=zeros(1,dT)                                  % Momente Stab oben wenn x = 0 
    else
    dSOL=round(((dT+1)/ba)*x(z))                        % Anzahl Teilst�cke f�r Moment oben Links von Kraft
    MvorbSOL=linspace(Ml(z),Mf(z),dSOL)                 % Moment Stab oben Links von F
    MvorbSOR=linspace(Mf(z),Mr(z),dT+1-dSOL)            % Moment Stab oben Rechts von F
    MSO{z}=[MvorbSOL(1:end-1),MvorbSOR]                 % Moment Stab oben Links + Rechts
    end
   MSupSO=MSupSO+MSO{z}                                 % Superposition Stab oben f�r Moment
 end
 
% Werte Querkraft f�r Superposition
VSupSL=linspace(sum(-Ah),sum(-Ah),dS)                   % Superposition Stab Links Querkraftkraft
VSupSR=linspace(sum(-Bh),sum(-Bh),dS)                   % Superposition Stab Rechts Querkraftkraft

VSupSO=zeros(1,dT)                                      % 0 Vektor mit Anzahl Eintr�gen wie MSO f�r Addition
for z=[1:length(F)]
   if x(z)== 0 
   VSO{z}=zeros(1,dT)                                   % Momente Stab oben wenn x = 0     
   else     
   dSOL=round(((dT+1)/ba)*x(z))                         % Anzahl Teilst�cke f�r Querkraft oben Links von Kraft
   VvorbSOL=linspace(Av(z),Av(z),dSOL)                  % Querkraft Stab oben Links von F
   VvorbSOR=linspace(Av(z)-F(z),Av(z)-F(z),dT+1-dSOL)   % Querkraft Stab oben Rechts von F
   VSO{z}=[VvorbSOL(1:end-1),VvorbSOR]                  % Querkraft Stab oben Links + Rechts
   end
  VSupSO=VSupSO+VSO{z}                                  % Superposition Stab Oben Werte Querkraft
end


% Werte Normalkraft f�r Superposition
NSupSL=linspace(sum(-Av),sum(-Av),dS)                   % Superposition Stab Links Werte Normalkraft
NSupSR=linspace(sum(Bv),sum(Bv),dS)                     % Superposition Stab Rechts Werte Normalkraft
NSupSO=linspace(sum(Ah),sum(Bh),dS)                     % Superposition Stab Oben Werte Normalkraft


elseif  AZB == 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ___________%%%%%%%%%%%%%%
%    Berechnung (n=4) mit 3 St�tzen            �     �     �            %                          
%}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Verschiebungsgr�ssen Erg�nzung f�r System (n=4)(�berlagerung der Momente - Kraftgr�ssenverfahren mit Werte aus Integrationstabelle)
for z=[1:length(F)]                                     % 0 mit 4 Zustand
if x(z)<=(ba/2)
    a40(z)=(1/12).*((3-4.*((x(z)./ba).^2))/(1-(x(z)./ba))).*(-0.25.*ba).*(Av0(z).*x(z)).*ba
else x(z)>(ba/2)                                       
    a40(z)=(1/12).*((3-4.*((1-(x(z)./ba)).^2))/(x(z)./ba)).*(-0.25.*ba).*(Av0(z).*x(z)).*ba
end
end

a14=0.5*(-0.25*ba)*1*ba                                 % 1 mit 4 Zustand

a24=0.25*(-0.25*ba)*1*ba                                % 2 mit 4 Zustand

a34=0.25*(-0.25*ba)*-1*ba                               % 3 mit 4 Zustand

a44=(1/3)*(-0.25*ba)*(-0.25*ba)*ba                      % 4 mit 4 Zustand


% Matrix der Verschiebungsgr�ssen [B A] * X = [0;0;0;0]
A=[a11,a12,a13,a14;a12,a22,a23,a24;a13,a23,a33,a34;a14,a24,a34,a44]
B=[-a10;-a20;-a30;-a40]

X=A\B

X1=X(1,:)
X2=X(2,:)
X3=X(3,:)
X4=X(4,:)

% Auflagerkr�fte in A
Av=Av0+0*X1+(-1/ba)*X2+(1/ba)*X3+(-0.5)*X4
Ah=0+(-1/h)*X1+0*X2+(1/h)*X3+0*X4
Ma=0+0*X1+1*X2+0*X3+0*X4

% Auflagerkr�fte in B
Bv=Bv0+0*X1+(1/ba)*X2+(-1/ba)*X3+(-0.5)*X4
Bh=0+(1/h)*X1+0*X2+(-1/h)*X3
Mb=0+0*X1+0*X2+1*X3+0*X4

% Auflagerkraft in St�tze 1 (Mitte)
S1v=X4

% Moment bei St�tze in Mitte
for z=[1:length(F)]
    if x(z)<=(ba*0.5)
    Ms1(z)=(Bv0(z).*0.5*ba)+1.*X1(z)+(0.5).*X2(z)+(-0.5).*X3(z)+(-0.25*ba).*X4(z)
    else x(z)>(ba*0.5)
    Ms1(z)=((Av0(z).*0.5*ba))+1.*X1(z)+(0.5).*X2(z)+(-0.5).*X3(z)+(-0.25*ba).*X4(z)
end
end

% Moment bei Kraft F
for z=[1:length(F)]
if x(z)<(ba/2)
   Mf(z)=Av0(z)*x(z)+1*X1(z)+(1-(x(z)/ba))*X2(z)+(1-(x(z)/ba))*X3(z)*(-1)+(2*x(z)/ba)*(-0.25*ba)*X4(z)
elseif x(z) ==(ba/2)
   Mf(z)=Ms1(z)
elseif x(z)>(ba/2)
   Mf(z)=Av0(z)*x(z)+1*X1(z)+(1-(x(z)/ba))*X2(z)+(1-(x(z)/ba))*X3(z)*(-1)+((1-(x(z)/ba))*2)*(-0.25*ba)*X4(z)
end
end
   
% Schnittkrafte Ecke Links oben
Ml=0+1.*X1+1.*X2+-1.*X3+0*X4

% Schnittkr�fte Ecke Rechts oben
Mr=0+1.*X1+0.*X2+0.*X3+0*X4


% Werte Moment f�r Superposition
dx=1000                                                 % Teilungsfaktor Stab Oben(St�cke pro Meter)
dT=(ba*dx)                                              % Anzahl Teilst�cke des Verlaufs vom Tr�ger
dS=1                                                    % Anzahl Teilst�cke des Verlaufs der St�be (dS=1, generiert ein Wert -> ausreichend )

MSupSL=linspace(sum(Ml),sum(Ma),dS)                     % Superposition Stab Links Moment
MSupSR=linspace(sum(Mb),sum(Mr),dS)                     % Superposition Stab Rechts Moment

MSupSO=zeros(1,dT)                                      % 0 Vektor mit Anzahl Eintr�gen wie MSO f�r Addition
 for z=[1:length(F)]
    if x(z)==0
    MSO{z}=zeros(1,dT)                                  % Momente Stab oben wenn x = 0 
    elseif x(z)== ba*0.5 
    MSO{z}=zeros(1,dT)                                  % Momente Stab oben wenn x = 0 
    elseif x(z)== ba 
    MSO{z}=zeros(1,dT)                                  % Momente Stab oben wenn x = 0 
    elseif x(z)<0.5*ba
    dSOL=round(((dT+2)/ba)*x(z))                        % Anzahl Teilst�cke f�r Moment oben Links von Kraft
    dSOM=fix(((dT+2)/ba)*(ba*0.5-x(z)))                 % Anzahl Teilst�cke f�r Moment oben Rechts von Kraft
    MvorbSOL=linspace(Ml(z),Mf(z),dSOL)                 % Moment Stab oben Links von F
    MvorbSOM=linspace(Mf(z),Ms1(z),dSOM)                % Moment Stab oben Mitte von F
    MvorbSOR=linspace(Ms1(z),Mr(z),dT+2-dSOL-dSOM)      % Moment Stab oben Rechts von F
    MSO{z}=[MvorbSOL(1:end-1),MvorbSOM,MvorbSOR(2:end)] % Moment Stab oben Links + Mitte + Rechts
    else x(z)>0.5*ba
    dSOM=round(((dT+2)/ba)*(x(z)-0.5*ba))               % Anzahl Teilst�cke f�r Moment oben Links von Kraft
    dSOR=fix(((dT+2)/ba)*(ba-x(z)))                     % Anzahl Teilst�cke f�r Moment oben Rechts von Kraft
    MvorbSOL=linspace(Ml(z),Ms1(z),dT+2-dSOM-dSOR)      % Moment Stab oben Links von F
    MvorbSOM=linspace(Ms1(z),Mf(z),dSOM)                % Moment Stab oben Mitte von F
    MvorbSOR=linspace(Mf(z),Mr(z),dSOR)                 % Moment Stab oben Rechts von F
    MSO{z}=[MvorbSOL(1:end-1),MvorbSOM,MvorbSOR(2:end)] % Moment Stab oben Links + Mitte + Rechts
    end
   MSupSO=MSupSO+MSO{z}                                 % Superposition Stab oben f�r Moment
 end
 
%Werte Querkraft f�r Superposition
VSupSL=linspace(sum(-Ah),sum(-Ah),dS)                               % Superposition Stab Links Querkraftkraft
VSupSR=linspace(sum(-Bh),sum(-Bh),dS)                               % Superposition Stab Rechts Querkraftkraft

VSupSO=zeros(1,dT)                                                  % 0 Vektor mit Anzahl Eintr�gen wie MSO f�r Addition
for z=[1:length(F)]
   if x(z)== 0 
   VSO{z}=zeros(1,dT)                                               % Momente Stab oben wenn x = 0     
   elseif x(z)== ba*0.5 
   VSO{z}=zeros(1,dT)                                               % Momente Stab oben wenn x = 0 
   elseif x(z)== ba 
   VSO{z}=zeros(1,dT)                                               % Momente Stab oben wenn x = 0     
   elseif x(z)<0.5*ba    
   dSOL=round(((dT+2)/ba)*x(z))                                     % Anzahl Teilst�cke f�r Querkraft oben Links von Kraft
   dSOR=fix(((dT+2)/ba)*(0.5*ba))                                   % Anzahl Teilst�cke f�r Querkraft oben Rechts von Kraft
   VvorbSOL=linspace(Av(z),Av(z),dSOL)                              % Querkraft Stab oben links von F
   VvorbSOM=linspace(Av(z)-F(z),Av(z)-F(z),dT+2-dSOR-dSOL)          % Querkraft Stab oben Mitte von F
   VvorbSOR=linspace(Av(z)-F(z)+S1v(z),Av(z)-F(z)+S1v(z),dSOR)      % Querkraft Stab oben Rechts von F
   VSO{z}=[VvorbSOL(1:end-1),VvorbSOM,VvorbSOR(2:end)]              % Querkraft Stab oben Links + Mitte + Rechts
   else x(z)>0.5*ba
   dSOM=round(((dT+2)/ba)*(x(z)-0.5*ba))                            % Anzahl Teilst�cke f�r Querkraft oben Links von Kraft
   dSOR=fix(((dT+2)/ba)*(ba-x(z)))                                  % Anzahl Teilst�cke f�r Querkraft oben Rechts von Kraft
   VvorbSOL=linspace(Av(z),Av(z),dT+2-dSOM-dSOR)                    % Querkraft Stab oben links von F
   VvorbSOM=linspace(Av(z)+S1v(z),Av(z)+S1v(z),dSOM)                % Querkraft Stab oben Mitte von F
   VvorbSOR=linspace(Av(z)-F(z)+S1v(z),Av(z)-F(z)+S1v(z),dSOR)      % Querkraft Stab oben Rechts von F
   VSO{z}=[VvorbSOL(1:end-1),VvorbSOM,VvorbSOR(2:end)]              % Querkraft Stab oben Links + Mitte + Rechts    
   end
  VSupSO=VSupSO+VSO{z}                                              % Superposition Stab oben Werte Querkraft
end


%Werte Normalkraft f�r Superposition
NSupSL=linspace(sum(-Av),sum(-Av),dS)                   % Superposition Stab Links Werte Normalkraft
NSupSR=linspace(sum(-Bv),sum(-Bv),dS)                   % Superposition Stab Rechts Werte Normalkraft
NSupSO=linspace(sum(Ah),sum(Bh),dS)                     % Superposition Stab Oben Werte Normalkraft
NSupS1=linspace(sum(S1v),sum(S1v),dS)                   % Superposition Stab Mitte Normalkraft



else  AZB == 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ___________%%%%%%%%%%%%%%             
%    Berechnung (n=5) mit 4 St�tzen            �   �   �   �            %                          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fehlt noch !!! weil hat ein Problem

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Erstellen der Outputmatrizen                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Aufbau Auflagermatrix

if AZB == 1
Auflagermatrix = [sum(Av),sum(Ah),sum(Ma);sum(Bv),sum(Bh),sum(Mb)]                     %Generiung der Matrix f�r AZB = 1
elseif AZB == 2
Auflagermatrix = [sum(Av),sum(Ah),sum(Ma);sum(Bv),sum(Bh),sum(Mb);sum(S1v),0,0]             %Generiung der Matrix f�r AZB = 2
else AZB == 3
Auflagermatrix = [sum(Av),sum(Ah),sum(Ma);sum(Bv),sum(Bh),sum(Mb);sum(S1v),0,0;sum(S1v),sum(S2v),0]   %Generiung der Matrix f�r AZB = 3
end

%Aufbau Matrix Momentenverlauf f�r Plot 
MMX ={MSupSL, MSupSR ,MSupSO}
%Aufba Matrix Querkraftverlauf f�r Plot 
QMX = {VSupSL, VSupSR ,VSupSO}
%Aufbau Matrix Normalkraftverlauf f�r Plot 
if AZB == 1
NMX = {NSupSL, NSupSR ,NSupSO}
elseif AZB == 2
NMX = {NSupSL, NSupSR ,NSupSO NSupS1} 
else AZB == 3
NMX = {NSupSL, NSupSR ,NSupSO, NSupS1, NSupS2}
end


end

function [ ] = Funktion_Darstellung_2d_Stahlhalle( K,AZB,ba,h,MMX,QMX,NMX )
%Darstellung der Resultate in 2D
%   Input:
%

%Werte Raphael f�r Fundament in Input hinzuf�gen

%Problem von Simon noch zu l�sen: 
%wie erkennt Funktion ob zum Beispiel: MMX = MMX_1 oder MMX_2 -> mit MMX_ und dann der Wert von K



%Entschl�sselung Matrix Momentenverlauf f�r Plot 
MSupSL=MMX{1} 
MSupSR=MMX{2}
MSupSO=MMX{3}
%Aufba Matrix Querkraftverlauf f�r Plot 
VSupSL=QMX{1} 
VSupSR=QMX{2}
VSupSO=QMX{3}
%Aufbau Matrix Normalkraftverlauf f�r Plot 
NSupSL=NMX{1} 
NSupSR=NMX{2}
NSupSO=NMX{3}
if AZB == 2
NSupS1=NMX{4} 
else AZB == 3
NSupS2=NMX{5} 
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Darstellung Bogen  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)

%Darstellung: Struktur, Auflast & Fundamente
subplot(2,4,1)
hold on
axis equal

plot([0,0],[0,h],'k','LineWidth',3)                                     %Stab Links 
plot([0,ba],[h,h],'k','LineWidth',3)                                    %Stab Oben
plot([ba,ba],[0,h],'k','LineWidth',3)                                   %Stab Rechts
if AZB>1
plot([(1/AZB)*ba,(1/AZB)*ba],[0,h],'k','LineWidth',3)                   %Stab Links 
end
if AZB==3
plot([(2/3)*ba,(2/3)*ba],[0,h],'k','LineWidth',3)                       %Stab Links 
end

plot([-0.5,ba+0.5],[-2,-2],'Color',[0.19 0.19 0.19],'LineWidth',1)      %Bemassung Linie (Breite) Grau
plot([0,0],[-2.5,-1.5],'Color',[0.19 0.19 0.19],'LineWidth',1)          %Bemassung Hilfslinie rechts (Breite) Grau
plot([ba,ba],[-2.5,-1.5],'Color',[0.19 0.19 0.19],'LineWidth',1)        %Bemassung Hilfslinie links (Breite) Grau
if AZB ==1
text(ba*0.5,-1,(num2str(roundn(ba,-2))),'Color',[0.19 0.19 0.19])       %Wert Bemassung (Breite) (Breite !!ba!! -> muss b sein) Grau
elseif AZB ==2
plot([0.5*ba,0.5*ba],[-2.5,-1.5],'Color',[0.19 0.19 0.19],'LineWidth',1)        %Bemassung Hilfslinie St�tze 1 (Breite) Grau    
text(ba*0.25,-1,(num2str(roundn(0.5*ba,-2))),'Color',[0.19 0.19 0.19])       %Wert Bemassung (Breite) (Breite !!ba!! -> muss b sein) Grau
text(ba*0.75,-1,(num2str(roundn(0.5*ba,-2))),'Color',[0.19 0.19 0.19])       %Wert Bemassung (Breite) (Breite !!ba!! -> muss b sein) Grau
else AZB == 3
plot([(1/3)*ba,(1/3)*ba],[-2.5,-1.5],'Color',[0.19 0.19 0.19],'LineWidth',1)        %Bemassung Hilfslinie St�tze 1 (Breite) Grau
plot([(2/3)*ba,(2/3)*ba],[-2.5,-1.5],'Color',[0.19 0.19 0.19],'LineWidth',1)        %Bemassung Hilfslinie St�tze 2 (Breite) Grau
text(ba*(1/3),-1,(num2str(roundn((1/3)*ba,-2))),'Color',[0.19 0.19 0.19])       %Wert Bemassung (Breite) (Breite !!ba!! -> muss b sein) Grau
text(ba*(1/3),-1,(num2str(roundn((1/3)*ba,-2))),'Color',[0.19 0.19 0.19])       %Wert Bemassung (Breite) (Breite !!ba!! -> muss b sein) Grau
text(ba*0.5,-1,(num2str(roundn((1/3)*ba,-2))),'Color',[0.19 0.19 0.19])       %Wert Bemassung (Breite) (Breite !!ba!! -> muss b sein) Grau
end
plot([ba+2,ba+2],[-0.5,h+0.5],'Color',[0.19 0.19 0.19],'LineWidth',1)      %Bemassung Linie (H�he) Grau
plot([ba+1.5,ba+2.5],[0,0],'Color',[0.19 0.19 0.19],'LineWidth',1)          %Bemassung Hilfslinie rechts (H�he) Grau
plot([ba+1.5,ba+2.5],[h,h],'Color',[0.19 0.19 0.19],'LineWidth',1)        %Bemassung Hilfslinie links (H�he) Grau
text(ba+1,h*0.5,(num2str(roundn(h,-2))),'Color',[0.19 0.19 0.19])                  %Wert Bemassung (H�he) (Breite !!h!! -> muss ... sein) Grau
hold off

dR= -10   %dR = Rundungsziffer weil sehr kleine Null Werte die Grafik verziehen

%Daratellung Moment
dM= (ba*0.25)/roundn(max(abs([MSupSL MSupSO MSupSR])),dR)                   %Darstellungs Faktor Moment (Mmax = 0.25 von Breite)
subplot(2,4,2)
hold on
axis equal

%Struktur
plot([0,0],[0,h],'k','LineWidth',3)                                     %Stab Links 
plot([0,ba],[h,h],'k','LineWidth',3)                                    %Stab Oben
plot([ba,ba],[0,h],'k','LineWidth',3)                                   %Stab Rechts
if AZB>1
plot([(1/AZB)*ba,(1/AZB)*ba],[0,h],'k','LineWidth',3)                   %Stab Links 
end
if AZB==3
plot([(2/3)*ba,(2/3)*ba],[0,h],'k','LineWidth',3)                       %Stab Links 
end

%Momentenverlauf Stab links 
MxSL=(MSupSL.*dM)
MySL=linspace(h,0,3)
plot(MxSL,MySL,'r','LineWidth',2)                    %Stab-Moment Rechts
plot([0,MSupSL(end)*dM],[0,0],'r','LineWidth',2)         %Stab-Moment Erg�nzung unten
plot([0,MSupSL(1)*dM],[h,h],'r','LineWidth',2)         %Stab-Moment Erg�nzung oben
text((MSupSL(end)*dM),-1,num2str(roundn(MSupSL(end),-2)))  %Text unten Ma !!! Wert -1 !!

%Momentenverlauf Stab rechts
MxSR=ba-(MSupSR.*dM)           
MySR=linspace(0,h,3)
plot(MxSR,MySR,'r','LineWidth',2)                      %Stab-Moment Links
plot([ba,ba-MSupSR(1)*dM],[0,0],'r','LineWidth',2)       %Stab-Moment Erg�nzung unten
plot([ba,ba-MSupSR(end)*dM],[h,h],'r','LineWidth',2)       %Stab-Moment Erg�nzung oben
text((ba-MSupSR(1)*dM)-4,-1,num2str(roundn(MSupSR(1),-2)))   %Text unten Mb !!! Wert -4&-1 !!! 

%Momentenverlauf Stab oben
MySO=h-(MSupSO.*dM)
MxSO=linspace(0,ba,length(MSupSO))
plot(MxSO,MySO,'r','LineWidth',2)                       %Stab-Moment Oben
plot([0,0],[h,h-MSupSL(1)*dM],'r','LineWidth',2)          %Stab-Moment Erg�nzung Links
plot([ba,ba],[h,h-MSupSR(end)*dM],'r','LineWidth',2)        %Stab-Moment Erg�nzung rechts
text(-1+MSupSL(1)*dM,h+1-MSupSL(1)*dM,num2str(roundn(MSupSL(1),-2)))               %Text Ml !!! +1 % -1!!!
text(ba-MSupSR(end)*dM,h-MSupSR(end)*dM,num2str(roundn(MSupSR(end),-2)))                  %Text Mr
text((mean((find(MSupSO==max(MSupSO))/length(MSupSO))))*ba...
    ,h-1-max(MSupSO)*dM,num2str(roundn(max(MSupSO),-2)))             %Text Max-Moment Mf !!! -1 !!!
if AZB>1
text((mean((find(MSupSO==min(MSupSO))/length(MSupSO))))*ba...
    ,h-min(MSupSO)*dM,num2str(roundn(min(MSupSO),-2)))                                 %Text MIN-Moment Mf
end

hold off

% Darstellung Querkraft
dV=(ba*0.25)/roundn(max(abs([VSupSL VSupSO VSupSR])),dR) 
subplot(2,4,3)
hold on
axis equal 

%Struktur
plot([0,0],[0,h],'k','LineWidth',3)                                     %Stab Links 
plot([0,ba],[h,h],'k','LineWidth',3)                                    %Stab Oben
plot([ba,ba],[0,h],'k','LineWidth',3)                                   %Stab Rechts
if AZB>1
plot([(1/AZB)*ba,(1/AZB)*ba],[0,h],'k','LineWidth',3)                   %Stab Links 
end
if AZB==3
plot([(2/3)*ba,(2/3)*ba],[0,h],'k','LineWidth',3)                       %Stab Links 
end

%Querkraftverlauf Stab Links
plot([VSupSL*dV,VSupSL*dV],[0,h],'b','LineWidth',2)            %Querkraft Stab links
plot([0,VSupSL*dV],[0,0],'b','LineWidth',2)                      %Querkraft Stab links Erg�nzunglinie unten
plot([0,VSupSL*dV],[h,h],'b','LineWidth',2)                      %Querkraft Stab links Erg�nzunglinie oben
text(VSupSL*dV,h*0.5,num2str(roundn(VSupSL,-2)))             %Text Stab Links !!!  !!!

%Querkraftverlauf Stab Rechts
plot([ba-VSupSR*dV,ba-VSupSR*dV],[0,h],'b','LineWidth',2)            %Querkraft Stab links
plot([ba,ba-VSupSR*dV],[0,0],'b','LineWidth',2)                      %Querkraft Stab links Erg�nzunglinie unten
plot([ba,ba-VSupSR*dV],[h,h],'b','LineWidth',2)                      %Querkraft Stab links Erg�nzunglinie oben
text(ba-VSupSR*dV,h*0.5,num2str(roundn(VSupSR,-2)))             %Text Stab Links !!!  !!!

%Querkraftverlauf Stab oben
VySO=h-(VSupSO.*dV)
VxSO=linspace(0,ba,length(VSupSO))
plot(VxSO,VySO,'b','LineWidth',2)                   %Querkraft Stab oben
plot([0,0],[h,VySO(1)],'b','LineWidth',2)           %Querkraft Stab oben Erg�nzungslinie links
plot([ba,ba],[h,VySO(end)],'b','LineWidth',2)       %Querkraft Stab oben Erg�nzungslinie rechts
text((mean((find(VSupSO==max(VSupSO))/length(VSupSO))))*ba,h-max(VSupSO)*dV,num2str(roundn(max(VSupSO),-2)))             %Text Max Querkraft !!!  !!!
text((mean((find(VSupSO==min(VSupSO))/length(VSupSO))))*ba,h-min(VSupSO)*dV,num2str(roundn(min(VSupSO),-2)))                %Text Min-Querkraft !!!  !!!

hold off

%Normalkaft
if AZB==1
dN=(ba*0.25)/roundn(max(abs([NSupSL NSupSO NSupSR])),dR) 
elseif AZB ==2
dN=(ba*0.25)/max(abs([NSupSL NSupSO NSupSR NSupS1]))     
elseif AZB == 3
dN=(ba*0.25)/max(abs([NSupSL NSupSO NSupSR NSupS1 NSupS2])) 
end 
subplot(2,4,4)
hold on
axis equal 

%Struktur
plot([0,0],[0,h],'k','LineWidth',3)                                     %Stab Links 
plot([0,ba],[h,h],'k','LineWidth',3)                                    %Stab Oben
plot([ba,ba],[0,h],'k','LineWidth',3)                                   %Stab Rechts
if AZB>1
plot([(1/AZB)*ba,(1/AZB)*ba],[0,h],'k','LineWidth',3)                   %Stab Links 
end
if AZB==3
plot([(2/3)*ba,(2/3)*ba],[0,h],'k','LineWidth',3)                       %Stab Links 
end

%Normalkraftverlauf Stab Links
plot([-NSupSL*dN,-NSupSL*dN],[0,h],'g','LineWidth',2)            %Normalkraft Stab links
plot([0,-NSupSL*dN],[0,0],'g','LineWidth',2)                     %Normalkraft Stab links Erg�nzunglinie unten
plot([0,-NSupSL*dN],[h,h],'g','LineWidth',2)                     %Normalkraft Stab links Erg�nzunglinie oben
text(-NSupSL*dN,h*0.5,num2str(roundn(NSupSL,-2)))                %Text Stab Links !!!  !!!

%Normalkraftverlauf Stab Rechts
plot([ba-NSupSR*dN,ba-NSupSR*dN],[0,h],'g','LineWidth',2)            %Normalkraft Stab rechts
plot([ba,ba-NSupSR*dN],[0,0],'g','LineWidth',2)                      %Normalkraft Stab rechts Erg�nzunglinie unten
plot([ba,ba-NSupSR*dN],[h,h],'g','LineWidth',2)                      %Normalkraft Stab rechts Erg�nzunglinie oben
text(ba-NSupSR*dN,h*0.5,num2str(roundn(NSupSR,-2)))                  %Text Stab Links !!!  !!!

%Querkraftverlauf Stab Mitte
if AZB==2
plot([(1/AZB)*ba-NSupS1*dN,(1/AZB)*ba-NSupS1*dN],[0,h],'g','LineWidth',2)            %Normalkraft Stab rechts
plot([(1/AZB)*ba,(1/AZB)*ba-NSupS1*dN],[0,0],'g','LineWidth',2)                      %Normalkraft Stab rechts Erg�nzunglinie unten
plot([(1/AZB)*ba,(1/AZB)*ba-NSupS1*dN],[h,h],'g','LineWidth',2)                      %Normalkraft Stab rechts Erg�nzunglinie oben
text((1/AZB)*ba-NSupS1*dN,h*0.5,num2str(roundn(NSupS1,-2)))                  %Text Stab Links !!!  !!!
elseif AZB==3
    
end
%Normalkraftverlauf Stab oben
plot([0,ba],[h+NSupSO*dN,h+NSupSO*dN],'g','LineWidth',2)            %Normalkraft Stab oben
plot([0,0],[h,h+NSupSO*dN],'g','LineWidth',2)                      %Normalkraft Stab oben Erg�nzunglinie unten
plot([ba,ba],[h,h+NSupSO*dN],'g','LineWidth',2)                      %Normalkraft Stab oben Erg�nzunglinie oben
text(ba*0.5,h+NSupSR*dN,num2str(roundn(NSupSO,-2)))                  %Text Stab Links !!!  !!!

hold off
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fundamente

function [ ] = Funktion_Berechnung_Fundament(Auflagermatrix,K,AZB,sm,ksm)

%Fundamente Rahmen

o2=ksm*sm   %Randspannung=Bettungsmodul*Setzung

hf=1        %Einbindetiefe

if K==1
bf1=(sum(Ma)+(sum(Ah)*hf)/sum(Av))*6   %Breite aufgrund von Kernpunkt
if bf1<=0.4          %Mindesbreite
    bf1=0.4          
else bf1=((sum(Ma)+(sum(Ah)*hf))/sum(Av))*6 %gr�sser als Mindesbreite
end

tf1=2*sum(Av)/(o2*bf1)      %L�nge aufgrund Einwirkung
if tf1<=0.4          %Mindesl�nge
    tf1=0.4
else tf1=2*sum(Av)/(o2*bf1)      %L�nge aufgrund Einwirkung
end
end

if K==2
bf2=(sum(Ma)+(sum(Ah)*hf)/sum(Av))*6   %Breite aufgrund von Kernpunkt
if bf2<=0.4          %Mindesbreite
    bf2=0.4          
else bf2=((sum(Ma)+(sum(Ah)*hf))/sum(Av))*6 %gr�sser als Mindesbreite
end

tf2=2*sum(Av)/(o2*bf2)      %L�nge aufgrund Einwirkung
if tf2<=0.4          %Mindesl�nge
    tf2=0.4
else tf2=2*sum(Av)/(o2*bf2)      %L�nge aufgrund Einwirkung
end
end

%Fundamente Pendelst�tze (Kein Moment)
om=ksm*sm  %Bodenspannung Mitte

%om=Kraft /Fl�che

FAM=sum(S1v)/om    %Fl�che um Normalkraft aufzunehmen

blm=sqrt(FAM) %quadratisches Fundament

end

%Plot f�r erster + letzer Rahmen

[ Auflagermatrix, MMX,QMX,NMX ] = Funktion_Berechnung_Stahlhalle( 1,AZB,EinwirkungenaufRahmen,ba,h,hI )


%[ figure(1) ] = Funktion_Darstellung_2d_Stahlhalle( 1,AZB,ba,h,MMX,QMX,NMX )

%Plot mittlere Rahmen

[ Auflagermatrix, MMX,QMX,NMX ] = Funktion_Berechnung_Stahlhalle( 2,AZB,EinwirkungenaufRahmen,ba,h,hI )

%[ figure(2) ] = Funktion_Darstellung_2d_Stahlhalle( 2,AZB,ba,h,MMX,QMX,NMX )


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
%Patch Properties
fac= [1 2 3 4; 4 3 5 6; 6 7 8 5; 1 2 8 7; 6 7 1 4; 2 3 5 8];    % Welche Eckpunkte werden als eine Polygonfl�che eingef�rbt

%FaceColor
FarbePfette = 'b'
FarbePfetteI = 'm'
FarbeStuetze = 'r'
FarbeStuetzeI = 'y'
FarbeFundament = [0.12 0.56 1]
FarbeQuerbalken = 'g'
FarbeQuerbalkenI = 'y'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pfette A
vert1= [ProfSb/2-ProfTb/2 0 (h-ProfTh); ProfSb/2+ProfTb/2 0 (h-ProfTh); ProfSb/2+ProfTb/2 0 h; ProfSb/2-ProfTb/2 0 h; ProfTb l h; ProfSb/2-ProfTb/2 l h; ProfSb/2-ProfTb/2 l (h-ProfTh); ProfSb/2+ProfTb/2 l (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert1,'FaceColor',FarbePfette);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Pfette B
vert2= [(b-ProfSb/2-ProfTb/2) 0 (h-ProfTh); b-ProfSb/2+ProfTb/2 0 (h-ProfTh); b-ProfSb/2+ProfTb/2 0 h; (b-ProfSb/2-ProfTb/2) 0 h; b-ProfSb/2+ProfTb/2 l h; (b-ProfSb/2-ProfTb/2) l h; (b-ProfSb/2-ProfTb/2) l (h-ProfTh); b-ProfSb/2+ProfTb/2 l (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert2,'FaceColor',FarbePfette);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 1
vert3= [0 0 0; 0 ProfSt 0; ProfSb ProfSt 0; ProfSb 0 0; ProfSb ProfSt (h-2*ProfTh); ProfSb 0 (h-2*ProfTh); 0 0 (h-2*ProfTh); 0 ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor',FarbeStuetze);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament 1
vert14= [ProfSb/2-bf/2 ProfSt/2-tf/2 0; ProfSb/2-bf/2 ProfSt/2+tf/2 0; ProfSb/2+bf/2 ProfSt/2+tf/2 0; ProfSb/2+bf/2 ProfSt/2-tf/2 0;...
        ProfSb/2+bf/2 ProfSt/2+tf/2 -hf; ProfSb/2+bf/2 ProfSt/2-tf/2 -hf; ProfSb/2-bf/2 ProfSt/2-tf/2 -hf; ProfSb/2-bf/2 ProfSt/2+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert14,'FaceColor', FarbeFundament);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 2
vert4= [b 0 0; b ProfSt 0; (b-ProfSb) ProfSt 0; (b-ProfSb) 0 0; (b-ProfSb) ProfSt (h-2*ProfTh); (b-ProfSb) 0 (h-2*ProfTh); b 0 (h-2*ProfTh); b ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert4,'FaceColor',FarbeStuetze);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament 2
vert15= [b-(ProfSb/2-bf/2) ProfSt/2-tf/2 0; b-(ProfSb/2-bf/2) ProfSt/2+tf/2 0; b-(ProfSb/2+bf/2) ProfSt/2+tf/2 0; b-(ProfSb/2+bf/2) ProfSt/2-tf/2 0;...
        b-(ProfSb/2+bf/2) ProfSt/2+tf/2 -hf; b-(ProfSb/2+bf/2) ProfSt/2-tf/2 -hf; b-(ProfSb/2-bf/2) ProfSt/2-tf/2 -hf; b-(ProfSb/2-bf/2) ProfSt/2+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert15,'FaceColor',FarbeFundament);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 3
vert5= [0 (l-ProfSt) 0; 0 l 0; ProfSb l 0; ProfSb (l-ProfSt) 0; ProfSb l (h-2*ProfTh); ProfSb (l-ProfSt) (h-2*ProfTh); 0 (l-ProfSt) (h-2*ProfTh); 0 l (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor',FarbeStuetze);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament 3
vert16= [ProfSb/2-bf/2 l-(ProfSt/2-tf/2) 0; ProfSb/2-bf/2 l-(ProfSt/2+tf/2) 0; ProfSb/2+bf/2 l-(ProfSt/2+tf/2) 0; ProfSb/2+bf/2 l-(ProfSt/2-tf/2) 0;...
        ProfSb/2+bf/2 l-(ProfSt/2+tf/2) -hf; ProfSb/2+bf/2 l-(ProfSt/2-tf/2) -hf; ProfSb/2-bf/2 l-(ProfSt/2-tf/2) -hf; ProfSb/2-bf/2 l-(ProfSt/2+tf/2) -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert16,'FaceColor',FarbeFundament);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 4
vert6= [b (l-ProfSt) 0; b l 0; (b-ProfSb) l 0; (b-ProfSb) (l-ProfSt) 0; (b-ProfSb) l (h-2*ProfTh); (b-ProfSb) (l-ProfSt) (h-2*ProfTh); b (l-ProfSt) (h-2*ProfTh); b l (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert6,'FaceColor',FarbeStuetze);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament 4
vert17= [b-(ProfSb/2-bf/2) l-(ProfSt/2-tf/2) 0; b-(ProfSb/2-bf/2) l-(ProfSt/2+tf/2) 0; b-(ProfSb/2+bf/2) l-(ProfSt/2+tf/2) 0; b-(ProfSb/2+bf/2) l-(ProfSt/2-tf/2) 0;...
        b-(ProfSb/2+bf/2) l-(ProfSt/2+tf/2) -hf; b-(ProfSb/2+bf/2) l-(ProfSt/2-tf/2) -hf; b-(ProfSb/2-bf/2) l-(ProfSt/2-tf/2) -hf; b-(ProfSb/2-bf/2) l-(ProfSt/2+tf/2) -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor',FarbeFundament);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Querbalken Anfang
vert7= [0 ProfSt/2-ProfTb/2 (h-2*ProfTh); 0 ProfSt/2-ProfTb/2 (h-ProfTh); 0 ProfSt/2+ProfTb/2 (h-ProfTh); 0 ProfSt/2+ProfTb/2 (h-2*ProfTh); b ProfSt/2+ProfTb/2 (h-ProfTh); b ProfSt/2+ProfTb/2 (h-2*ProfTh); b ProfSt/2-ProfTb/2 (h-2*ProfTh); b 0 (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert7,'FaceColor',FarbeQuerbalken);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Querbalken Ende
vert8= [0 (l-ProfSt/2-ProfTb/2) (h-2*ProfTh); 0 (l-ProfSt/2-ProfTb/2) (h-ProfTh); 0 l-ProfSt/2+ProfTb/2 (h-ProfTh); 0 l-ProfSt/2+ProfTb/2 (h-2*ProfTh); b l-ProfSt/2+ProfTb/2 (h-ProfTh); b l-ProfSt/2+ProfTb/2 (h-2*ProfTh); b (l-ProfSt/2-ProfTb/2) (h-2*ProfTh); b (l-ProfSt/2-ProfTb/2) (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert8,'FaceColor',FarbeQuerbalken);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Wenn Hallenbreite gr�sser 13m ist wird eine weiter Sttzenreihe bei 1/2
%erg�nzt
%St�tzen anfang und ende
if b > 13 & b < 26
   SMb= (b/2) -(ProfSb/2);           %Hilfsgr�sse% Pos X (also St�tzenabstand) der St�zte. Einmitung auf Achsmass der St�tze
  
%Stuetze VM 
vert3= [SMb 0 0; SMb ProfSt 0; (SMb+ProfSb) ProfSt 0; (SMb+ProfSb) 0 0; (SMb+ProfSb) ProfSt (h-2*ProfTh); (SMb+ProfSb) 0 (h-2*ProfTh); SMb 0 (h-2*ProfTh); SMb ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor',FarbeStuetze);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament VM
vert15= [(b/2-bf/2) ProfSt/2-tf/2 0; (b/2-bf/2) ProfSt/2+tf/2 0; (b/2+bf/2) ProfSt/2+tf/2 0; (b/2+bf/2) ProfSt/2-tf/2 0;...
        (b/2+bf/2) ProfSt/2+tf/2 -hf; (b/2+bf/2) ProfSt/2-tf/2 -hf; (b/2-bf/2) ProfSt/2-tf/2 -hf; (b/2-bf/2) ProfSt/2+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert15,'FaceColor',FarbeFundament);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze HM
vert5= [SMb (l-ProfSt) 0; SMb l 0; (SMb+ProfSb) l 0; (SMb+ProfSb) (l-ProfSt) 0; (SMb+ProfSb) l (h-2*ProfTh); (SMb+ProfSb) (l-ProfSt) (h-2*ProfTh); SMb (l-ProfSt) (h-2*ProfTh); SMb l (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor',FarbeStuetze);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament HM
vert17= [(b/2-bf/2) l-(ProfSt/2-tf/2) 0; (b/2-bf/2) l-(ProfSt/2+tf/2) 0; (b/2+bf/2) l-(ProfSt/2+tf/2) 0; (b/2+bf/2) l-(ProfSt/2-tf/2) 0;...
        (b/2+bf/2) l-(ProfSt/2+tf/2) -hf; (b/2+bf/2) l-(ProfSt/2-tf/2) -hf; (b/2-bf/2) l-(ProfSt/2-tf/2) -hf; (b/2-bf/2) l-(ProfSt/2+tf/2) -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor',FarbeFundament);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pfetten dazwischen
j=0;
while j< (b-(apres))
    j=j+apres;
  XMRL = (j-(ProfTb/2));      %Hilfsgr�sse% Achsabstand der L�ngsbinder in While Schleife
vert13= [XMRL 0 (h-ProfTh); (XMRL+ProfTb) 0 (h-ProfTh); (XMRL+ProfTb) 0 h; XMRL 0 h; (XMRL+ProfTb) l h; XMRL l h; XMRL l (h-ProfTh); (XMRL+ProfTb) l (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert13,'FaceColor',FarbePfetteI);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)  
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Binder i St�tzen und Querbalken dazwischen
i1=0;
while i1 < l-arres; 
       i1= i1 +arres;
   XMVQS = (i1-(ProfSt/2));           %Hilfsgr�sse% Achsabstand der St�tze in While-schleife
   XMVQT=  (i1-(ProfTb/2));           %Hilfsgr�sse% Achsabstand der Balken in While-schleife

%Querbalken 
vert9= [0 XMVQT (h-2*ProfTh); 0 XMVQT (h-ProfTh); 0 (XMVQT+ProfTb) (h-ProfTh); 0 (XMVQT+ProfTb) (h-2*ProfTh); b (XMVQT+ProfTb) (h-ProfTh); b (XMVQT+ProfTb) (h-2*ProfTh); b XMVQT (h-2*ProfTh); b XMVQT (h-ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor',FarbeQuerbalkenI);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze iA
vert10= [0 XMVQS 0; 0 (XMVQS+ProfSt) 0; ProfSb (XMVQS+ProfSt) 0; ProfSb XMVQS 0; ProfSb (XMVQS+ProfSt) (h-2*ProfTh); ProfSb XMVQS (h-2*ProfTh); 0 XMVQS (h-2*ProfTh); 0 (XMVQS+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor',FarbeQuerbalkenI);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament iA
vert16= [ProfSb/2-bf/2 i1-tf/2 0; ProfSb/2-bf/2 i1+tf/2 0; ProfSb/2+bf/2 i1+tf/2 0; ProfSb/2+bf/2 i1-tf/2 0;...
        ProfSb/2+bf/2 i1+tf/2 -hf; ProfSb/2+bf/2 i1-tf/2 -hf; ProfSb/2-bf/2 i1-tf/2 -hf; ProfSb/2-bf/2 i1+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert16,'FaceColor', FarbeFundament);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze iB
vert11= [b XMVQS 0; b (XMVQS+ProfSt) 0; (b-ProfSb) (XMVQS+ProfSt) 0; (b-ProfSb) XMVQS 0; (b-ProfSb) (XMVQS+ProfSt) (h-2*ProfTh); (b-ProfSb) XMVQS (h-2*ProfTh); b XMVQS (h-2*ProfTh); b (XMVQS+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor',FarbeStuetzeI);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament iB
vert17= [b-(ProfSb/2-bf/2) i1-tf/2 0; b-(ProfSb/2-bf/2) i1+tf/2 0; b-(ProfSb/2+bf/2) i1+tf/2 0; b-(ProfSb/2+bf/2) i1-tf/2 0;...
        b-(ProfSb/2+bf/2) i1+tf/2 -hf; b-(ProfSb/2+bf/2) i1-tf/2 -hf; b-(ProfSb/2-bf/2) i1-tf/2 -hf; b-(ProfSb/2-bf/2) i1+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor',FarbeFundament);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%St�tzenreihen bei gr�sseren Spannweiten >13
if b >13 & b < 26
    
%Stuetze iM
vert3= [SMb XMVQS 0; SMb (XMVQS+ProfSt) 0; (SMb+ProfSb) (XMVQS+ProfSt) 0; (SMb+ProfSb) XMVQS 0; (SMb+ProfSb) (XMVQS+ProfSt) (h-2*ProfTh); (SMb+ProfSb) XMVQS (h-2*ProfTh); SMb XMVQS (h-2*ProfTh); SMb (XMVQS+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor',FarbeStuetze);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Einzelfundament iM
vert17= [(b/2-bf/2) i1-tf/2 0; (b/2-bf/2) i1+tf/2 0; (b/2+bf/2) i1+tf/2 0; (b/2+bf/2) i1-tf/2 0;...
        (b/2+bf/2) i1+tf/2 -hf; (b/2+bf/2) i1-tf/2 -hf; (b/2-bf/2) i1-tf/2 -hf; (b/2-bf/2) i1+tf/2 -hf]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor',FarbeFundament);            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
        end
    
 end