clear all, clc


Dim=0.2             %Dimension der Stahltrager  - zurzeitn Quadrate
l=20                %L�nge
ba=13                %Breite zwischen den St�tzen
h=6                 %H�he
a=1.5               %Binderabstand
E=200000            %E-Modul
IS=500000000        %I St�tze [mm^4]
IT=5000000000        %I Tr�ger oben [mm^4]
F=[10,10,50,50]                %Kr�ft in kN
x=[3,5,9]            %Distanz von Links her
hI=h*(IT/IS)                                  %Vergleichsh�he f�r St�tze 
AZB=1                                         %Indikator f�r Hallenfaktor


if AZB == 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                               ___________             %
%       Variante n=3 mit 2 St�tzen aussen      �           �            %
%                                                                       %                          
%}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Auflagerkr�fte
Av0=(1.-(x./ba)).*F
Bv0=(x./ba).*F

%Verschiebungsgr�ssen (�berlagerung der Momente)
a10=0.5.*Av0.*x.*1.*ba                               %0 mit 1 Zustand
    
a20=(1/6).*(1+(1-(x./ba))).*(Av0.*x).*1.*ba          %0 mit 2 Zustand

a30=-a20                                             %0 mit 3 Zustand

a11=1*1*1*ba+2*((1/3)*1*1*hI)                        %1 mit 1 Zustand

a12=0.5*1*1*ba+0.5*1*1*hI                            %1 mit 2 Zustand

a13=(1/3)*1*-1*hI+(1/2)*1*-1*ba+(1/6)*1*1*hI         %1 mit 3 Zustand

a22=(1/3)*1*1*ba+1*1*1*hI                            %2 mit 2 Zustand

a23=0.5*1*-1*hI+(1/3)*-1*1*ba                        %2 mit 3 Zustand

a33=(1/3)*-1*-1*hI+(1/3)*-1*-1*ba+(1/3)*1*1*hI       %3 mit 3 Zustand

%Matrix der Verschiebungsgr�ssen [B A] * X = [0;0;0]
A=[a11,a12,a13;a12,a22,a23;a13,a23,a33]
B=[-a10;-a20;-a30]

X=A\B

X1=X(1,:)
X2=X(2,:)
X3=X(3,:)

%Auflagerkr�fte in A
Av=Av0+0*X1+(-1/ba)*X2+(1/ba)*X3
Ah=0+(-1/h)*X1+0*X2+(1/h)*X3
Ma=0+0*X1+1*X2+0*X3

%Auflagerkr�fte in B
Bv=Bv0+0*X1+(1/ba)*X2+(-1/ba)*X3
Bh=0+(1/h)*X1+0*X2+(-1/h)*X3
Mb=0+0*X1+0*X2+1*X3

%Moment bei Kraft F
Mf=Av0.*x+1.*X1+(1-(x./ba)).*X2+(1-(x./ba)).*X3.*(-1)

%Moment Ecke Links
Ml=0+1.*X1+1.*X2+-1.*X3

%Moment Ecke Rechts
Mr=0+1.*X1+0.*X2+0.*X3


% Werte Moment f�r Superposition
dx=10.11111111111111111111111111111111111111111111111                                                       %Teilungsfaktor

MSupSL=linspace(sum(Ml),sum(Ma),dx)                       %Superposition Stab Links Werte Moment
MSupSR=linspace(sum(Mb),sum(Mr),dx)                       %Superposition Stab Rechts Werte Moment
                                                                
 for z=[1:length(F)]
    if x(z)==ba 
    MSO{z}=zeros(1,((ba*dx)-1))                    %Momente Stab oben wenn Moment = 0 
    elseif x(z)==0 
    MSO{z}=zeros(1,((ba*dx)-1))                    %Momente Stab oben wenn Moment = 0 
    else            
    MvorbSOL=linspace(Ml(z),Mf(z),(x(z)*dx))              %Moment Stab oben links von F
    MvorbSOR=linspace(Mf(z),Mr(z),((ba-(x(z)))*dx))       %Moment Stab oben rechts von F
    MSO{z}=[MvorbSOL(1:end-1),MvorbSOR]                %Moment Stab oben links + rechts
    end
   
 end
 
    MSupSO=zeros(1,((ba*dx)-1))
 for z=[1:length(F)]
     MSupSO=MSupSO+MSO{z}                      %Supeposition Stab oben Werte Moment
 end
   
%Werte Querkraft f�r Superpoistion
VSupSL=linspace(sum(-Ah),sum(-Ah),1)                       %Superposition Stab Links Werte Normalkraft
VSupSR=linspace(sum(-Bh),sum(-Bh),1)                       %Superposition Stab Rechts Werte Normalkraft

for z=[1:length(F)]
   VvorbSOL=linspace(Av(z),Av(z),(x(z).*dx))
   VvorbSOR=linspace(Av(z)-F(z),Av(z)-F(z),((ba-x(z)).*dx))
   VSO{z}=[VvorbSOL,VvorbSOR]
end

VSupSO=zeros(1,(ba*dx))
for z=[1:length(F)]
    VSupSO=VSupSO+VSO{z}
end

%Werte Normalkraft f�r Superposition
NSupSL=linspace(sum(-Av),sum(-Av),1)                       %Superposition Stab Links Werte Normalkraft
NSupSR=linspace(sum(Bv),sum(Bv),1)                       %Superposition Stab Rechts Werte Normalkraft
NSupSO=linspace(sum(Ah),sum(Bh),1)                      %Superposition Stab Oben Werte Normalkraft


% Darstellung Bogen  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Darstellung: Struktur, Auflast & Fundamente
subplot(2,4,1)
hold on
axis equal

plot([0,0],[0,h],'k','LineWidth',3)             %Stab Links 
plot([0,ba],[h,h],'k','LineWidth',3)            %Stab Oben
plot([ba,ba],[0,h],'k','LineWidth',3)           %Stab Rechts

plot([-0.5,ba+0.5],[-2,-2],'Color',[0.19 0.19 0.19],'LineWidth',1)      %Bemassung Linie (Breite) Grau
plot([0,0],[-2.5,-1.5],'Color',[0.19 0.19 0.19],'LineWidth',1)          %Bemassung Hilfslinie rechts (Breite) Grau
plot([ba,ba],[-2.5,-1.5],'Color',[0.19 0.19 0.19],'LineWidth',1)        %Bemassung Hilfslinie links (Breite) Grau
text(ba*0.5,-1,(num2str(roundn(ba,-2))),'Color',[0.19 0.19 0.19])                  %Wert Bemassung (Breite) (Breite !!ba!! -> muss b sein) Grau

plot([ba+2,ba+2],[-0.5,h+0.5],'Color',[0.19 0.19 0.19],'LineWidth',1)      %Bemassung Linie (H�he) Grau
plot([ba+1.5,ba+2.5],[0,0],'Color',[0.19 0.19 0.19],'LineWidth',1)          %Bemassung Hilfslinie rechts (H�he) Grau
plot([ba+1.5,ba+2.5],[h,h],'Color',[0.19 0.19 0.19],'LineWidth',1)        %Bemassung Hilfslinie links (H�he) Grau
text(ba+1,h*0.5,(num2str(roundn(h,-2))),'Color',[0.19 0.19 0.19])                  %Wert Bemassung (H�he) (Breite !!h!! -> muss ... sein) Grau
hold off


%Daratellung Moment
dM= (ba*0.25)/max(abs([MSupSL MSupSO MSupSR]))                   %Darstellungs Faktor Moment (Mmax = 0.25 von Breite)
subplot(2,4,2)
hold on
axis equal

%Struktur
plot([0,0],[0,h],'k','LineWidth',3)             %Stab Links 
plot([0,ba],[h,h],'k','LineWidth',3)            %Stab Oben
plot([ba,ba],[0,h],'k','LineWidth',3)           %Stab Rechts

%Momentenverlauf Stab links 
MxSL=(MSupSL.*dM)
MySL=linspace(h,0,dx)
plot(MxSL,MySL,'r','LineWidth',2)                    %Stab-Moment Rechts
plot([0,sum(Ma)*dM],[0,0],'r','LineWidth',2)         %Stab-Moment Erg�nzung unten
plot([0,sum(Ml)*dM],[h,h],'r','LineWidth',2)         %Stab-Moment Erg�nzung oben
text((sum(Ma)*dM),-1,num2str(roundn(sum(Ma),-2)))  %Text unten Ma !!! Wert -1 !!!

%Momentenverlauf Stab rechts
MxSR=ba-(MSupSR.*dM)           
MySR=linspace(0,h,dx)
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



hold off

% Darstellung Querkraft
dV=(ba*0.25)/max(abs([VSupSL VSupSO VSupSR])) 
subplot(2,4,3)
hold on
axis equal 

%Struktur
plot([0,0],[0,h],'k','LineWidth',3)             %Stab Links
plot([0,ba],[h,h],'k','LineWidth',3)            %Stab Oben
plot([ba,ba],[0,h],'k','LineWidth',3)           %Stab Rechts

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
dN=(ba*0.25)/max(abs([NSupSO NSupSR NSupSL])) 
subplot(2,4,4)
hold on
axis equal 
plot([0,0],[0,h],'k','LineWidth',3)             %Stab Links
plot([0,ba],[h,h],'k','LineWidth',3)            %Stab Oben
plot([ba,ba],[0,h],'k','LineWidth',3)           %Stab Rechts

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

%Normalkraftverlauf Stab oben
plot([0,ba],[h+NSupSO*dN,h+NSupSO*dN],'g','LineWidth',2)            %Normalkraft Stab oben
plot([0,0],[h,h+NSupSO*dN],'g','LineWidth',2)                      %Normalkraft Stab oben Erg�nzunglinie unten
plot([ba,ba],[h,h+NSupSO*dN],'g','LineWidth',2)                      %Normalkraft Stab oben Erg�nzunglinie oben
text(ba*0.5,h+NSupSR*dN,num2str(roundn(NSupSO,-2)))                  %Text Stab Links !!!  !!!

hold off
%Auflagerkr�fte




elseif  AZB == 2
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                               ___________             %
%       Variante n=4 mit 3 St�tzen             �     �     �            %
%                                                                       %                          
%}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Auflagerkr�fte
Av0=(1.-(x./ba)).*F
Bv0=(x./ba).*F

%Verschiebungsgr�ssen (�berlagerung der Momente)

a10=0.5.*Av0.*x.*1.*ba                               %0 mit 1 Zustand
    
a20=(1/6).*(1+(1-(x./ba))).*(Av0.*x).*1.*ba           %0 mit 2 Zustand

a30=-a20                                            %0 mit 3 Zustand

for z=[1:length(F)]
if x(z)<=(ba/2)
    a40(z)=(1/12).*((3-4.*((x(z)./ba).^2))/(1-(x(z)./ba))).*(-0.25.*ba).*(Av0(z).*x(z)).*ba
elseif x(z)>(ba/2)                                      %0 mit 4 Zustand 
    a40(z)=(1/12).*((3-4.*((1-(x(z)./ba)).^2))/(x(z)./ba)).*(-0.25.*ba).*(Av0(z).*x(z)).*ba
end
end


a11=1*1*1*ba+2*((1/3)*1*1*hI)                        %1 mit 1 Zustand

a12=0.5*1*1*ba+0.5*1*1*hI                            %1 mit 2 Zustand

a13=(1/3)*1*-1*hI+(1/2)*1*-1*ba+(1/6)*1*1*hI         %1 mit 3 Zustand

a14=0.5*(-0.25*ba)*1*ba                               %1 mit 4 Zustand

a22=(1/3)*1*1*ba+1*1*1*hI                            %2 mit 2 Zustand

a23=0.5*1*-1*hI+(1/3)*-1*1*ba                        %2 mit 3 Zustand

a24=0.25*(-0.25*ba)*1*ba                              %2 mit 4 Zustand

a33=(1/3)*-1*-1*hI+(1/3)*-1*-1*ba+(1/3)*1*1*hI       %3 mit 3 Zustand

a34=0.25*(-0.25*ba)*-1*ba                             %3 mit 4 Zustand

a44=(1/3)*(-0.25*ba)*(-0.25*ba)*ba                     %4 mit 4 Zustand

%Matrix der Verschiebungsgr�ssen [B A] * X = [0;0;0;0]

A=[a11,a12,a13,a14;a12,a22,a23,a24;a13,a23,a33,a34;a14,a24,a34,a44]
B=[-a10;-a20;-a30;-a40]

X=A\B

X1=X(1,:)
X2=X(2,:)
X3=X(3,:)
X4=X(4,:)
%Auflagerkr�fte in A
Av=Av0+0*X1+(-1/ba)*X2+(1/ba)*X3+(-0.5)*X4
Ah=0+(-1/h)*X1+0*X2+(1/h)*X3+0*X4
Ma=0+0*X1+1*X2+0*X3+0*X4

%Auflagerkr�fte in B
Bv=Bv0+0*X1+(1/ba)*X2+(-1/ba)*X3
Bh=0+(1/h)*X1+0*X2+(-1/h)*X3
Mb=0+0*X1+0*X2+1*X3+0*X4

%Auflagerkraft in St�tze
S1v=X4

%Moment bei St�tze in Mitte
for z=[1:length(F)]
    if x(z)<(ba*0.5)
   Ms1(z)=((Av0(z).*0.5*ba)+(-F(z).*((0.5*ba)-x(z))))+1.*X1(z)+(0.5).*X2(z)+(-0.5).*X3(z)+(-0.25*ba).*X4(z)
    elseif x(z) ==(ba*0.5)
   Ms1(z)=Av0(z).*x(z)+1.*X1(z)+(0.5).*X2(z)+(-0.5).*X3(z)+(-0.25*ba).*X4(z)
    elseif x(z)>(ba*0.5)
   Ms1(z)=Av0(z).*(0.5*ba)+1.*X1(z)+(0.5).*X2(z)+(-0.5).*X3(z)+(-0.25*ba).*X4(z)
end
end


%Moment bei Kraft
for z=[1:length(F)]
if x(z)<(ba/2)
   Mf(z)=Av0(z)*x(z)+1*X1(z)+(1-(x(z)/ba))*X2(z)+(1-(x(z)/ba))*X3(z)*(-1)+(2*x(z)/ba)*(-0.25*ba)*X4(z)
elseif x(z) ==(ba/2)
   Mf(z)=Ms1(z)
elseif x(z)>(ba/2)
   Mf(z)=Av0(z)*x(z)+1*X1(z)+(1-(x(z)/ba))*X2(z)+(1-(x(z)/ba))*X3(z)*(-1)+((1-(x(z)/ba))*2)*(-0.25*ba)*X4(z)
end
end

   
%Schnittkrafte Ecke Links
Ml=0+1.*X1+1.*X2+-1.*X3+0*X4

%Schnittkr�fte Ecke Rechts
Mr=0+1.*X1+0.*X2+0.*X3+0*X4


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
   


% Darstellung Bogen  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot([0,0],[0,h],'k','LineWidth',4)             %Stab Links
hold on
axis equal 
plot([0,ba],[h,h],'k','LineWidth',4)             %Stab Oben
plot([ba,ba],[0,h],'k','LineWidth',4)             %Stab Rechts



dM= (ba*0.25)/max(MSupSO)                   %Darstellungs Faktor (Mmax = 0.25 von Breite)


%Graph Momentenverlauf Stab links 
MxSL=(MSupSL.*dM)
MySL=linspace(h,0,dx)
plot(MxSL,MySL,'r','LineWidth',2)               %Stab-Moment Rechts
plot([0,sum(Ma)*dM],[0,0],'r','LineWidth',2)         %Stab-Moment Erg�nzung unten
plot([0,sum(Ml)*dM],[h,h],'r','LineWidth',2)         %Stab-Moment Erg�nzung oben
text(sum(Ma)*dM,0,num2str(sum(Ma)))                       %Text unten Ma
text(sum(Ml)*dM,h,num2str(sum(Ml)))                    %Text oben  Ml

%Graph Momentenverlauf Stab rechts
MxSR=ba-(MSupSR.*dM)           
MySR=linspace(0,h,dx)
plot(MxSR,MySR,'r','LineWidth',2)               %Stab-Moment Links
plot([ba,ba-sum(Mb)*dM],[0,0],'r','LineWidth',2)       %Stab-Moment Erg�nzung unten
plot([ba,ba-sum(Mr)*dM],[h,h],'r','LineWidth',2)       %Stab-Moment Erg�nzung oben
text(ba-sum(Mb)*dM,0,num2str(sum(Mb)))                     %Text unten Mb 
text(ba-sum(Mr)*dM,h,num2str(sum(Mr)))                     %Text oben  Mr

%Momentenverlauf Stab oben
MySO=h-(MSupSO.*dM)
MxSO=linspace(0,ba,length(MSupSO))
plot(MxSO,MySO,'r','LineWidth',2)               %Stab-Moment Oben
plot([0,0],[h,h-sum(Ml)*dM],'r','LineWidth',2)       %Stab-Moment Erg�nzung Links
plot([ba,ba],[h,h-sum(Mr)*dM],'r','LineWidth',2)              %Stab-Moment Erg�nzung rechts
text(0,h-sum(Ml)*dM,num2str(sum(Ml)))                       %Text unten Ml
text(ba,h-sum(Mr)*dM,num2str(sum(Mr)))                       %Text unten Mr
text((find(MSupSO==max(MSupSO))/length(MSupSO))*ba...
    ,h-max(MSupSO)*dM,num2str(max(MSupSO)))             %Text Max-Moment Mf
text((find(MSupSO==min(MSupSO))/length(MSupSO))*ba...
    ,h-min(MSupSO)*dM,num2str(min(MSupSO)))             %Text Max-Moment Mf

%Auflagerkr�fte

hold off    






elseif  AZB == 3


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                               ___________             %
%       Variante n=5 mit 4 St�tzen             �   �   �   �            %
%                                                                       %                          
%}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Auflagerkr�fte
Av0=(1.-(x./ba)).*F
Bv0=(x./ba).*F

%Verschiebungsgr�ssen (�berlagerung der Momente)

a10=0.5.*Av0.*x.*1.*ba                               %0 mit 1 Zustand
    
a20=(1/6).*(1+(1-(x./ba))).*(Av0.*x).*1.*ba           %0 mit 2 Zustand

a30=-a20                                            %0 mit 3 Zustand
%{
for z1=[1:length(F)]
if x(z1)<=(ba/2)
    a40(z1)=(1/12).*((3-4.*((x(z1)./ba).^2))/(1-(x(z1)./ba))).*(-0.25.*ba).*(Av0(z1).*x(z1)).*ba
elseif x(z1)>(ba/2)                                      %0 mit 4 Zustand 
    a40(z1)=(1/12).*((3-4.*((1-(x(z1)./ba)).^2))/(x(z1)./ba)).*(-0.25.*ba).*(Av0(z1).*x(z1)).*ba
end
end




a50
%}

a11=1*1*1*ba+2*((1/3)*1*1*hI)                        %1 mit 1 Zustand

a12=0.5*1*1*ba+0.5*1*1*hI                            %1 mit 2 Zustand

a13=(1/3)*1*-1*hI+(1/2)*1*-1*ba+(1/6)*1*1*hI         %1 mit 3 Zustand

a14=0.5*(-0.25*ba)*1*ba                               %1 mit 4 Zustand

a22=(1/3)*1*1*ba+1*1*1*hI                            %2 mit 2 Zustand

a23=0.5*1*-1*hI+(1/3)*-1*1*ba                        %2 mit 3 Zustand

a24=0.25*(-0.25*ba)*1*ba                              %2 mit 4 Zustand

a33=(1/3)*-1*-1*hI+(1/3)*-1*-1*ba+(1/3)*1*1*hI       %3 mit 3 Zustand

a34=0.25*(-0.25*ba)*-1*ba                             %3 mit 4 Zustand

a44=(1/3)*(-0.25*ba)*(-0.25*ba)*ba                     %4 mit 4 Zustand

%Matrix der Verschiebungsgr�ssen [B A] * X = [0;0;0;0]

A=[a11,a12,a13,a14;a12,a22,a23,a24;a13,a23,a33,a34;a14,a24,a34,a44]
B=[-a10;-a20;-a30;-a40]

X=A\B

X1=X(1,:)
X2=X(2,:)
X3=X(3,:)
X4=X(4,:)
%Auflagerkr�fte in A
Av=Av0+0*X1+(-1/ba)*X2+(1/ba)*X3+(-0.5)*X4
Ah=0+(-1/h)*X1+0*X2+(1/h)*X3+0*X4
Ma=0+0*X1+1*X2+0*X3+0*X4

%Auflagerkr�fte in B
Bv=Bv0+0*X1+(1/ba)*X2+(-1/ba)*X3
Bh=0+(1/h)*X1+0*X2+(-1/h)*X3
Mb=0+0*X1+0*X2+1*X3+0*X4

%Auflagerkraft in St�tze
S1v=X4

%Moment bei St�tze in Mitte
for z=[1:length(F)]
    if x(z)<(ba*0.5)
   Ms1(z)=((Av0(z).*0.5*ba)+(-F(z).*((0.5*ba)-x(z))))+1.*X1(z)+(0.5).*X2(z)+(-0.5).*X3(z)+(-0.25*ba).*X4(z)
    elseif x(z) ==(ba*0.5)
   Ms1(z)=Av0(z).*x(z)+1.*X1(z)+(0.5).*X2(z)+(-0.5).*X3(z)+(-0.25*ba).*X4(z)
    elseif x(z)>(ba*0.5)
   Ms1(z)=Av0(z).*(0.5*ba)+1.*X1(z)+(0.5).*X2(z)+(-0.5).*X3(z)+(-0.25*ba).*X4(z)
end
end


%Moment bei Kraft
for z=[1:length(F)]
if x(z)<(ba/2)
   Mf(z)=Av0(z)*x(z)+1*X1(z)+(1-(x(z)/ba))*X2(z)+(1-(x(z)/ba))*X3(z)*(-1)+(2*x(z)/ba)*(-0.25*ba)*X4(z)
elseif x(z) ==(ba/2)
   Mf(z)=Ms1(z)
elseif x(z)>(ba/2)
   Mf(z)=Av0(z)*x(z)+1*X1(z)+(1-(x(z)/ba))*X2(z)+(1-(x(z)/ba))*X3(z)*(-1)+((1-(x(z)/ba))*2)*(-0.25*ba)*X4(z)
end
end

   
%Schnittkrafte Ecke Links
Ml=0+1.*X1+1.*X2+-1.*X3+0*X4

%Schnittkr�fte Ecke Rechts
Mr=0+1.*X1+0.*X2+0.*X3+0*X4


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
   


% Darstellung Bogen  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot([0,0],[0,h],'k','LineWidth',4)             %Stab Links
hold on
axis equal 
plot([0,ba],[h,h],'k','LineWidth',4)             %Stab Oben
plot([ba,ba],[0,h],'k','LineWidth',4)             %Stab Rechts



dM= (ba*0.25)/max(MSupSO)                   %Darstellungs Faktor (Mmax = 0.25 von Breite)


%Graph Momentenverlauf Stab links 
MxSL=(MSupSL.*dM)
MySL=linspace(h,0,dx)
plot(MxSL,MySL,'r','LineWidth',2)               %Stab-Moment Rechts
plot([0,sum(Ma)*dM],[0,0],'r','LineWidth',2)         %Stab-Moment Erg�nzung unten
plot([0,sum(Ml)*dM],[h,h],'r','LineWidth',2)         %Stab-Moment Erg�nzung oben
text(sum(Ma)*dM,0,num2str(sum(Ma)))                       %Text unten Ma
text(sum(Ml)*dM,h,num2str(sum(Ml)))                    %Text oben  Ml

%Graph Momentenverlauf Stab rechts
MxSR=ba-(MSupSR.*dM)           
MySR=linspace(0,h,dx)
plot(MxSR,MySR,'r','LineWidth',2)               %Stab-Moment Links
plot([ba,ba-sum(Mb)*dM],[0,0],'r','LineWidth',2)       %Stab-Moment Erg�nzung unten
plot([ba,ba-sum(Mr)*dM],[h,h],'r','LineWidth',2)       %Stab-Moment Erg�nzung oben
text(ba-sum(Mb)*dM,0,num2str(sum(Mb)))                     %Text unten Mb 
text(ba-sum(Mr)*dM,h,num2str(sum(Mr)))                     %Text oben  Mr

%Momentenverlauf Stab oben
MySO=h-(MSupSO.*dM)
MxSO=linspace(0,ba,length(MSupSO))
plot(MxSO,MySO,'r','LineWidth',2)               %Stab-Moment Oben
plot([0,0],[h,h-sum(Ml)*dM],'r','LineWidth',2)       %Stab-Moment Erg�nzung Links
plot([ba,ba],[h,h-sum(Mr)*dM],'r','LineWidth',2)              %Stab-Moment Erg�nzung rechts
text(0,h-sum(Ml)*dM,num2str(sum(Ml)))                       %Text unten Ml
text(ba,h-sum(Mr)*dM,num2str(sum(Mr)))                       %Text unten Mr
text((find(MSupSO==max(MSupSO))/length(MSupSO))*ba...
    ,h-max(MSupSO)*dM,num2str(max(MSupSO)))             %Text Max-Moment Mf
text((find(MSupSO==min(MSupSO))/length(MSupSO))*ba...
    ,h-min(MSupSO)*dM,num2str(min(MSupSO)))             %Text Max-Moment Mf

%Auflagerkr�fte

hold off    



end



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
















































%{








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Input Window
prompt = {'L�nge:','Breite:', 'H�he', 'Abstand','Dim'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'30','20','3','4','0.2'}; % Zahlenwerte k�nnen 'zwischen' entfert werden nur platzhalter
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
l= str2num(answer{1});
ba= str2num(answer{2});
h= str2num(answer{3});
a= str2num(answer{4});
Dim= str2num(answer{5});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%set axis and figure
clf;
figure(1)
format compact
myaxes =axes('xlim', [0, ba], 'ylim', [0, l], 'zlim', [0, h]);
axis equal
view(3)  %Erzeugung der 3D darstellung
grid on
xlabel('x - Breite')
ylabel('y - L�nge')
zlabel('z - H�he')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Laengstraeger 1
vert1= [0 0 (h-Dim); Dim 0 (h-Dim); Dim 0 h; 0 0 h; Dim l h; 0 l h; 0 l (h-Dim); Dim l (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
fac= [1 2 3 4; 4 3 5 6; 6 7 8 5; 1 2 8 7; 6 7 1 4; 2 3 5 8];    % Welche Eckpunkte werden als eine Polygonfl�che eingef�rbt
patch('Faces', fac,'Vertices',vert1,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Laengstraeger 2
vert2= [(ba-Dim) 0 (h-Dim); ba 0 (h-Dim); ba 0 h; (ba-Dim) 0 h; ba l h; (ba-Dim) l h; (ba-Dim) l (h-Dim); ba l (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert2,'FaceColor','b');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 1
vert3= [0 0 0; 0 Dim 0; Dim Dim 0; Dim 0 0; Dim Dim (h-Dim); Dim 0 (h-Dim); 0 0 (h-Dim); 0 Dim (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 2
vert4= [ba 0 0; ba Dim 0; (ba-Dim) Dim 0; (ba-Dim) 0 0; (ba-Dim) Dim (h-Dim); (ba-Dim) 0 (h-Dim); ba 0 (h-Dim); ba Dim (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert4,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 3
vert5= [0 (l-Dim) 0; 0 l 0; Dim l 0; Dim (l-Dim) 0; Dim l (h-Dim); Dim (l-Dim) (h-Dim); 0 (l-Dim) (h-Dim); 0 l (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze 4
vert6= [ba (l-Dim) 0; ba l 0; (ba-Dim) l 0; (ba-Dim) (l-Dim) 0; (ba-Dim) l (h-Dim); (ba-Dim) (l-Dim) (h-Dim); ba (l-Dim) (h-Dim); ba l (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert6,'FaceColor','r');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Querbalken Anfang
vert7= [Dim 0 (h-Dim); Dim 0 h; Dim Dim h; Dim Dim (h-Dim); (ba-Dim) Dim h; (ba-Dim) Dim (h-Dim); (ba-Dim) 0 (h-Dim); (ba-Dim) 0 h]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert7,'FaceColor','g');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Querbalken Ende
vert8= [Dim (l-Dim) (h-Dim); Dim (l-Dim) h; Dim l h; Dim l (h-Dim); (ba-Dim) l h; (ba-Dim) l (h-Dim); (ba-Dim) (l-Dim) (h-Dim); (ba-Dim) (l-Dim) h]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert8,'FaceColor','g');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if ba > 13
   SM= (ba/2) -(Dim/2);           %Hilfsgr�sse% Pos X (also St�tzenabstand) der St�zte. Einmitung auf Achsmass der St�tze

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
vert9= [Dim XMH (h-Dim); Dim XMH h; Dim (XMH+Dim) h; Dim (XMH+Dim) (h-Dim); (ba-Dim) (XMH+Dim) h; (ba-Dim) (XMH+Dim) (h-Dim); (ba-Dim) XMH (h-Dim); (ba-Dim) XMH h]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze A
vert10= [0 XMH 0; 0 (XMH+Dim) 0; Dim (XMH+Dim) 0; Dim XMH 0; Dim (XMH+Dim) (h-Dim); Dim XMH (h-Dim); 0 XMH (h-Dim); 0 (XMH+Dim) (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze B
vert11= [ba XMH 0; ba (XMH+Dim) 0; (ba-Dim) (XMH+Dim) 0; (ba-Dim) XMH 0; (ba-Dim) (XMH+Dim) (h-Dim); (ba-Dim) XMH (h-Dim); ba XMH (h-Dim); ba (XMH+Dim) (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

if ba >13
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
vert9= [Dim XMV (h-Dim); Dim XMV h; Dim (XMV+Dim) h; Dim (XMV+Dim) (h-Dim); (ba-Dim) (XMV+Dim) h; (ba-Dim) (XMV+Dim) (h-Dim); (ba-Dim) XMV (h-Dim); (ba-Dim) XMV h]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze A
vert10= [0 XMV 0; 0 (XMV+Dim) 0; Dim (XMV+Dim) 0; Dim XMV 0; Dim (XMV+Dim) (h-Dim); Dim XMV (h-Dim); 0 XMV (h-Dim); 0 (XMV+Dim) (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

%Stuetze B
vert11= [ba XMV 0; ba (XMV+Dim) 0; (ba-Dim) (XMV+Dim) 0; (ba-Dim) XMV 0; (ba-Dim) (XMV+Dim) (h-Dim); (ba-Dim) XMV (h-Dim); ba XMV (h-Dim); ba (XMV+Dim) (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor','y');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)

if ba >13
    %Stuetze VM
vert3= [SM XMV 0; SM (XMV+Dim) 0; (SM+Dim) (XMV+Dim) 0; (SM+Dim) XMV 0; (SM+Dim) (XMV+Dim) (h-Dim); (SM+Dim) XMV (h-Dim); SM XMV (h-Dim); SM (XMV+Dim) (h-Dim)]; % [x y z] Eckpunkte der Tr�ger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gef�rbten Fl�chen (Polygonen)
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Aussteifungen Kreuzverband Dach

%Aussteifungen Kreuzverband Wand Y=0

%Aussteifungen Kreuzverband Wand Y=l

%}
