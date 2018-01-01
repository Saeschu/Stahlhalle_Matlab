function [ Auflagermatrix, MMX,QMX,NMX ] = Funktion_Berechnung_Stahlhalle( K,AZB,EinwirkungenaufRahmen,ba,h,hI )
%Berechnet die Auflagerkraftematrix und die Plot Linien für die Bogen
%   Input:
%   K          Kennzahl für EinwirkungaufRahmen Matrix 
%                   -   1 = Ersten + Letzten Rahmen  
%                   -   2 = Mittlere Rahmen
%   AZB
%   EinwirkungaufRahmen
%   ba
%   hI
%
%   Output:
%   Auflagermatrix
%   MMX     Matrix Momentenverlauf für Plot MSupSL, MSupSR ,MSupSO
%   QMX     Matrix Querkraftverlauf für Plot VSupSL, VSupSR ,VSupSO
%   NMX     Matrix Normalkraftverlauf für Plot NSupSL, NSupSR ,NSupSO, NSupS1, NSupS2


%Wert aus EinwirkungaufRahmen Matrix lesen
F=EinwirkungenaufRahmen{1,2,K}
x=EinwirkungenaufRahmen{1,3,K}


   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funktion für Bogen 2 bis 4 Stützen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ___________ %%%%%%%%%%%%%
%   Berechnung (n=3) mit 2 Stützen aussen      ¦           ¦            %                          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
dx=1000                                                 % Teilungsfaktor Stab Oben(Stücke pro Meter)
dT=(ba*dx)                                              % Anzahl Teilstücke des Verlaufs vom Träger
dS=1                                                    % Anzahl Teilstücke des Verlaufs der Stäbe (dS=1, generiert ein Wert -> ausreichend )

MSupSL=linspace(sum(Ml),sum(Ma),dS)                     % Superposition Stab Links Moment
MSupSR=linspace(sum(Mb),sum(Mr),dS)                     % Superposition Stab Rechts Moment

MSupSO=zeros(1,dT)                                      % 0 Vektor mit Anzahl Einträgen wie MSO für Addition
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ___________%%%%%%%%%%%%%%
%    Berechnung (n=4) mit 3 Stützen            ¦     ¦     ¦            %                          
%}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
dx=1000                                                 % Teilungsfaktor Stab Oben(Stücke pro Meter)
dT=(ba*dx)                                              % Anzahl Teilstücke des Verlaufs vom Träger
dS=1                                                    % Anzahl Teilstücke des Verlaufs der Stäbe (dS=1, generiert ein Wert -> ausreichend )

MSupSL=linspace(sum(Ml),sum(Ma),dS)                     % Superposition Stab Links Moment
MSupSR=linspace(sum(Mb),sum(Mr),dS)                     % Superposition Stab Rechts Moment

MSupSO=zeros(1,dT)                                      % 0 Vektor mit Anzahl Einträgen wie MSO für Addition
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



else  AZB == 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ___________%%%%%%%%%%%%%%             
%    Berechnung (n=5) mit 4 Stützen            ¦   ¦   ¦   ¦            %                          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fehlt noch !!! weil hat ein Problem

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Erstellen der Outputmatrizen                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Aufbau Auflagermatrix

if AZB == 1
Auflagermatrix = [sum(Av),sum(Ah),sum(Ma);sum(Bv),sum(Bh),sum(Mb)]                     %Generiung der Matrix für AZB = 1
elseif AZB == 2
Auflagermatrix = [sum(Av),sum(Ah),sum(Ma);Sum(Bv),sum(Bh),sum(Mb);sum(S1v),0,0]             %Generiung der Matrix für AZB = 2
else AZB == 3
Auflagermatrix = [sum(Av),sum(Ah),sum(Ma);sum(Bv),sum(Bh),sum(Mb);sum(S1v),0,0;sum(S1v),sum(S2v),0]   %Generiung der Matrix für AZB = 3
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


