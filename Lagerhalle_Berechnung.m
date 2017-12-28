clear all, clc


Dim=0.2             %Dimension der Stahltrager  - zurzeitn Quadrate
l=20                %Länge
b=13                %Breite zwischen den Stützen
h=6                 %Höhe
a=1.5               %Binderabstand
E=200000            %E-Modul
IS=500000000        %I Stütze [mm^4]
IT=5000000000        %I Träger oben [mm^4]
F=[20,30]               %Kräft in kN
x=[5,9]               %Distanz von Links her
hI=h*(IT/IS)        %Vergleichshöhe für Stütze 
Anzahlstutzen=2     %Indikator für Hallenfaktor



if Anzahlstutzen == 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                               ___________             %
%       Variante n=3 mit 2 Stützen aussen      ¦           ¦            %
%                                                                       %                          
%}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Auflagerkräfte
Av0=(1.-(x./b)).*F
Bv0=(x./b).*F

%Verschiebungsgrössen (Überlagerung der Momente)

a10=0.5.*Av0.*x.*1.*b                               %0 mit 1 Zustand
    
a20=(1/6).*(1+(1-(x./b))).*(Av0.*x).*1.*b           %0 mit 2 Zustand

a30=-a20                                            %0 mit 3 Zustand

a11=1*1*1*b+2*((1/3)*1*1*hI)                        %1 mit 1 Zustand

a12=0.5*1*1*b+0.5*1*1*hI                            %1 mit 2 Zustand

a13=(1/3)*1*-1*hI+(1/2)*1*-1*b+(1/6)*1*1*hI         %1 mit 3 Zustand

a22=(1/3)*1*1*b+1*1*1*hI                            %2 mit 2 Zustand

a23=0.5*1*-1*hI+(1/3)*-1*1*b                        %2 mit 3 Zustand

a33=(1/3)*-1*-1*hI+(1/3)*-1*-1*b+(1/3)*1*1*hI       %3 mit 3 Zustand

%Matrix der Verschiebungsgrössen [B A] * X = [0;0;0]

A=[a11,a12,a13;a12,a22,a23;a13,a23,a33]
B=[-a10;-a20;-a30]

X=A\B

X1=X(1,:)
X2=X(2,:)
X3=X(3,:)

%Auflagerkräfte in A
Av=Av0+0*X1+(-1/b)*X2+(1/b)*X3
Ah=0+(-1/h)*X1+0*X2+(1/h)*X3
Ma=0+0*X1+1*X2+0*X3

%Auflagerkräfte in B
Bv=Bv0+0*X1+(1/b)*X2+(-1/b)*X3
Bh=0+(1/h)*X1+0*X2+(-1/h)*X3
Mb=0+0*X1+0*X2+1*X3

%Moment bei Kraft
Mf=Av0.*x+1.*X1+(1-(x./b)).*X2+(1-(x./b)).*X3.*(-1)

%Schnittkrafte Ecke Links
Ml=0+1.*X1+1.*X2+-1.*X3

%Schnittkräfte Ecke Rechts
Mr=0+1.*X1+0.*X2+0.*X3


% Werte Moment für Superposition

dx=10                                                   %Teilungsfaktor

WerteSTL=linspace(sum(Ml),sum(Ma),dx)                   %Superposition Stab Links Werte Moment
WerteSTR=linspace(sum(Mb),sum(Mr),dx)                   %Superposition Stab Rechts Werte Moment


                                                                
 for z1=[1:length(F)]
    if x(z1)==b 
    VorWerteSTO{z1}=zeros(1,((b*dx)-1))                     %Momente Stab oben wenn Moment = 0 
    elseif x(z1)==0 
    VorWerteSTO{z1}=zeros(1,((b*dx)-1))                     %Momente Stab oben wenn Moment = 0 
    elseif x(z1)~=or(0,b)            
    xSTOLV=linspace(Ml(z1),Mf(z1),(x(z1).*dx))              %Moment Stab oben links von F
    xSTORV=linspace(Mf(z1),Mr(z1),((b-(x(z1))).*dx))        %Moment Stab oben rechts von F
    VorWerteSTO{z1}=[xSTOLV(1:end-1),xSTORV]                %Moment Stab oben links + rechts
    end
 end
 
    WerteSTO=zeros(1,((b*dx)-1))
 for z1=[1:length(F)]
     WerteSTO=WerteSTO+VorWerteSTO{z1}                      %Supepositin Stab oben Werte Moment
 end
   


% Darstellung Bogen  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot([0,0],[0,h],'k','LineWidth',4)             %Stab Links
hold on
axis equal 
plot([0,b],[h,h],'k','LineWidth',4)             %Stab Oben
plot([b,b],[0,h],'k','LineWidth',4)             %Stab Rechts



dF= (b*0.25)/max(WerteSTO)                   %Darstellungs Faktor (Mmax = 0.25 von Breite)


%Graph Momentenverlauf Stab links 
xSTL=(WerteSTL.*dF)
ySTL=linspace(h,0,dx)
plot(xSTL,ySTL,'r','LineWidth',2)               %Stab-Moment Rechts
plot([0,sum(Ma)*dF],[0,0],'r','LineWidth',2)         %Stab-Moment Ergänzung unten
plot([0,sum(Ml)*dF],[h,h],'r','LineWidth',2)         %Stab-Moment Ergänzung oben
text(sum(Ma)*dF,0,num2str(sum(Ma)))                       %Text unten Ma
text(sum(Ml)*dF,h,num2str(sum(Ml)))                    %Text oben  Ml

%Graph Momentenverlauf Stab rechts
xSTR=b-(WerteSTR.*dF)           
ySTR=linspace(0,h,dx)
plot(xSTR,ySTR,'r','LineWidth',2)               %Stab-Moment Links
plot([b,b-sum(Mb)*dF],[0,0],'r','LineWidth',2)       %Stab-Moment Ergänzung unten
plot([b,b-sum(Mr)*dF],[h,h],'r','LineWidth',2)       %Stab-Moment Ergänzung oben
text(b-sum(Mb)*dF,0,num2str(sum(Mb)))                     %Text unten Mb 
text(b-sum(Mr)*dF,h,num2str(sum(Mr)))                     %Text oben  Mr

%Momentenverlauf Stab oben
ySTO=h-(WerteSTO.*dF)
xSTO=linspace(0,b,length(WerteSTO))
plot(xSTO,ySTO,'r','LineWidth',2)               %Stab-Moment Oben
plot([0,0],[h,h-sum(Ml)*dF],'r','LineWidth',2)       %Stab-Moment Ergänzung Links
plot([b,b],[h,h-sum(Mr)*dF],'r','LineWidth',2)              %Stab-Moment Ergänzung rechts
text(0,h-sum(Ml)*dF,num2str(sum(Ml)))                       %Text unten Ml
text(b,h-sum(Mr)*dF,num2str(sum(Mr)))                       %Text unten Mr
text((find(WerteSTO==max(WerteSTO))/length(WerteSTO))*b...
    ,h-max(WerteSTO)*dF,num2str(max(WerteSTO)))             %Text Max-Moment Mf

%Auflagerkräfte


hold off


else  Anzahlstutzen == 2
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                               ___________             %
%       Variante n=4 mit 3 Stützen             ¦     ¦     ¦            %
%                                                                       %                          
%}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Auflagerkräfte
Av0=(1.-(x./b)).*F
Bv0=(x./b).*F

%Verschiebungsgrössen (Überlagerung der Momente)

a10=0.5.*Av0.*x.*1.*b                               %0 mit 1 Zustand
    
a20=(1/6).*(1+(1-(x./b))).*(Av0.*x).*1.*b           %0 mit 2 Zustand

a30=-a20                                            %0 mit 3 Zustand

for z1=[1:length(F)]
if x(z1)<=(b/2)
    Va40{z1}=(1/12).*((3-4.*((x(z1)./b).^2))/(1-(x(z1)./b))).*(-0.25.*b).*(Av0(z1).*x(z1)).*b
elseif x(z1)>(b/2)                                      %0 mit 4 Zustand 
    Va40{z1}=(1/12).*((3-4.*((1-(x(z1)./b)).^2))/(x(z1)./b)).*(-0.25.*b).*(Av0(z1).*x(z1)).*b
end
end

    a40=zeros(1,length(F))
 for z1=[1:length(F)]
     a40=a40+Va40{z1}                      %Supepositin Stab oben Werte Moment
 end
a11=1*1*1*b+2*((1/3)*1*1*hI)                        %1 mit 1 Zustand

a12=0.5*1*1*b+0.5*1*1*hI                            %1 mit 2 Zustand

a13=(1/3)*1*-1*hI+(1/2)*1*-1*b+(1/6)*1*1*hI         %1 mit 3 Zustand

a14=0.5*(-0.25*b)*1*b                               %1 mit 4 Zustand

a22=(1/3)*1*1*b+1*1*1*hI                            %2 mit 2 Zustand

a23=0.5*1*-1*hI+(1/3)*-1*1*b                        %2 mit 3 Zustand

a24=0.25*(-0.25*b)*1*b                              %2 mit 4 Zustand

a33=(1/3)*-1*-1*hI+(1/3)*-1*-1*b+(1/3)*1*1*hI       %3 mit 3 Zustand

a34=0.25*(-0.25*b)*-1*b                             %3 mit 4 Zustand

a44=(1/3)*(-0.25*b)*(-0.25*b)*b                     %4 mit 4 Zustand

%Matrix der Verschiebungsgrössen [B A] * X = [0;0;0;0]

A=[a11,a12,a13,a14;a12,a22,a23,a24;a13,a23,a33,a34;a14,a24,a34,a44]
B=[-a10;-a20;-a30;-a40]

X=A\B

X1=X(1,:)
X2=X(2,:)
X3=X(3,:)
X4=X(4,:)
%Auflagerkräfte in A
Av=Av0+0*X1+(-1/b)*X2+(1/b)*X3+(-0.5)*X4
Ah=0+(-1/h)*X1+0*X2+(1/h)*X3+0*X4
Ma=0+0*X1+1*X2+0*X3+0*X4

%Auflagerkräfte in B
Bv=Bv0+0*X1+(1/b)*X2+(-1/b)*X3
Bh=0+(1/h)*X1+0*X2+(-1/h)*X3
Mb=0+0*X1+0*X2+1*X3+0*X4

%Auflagerkraft in Stütze
S1v=X4

%Moment bei Stütze in Mitte
if x<(b/2)
   Ms1=((Av0*0.5*b)+(-F*((0.5*b)-x)))+1*X1+(0.5)*X2+(-0.5)*X3+(-0.25*b)*X4
elseif x ==(b/2)
   Ms1=Av0*x+1*X1+(0.5)*X2+(-0.5)*X3+(-0.25*b)*X4
elseif x>(b/2)
   Ms1=Av0*(0.5*b)+1*X1+(0.5)*X2+(-0.5)*X3+(-0.25*b)*X4
end

%Moment bei Kraft
if x<(b/2)
   Mf=Av0*x+1*X1+(1-(x/b))*X2+(1-(x/b))*X3*(-1)+(2*x/b)*(-0.25*b)*X4
elseif x ==(b/2)
   Mf=Msl
elseif x>(b/2)
   Mf=Av0*x+1*X1+(1-(x/b))*X2+(1-(x/b))*X3*(-1)+((1-(x/b))*2)*(-0.25*b)*X4
end

%Schnittkrafte Ecke Links
Ml=0+1.*X1+1.*X2+-1.*X3+0*X4

%Schnittkräfte Ecke Rechts
Mr=0+1.*X1+0.*X2+0.*X3+0*X4


% Werte Moment für Superposition

dx=10                                                   %Teilungsfaktor

WerteSTL=linspace(sum(Ml),sum(Ma),dx)                   %Superposition Stab Links Werte Moment
WerteSTR=linspace(sum(Mb),sum(Mr),dx)                   %Superposition Stab Rechts Werte Moment


                                                                
 for z1=[1:length(F)]
    if x(z1)==0 
    VorWerteSTO{z1}=zeros(1,((b*dx)-2))                         %Momente Stab oben wenn Moment = 0 
    elseif x(z1)<0.5*b            
    xSTOLV{z1}=linspace(Ml(z1),Mf(z1),(x(z1).*dx))                  %Moment Stab oben links von F
    xSTOMV{z1}=linspace(Mf(z1),Ms1(z1),((0.5*b-(x(z1))).*dx))
    xSTORV{z1}=linspace(Ms1(z1),Mr(z1),((0.5*b).*dx))               %Moment Stab oben rechts von F
    VorWerteSTO{z1}=[xSTOLV{z1}(1:end-1),xSTOMV{z1},xSTORV{z1}(2:end)]    %Moment Stab oben links + rechts
    elseif x(z1)==b*0.5 
    VorWerteSTO{z1}=zeros(1,((b*dx)-2))                     %Momente Stab oben wenn Moment = 0 
    elseif x(z1)==b 
    VorWerteSTO{z1}=zeros(1,((b*dx)-2))
    elseif x(z1)>0.5*b            
    xSTOLV{z1}=linspace(Ml(z1),Ms1(z1),((0.5*b).*dx))                   %Moment Stab oben links von F
    xSTOM{z1}V=linspace(Ms1(z1),Mf(z1),((x(z1)-(0.5*b)).*dx))
    xSTORV{z1}=linspace(Mf(z1),Mr(z1),((b-(x(z1))).*dx))                %Moment Stab oben rechts von F
    VorWerteSTO{z1}=[xSTOLV{z1}(1:end-1),xSTOMV{z1},xSTORV{z1}(2:end)]          %Moment Stab oben links + rechts
 
    end
 end
 
    WerteSTO=zeros(1,((b*dx)-2))
 for z1=[1:length(F)]
     WerteSTO=WerteSTO+VorWerteSTO{z1}                      %Supepositin Stab oben Werte Moment
 end
   


% Darstellung Bogen  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot([0,0],[0,h],'k','LineWidth',4)             %Stab Links
hold on
axis equal 
plot([0,b],[h,h],'k','LineWidth',4)             %Stab Oben
plot([b,b],[0,h],'k','LineWidth',4)             %Stab Rechts



dF= (b*0.25)/max(WerteSTO)                   %Darstellungs Faktor (Mmax = 0.25 von Breite)


%Graph Momentenverlauf Stab links 
xSTL=(WerteSTL.*dF)
ySTL=linspace(h,0,dx)
plot(xSTL,ySTL,'r','LineWidth',2)               %Stab-Moment Rechts
plot([0,sum(Ma)*dF],[0,0],'r','LineWidth',2)         %Stab-Moment Ergänzung unten
plot([0,sum(Ml)*dF],[h,h],'r','LineWidth',2)         %Stab-Moment Ergänzung oben
text(sum(Ma)*dF,0,num2str(sum(Ma)))                       %Text unten Ma
text(sum(Ml)*dF,h,num2str(sum(Ml)))                    %Text oben  Ml

%Graph Momentenverlauf Stab rechts
xSTR=b-(WerteSTR.*dF)           
ySTR=linspace(0,h,dx)
plot(xSTR,ySTR,'r','LineWidth',2)               %Stab-Moment Links
plot([b,b-sum(Mb)*dF],[0,0],'r','LineWidth',2)       %Stab-Moment Ergänzung unten
plot([b,b-sum(Mr)*dF],[h,h],'r','LineWidth',2)       %Stab-Moment Ergänzung oben
text(b-sum(Mb)*dF,0,num2str(sum(Mb)))                     %Text unten Mb 
text(b-sum(Mr)*dF,h,num2str(sum(Mr)))                     %Text oben  Mr

%Momentenverlauf Stab oben
ySTO=h-(WerteSTO.*dF)
xSTO=linspace(0,b,length(WerteSTO))
plot(xSTO,ySTO,'r','LineWidth',2)               %Stab-Moment Oben
plot([0,0],[h,h-sum(Ml)*dF],'r','LineWidth',2)       %Stab-Moment Ergänzung Links
plot([b,b],[h,h-sum(Mr)*dF],'r','LineWidth',2)              %Stab-Moment Ergänzung rechts
text(0,h-sum(Ml)*dF,num2str(sum(Ml)))                       %Text unten Ml
text(b,h-sum(Mr)*dF,num2str(sum(Mr)))                       %Text unten Mr
text((find(WerteSTO==max(WerteSTO))/length(WerteSTO))*b...
    ,h-max(WerteSTO)*dF,num2str(max(WerteSTO)))             %Text Max-Moment Mf
text((find(WerteSTO==min(WerteSTO))/length(WerteSTO))*b...
    ,h-min(WerteSTO)*dF,num2str(min(WerteSTO)))             %Text Max-Moment Mf

%Auflagerkräfte


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

























































%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Input Window
prompt = {'Länge:','Breite:', 'Höhe', 'Abstand','Dim'};
dlg_title = 'Input';
num_lines = 1;
defaultans = {'30','20','3','4','0.2'}; % Zahlenwerte können 'zwischen' entfert werden nur platzhalter
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
l= str2num(answer{1});
b= str2num(answer{2});
h= str2num(answer{3});
a= str2num(answer{4});
Dim= str2num(answer{5});
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if b > 13
   SM= (b/2) -(Dim/2);           %Hilfsgrösse% Pos X (also Stützenabstand) der Stüzte. Einmitung auf Achsmass der Stütze

%Stuetze VM
vert3= [SM 0 0; SM Dim 0; (SM+Dim) Dim 0; (SM+Dim) 0 0; (SM+Dim) Dim (h-Dim); (SM+Dim) 0 (h-Dim); SM 0 (h-Dim); SM Dim (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze HM
vert5= [SM (l-Dim) 0; SM l 0; (SM+Dim) l 0; (SM+Dim) (l-Dim) 0; (SM+Dim) l (h-Dim); (SM+Dim) (l-Dim) (h-Dim); SM (l-Dim) (h-Dim); SM l (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert5,'FaceColor','c');            % Erzeugen der Gefärbten Flächen (Polygonen)
end

%Binderi i Stützen und Querbalken
%Aufbau von der Mittea aus um Anfang und Endabstand Binder-Stütze gleich
%gross zu halten
i=-a;
while i <= (l/2)-a;         
      i= i + a;
   XMH = ((l/2)+i-(Dim/2));      %Hilfsgrösse% Achsabstand der Stützen in While Schleife

%Querbalken 
vert9= [Dim XMH (h-Dim); Dim XMH h; Dim (XMH+Dim) h; Dim (XMH+Dim) (h-Dim); (b-Dim) (XMH+Dim) h; (b-Dim) (XMH+Dim) (h-Dim); (b-Dim) XMH (h-Dim); (b-Dim) XMH h]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze A
vert10= [0 XMH 0; 0 (XMH+Dim) 0; Dim (XMH+Dim) 0; Dim XMH 0; Dim (XMH+Dim) (h-Dim); Dim XMH (h-Dim); 0 XMH (h-Dim); 0 (XMH+Dim) (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze B
vert11= [b XMH 0; b (XMH+Dim) 0; (b-Dim) (XMH+Dim) 0; (b-Dim) XMH 0; (b-Dim) (XMH+Dim) (h-Dim); (b-Dim) XMH (h-Dim); b XMH (h-Dim); b (XMH+Dim) (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

if b >13
    %Stuetze VM   
vert3= [SM XMH 0; SM (XMH+Dim) 0; (SM+Dim) (XMH+Dim) 0; (SM+Dim) XMH 0; (SM+Dim) (XMH+Dim) (h-Dim); (SM+Dim) XMH (h-Dim); SM XMH (h-Dim); SM (XMH+Dim) (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Laengstraeger M        %Zur Zeit durchlaufend noch keine unterbrücke bei den
%Sützen oder Binder
vert1= [SM 0 (h-Dim); (SM+Dim) 0 (h-Dim); (SM+Dim) 0 h; SM 0 h; (SM+Dim) l h; SM l h; SM l (h-Dim); (SM+Dim) l (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
fac= [1 2 3 4; 4 3 5 6; 6 7 8 5; 1 2 8 7; 6 7 1 4; 2 3 5 8];    % Welche Eckpunkte werden als eine Polygonfläche eingefärbt
patch('Faces', fac,'Vertices',vert1,'FaceColor','b');            % Erzeugen der Gefärbten Flächen (Polygonen)
end

end
k=l/2;
while k >= a; 
       k= k - a;
   XMV = (k-(Dim/2));           %Hilfsgrösse% Achsabstand der Stütze in While Schleife

%Querbalken 
vert9= [Dim XMV (h-Dim); Dim XMV h; Dim (XMV+Dim) h; Dim (XMV+Dim) (h-Dim); (b-Dim) (XMV+Dim) h; (b-Dim) (XMV+Dim) (h-Dim); (b-Dim) XMV (h-Dim); (b-Dim) XMV h]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert9,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze A
vert10= [0 XMV 0; 0 (XMV+Dim) 0; Dim (XMV+Dim) 0; Dim XMV 0; Dim (XMV+Dim) (h-Dim); Dim XMV (h-Dim); 0 XMV (h-Dim); 0 (XMV+Dim) (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert10,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

%Stuetze B
vert11= [b XMV 0; b (XMV+Dim) 0; (b-Dim) (XMV+Dim) 0; (b-Dim) XMV 0; (b-Dim) (XMV+Dim) (h-Dim); (b-Dim) XMV (h-Dim); b XMV (h-Dim); b (XMV+Dim) (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert11,'FaceColor','y');            % Erzeugen der Gefärbten Flächen (Polygonen)

if b >13
    %Stuetze VM
vert3= [SM XMV 0; SM (XMV+Dim) 0; (SM+Dim) (XMV+Dim) 0; (SM+Dim) XMV 0; (SM+Dim) (XMV+Dim) (h-Dim); (SM+Dim) XMV (h-Dim); SM XMV (h-Dim); SM (XMV+Dim) (h-Dim)]; % [x y z] Eckpunkte der Träger in Vektorschreibweise
patch('Faces', fac,'Vertices',vert3,'FaceColor','c');            % Erzeugen der Gefärbten Flächen (Polygonen)
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Aussteifungen Kreuzverband Dach

%Aussteifungen Kreuzverband Wand Y=0

%Aussteifungen Kreuzverband Wand Y=l

