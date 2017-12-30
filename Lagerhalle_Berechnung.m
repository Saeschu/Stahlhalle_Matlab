close all
clear all, clc


Dim=0.2             %Dimension der Stahltrager  - zurzeitn Quadrate
l=20                %L�nge
ba=13               %Breite zwischen den St�tzen
h=6                 %H�he
a=1.5               %Binderabstand
E=200000            %E-Modul
IS=500000000        %I St�tze [mm^4]
IT=5000000000        %I Tr�ger oben [mm^4]
%F=linspace(30,30,13)                %Kr�ft in kN
%x=linspace(0,13,13)
%F=[50,40,40,40,40,40,40,40,40,40,50]
%x=[0:1.3:13]
F=[100]
x=[3]
hI=h*(IT/IS)                                  %Vergleichsh�he f�r St�tze 
AZB=3                                         %Indikator f�r Hallenfaktor



   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funktion f�r Bogen 2 bis 4 St�tzen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  

%function
%%%k = Kennzahl des Bogens
%F=F(K)
%x=x(K)


%Output
%Av({K}








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
NSupSR=linspace(sum(Bv),sum(Bv),dS)                     % Superposition Stab Rechts Werte Normalkraft
NSupSO=linspace(sum(Ah),sum(Bh),dS)                     % Superposition Stab Oben Werte Normalkraft
NSupS1=linspace(sum(S1v),sum(S1v),dS)                   % Superposition Stab Mitte Normalkraft



else  AZB == 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ___________%%%%%%%%%%%%%%             
%    Berechnung (n=5) mit 4 St�tzen            �   �   �   �            %                          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Verschiebungsgr�ssen Erg�nzung f�r System (n=5)(�berlagerung der Momente - Kraftgr�ssenverfahren mit Werte aus Integrationstabelle)
for z=[1:length(F)]                                     % 0 mit 4 Zustand 
if x(z)<=(1/3*ba)
    a40(z)=(1/6)*(((2*(1/3)*ba)-((1/3*ba)^2)-(x(z)^2))/((1/3*ba)*(ba-x(z))))*(Av0(z).*x(z)).*((-2/9).*ba).*ba
elseif x(z)<=(ba/2)                                      
    a40(z)=(1/6)*((2*x(z)-(x(z)^2)-(1/3*ba))/((2/3*ba)*x(z)))*(Av0(z).*x(z)).*((2/9).*ba).*ba
elseif x(z)<=(2/3*ba)
    a40(z)=(1/6)*((2*(ba-x(z))-((ba-x(z))^2)-(1/3*ba))/((2/3*ba)*(ba-x(z))))*(Av0(z).*x(z)).*((-2/9).*ba).*ba
else x(z)>(2/3*ba)
    a40(z)=(1/6)*(((2*(1/3)*ba)-((1/3*ba)^2)-((ba-x(z))^2))/((1/3*ba)*(x(z))))*(Av0(z).*x(z)).*((-2/9).*ba).*ba
end
end

a50=a40

a14=0.5*((-2/9)*ba)*1*ba                                % 1 mit 4 Zustand

a15=a14                                                 % 1 mit 5 Zustand

a24=(1/6)*(1+(2/3)*ba)*((-2/9)*ba)*1*ba                 % 2 mit 4 Zustand

a25=a24                                                 % 2 mit 5 Zustand

a34=(1/6)*(1+(2/3)*ba)*((-2/9)*ba)*-1*ba                % 3 mit 4 Zustand

a35=a34                                                 % 3 mit 5 Zustand

a44=(2*(1/3)*(-2/9)*ba*(-2/9)*ba)*ba                    % 4 mit 4 Zustand

a45=(1/12)*(((2*(1/3)*ba)-((1/3*ba)^2)-((1/3*ba)^2))/((1/3*ba)*(2/3*ba)))*(2*(-2/9)*ba)*ba

a55=a44
%Matrix der Verschiebungsgr�ssen [B A] * X = [0;0;0;0;0]

A=[a11,a12,a13,a14,a15;a12,a22,a23,a24,a25;a13,a23,a33,a34,35;a14,a24,a34,a44,a45;a15,a25,a35,a45,a55]
B=[-a10;-a20;-a30;-a40;-a50]

X=A\B

X1=X(1,:)
X2=X(2,:)
X3=X(3,:)
X4=X(4,:)
X5=X(5,:)

%Auflagerkr�fte in A
Av=Av0+0*X1+(-1/ba)*X2+(1/ba)*X3+(-2/3)*X4+(-1/3)*X5
Ah=0+(-1/h)*X1+0*X2+(1/h)*X3+0*X4+0*X5
Ma=0+0*X1+1*X2+0*X3+0*X4+0*X5

%Auflagerkr�fte in B
Bv=Bv0+0*X1+(1/ba)*X2+(-1/ba)*X3+(-1/3)*X4+(-2/3)*X5
Bh=0+(1/h)*X1+0*X2+(-1/h)*X3+0*X4+0*X5
Mb=0+0*X1+0*X2+1*X3+0*X4+0*X

%Auflagerkraft in St�tze 1 (links)
S1v=X4

%Auflagerkraft bei St�tze 2 (rechts)
S2v=X5

%Moment bei St�tze 1 (links)
for z=[1:length(F)]
    if x(z)<(ba*(1/3))
   Ms1(z)=(Av0(z).*(1/3)*ba)+(-F(z).*(((1/3)*ba)-x(z)))+1.*X1(z)+(2/3).*X2(z)+(-2/3).*X3(z)+(-2/9*ba).*X4(z)+(0.5*(-2/9*ba)).*X5(z)
    elseif x(z) ==(ba*(1/3))
   Ms1(z)=Av0(z).*x(z)+1.*X1(z)+(2/3).*X2(z)+(-2/3).*X3(z)+(-2/9*ba).*X4(z)+(0.5*(-2/9*ba)).*X5(z)
    elseif x(z)>(ba*(1/3))
   Ms1(z)=Av0(z).*((1/3)*ba)+(F(z).*(x(z)-(1/3)*ba))+1.*X1(z)+(2/3).*X2(z)+(-2/3).*X3(z)+(-2/9*ba).*X4(z)+(0.5*(-2/9*ba)).*X5(z)
end
end
%{
% Moment bei St�tze in Mitte
for z=[1:length(F)]
    if x(z)<=(ba*0.5)
    Ms1(z)=(Bv0(z).*0.5*ba)+1.*X1(z)+(0.5).*X2(z)+(-0.5).*X3(z)+(-0.25*ba).*X4(z)
    else x(z)>(ba*0.5)
    Ms1(z)=((Av0(z).*0.5*ba))+1.*X1(z)+(0.5).*X2(z)+(-0.5).*X3(z)+(-0.25*ba).*X4(z)
end
end
%}


%Moment bei St�tze 2 (Rechts)
for z=[1:length(F)]
    if x(z)<(ba*(2/3))
   Ms2(z)=(Av0(z).*(2/3)*ba)+(-F(z).*(((2/3)*ba)-x(z)))+1.*X1(z)+(1/3).*X2(z)+(-1/3).*X3(z)+(0.5*(-2/9*ba)).*X4(z)+(-2/9*ba).*X5(z)
    elseif x(z) ==(ba*(2/3))
   Ms2(z)=Av0(z).*x(z)+1.*X1(z)+(1/3).*X2(z)+(-1/3).*X3(z)+(0.5*(-2/9*ba)).*X4(z)+(-2/9*ba).*X5(z)
    elseif x(z)>(ba*(2/3))
   Ms2(z)=Av0(z).*((2/3)*ba)+(F(z).*(x(z)-(2/3)*ba))+1.*X1(z)+(1/3).*X2(z)+(-1/3).*X3(z)+(0.5*(-2/9*ba)).*X4(z)+(-2/9*ba).*X5(z)
end
end


%Moment bei Kraft
for z=[1:length(F)]
if x(z)<(ba*(1/3))
   Mf(z)=Av0(z)*x(z)+1*X1(z)+(1-(x(z)/ba))*X2(z)+(1-(x(z)/ba))*X3(z)*(-1)+(x(z)/(ba*(1/3)))*(-2/9*ba)*X4(z)+(x(z)/(ba*(2/3)))*(-2/9*ba)*X5(z)
elseif x(z) ==(ba*(1/3))
   Mf(z)=Ms1(z)
elseif x(z)>(ba*(1/3))
   Mf(z)=Av0(z)*x(z)+1*X1(z)+(1-(x(z)/ba))*X2(z)+(1-(x(z)/ba))*X3(z)*(-1)+((ba-x(z))/(ba*(2/3)))*(-2/9*ba)*X4(z)+(x(z)/(ba*(2/3)))*(-2/9*ba)*X5(z)
elseif x(z)==(ba*(2/3))
   Mf(z)=Ms2(z)
else x(z)>(ba*(2/3))
   Mf(z)=Av0(z)*x(z)+1*X1(z)+(1-(x(z)/ba))*X2(z)+(1-(x(z)/ba))*X3(z)*(-1)+((ba-x(z))/(ba*(2/3)))*(-2/9*ba)*X4(z)+((ba-x(z))/(ba*(1/3)))*(-2/9*ba)*X5(z)
end
end

   
%Schnittkrafte Ecke Links
Ml=0+1.*X1+1.*X2+-1.*X3+0*X4+0*X5

%Schnittkr�fte Ecke Rechts
Mr=0+1.*X1+0.*X2+0.*X3+0*X4+0*X5

% Werte Moment f�r Superposition

dx=10                                                   %Teilungsfaktor

MSupSL=linspace(sum(Ml),sum(Ma),dx)                   %Superposition Stab Links Werte Moment
MSupSR=linspace(sum(Mb),sum(Mr),dx)                   %Superposition Stab Rechts Werte Moment


                                                                
 for z=[1:length(F)]
    if x(z)==0 
    MSO{z}=zeros(1,((ba*dx)-2))                         %Momente Stab oben wenn Moment = 0 
    elseif x(z)<0.5*ba            
    MvorbSOL{z}=linspace(Ml(z),Mf(z),(x(z).*dx))                  %Moment Stab oben links von F
    xSTOMV{z}=linspace(Mf(z),Ms1(z),((0.5*ba-(x(z))).*dx))
    MvorbSOR{z}=linspace(Ms1(z),Mr(z),((0.5*ba).*dx))               %Moment Stab oben rechts von F
    MSO{z}=[MvorbSOL{z}(1:end-1),xSTOMV{z},MvorbSOR{z}(2:end)]    %Moment Stab oben links + rechts
    elseif x(z)==ba*0.5 
    MSO{z}=zeros(1,((ba*dx)-2))                     %Momente Stab oben wenn Moment = 0 
    elseif x(z)==ba 
    MSO{z}=zeros(1,((ba*dx)-2))
    elseif x(z)>0.5*ba            
    MvorbSOL{z}=linspace(Ml(z),Ms1(z),((0.5*ba).*dx))                   %Moment Stab oben links von F
    xSTOMV{z}=linspace(Ms1(z),Mf(z),((x(z)-(0.5*ba)).*dx))
    MvorbSOR{z}=linspace(Mf(z),Mr(z),((ba-(x(z))).*dx))                %Moment Stab oben rechts von F
    MSO{z}=[MvorbSOL{z}(1:end-1),xSTOMV{z},MvorbSOR{z}(2:end)]          %Moment Stab oben links + rechts
 
    end
 end
 
    MSupSO=zeros(1,((ba*dx)-2))
 for z=[1:length(F)]
     MSupSO=MSupSO+MSO{z}                      %Supepositin Stab oben Werte Moment
 end
   
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Darstellung Bogen  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
plot([0,sum(Ma)*dM],[0,0],'r','LineWidth',2)         %Stab-Moment Erg�nzung unten
plot([0,sum(Ml)*dM],[h,h],'r','LineWidth',2)         %Stab-Moment Erg�nzung oben
text((sum(Ma)*dM),-1,num2str(roundn(sum(Ma),-2)))  %Text unten Ma !!! Wert -1 !!!

%Momentenverlauf Stab rechts
MxSR=ba-(MSupSR.*dM)           
MySR=linspace(0,h,3)
plot(MxSR,MySR,'r','LineWidth',2)                      %Stab-Moment Links
plot([ba,ba-sum(Mb)*dM],[0,0],'r','LineWidth',2)       %Stab-Moment Erg�nzung unten
plot([ba,ba-sum(Mr)*dM],[h,h],'r','LineWidth',2)       %Stab-Moment Erg�nzung oben
text((ba-sum(Mb)*dM)-4,-1,num2str(roundn(sum(Mb),-2)))   %Text unten Mb !!! Wert -4&-1 !!! 

%Momentenverlauf Stab oben
MySO=h-(MSupSO.*dM)
MxSO=linspace(0,ba,length(MSupSO))
plot(MxSO,MySO,'r','LineWidth',2)                       %Stab-Moment Oben
plot([0,0],[h,h-sum(Ml)*dM],'r','LineWidth',2)          %Stab-Moment Erg�nzung Links
plot([ba,ba],[h,h-sum(Mr)*dM],'r','LineWidth',2)        %Stab-Moment Erg�nzung rechts
text(-1+sum(Ml)*dM,h+1-sum(Ml)*dM,num2str(roundn(sum(Ml),-2)))               %Text Ml !!! +1 % -1!!!
text(ba-sum(Mr)*dM,h-sum(Mr)*dM,num2str(roundn(sum(Mr),-2)))                  %Text Mr
text((mean((find(MSupSO==max(MSupSO))/length(MSupSO))))*ba...
    ,h-1-max(MSupSO)*dM,num2str(roundn(max(MSupSO),-2)))             %Text Max-Moment Mf !!! -1 !!!
if AZB>1
text((mean((find(MSupSO==min(MSupSO))/length(MSupSO))))*ba...
    ,h-min(MSupSO)*dM,num2str(min(MSupSO)))                                 %Text MIN-Moment Mf
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
%Auflagerkr�fte




 









%Variante mit Kragarm (Funktioniert nicht)
%{
Av0=F
Ma0=-F.*x




a10=(((b-x)/b)+2)*((-F*x.^2)/6)+(-F)*b*hI
a20=((-F*x.^2)/2)+0.5*hI
a30=((-F*x.^2)/2)+hI
a11=(1/3)*b+hI
a12=-0.5*b+(-0.5)*hI
a13=-0.5*b+(-hI)
a22=b+(2/3)*hI
a23=b+hI
a33=b+(2/3)*hI

a10=(1./6)*-F*x*(((b-x)./l)+2*1)*x*(1./IT)+1*1*-F*b*h*(1./IS)
a20=0.5*-F*x*1*x*(1./IT)+0.5*1*1*h*(1./IS)
a30=0.5*-F*x*1*x*(1./IT)+1*1*1*h*(1./IS)
a11=(1/3)*1*1*b*(1./IT)+1*1*1*h*(1/IS)
a12=0.5*1*-1*b*(1/IT)+0.5*1*-1*h*(1/IS)
a13=0.5*1*-1*b*(1/IT)+1*1*-1*h*(1/IS)
a22=1*-1*-1*b*(1/IT)+2*(1/3)*-1*-1*h*(1/IS)
a23=1*-1*-1*b*(1/IT)+2*0.5*-1*-1*h*(1/IS)
a33=1*1*1*b*(1/IT)+2*(1/3)*1*1*h*(1/IS)
%}
beep
