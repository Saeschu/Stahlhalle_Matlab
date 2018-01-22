function mygui()
f1= figure('Name', 'Input Window', 'NumberTitle', 'off','MenuBar', 'None', 'color', 'w',...
    'resize', 'on', 'nextPlot', 'new', 'units', 'normalized', 'position', [0.05 0.45 0.445 0.44])    %'units', 'normalized' => Positionsverhältis des Bildschirmes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
txtTittel = uicontrol('Style','text','HorizontalAlignment', 'Center',...
        'Position',[230 380 300 30],'BackgroundColor','w',...
        'String','Kräftefluss in einer Stahlhalle', 'FontSize', 16); 

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
%Eingabe Länge 
txtLaenge = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[20 329 100 20],'BackgroundColor', 'w',...
        'String','Länge [m] :'); 
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
        'String','Ab einer Spannweite ab 13 m wird die Geasmtspannweite mittels Stützen gewährleistet. Maximalespannweite zwischen den Stüzten beträgt 13 m, maximale Gesammtspannweite beträgt 26 m.');
    
%Eingabe Höhe
txtHoehe = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[20 279 100 20],'BackgroundColor', 'w',...
        'String','Höhe [m] :'); 
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
%Träger
txtBauDimT = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[265 329 100 20], 'BackgroundColor', 'w',...
        'String','Profil Träger :'); 
DdownBauDimT= uicontrol('Style', 'popup',...
        'String', {'IPE200', 'IPE220', 'IPE240', 'IPE270', 'HEA200', 'HEA220', 'HEA240', 'HEA260'},...
        'Position', [375 330 100 22],'background','w');
%Stütze         
txtBauDimS = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[265 304 100 20],'BackgroundColor', 'w',...
        'String','Profil Stütze :'); 
DdownBauDimS= uicontrol('Style', 'popup',...
        'String', {'IPE200', 'IPE220', 'IPE240', 'IPE270', 'HEA200', 'HEA220', 'HEA240', 'HEA260'},...
        'Position', [375 305 100 22],'background','w');
    
% Festlegung ob Hallenhöe unter oder oberkannte Balken gesetzt werden soll
% 1== Unterkannte, 2== Oberkannte
txtBedH = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[505 329 100 20],'BackgroundColor', 'w',...
        'String','Bezugshöhe :'); 
DdownBedH= uicontrol('Style', 'popup',...
             'String', {'Unterkante Binder', 'Oberkante Pfette'},...
             'Position', [625 330 120 22],'background','w');    
         
%Tittel Einwirkungen
txtTitAbm = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[20 180 100 17],'BackgroundColor','w', 'fontsize', 10,...
        'String','Einwirkungen');

% Flächenlast
txtq = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[20 149 100 20], 'BackgroundColor','w',...
        'String','Flächenlast [kN/m2] :'); 
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
        'String', 'zulässige Setzungen :');
DdownSet = uicontrol('Style', 'popup',...
        'String', {'5 mm','10 mm','15 mm'},...
        'Position', [375 125 100 20],'background','w');
    
%Info 'Position', [left bottom width height]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
%Bauteilprofiele    %[Höhe Breite Iy]
elementBP= [0.2 0.1 19.4e6;...      %IPE200
          0.22 0.11 27.7e6;...      %IPE220
          0.24 0.12 38.9e6;...      %IPE240
          0.27 0.135 57.9e6;...     %IPE270
          0.2 0.19 36.9e6;...       %HEA200
          0.22 0.21 54.1e6;...      %HEA220
          0.24 0.23 77.6e6;...      %HEA240
          0.26 0.25 104.5e6];       %HEA260
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
%Übernahme Input        
%Editfield
l= (str2num(get(EditLaenge, 'String')))
b= (str2num(get(EditBreite, 'string')))
h= (str2num(get(EditHoehe, 'String')))
a= (str2num(get(EditBabst, 'String')))
q= (str2num(get(Editq, 'String')))

%Inpunt dropdown Profiele
ProfS= get(DdownBauDimS, 'Value') %Profiel Stütze
ProfSb= elementBP(ProfS, 1) 
ProfSt= elementBP(ProfS, 2)
IS= elementBP(ProfS, 3)

ProfT= get(DdownBauDimT, 'Value') %Profiel Träger
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
%Textausgabe, Gesammtspannweite überschreitet einzelspannweiten der Träger.
%Berechnung kann nicht weiter ausgeführt werden.
if b > 26
    msgbox('Die gewählte Gesamtspannweite der Lagerhalle [Breite], überschreitet die zulässige maximalspannweite von 26m. Berechnung mit mehr als 3 Stützenreihen bzw. 2 Rahmen ist zur zeit nicht möglich.',...
        'Infobox')
    return 
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Festlegung ob Hallenhöhe unter oder oberkannte Balken ist... 1= Unterkannte, 2= Oberkannte
if BedH==1        
    h=h+2*ProfTh
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Datenbank
ba= b-ProfSb         %Breite Achsabstand
hI=h*(IT/IS)        %Vergleichshöhe für Stütze
dx= 10              %Teilungsfaktor
AZB= 1;             %Anzahl Bögen

hf= 1;
bf= 0.5;
tf= 0.5;

%Anzahl Rahmen für Unbestimtheit
AZB = 1;
if b >= 13 & b <= 26
    AZB=2;
end

%Längsbinder in Hallenbreite mit while schleife legen
a1= 1; %Längsbinderabstand 1,0...4,0m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Anzahl Pfetten abhängig von Breite
%Pfettenabstand
n1=(ba/a1)               %Anzahl Pfetten, wenn Abstand 1.0m
a15=1.5                 %Definition von a15; Pfettenabstand 1.5m
n15=(ba/a15)             %Anzahl Pfetten, wenn Abstand 1.5m
npres=0                 %entgültige Anzahl an Pfetten, um dann weiterzurechnen

if n15==round(n15)      %Wenn n15 ganze Zahl, 
    npres=n15+1         %+1 weil Endstütze hinzukommt
elseif n1==round(n1)    %Wenn n1 ganze Zahl,
    npres=n1+1          %+1 weil Endstütze hinzukommt
else n15~=round(n15)    %Wenn n15 keine ganze Zahl,
    npres=ceil(n15)+1   %Aufrunden, dass n15 ganz wird (+1 weil Endstütze hinzukommt)
end
apres=(ba/(npres-1))      %resultierender Pfettenabstand (variert zwischen 1 und 1.5)


%Anzahl Binder abhängig von Länge und Abstand
nr=(l/a)               %Anzahl Rahmen, gegeben durch (Länge/Abstand) von Benutzer gewählt
nrres=0                %Anzahl Rahmen, um dann weiterzurechnen

if nr==round(nr)       %Wenn nl ganze Zahl, 
    nrres=nr+1         %+1 weil Endrahmen hinzukommt

else nr~=round(nr)     %Wenn nl keine ganze Zahl,
    nrres=ceil(nr)+1   %Aufrunden, dass nrres gerade wird (+1 weil Endstütze hinzukommt)
                       %Verändert den eingegebenen Abstand, damit eine
                       %ganze Anzahl an Rahmen entseht
end
arres=(l/(nrres-1))     %resultierender Abstand der Rahmen
                       %weicht vom eingegebenen a ab, wenn (Länge/Abstand)
                       %keine ganze Zahl ergibt
                       
%Ende Aufbau der Abstände (Pfetten und Rahmen) und Anahl (Pfetten und
%Rahmen)

%Beginn Aufteilung der Flächenlast auf Pfetten -> erster und letzter Rahmen
%Grundlage für Matrix für Simon
                      
                            
F1PA=(q*(apres/2)*(arres/2))    %Flächenlast auf dem ersten Rahmnen, erste Pfette
                                %Namensgebung: F=Kraft,1=Erster Rahmen,
                                %PA=erste Pfette
F1PB=(q*apres*(arres/2))        %Flächenlast auf dem ersten Rahmnen, erste Pfette
                                %Namensgebung: F=Kraft,1=Erster Rahmen,
                                %PB=zweite Pfette oder alle mittlere
                                %Pfetten (alle gleich)

for w=0:(npres-2)               %w=Anzahl Mittelpfetten abhängig von der eingegebenen Breite
    w=w
end

Anz1PMi=linspace(F1PB,F1PB,w)   %Voraufbau für Matrix
FR1=[F1PA,Anz1PMi,F1PA]         %Matrix für alle Kräfte auf ersten Rahmen 

%Aufbau für Matrix 'Distanz x'

u=(npres-2)                     %u=Anzahl Mittelpfetten
uapres=u*apres                  %uapres=Höchste Distanz der Mittelpfette
aMittelstueke=linspace(apres,uapres,u)  %Normalverteilung der Abstände der Mittelpfetten)
Distanzx=[0,aMittelstueke,ba]    %Distanzmatrix

%Aufteilung der Flächenlast auf Pfetten -> mittlere Rahmen (alle gleich)
FMPA=(q*(apres/2)*arres)        %Aufbau Name: F=Kraft, M=Mittlere Rahmen PA=erste Pfette 
FMPB=(q*apres*arres)            %Aufbau Name: F=Kraft, M=Mittlere Rahmen PA=mittlere Pfette

for v=0:(npres-2)               %Anzahl mittlere Pfetten
    v=v                         %Merke erst jetzt, dass auch w gehen würde, sorry (oben definiert)
end 

                                %AnzahlMitteRahm=v
AnzMiPMi=linspace(FMPB,FMPB,v)  %Anzahl Mittlere Pfetten, generierung für Matrix
FR2=[FMPA,AnzMiPMi,FMPA]       %Matrix Kräfte auf mittleren Rahmen


%Aufbau Mastermatrix
AA{1,1} = 'Rahmen1 und letzter'; %Name des ersten und letzen Rahmens
AA{1,2} = FR1;                   %Matrix mit Kräften des ersten Rahmens
AA{1,3} = Distanzx;              %Matrix mit den Distanzen der Pfetten von links

BB{1,1} = 'Rahmen Mitte';        %Name der mittleren Rahmen, alle identisch
BB{1,2} = FR2;                   %Matrix mit Kräften der mittleren Rahmen
BB{1,3} = Distanzx;              %Matrix mit den Distanzen der Pfetten von links

EinwirkungenaufRahmen = cat(3,AA,BB);    %Generiung der Matrix in Matrix

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ Auflagermatrix, MMX,QMX,NMX ] = Funktion_Berechnung_Stahlhalle( K,AZB,EinwirkungenaufRahmen,ba,h,hI )
%Berechnet die Auflagerkraftematrix und die Plot Linien für die Bogen
%
%   Output:
%   Auflagermatrix      Zusammenstellung der Auflagerkräfte
%   MMX                 Matrix Momentenverlauf für Plot MSupSL, MSupSR ,MSupSO
%   QMX                 Matrix Querkraftverlauf für Plot VSupSL, VSupSR ,VSupSO
%   NMX                 Matrix Normalkraftverlauf für Plot NSupSL, NSupSR ,NSupSO, NSupS1, NSupS2

%Wert aus EinwirkungaufRahmen Matrix lesen
F=EinwirkungenaufRahmen{1,2,K}
x=EinwirkungenaufRahmen{1,3,K}
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funktion für Bogen 2 bis 3 Stützen                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Auflagerkräfte von 0 Zustand
Av0=(1.-(x./ba)).*F
Bv0=(x./ba).*F

% Verschiebungsgrössen (Überlagerung der Momente - Kraftgrössenverfahren mit Werte aus Integrationstabelle)
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ___________ %%%%%%%%%%%%%%
%   Berechnung (n=3) mit 2 Stützen aussen      ¦           ¦             %                          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Matrix der Verschiebungsgrössen [B A] * X = [0;0;0]
A=[a11,a12,a13;a12,a22,a23;a13,a23,a33]
B=[-a10;-a20;-a30]

X=A\B

X1=X(1,:)
X2=X(2,:)
X3=X(3,:)

% Auflagerkräfte in A
Av=Av0+0*X1+(-1/ba)*X2+(1/ba)*X3
Ah=0+(-1/h)*X1+0*X2+(1/h)*X3
Ma=0+0*X1+1*X2+0*X3

% Auflagerkräfte in B
Bv=Bv0+0*X1+(1/ba)*X2+(-1/ba)*X3
Bh=0+(1/h)*X1+0*X2+(-1/h)*X3
Mb=0+0*X1+0*X2+1*X3

% Moment bei Kraft F
Mf=Av0.*x+1.*X1+(1-(x./ba)).*X2+(1-(x./ba)).*X3.*(-1)

% Moment Ecke Links oben
Ml=0+1.*X1+1.*X2+-1.*X3

% Moment Ecke Rechts oben
Mr=0+1.*X1+0.*X2+0.*X3

% Werte Moment für Superposition
dx=100                                                  % Teilungsfaktor Stab Oben(Stücke pro Meter)
dT=roundn((ba*dx),0)                                              % Anzahl Teilstücke des Verlaufs vom Träger
dS=2                                                    % Anzahl Teilstücke des Verlaufs der Stäbe 

MSupSL=linspace(sum(Ml),sum(Ma),dS)                     % Superposition Stab Links Moment
MSupSR=linspace(sum(Mb),sum(Mr),dS)                     % Superposition Stab Rechts Moment

MSupSO=zeros(1,dT)                                      % 0 Vektor mit Länge wie MSO (Anzahl Einträge) für Addition
 for z=[1:length(F)]
    if x(z)== 0 
    MSO{z}=zeros(1,dT)                                  % Momente Stab oben wenn x = 0 
    else
    dSOL=round(((dT+1)/ba)*x(z))                        % Anzahl Teilstücke für Moment oben Links von Kraft
    MvorbSOL=linspace(Ml(z),Mf(z),dSOL)                 % Moment Stab oben Links von F
    MvorbSOR=linspace(Mf(z),Mr(z),dT+1-dSOL)            % Moment Stab oben Rechts von F
    MSO{z}=[MvorbSOL(1:end-1),MvorbSOR]                 % Moment Stab oben Links + Rechts
    end
   MSupSO=MSupSO+MSO{z}                                 % Superposition Stab oben für Moment
 end
 
% Werte Querkraft für Superposition
VSupSL=linspace(sum(-Ah),sum(-Ah),dS)                   % Superposition Stab Links Querkraftkraft
VSupSR=linspace(sum(-Bh),sum(-Bh),dS)                   % Superposition Stab Rechts Querkraftkraft

VSupSO=zeros(1,dT)                                      % 0 Vektor mit Anzahl Einträgen wie MSO für Addition
for z=[1:length(F)]
   if x(z)== 0 
   VSO{z}=zeros(1,dT)                                   % Momente Stab oben wenn x = 0     
   else     
   dSOL=round(((dT+1)/ba)*x(z))                         % Anzahl Teilstücke für Querkraft oben Links von Kraft
   VvorbSOL=linspace(Av(z),Av(z),dSOL)                  % Querkraft Stab oben Links von F
   VvorbSOR=linspace(Av(z)-F(z),Av(z)-F(z),dT+1-dSOL)   % Querkraft Stab oben Rechts von F
   VSO{z}=[VvorbSOL(1:end-1),VvorbSOR]                  % Querkraft Stab oben Links + Rechts
   end
  VSupSO=VSupSO+VSO{z}                                  % Superposition Stab Oben Werte Querkraft
end


% Werte Normalkraft für Superposition
NSupSL=linspace(sum(-Av),sum(-Av),dS)                   % Superposition Stab Links Werte Normalkraft
NSupSR=linspace(sum(Bv),sum(Bv),dS)                     % Superposition Stab Rechts Werte Normalkraft
NSupSO=linspace(sum(Ah),sum(Bh),dS)                     % Superposition Stab Oben Werte Normalkraft


elseif  AZB == 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ___________%%%%%%%%%%%%%%%
%    Berechnung (n=4) mit 3 Stützen            ¦     ¦     ¦             %                          
%}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Verschiebungsgrössen Ergänzung für System (n=4)(Überlagerung der Momente - Kraftgrössenverfahren mit Werte aus Integrationstabelle)
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


% Matrix der Verschiebungsgrössen [B A] * X = [0;0;0;0]
A=[a11,a12,a13,a14;a12,a22,a23,a24;a13,a23,a33,a34;a14,a24,a34,a44]
B=[-a10;-a20;-a30;-a40]

X=A\B

X1=X(1,:)
X2=X(2,:)
X3=X(3,:)
X4=X(4,:)

% Auflagerkräfte in A
Av=Av0+0*X1+(-1/ba)*X2+(1/ba)*X3+(-0.5)*X4
Ah=0+(-1/h)*X1+0*X2+(1/h)*X3+0*X4
Ma=0+0*X1+1*X2+0*X3+0*X4

% Auflagerkräfte in B
Bv=Bv0+0*X1+(1/ba)*X2+(-1/ba)*X3+(-0.5)*X4
Bh=0+(1/h)*X1+0*X2+(-1/h)*X3
Mb=0+0*X1+0*X2+1*X3+0*X4

% Auflagerkraft in Stütze 1 (Mitte)
S1v=X4

% Moment bei Stütze in Mitte
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

% Schnittkräfte Ecke Rechts oben
Mr=0+1.*X1+0.*X2+0.*X3+0*X4


% Werte Moment für Superposition
dx=100                                                 % Teilungsfaktor Stab Oben(Stücke pro Meter)
dT=(ba*dx)                                              % Anzahl Teilstücke des Verlaufs vom Träger
dS=2                                                    % Anzahl Teilstücke des Verlaufs der Stäbe (dS=1, generiert ein Wert -> ausreichend )

MSupSL=linspace(sum(Ml),sum(Ma),dS)                     % Superposition Stab Links Moment
MSupSR=linspace(sum(Mb),sum(Mr),dS)                     % Superposition Stab Rechts Moment

MSupSO=zeros(1,dT)                                      % 0 Vektor mit Länge wie MSO (Anzahl Einträge) für Addition
 for z=[1:length(F)]
    if x(z)==0
    MSO{z}=zeros(1,dT)                                  % Momente Stab oben wenn x = 0 
    elseif x(z)== ba*0.5 
    MSO{z}=zeros(1,dT)                                  % Momente Stab oben wenn x = 0 
    elseif x(z)== ba 
    MSO{z}=zeros(1,dT)                                  % Momente Stab oben wenn x = 0 
    elseif x(z)<0.5*ba
    dSOL=round(((dT+2)/ba)*x(z))                        % Anzahl Teilstücke für Moment oben Links von Kraft
    dSOM=fix(((dT+2)/ba)*(ba*0.5-x(z)))                 % Anzahl Teilstücke für Moment oben Rechts von Kraft
    MvorbSOL=linspace(Ml(z),Mf(z),dSOL)                 % Moment Stab oben Links von F
    MvorbSOM=linspace(Mf(z),Ms1(z),dSOM)                % Moment Stab oben Mitte von F
    MvorbSOR=linspace(Ms1(z),Mr(z),dT+2-dSOL-dSOM)      % Moment Stab oben Rechts von F
    MSO{z}=[MvorbSOL(1:end-1),MvorbSOM,MvorbSOR(2:end)] % Moment Stab oben Links + Mitte + Rechts
    else x(z)>0.5*ba
    dSOM=round(((dT+2)/ba)*(x(z)-0.5*ba))               % Anzahl Teilstücke für Moment oben Links von Kraft
    dSOR=fix(((dT+2)/ba)*(ba-x(z)))                     % Anzahl Teilstücke für Moment oben Rechts von Kraft
    MvorbSOL=linspace(Ml(z),Ms1(z),dT+2-dSOM-dSOR)      % Moment Stab oben Links von F
    MvorbSOM=linspace(Ms1(z),Mf(z),dSOM)                % Moment Stab oben Mitte von F
    MvorbSOR=linspace(Mf(z),Mr(z),dSOR)                 % Moment Stab oben Rechts von F
    MSO{z}=[MvorbSOL(1:end-1),MvorbSOM,MvorbSOR(2:end)] % Moment Stab oben Links + Mitte + Rechts
    end
   MSupSO=MSupSO+MSO{z}                                 % Superposition Stab oben für Moment
 end
 
%Werte Querkraft für Superposition
VSupSL=linspace(sum(-Ah),sum(-Ah),dS)                               % Superposition Stab Links Querkraftkraft
VSupSR=linspace(sum(-Bh),sum(-Bh),dS)                               % Superposition Stab Rechts Querkraftkraft

VSupSO=zeros(1,dT)                                                  % 0 Vektor mit Anzahl Einträgen wie MSO für Addition
for z=[1:length(F)]
   if x(z)== 0 
   VSO{z}=zeros(1,dT)                                               % Momente Stab oben wenn x = 0     
   elseif x(z)== ba*0.5 
   VSO{z}=zeros(1,dT)                                               % Momente Stab oben wenn x = 0 
   elseif x(z)== ba 
   VSO{z}=zeros(1,dT)                                               % Momente Stab oben wenn x = 0     
   elseif x(z)<0.5*ba    
   dSOL=round(((dT+2)/ba)*x(z))                                     % Anzahl Teilstücke für Querkraft oben Links von Kraft
   dSOR=fix(((dT+2)/ba)*(0.5*ba))                                   % Anzahl Teilstücke für Querkraft oben Rechts von Kraft
   VvorbSOL=linspace(Av(z),Av(z),dSOL)                              % Querkraft Stab oben links von F
   VvorbSOM=linspace(Av(z)-F(z),Av(z)-F(z),dT+2-dSOR-dSOL)          % Querkraft Stab oben Mitte von F
   VvorbSOR=linspace(Av(z)-F(z)+S1v(z),Av(z)-F(z)+S1v(z),dSOR)      % Querkraft Stab oben Rechts von F
   VSO{z}=[VvorbSOL(1:end-1),VvorbSOM,VvorbSOR(2:end)]              % Querkraft Stab oben Links + Mitte + Rechts
   else x(z)>0.5*ba
   dSOM=round(((dT+2)/ba)*(x(z)-0.5*ba))                            % Anzahl Teilstücke für Querkraft oben Links von Kraft
   dSOR=fix(((dT+2)/ba)*(ba-x(z)))                                  % Anzahl Teilstücke für Querkraft oben Rechts von Kraft
   VvorbSOL=linspace(Av(z),Av(z),dT+2-dSOM-dSOR)                    % Querkraft Stab oben links von F
   VvorbSOM=linspace(Av(z)+S1v(z),Av(z)+S1v(z),dSOM)                % Querkraft Stab oben Mitte von F
   VvorbSOR=linspace(Av(z)-F(z)+S1v(z),Av(z)-F(z)+S1v(z),dSOR)      % Querkraft Stab oben Rechts von F
   VSO{z}=[VvorbSOL(1:end-1),VvorbSOM,VvorbSOR(2:end)]              % Querkraft Stab oben Links + Mitte + Rechts    
   end
  VSupSO=VSupSO+VSO{z}                                              % Superposition Stab oben Werte Querkraft
end


%Werte Normalkraft für Superposition
NSupSL=linspace(sum(-Av),sum(-Av),dS)                   % Superposition Stab Links Werte Normalkraft
NSupSR=linspace(sum(-Bv),sum(-Bv),dS)                   % Superposition Stab Rechts Werte Normalkraft
NSupSO=linspace(sum(Ah),sum(Bh),dS)                     % Superposition Stab Oben Werte Normalkraft
NSupS1=linspace(sum(S1v),sum(S1v),dS)                   % Superposition Stab Mitte Normalkraft


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Erstellen der Outputmatrizen                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Aufbau Auflagermatrix

if AZB == 1
Auflagermatrix = [sum(Av),sum(Ah),sum(Ma);sum(Bv),sum(Bh),sum(Mb)]                     %Generiung der Matrix für AZB = 1
elseif AZB == 2
Auflagermatrix = [sum(Av),sum(Ah),sum(Ma);sum(Bv),sum(Bh),sum(Mb);sum(S1v),0,0]             %Generiung der Matrix für AZB = 2
end

%Aufbau Matrix Momentenverlauf für Plot 
MMX ={MSupSL, MSupSR ,MSupSO}
%Aufba Matrix Querkraftverlauf für Plot 
QMX = {VSupSL, VSupSR ,VSupSO}
%Aufbau Matrix Normalkraftverlauf für Plot 
if AZB == 1
NMX = {NSupSL, NSupSR ,NSupSO}
elseif AZB == 2
NMX = {NSupSL, NSupSR ,NSupSO NSupS1} 
else AZB == 3
NMX = {NSupSL, NSupSR ,NSupSO, NSupS1, NSupS2}
end


end


function [bf, tf, bfm, hf ] = Funktion_Berechnung_Fundament(Auflagermatrix,AZB,sm,ksm,arres)
%Fundamente
%Werte aus Auflagermatrix lesen

MaT=Auflagermatrix(1,3)
AhT=Auflagermatrix(1,2)
AvT=Auflagermatrix(1,1)
%Mb=Auflagermatrix(8)
%Bh=Auflagermatrix(5)
%Bv=Auflagermatrix(2)


if AZB==2
S1vT=Auflagermatrix(3,1)
end

%Fundamente Rahmen

o2=ksm*sm   %Randspannung=Bettungsmodul*Setzung

hf=1        %Einbindetiefe

Flf=(4*AvT)/o2
bf=sqrt(Flf)

if bf<=3*(MaT+(AhT*hf))/AvT
    bf=3*(MaT+(AhT*hf))/AvT
elseif bf<=0.4
    bf=0.4
end

tf=sqrt(Flf)
if tf<=0.4
    tf=0.4
elseif tf>=arres
    tf=arres
end

if (Flf/tf)>=bf
    bf=(Flf/tf)
end
bfm=0                  %damit bfm1 bei AZB=1 besetzt ist

if AZB ==2

%Fundamente Pendelstütze (Kein Moment)
om=ksm*sm  %Bodenspannung Mitte

%om=Kraft /Fläche

FAM=sum(S1vT)/om    %Fläche um Normalkraft aufzunehmen

bfm=sqrt(FAM) %quadratisches Fundament
if bfm<=0.4
    bfm=0.4
end
end
end


function [f] = Funktion_Darstellung_2d_Stahlhalle( K,AZB,b,h,MMX,QMX,NMX,bf,tf,bfm )
%Darstellung der Resultate in 2D

%Entschlüsselung Matrix Momentenverlauf für Plot 
MSupSL=MMX{1} 
MSupSR=MMX{2}
MSupSO=MMX{3}
%Aufba Matrix Querkraftverlauf für Plot 
VSupSL=QMX{1} 
VSupSR=QMX{2}
VSupSO=QMX{3}
%Aufbau Matrix Normalkraftverlauf für Plot 
NSupSL=NMX{1} 
NSupSR=NMX{2}
NSupSO=NMX{3}
if AZB == 2
NSupS1=NMX{4} 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Darstellung Bogen                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Bezeichnugen anpassen
bFL =bf                              % breite Fundament Links
bFM =bfm                             % breite Fundament Mitte
bFR =bf                              % breite Fundament Rechts
hFL =hf                              % höhe Fundament Links
hFM =hf                              % höhe Fundament Mitte
hFR =hf                              % höhe Fundament Rechts

hFMAX=max([hFL hFM hFR])             % Darstellungs Faktor Bemassungs Linie damit Abstand zwischen Fundament und Bemassungslinie stimmt 

if K==1                                                                                                                  %position [left bottom width height]            
f= figure('Name','Erster und Letzter Bogen','NumberTitle', 'off','menubar', 'None', 'units', 'normalized', 'color', 'w', 'position', [0.63 0.524 0.36 0.44])         
else %K==2
    if arres ~= l
f= figure('Name','Zweiter bis zweitletzter Bogen','NumberTitle', 'off','menubar', 'None', 'units', 'normalized','color', 'w', 'position', [0.63 0.05 0.36 0.44])
    end
end

%Darstellung: Struktur Feld
subplot(2,2,1)
hold on
axis equal
axis off
title('Struktur')

%Darstellung Struktur
plot([0,0],[0,h],'k','LineWidth',3)                                                                     % Stab Links 
plot([0,b],[h,h],'k','LineWidth',3)                                                                     % Stab Oben
plot([b,b],[0,h],'k','LineWidth',3)                                                                     % Stab Rechts
if AZB==2
plot([(1/AZB)*b,(1/AZB)*b],[0,h],'k','LineWidth',3)                                                     % Stab Mitte 
end

%Darstellung Bemassung horizontal
plot([-0.5,b+0.5],[-2-hFMAX,-2-hFMAX],'Color',[0.19 0.19 0.19],'LineWidth',1)                           % Bemassung Linie (Breite) Grau oben
plot([0,0],[-2.5-hFMAX,-1.5-hFMAX],'Color',[0.19 0.19 0.19],'LineWidth',1)                              % Bemassung Hilfslinie links (Breite) Grau oben
plot([b,b],[-2.5-hFMAX,-1.5-hFMAX],'Color',[0.19 0.19 0.19],'LineWidth',1)                              % Bemassung Hilfslinie rechts (Breite) Grau oben
plot([-0.5+(-bFL/2),b+0.5+(bFR/2)],[-5.5-hFMAX,-5.5-hFMAX],'Color',[0.19 0.19 0.19],'LineWidth',1)      % Bemassung Linie (Breite) Grau unten
plot([0+(-bFL/2),0+(-bFL/2)],[-6-hFMAX,-5-hFMAX],'Color',[0.19 0.19 0.19],'LineWidth',1)                % Bemassung Hilfslinie links von linken Funament(Breite) Grau unten
plot([0+(bFL/2),0+(bFL/2)],[-6-hFMAX,-5-hFMAX],'Color',[0.19 0.19 0.19],'LineWidth',1)                  % Bemassung Hilfslinie rechts von linken Fundament (Breite) Grau unten
plot([b+(-bFR/2),b+(-bFR/2)],[-6-hFMAX,-5-hFMAX],'Color',[0.19 0.19 0.19],'LineWidth',1)                % Bemassung Hilfslinie links vom rechten Fundament (Breite) Grau
plot([b+(bFR/2),b+(bFR/2)],[-6-hFMAX,-5-hFMAX],'Color',[0.19 0.19 0.19],'LineWidth',1)                  % Bemassung Hilfslinie rechts vom rechten Fundament (Breite) Grau
text(-1.5,-3.5-hFMAX,(num2str(roundn(bFL,-2))),'Color',[0.19 0.19 0.19])                                % Wert Bemassung Fundament links (Breite) Grau
text(b-1.5,-3.5-hFMAX,(num2str(roundn(bFR,-2))),'Color',[0.19 0.19 0.19])                               % Wert Bemassung Fundament rechts (Breite) Grau

if AZB ==1
text(b*0.5-1.5,-0.5-hFMAX,(num2str(roundn(b,-2))),'Color',[0.19 0.19 0.19])                             % Wert Bemassung der Breite (Breite) Grau
%text(b*0.5-1.5,-3.5-hFMAX,(num2str(roundn((b-(bFL/2+bFR/2)),-2))),'Color',[0.19 0.19 0.19])             % Wert Bemassung Distanz zwischen Fundamenten(Breite) Grau

else %AZB = 2
plot([(b/2)+(-bFM/2),(b/2)+(-bFM/2)],[-6-hFMAX,-5-hFMAX],'Color',[0.19 0.19 0.19],'LineWidth',1)        % Bemassung Hilfslinie links Mittel Fundament (Breite) Grau
plot([(b/2)+(bFM/2),(b/2)+(bFM/2)],[-6-hFMAX,-5-hFMAX],'Color',[0.19 0.19 0.19],'LineWidth',1)          % Bemassung Hilfslinie rechts Mittel Fundament (Breite) Grau

plot([0.5*b,0.5*b],[-2.5-hFMAX,-1.5-hFMAX],'Color',[0.19 0.19 0.19],'LineWidth',1)                      % Bemassung Hilfslinie oben mitte bei Stütze (Breite) Grau    
text(b*0.25-0.5,-0.5-hFMAX,(num2str(roundn(0.5*b,-2))),'Color',[0.19 0.19 0.19])                        % Wert Bemassung Bogen links (Breite) Grau
text(b*0.75-0.5,-0.5-hFMAX,(num2str(roundn(0.5*b,-2))),'Color',[0.19 0.19 0.19])                        % Wert Bemassung Bogen rechts (Breite) Grau
text(b*0.5-1.5,-3.5-hFMAX,(num2str(roundn(bFM,-2))),'Color',[0.19 0.19 0.19])                           % Wert Bemassung Mittel Fundament(Breite) Grau
end

%Darstellung Bemassung vertikal
plot([b+4.5+(bFR/2),b+4.5+(bFR/2)],[-0.5-hFR,h+0.5],'Color',[0.19 0.19 0.19],'LineWidth',1)                 % Bemassung Linie (Höhe) Grau
plot([b+4+(bFR/2),b+5+(bFR/2)],[0,0],'Color',[0.19 0.19 0.19],'LineWidth',1)                        % Bemassung Hilfslinie unten Stab (Höhe) Grau
plot([b+4+(bFR/2),b+5+(bFR/2)],[h,h],'Color',[0.19 0.19 0.19],'LineWidth',1)                        % Bemassung Hilfslinie oben Stab (Höhe) Grau
plot([b+4+(bFR/2),b+5+(bFR/2)],[-hFR,-hFR],'Color',[0.19 0.19 0.19],'LineWidth',1)                  % Bemassung Hilfslinie unten Fundament (Höhe) Grau
text(b+0.75+(bFR/2),h*0.5,(num2str(roundn(h,-2))),'Color',[0.19 0.19 0.19])                             % Wert Bemassung Stab(Höhe) Grau
text(b+0.75+(bFR/2),-hFR*0.5,(num2str(roundn(hFR,-2))),'Color',[0.19 0.19 0.19])                        % Wert Bemassung Fundament (Höhe)Grau

%Darstellung Fundament
plot([0-(bFL/2),0+(bFL/2)],[0,0],'Color','c','LineWidth',1)                                             % obere Linie Fundament Links
plot([0-(bFL/2),0+(bFL/2)],[0-hFL,0-hFL],'Color','c','LineWidth',1)                                     % untere Linie Fundament Links
plot([0-(bFL/2),0-(bFL/2)],[0,0-hFL],'Color','c','LineWidth',1)                                         % Linke Linie Fundament Links
plot([0+(bFL/2),0+(bFL/2)],[0,0-hFL],'Color','c','LineWidth',1)                                         % Rechet Linie Fundament Links

plot([b-(bFR/2),b+(bFR/2)],[0,0],'Color','c','LineWidth',1)                                             % obere Linie Fundament Rechts
plot([b-(bFR/2),b+(bFR/2)],[0-hFR,0-hFR],'Color','c','LineWidth',1)                                     % untere Linie Fundament Rechts
plot([b-(bFR/2),b-(bFR/2)],[0,0-hFR],'Color','c','LineWidth',1)                                         % Linke Linie Fundament Rechts
plot([b+(bFR/2),b+(bFR/2)],[0,0-hFR],'Color','c','LineWidth',1)                                         % Rechet Linie Fundament Rechts

if AZB == 2
plot([(b/2)-(bFM/2),(b/2)+(bFM/2)],[0,0],'Color','c','LineWidth',1)                                     % obere Linie Fundament Mitte
plot([(b/2)-(bFM/2),(b/2)+(bFM/2)],[0-hFM,0-hFM],'Color','c','LineWidth',1)                             % untere Linie Fundament Mitte
plot([(b/2)-(bFM/2),(b/2)-(bFM/2)],[0,0-hFM],'Color','c','LineWidth',1)                                 % Linke Linie Fundament Mitte
plot([(b/2)+(bFM/2),(b/2)+(bFM/2)],[0,0-hFM],'Color','c','LineWidth',1)                                 % Rechet Linie Fundament Mitte
end

%Darstellung Auflast   
Q=2.5                                                                                                   % Höhe der Linenlast Darstellung
patch([0,b,b,0],[h,h,h+Q,h+Q],[0.9725    0.9255    0.3137])                                             % Fläche der Linienlast
plot([0,b],[h,h],'Color',[0.9686 0.4549 0.0510],'LineWidth',1.5)                                        % Linie unten
plot([0,b],[h+Q,h+Q],'Color',[0.9686 0.4549 0.0510],'LineWidth',1.5)                                    % Linie oben
plot([0,0],[h+Q,h],'Color',[0.9686 0.4549 0.0510],'LineWidth',1.5)                                      % Linie links 
plot([b,b],[h,Q+h],'Color',[0.9686 0.4549 0.0510],'LineWidth',1.5)                                      % Linie rechts 
plot([0,-0.5],[h,Q/2+h],'Color',[0.9686 0.4549 0.0510],'LineWidth',1.5)                                 % Linie Pfeil links 
plot([0,0.5],[h,Q/2+h],'Color',[0.9686 0.4549 0.0510],'LineWidth',1.5)                                  % Linie Pfeil rechts
plot([0.5,-0.5],[h+Q/2,h+Q/2],'Color',[0.9686 0.4549 0.0510],'LineWidth',1.5)                           % Linie Pfeil oben
plot([b,b-0.5],[h,Q/2+h],'Color',[0.9686 0.4549 0.0510],'LineWidth',1.5)                                % Linie Pfeil links 
plot([b,b+0.5],[h,Q/2+h],'Color',[0.9686 0.4549 0.0510],'LineWidth',1.5)                                % Linie Pfeil rechts 
plot([b-0.5,b+0.5],[h+Q/2,h+Q/2],'Color',[0.9686 0.4549 0.0510],'LineWidth',1.5)                        % Linie Pfeil oben
text(b/2-3,h+1.25,(num2str(q)))                                                                      	% Text Grösse q
text(b/2,h+1.5,('kN/m^2'))                                                                              % Text kN pro m^2

hold off


dR= -10                                                                     % dR = Rundungsziffer weil sehr kleine Null Werte die Grafik verziehen

%Daratellung Moment
dM= (b*0.25)/roundn(max(abs([MSupSL MSupSO MSupSR])),dR)                    % Darstellungs Faktor Moment (Mmax = 0.25 von Breite)
subplot(2,2,2)
hold on
axis off
axis equal
title('Moment [kNm]')

%Struktur
plot([0,0],[0,h],'k','LineWidth',3)                                         % Stab Links 
plot([0,b],[h,h],'k','LineWidth',3)                                         % Stab Oben
plot([b,b],[0,h],'k','LineWidth',3)                                         % Stab Rechts
if AZB==2
plot([(1/AZB)*b,(1/AZB)*b],[0,h],'k','LineWidth',3)                         % Stab Links 
end

%Momentenverlauf Stab links 
MxSL=(MSupSL.*dM)
MySL=linspace(h,0,2)
plot(MxSL,MySL,'r','LineWidth',2)                                           % Stab-Moment Rechts
plot([0,MSupSL(2)*dM],[0,0],'r','LineWidth',2)                              % Stab-Moment Ergänzung unten
plot([0,MSupSL(1)*dM],[h,h],'r','LineWidth',2)                              % Stab-Moment Ergänzung oben
text(-2.5,-1,num2str(roundn(MSupSL(2),-2)))                                    % Text unten Ma

%Momentenverlauf Stab rechts
MxSR=b-(MSupSR.*dM)           
MySR=linspace(0,h,2)
plot(MxSR,MySR,'r','LineWidth',2)                                           % Stab-Moment Links
plot([b,b-MSupSR(1)*dM],[0,0],'r','LineWidth',2)                            % Stab-Moment Ergänzung unten
plot([b,b-MSupSR(2)*dM],[h,h],'r','LineWidth',2)                            % Stab-Moment Ergänzung oben
text(b-2,-1,num2str(roundn(MSupSR(1),-2)))                                  % Text unten Mb 

%Momentenverlauf Stab oben
MySO=h-(MSupSO.*dM)
MxSO=linspace(0,b,length(MSupSO))
plot(MxSO,MySO,'r','LineWidth',2)                                           % Stab-Moment Oben
plot([0,0],[h,h-MSupSL(1)*dM],'r','LineWidth',2)                            % Stab-Moment Ergänzung Links
plot([b,b],[h,h-MSupSR(2)*dM],'r','LineWidth',2)                            % Stab-Moment Ergänzung rechts
text(-3.5+MSupSL(1)*dM,h+2,num2str(roundn(MSupSL(1),-2)))                   % Text Moment oben Links
text(b+1,h+2,num2str(roundn(MSupSR(2),-2)))                                 % Text Moment oben Rechts
text((mean((find(MSupSO==max(MSupSO))/length(MSupSO))))*b...
    -2,h-1-max(MSupSO)*dM,num2str(roundn(max(MSupSO),-2)))                  % Text Max-Moment Mf 
if AZB>1
text((mean((find(MSupSO==min(MSupSO))/length(MSupSO))))*b...
    -2,h+1-min(MSupSO)*dM,num2str(roundn(min(MSupSO),-2)))                  % Text MIN-Moment Mf
end

hold off

% Darstellung Querkraft
dV=(b*0.25)/roundn(max(abs([VSupSL VSupSO VSupSR])),dR) 
subplot(2,2,3)
hold on
axis off 
axis equal
title('Querkraft [kN]')

%Struktur
plot([0,0],[0,h],'k','LineWidth',3)                                         % Stab Links 
plot([0,b],[h,h],'k','LineWidth',3)                                         % Stab Oben
plot([b,b],[0,h],'k','LineWidth',3)                                         % Stab Rechts
if AZB==2
plot([(1/AZB)*b,(1/AZB)*b],[0,h],'k','LineWidth',3)                         % Stab Links 
end

%Querkraftverlauf Stab Links
plot([VSupSL(1)*dV,VSupSL(1)*dV],[0,h],'b','LineWidth',2)                   % Querkraft Stab links
plot([0,VSupSL(1)*dV],[0,0],'b','LineWidth',2)                              % Querkraft Stab links Ergänzunglinie unten
plot([0,VSupSL(1)*dV],[h,h],'b','LineWidth',2)                              % Querkraft Stab links Ergänzunglinie oben
text(VSupSL(1)*dV-2,-2,num2str(roundn(VSupSL(1),-2)))                       % Text Stab Links 

%Querkraftverlauf Stab Rechts
plot([b-VSupSR(1)*dV,b-VSupSR(1)*dV],[0,h],'b','LineWidth',2)               % Querkraft Stab links
plot([b,b-VSupSR(1)*dV],[0,0],'b','LineWidth',2)                            % Querkraft Stab links Ergänzunglinie unten
plot([b,b-VSupSR(1)*dV],[h,h],'b','LineWidth',2)                            % Querkraft Stab links Ergänzunglinie oben
text(b-VSupSR(1)*dV-2,-2,num2str(roundn(VSupSR(1),-2)))                     % Text Stab Rechts

%Querkraftverlauf Stab oben
VySO=h-(VSupSO.*dV)
VxSO=linspace(0,b,length(VSupSO))
plot(VxSO,VySO,'b','LineWidth',2)                                           % Querkraft Stab oben
plot([0,0],[h,VySO(1)],'b','LineWidth',2)                                   % Querkraft Stab oben Ergänzungslinie links
plot([b,b],[h,VySO(end)],'b','LineWidth',2)                                 % Querkraft Stab oben Ergänzungslinie rechts
text((mean((find(VSupSO==max(VSupSO))/length(VSupSO))))*b-5,h-max(VSupSO)*dV-0.75,num2str(roundn(max(VSupSO),-2)))     % Text Max Querkraft 
text((mean((find(VSupSO==min(VSupSO))/length(VSupSO))))*b+1,h-min(VSupSO)*dV+0.75,num2str(roundn(min(VSupSO),-2)))     % Text Min-Querkraft 

hold off

%Normalkaft
if AZB==1
dN=(b*0.25)/roundn(max(abs([NSupSL NSupSO NSupSR])),dR) 
elseif AZB ==2
dN=(b*0.25)/max(abs([NSupSL NSupSO NSupSR NSupS1]))     
end 

subplot(2,2,4)
hold on
axis off 
axis equal
title('Normalkraft [kN]')

%Struktur
plot([0,0],[0,h],'k','LineWidth',3)                                         % Stab Links 
plot([0,b],[h,h],'k','LineWidth',3)                                         % Stab Oben
plot([b,b],[0,h],'k','LineWidth',3)                                         % Stab Rechts
if AZB==2
plot([(1/AZB)*b,(1/AZB)*b],[0,h],'k','LineWidth',3)                         % Stab Links 
end

%Normalkraftverlauf Stab Links
plot([-NSupSL(1)*dN,-NSupSL(1)*dN],[0,h],'g','LineWidth',2)                 % Normalkraft Stab links
plot([0,-NSupSL(1)*dN],[0,0],'g','LineWidth',2)                             % Normalkraft Stab links Ergänzunglinie unten
plot([0,-NSupSL(1)*dN],[h,h],'g','LineWidth',2)                             % Normalkraft Stab links Ergänzunglinie oben
text(-2,-1,num2str(roundn(NSupSL(1),-2)))                                   % Text Stab Links

%Normalkraftverlauf Stab Rechts
plot([b-NSupSR(1)*dN,b-NSupSR(1)*dN],[0,h],'g','LineWidth',2)               % Normalkraft Stab rechts
plot([b,b-NSupSR(1)*dN],[0,0],'g','LineWidth',2)                            % Normalkraft Stab rechts Ergänzunglinie unten
plot([b,b-NSupSR(1)*dN],[h,h],'g','LineWidth',2)                            % Normalkraft Stab rechts Ergänzunglinie oben
text(b,-1,num2str(roundn(NSupSR(1),-2)))                                    % Text Stab Rechts

%Querkraftverlauf Stab Mitte
if AZB==2
plot([(1/AZB)*b-NSupS1(1)*dN,(1/AZB)*b-NSupS1(1)*dN],[0,h],'g','LineWidth',2)   % Normalkraft Stab rechts
plot([(1/AZB)*b,(1/AZB)*b-NSupS1(1)*dN],[0,0],'g','LineWidth',2)                % Normalkraft Stab rechts Ergänzunglinie unten
plot([(1/AZB)*b,(1/AZB)*b-NSupS1(1)*dN],[h,h],'g','LineWidth',2)                % Normalkraft Stab rechts Ergänzunglinie oben
text(b*0.5-2.5,-1,num2str(roundn(NSupS1(1),-2)))                                % Text Stab Mitte   
end

%Normalkraftverlauf Stab oben
plot([0,b],[h+NSupSO(1)*dN,h+NSupSO(1)*dN],'g','LineWidth',2)               % Normalkraft Stab oben
plot([0,0],[h,h+NSupSO(1)*dN],'g','LineWidth',2)                            % Normalkraft Stab oben Ergänzunglinie unten
plot([b,b],[h,h+NSupSO(1)*dN],'g','LineWidth',2)                            % Normalkraft Stab oben Ergänzunglinie oben
text(b*0.5-2.5,h-NSupSR(1)*dN,num2str(roundn(NSupSO(1),-2)))                % Text Stab oben

hold off

end


%Plot für erster + letzer Rahmen

[ Auflagermatrix, MMX,QMX,NMX ] = Funktion_Berechnung_Stahlhalle( 1,AZB,EinwirkungenaufRahmen,ba,h,hI )

[bf, tf, bfm, hf ] = Funktion_Berechnung_Fundament(Auflagermatrix,AZB,sm,ksm, arres)

[f] = Funktion_Darstellung_2d_Stahlhalle( 1,AZB,b,h,MMX,QMX,NMX,bf,tf,bfm )

bf1=bf
tf1=tf
bfm1=bfm
hf1=hf
%Plot mittlere Rahmen

[ Auflagermatrix, MMX,QMX,NMX ] = Funktion_Berechnung_Stahlhalle( 2,AZB,EinwirkungenaufRahmen,ba,h,hI )

[bf, tf, bfm, hf ] = Funktion_Berechnung_Fundament(Auflagermatrix,AZB,sm,ksm, arres)

if arres ~= l
[f] = Funktion_Darstellung_2d_Stahlhalle( 2,AZB,b,h,MMX,QMX,NMX,bf,tf,bfm )
end

bf2=bf
tf2=tf
bfm2=bfm
hf2=hf

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f2=figure('Name', 'Darstellung Lagerhalle 3D', 'NumberTitle', 'off', 'units','normalized', 'InnerPosition', [0.007 0.05 0.60 0.67])
format compact
myaxes =axes('xlim', [-(bf/2)-1, b+(bf/2)+1], 'ylim', [-(tf/2)-1, l+(tf/2)+1], 'zlim', [-1.2, h], 'box', 'on',...
    'boxstyle', 'back', 'linewidth', 1,'units', 'normalized', 'Position', [0.2 0.06 0.75 0.9]) 
axis equal 
view(3)  %Erzeugung der 3D darstellung
grid on
xlabel('x - Breite')
ylabel('y - Länge')
zlabel('z - Höhe')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Legende
%Inof 'Position', [left bottom width height]
legTitel = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[10 560 160 30],...
        'String','Legende Lagerhalle', 'FontSize', 13);

legLaenge = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[10 537 100 20],...
        'String','Lagerhallen Länge :');
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
        'String','Lagerhallen Höhe :');
legNumHoehe = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[120 497 50 20],...
        'String',[num2str(h) ' m']);

legBabst = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[10 477 100 20],...
        'String','Binderabstände :');
legNumBabst = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[120 477 50 20],...
        'String',[num2str(a) ' m']);
    
legEditq = uicontrol('Style','text','HorizontalAlignment', 'right',...
        'Position',[10 457 100 20],...
        'String','Flächenlast :');
legNumEditq = uicontrol('Style','text','HorizontalAlignment', 'left',...
        'Position',[120 457 70 20],...
        'String',[num2str(q) ' kN/m2']);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Patch Properties
fac= [1 2 3 4; 4 3 5 6; 6 7 8 5; 1 2 8 7; 6 7 1 4; 2 3 5 8];    % Welche Eckpunkte werden als eine Polygonfläche eingefärbt

%FaceColor
FarbePfette = [0 0.69 0.702]           %Pfette A und B
FarbePfetteI = [0 0.69 0.702]           %Pfette dazwischen

FarbeStuetze = 'r'          % Stuetze 1 bis 4
FarbeStuetzeM = 'r'
FarbeQuerbalken = 'r'

FarbeStuetzeI = 'y'
FarbeStuetzeIM = 'y'
FarbeQuerbalkenI = 'y'

FarbeFundament = [0.788 0.788 0.788]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pfette A
vert1= [ProfSb/2-ProfTb/2 0 (h-ProfTh); ProfSb/2+ProfTb/2 0 (h-ProfTh); ProfSb/2+ProfTb/2 0 h; ProfSb/2-ProfTb/2 0 h; ProfTb l h; ProfSb/2-ProfTb/2 l h; ProfSb/2-ProfTb/2 l (h-ProfTh); ProfSb/2+ProfTb/2 l (h-ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert1,'FaceColor',FarbePfette);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Pfette B
vert2= [(b-ProfSb/2-ProfTb/2) 0 (h-ProfTh); b-ProfSb/2+ProfTb/2 0 (h-ProfTh); b-ProfSb/2+ProfTb/2 0 h; (b-ProfSb/2-ProfTb/2) 0 h; b-ProfSb/2+ProfTb/2 l h; (b-ProfSb/2-ProfTb/2) l h; (b-ProfSb/2-ProfTb/2) l (h-ProfTh); b-ProfSb/2+ProfTb/2 l (h-ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert2,'FaceColor',FarbePfette);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 1
vert3= [0 0 0; 0 ProfSt 0; ProfSb ProfSt 0; ProfSb 0 0; ProfSb ProfSt (h-2*ProfTh); ProfSb 0 (h-2*ProfTh); 0 0 (h-2*ProfTh); 0 ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor',FarbeStuetze);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Einzelfundament 1
vert14= [ProfSb/2-bf1/2 ProfSt/2-tf1/2 0; ProfSb/2-bf1/2 ProfSt/2+tf1/2 0; ProfSb/2+bf1/2 ProfSt/2+tf1/2 0; ProfSb/2+bf1/2 ProfSt/2-tf1/2 0;...
        ProfSb/2+bf1/2 ProfSt/2+tf1/2 -hf1; ProfSb/2+bf1/2 ProfSt/2-tf1/2 -hf1; ProfSb/2-bf1/2 ProfSt/2-tf1/2 -hf1; ProfSb/2-bf1/2 ProfSt/2+tf1/2 -hf1]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert14,'FaceColor', FarbeFundament);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 2
vert4= [b 0 0; b ProfSt 0; (b-ProfSb) ProfSt 0; (b-ProfSb) 0 0; (b-ProfSb) ProfSt (h-2*ProfTh); (b-ProfSb) 0 (h-2*ProfTh); b 0 (h-2*ProfTh); b ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert4,'FaceColor',FarbeStuetze);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Einzelfundament 2
vert15= [b-(ProfSb/2-bf1/2) ProfSt/2-tf1/2 0; b-(ProfSb/2-bf1/2) ProfSt/2+tf1/2 0; b-(ProfSb/2+bf1/2) ProfSt/2+tf1/2 0; b-(ProfSb/2+bf1/2) ProfSt/2-tf1/2 0;...
        b-(ProfSb/2+bf1/2) ProfSt/2+tf1/2 -hf1; b-(ProfSb/2+bf1/2) ProfSt/2-tf1/2 -hf1; b-(ProfSb/2-bf1/2) ProfSt/2-tf1/2 -hf1; b-(ProfSb/2-bf1/2) ProfSt/2+tf1/2 -hf1]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert15,'FaceColor',FarbeFundament);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 3
vert5= [0 (l-ProfSt) 0; 0 l 0; ProfSb l 0; ProfSb (l-ProfSt) 0; ProfSb l (h-2*ProfTh); ProfSb (l-ProfSt) (h-2*ProfTh); 0 (l-ProfSt) (h-2*ProfTh); 0 l (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor',FarbeStuetze);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Einzelfundament 3
vert16= [ProfSb/2-bf1/2 l-(ProfSt/2-tf1/2) 0; ProfSb/2-bf1/2 l-(ProfSt/2+tf1/2) 0; ProfSb/2+bf1/2 l-(ProfSt/2+tf1/2) 0; ProfSb/2+bf1/2 l-(ProfSt/2-tf1/2) 0;...
        ProfSb/2+bf1/2 l-(ProfSt/2+tf1/2) -hf1; ProfSb/2+bf1/2 l-(ProfSt/2-tf1/2) -hf1; ProfSb/2-bf1/2 l-(ProfSt/2-tf1/2) -hf1; ProfSb/2-bf1/2 l-(ProfSt/2+tf1/2) -hf1]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert16,'FaceColor',FarbeFundament);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze 4
vert6= [b (l-ProfSt) 0; b l 0; (b-ProfSb) l 0; (b-ProfSb) (l-ProfSt) 0; (b-ProfSb) l (h-2*ProfTh); (b-ProfSb) (l-ProfSt) (h-2*ProfTh); b (l-ProfSt) (h-2*ProfTh); b l (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert6,'FaceColor',FarbeStuetze);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Einzelfundament 4
vert17= [b-(ProfSb/2-bf1/2) l-(ProfSt/2-tf1/2) 0; b-(ProfSb/2-bf1/2) l-(ProfSt/2+tf1/2) 0; b-(ProfSb/2+bf1/2) l-(ProfSt/2+tf1/2) 0; b-(ProfSb/2+bf1/2) l-(ProfSt/2-tf1/2) 0;...
        b-(ProfSb/2+bf1/2) l-(ProfSt/2+tf1/2) -hf1; b-(ProfSb/2+bf1/2) l-(ProfSt/2-tf1/2) -hf1; b-(ProfSb/2-bf1/2) l-(ProfSt/2-tf1/2) -hf1; b-(ProfSb/2-bf1/2) l-(ProfSt/2+tf1/2) -hf1]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor',FarbeFundament);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Querbalken Anfang
vert7= [0 ProfSt/2-ProfTb/2 (h-2*ProfTh); 0 ProfSt/2-ProfTb/2 (h-ProfTh); 0 ProfSt/2+ProfTb/2 (h-ProfTh); 0 ProfSt/2+ProfTb/2 (h-2*ProfTh); b ProfSt/2+ProfTb/2 (h-ProfTh); b ProfSt/2+ProfTb/2 (h-2*ProfTh); b ProfSt/2-ProfTb/2 (h-2*ProfTh); b 0 (h-ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert7,'FaceColor',FarbeQuerbalken);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Querbalken Ende
vert8= [0 (l-ProfSt/2-ProfTb/2) (h-2*ProfTh); 0 (l-ProfSt/2-ProfTb/2) (h-ProfTh); 0 l-ProfSt/2+ProfTb/2 (h-ProfTh); 0 l-ProfSt/2+ProfTb/2 (h-2*ProfTh); b l-ProfSt/2+ProfTb/2 (h-ProfTh); b l-ProfSt/2+ProfTb/2 (h-2*ProfTh); b (l-ProfSt/2-ProfTb/2) (h-2*ProfTh); b (l-ProfSt/2-ProfTb/2) (h-ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert8,'FaceColor',FarbeQuerbalken);            % Erzeugen der Gefärbten Flächen (Polygonen)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Wenn Hallenbreite grösser 13m ist wird eine weiter Sttzenreihe bei 1/2
%ergänzt
%Stützen anfang und ende
if b >= 13 & b <= 26
   SMb= (b/2) -(ProfSb/2);           %Hilfsgrösse% Pos X (also Stützenabstand) der Stüzte. Einmitung auf Achsmass der Stütze
  
%Stuetze VM 
vert3= [SMb 0 0; SMb ProfSt 0; (SMb+ProfSb) ProfSt 0; (SMb+ProfSb) 0 0; (SMb+ProfSb) ProfSt (h-2*ProfTh); (SMb+ProfSb) 0 (h-2*ProfTh); SMb 0 (h-2*ProfTh); SMb ProfSt (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor',FarbeStuetzeM);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Einzelfundament VM
vert15= [(b/2-bfm1/2) ProfSt/2-bfm1/2 0; (b/2-bfm1/2) ProfSt/2+bfm1/2 0; (b/2+bfm1/2) ProfSt/2+bfm1/2 0; (b/2+bfm1/2) ProfSt/2-bfm1/2 0;...
        (b/2+bfm1/2) ProfSt/2+bfm1/2 -hf1; (b/2+bfm1/2) ProfSt/2-bfm1/2 -hf1; (b/2-bfm1/2) ProfSt/2-bfm1/2 -hf1; (b/2-bfm1/2) ProfSt/2+bfm1/2 -hf1]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert15,'FaceColor',FarbeFundament);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze HM
vert5= [SMb (l-ProfSt) 0; SMb l 0; (SMb+ProfSb) l 0; (SMb+ProfSb) (l-ProfSt) 0; (SMb+ProfSb) l (h-2*ProfTh); (SMb+ProfSb) (l-ProfSt) (h-2*ProfTh); SMb (l-ProfSt) (h-2*ProfTh); SMb l (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor',FarbeStuetzeM);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Einzelfundament HM
vert17= [(b/2-bfm1/2) l-(ProfSt/2-bfm1/2) 0; (b/2-bfm1/2) l-(ProfSt/2+bfm1/2) 0; (b/2+bfm1/2) l-(ProfSt/2+bfm1/2) 0; (b/2+bfm1/2) l-(ProfSt/2-bfm1/2) 0;...
        (b/2+bfm1/2) l-(ProfSt/2+bfm1/2) -hf1; (b/2+bfm1/2) l-(ProfSt/2-bfm1/2) -hf1; (b/2-bfm1/2) l-(ProfSt/2-bfm1/2) -hf1; (b/2-bfm1/2) l-(ProfSt/2+bfm1/2) -hf1]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor',FarbeFundament);            % Erzeugen der Gefärbten Flächen (Polygonen)

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Pfetten dazwischen
j=0;
while j< (b-(apres))
    j=j+apres;
  XMRL = (j-(ProfTb/2));      %Hilfsgrösse% Achsabstand der Längsbinder in While Schleife
vert13= [XMRL 0 (h-ProfTh); (XMRL+ProfTb) 0 (h-ProfTh); (XMRL+ProfTb) 0 h; XMRL 0 h; (XMRL+ProfTb) l h; XMRL l h; XMRL l (h-ProfTh); (XMRL+ProfTb) l (h-ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert13,'FaceColor',FarbePfetteI);            % Erzeugen der Gefärbten Flächen (Polygonen)  
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Binder i Stützen und Querbalken dazwischen
i1=0;
while i1 < l-arres; 
       i1= i1 +arres;
   XMVQS = (i1-(ProfSt/2));           %Hilfsgrösse% Achsabstand der Stütze in While-schleife
   XMVQT=  (i1-(ProfTb/2));           %Hilfsgrösse% Achsabstand der Balken in While-schleife

%Querbalken 
vert9= [0 XMVQT (h-2*ProfTh); 0 XMVQT (h-ProfTh); 0 (XMVQT+ProfTb) (h-ProfTh); 0 (XMVQT+ProfTb) (h-2*ProfTh); b (XMVQT+ProfTb) (h-ProfTh); b (XMVQT+ProfTb) (h-2*ProfTh); b XMVQT (h-2*ProfTh); b XMVQT (h-ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor',FarbeQuerbalkenI);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze iA
vert10= [0 XMVQS 0; 0 (XMVQS+ProfSt) 0; ProfSb (XMVQS+ProfSt) 0; ProfSb XMVQS 0; ProfSb (XMVQS+ProfSt) (h-2*ProfTh); ProfSb XMVQS (h-2*ProfTh); 0 XMVQS (h-2*ProfTh); 0 (XMVQS+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor',FarbeQuerbalkenI);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Einzelfundament iA
vert16= [ProfSb/2-bf2/2 i1-tf2/2 0; ProfSb/2-bf2/2 i1+tf2/2 0; ProfSb/2+bf2/2 i1+tf2/2 0; ProfSb/2+bf2/2 i1-tf2/2 0;...
        ProfSb/2+bf2/2 i1+tf2/2 -hf; ProfSb/2+bf2/2 i1-tf2/2 -hf; ProfSb/2-bf2/2 i1-tf2/2 -hf; ProfSb/2-bf2/2 i1+tf2/2 -hf]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert16,'FaceColor', FarbeFundament);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze iB
vert11= [b XMVQS 0; b (XMVQS+ProfSt) 0; (b-ProfSb) (XMVQS+ProfSt) 0; (b-ProfSb) XMVQS 0; (b-ProfSb) (XMVQS+ProfSt) (h-2*ProfTh); (b-ProfSb) XMVQS (h-2*ProfTh); b XMVQS (h-2*ProfTh); b (XMVQS+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor',FarbeStuetzeI);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Einzelfundament iB
vert17= [b-(ProfSb/2-bf2/2) i1-tf2/2 0; b-(ProfSb/2-bf2/2) i1+tf2/2 0; b-(ProfSb/2+bf2/2) i1+tf2/2 0; b-(ProfSb/2+bf2/2) i1-tf2/2 0;...
        b-(ProfSb/2+bf2/2) i1+tf2/2 -hf; b-(ProfSb/2+bf2/2) i1-tf2/2 -hf; b-(ProfSb/2-bf2/2) i1-tf2/2 -hf; b-(ProfSb/2-bf2/2) i1+tf2/2 -hf]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor',FarbeFundament);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stützenreihen bei grösseren Spannweiten >13
if b >=13 & b <= 26
    
%Stuetze iM
vert3= [SMb XMVQS 0; SMb (XMVQS+ProfSt) 0; (SMb+ProfSb) (XMVQS+ProfSt) 0; (SMb+ProfSb) XMVQS 0; (SMb+ProfSb) (XMVQS+ProfSt) (h-2*ProfTh); (SMb+ProfSb) XMVQS (h-2*ProfTh); SMb XMVQS (h-2*ProfTh); SMb (XMVQS+ProfSt) (h-2*ProfTh)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor',FarbeStuetzeIM);            % Erzeugen der Gefärbten Flächen (Polygonen)

%Einzelfundament iM
vert17= [(b/2-bfm2/2) i1-bfm2/2 0; (b/2-bfm2/2) i1+bfm2/2 0; (b/2+bfm2/2) i1+bfm2/2 0; (b/2+bfm2/2) i1-bfm2/2 0;...
        (b/2+bfm2/2) i1+bfm2/2 -hf; (b/2+bfm2/2) i1-bfm2/2 -hf; (b/2-bfm2/2) i1-bfm2/2 -hf; (b/2-bfm2/2) i1+bfm2/2 -hf]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert17,'FaceColor',FarbeFundament);            % Erzeugen der Gefärbten Flächen (Polygonen)

end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
        end
    
 end
