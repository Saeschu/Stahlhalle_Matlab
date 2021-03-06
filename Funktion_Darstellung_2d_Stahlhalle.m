function [ figure(K) ] = Funktion_Darstellung_2d_Stahlhalle( K,AZB,ba,h,MMX,QMX,NMX )
%Darstellung der Resultate in 2D
%   Input:
%

%Werte Raphael für Fundament in Input hinzufügen

%Problem von Simon noch zu lösen: 
%wie erkennt Funktion ob zum Beispiel: MMX = MMX_1 oder MMX_2 -> mit MMX_ und dann der Wert von K



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
else AZB == 3
NSupS2=NMX{5} 
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Darstellung Bogen  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(K)

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
plot([0.5*ba,0.5*ba],[-2.5,-1.5],'Color',[0.19 0.19 0.19],'LineWidth',1)        %Bemassung Hilfslinie Stütze 1 (Breite) Grau    
text(ba*0.25,-1,(num2str(roundn(0.5*ba,-2))),'Color',[0.19 0.19 0.19])       %Wert Bemassung (Breite) (Breite !!ba!! -> muss b sein) Grau
text(ba*0.75,-1,(num2str(roundn(0.5*ba,-2))),'Color',[0.19 0.19 0.19])       %Wert Bemassung (Breite) (Breite !!ba!! -> muss b sein) Grau
else AZB == 3
plot([(1/3)*ba,(1/3)*ba],[-2.5,-1.5],'Color',[0.19 0.19 0.19],'LineWidth',1)        %Bemassung Hilfslinie Stütze 1 (Breite) Grau
plot([(2/3)*ba,(2/3)*ba],[-2.5,-1.5],'Color',[0.19 0.19 0.19],'LineWidth',1)        %Bemassung Hilfslinie Stütze 2 (Breite) Grau
text(ba*(1/3),-1,(num2str(roundn((1/3)*ba,-2))),'Color',[0.19 0.19 0.19])       %Wert Bemassung (Breite) (Breite !!ba!! -> muss b sein) Grau
text(ba*(1/3),-1,(num2str(roundn((1/3)*ba,-2))),'Color',[0.19 0.19 0.19])       %Wert Bemassung (Breite) (Breite !!ba!! -> muss b sein) Grau
text(ba*0.5,-1,(num2str(roundn((1/3)*ba,-2))),'Color',[0.19 0.19 0.19])       %Wert Bemassung (Breite) (Breite !!ba!! -> muss b sein) Grau
end
plot([ba+2,ba+2],[-0.5,h+0.5],'Color',[0.19 0.19 0.19],'LineWidth',1)      %Bemassung Linie (Höhe) Grau
plot([ba+1.5,ba+2.5],[0,0],'Color',[0.19 0.19 0.19],'LineWidth',1)          %Bemassung Hilfslinie rechts (Höhe) Grau
plot([ba+1.5,ba+2.5],[h,h],'Color',[0.19 0.19 0.19],'LineWidth',1)        %Bemassung Hilfslinie links (Höhe) Grau
text(ba+1,h*0.5,(num2str(roundn(h,-2))),'Color',[0.19 0.19 0.19])                  %Wert Bemassung (Höhe) (Breite !!h!! -> muss ... sein) Grau
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
plot([0,MSupSL(end)*dM],[0,0],'r','LineWidth',2)         %Stab-Moment Ergänzung unten
plot([0,MSupSL(1)*dM],[h,h],'r','LineWidth',2)         %Stab-Moment Ergänzung oben
text((MSupSL(end)*dM),-1,num2str(roundn(MSupSL(end),-2)))  %Text unten Ma !!! Wert -1 !!

%Momentenverlauf Stab rechts
MxSR=ba-(MSupSR.*dM)           
MySR=linspace(0,h,3)
plot(MxSR,MySR,'r','LineWidth',2)                      %Stab-Moment Links
plot([ba,ba-MSupSR(1)*dM],[0,0],'r','LineWidth',2)       %Stab-Moment Ergänzung unten
plot([ba,ba-MSupSR(end)*dM],[h,h],'r','LineWidth',2)       %Stab-Moment Ergänzung oben
text((ba-MSupSR(1)*dM)-4,-1,num2str(roundn(MSupSR(1),-2)))   %Text unten Mb !!! Wert -4&-1 !!! 

%Momentenverlauf Stab oben
MySO=h-(MSupSO.*dM)
MxSO=linspace(0,ba,length(MSupSO))
plot(MxSO,MySO,'r','LineWidth',2)                       %Stab-Moment Oben
plot([0,0],[h,h-MSupSL(1)*dM],'r','LineWidth',2)          %Stab-Moment Ergänzung Links
plot([ba,ba],[h,h-MSupSR(end)*dM],'r','LineWidth',2)        %Stab-Moment Ergänzung rechts
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
plot([0,VSupSL*dV],[0,0],'b','LineWidth',2)                      %Querkraft Stab links Ergänzunglinie unten
plot([0,VSupSL*dV],[h,h],'b','LineWidth',2)                      %Querkraft Stab links Ergänzunglinie oben
text(VSupSL*dV,h*0.5,num2str(roundn(VSupSL,-2)))             %Text Stab Links !!!  !!!

%Querkraftverlauf Stab Rechts
plot([ba-VSupSR*dV,ba-VSupSR*dV],[0,h],'b','LineWidth',2)            %Querkraft Stab links
plot([ba,ba-VSupSR*dV],[0,0],'b','LineWidth',2)                      %Querkraft Stab links Ergänzunglinie unten
plot([ba,ba-VSupSR*dV],[h,h],'b','LineWidth',2)                      %Querkraft Stab links Ergänzunglinie oben
text(ba-VSupSR*dV,h*0.5,num2str(roundn(VSupSR,-2)))             %Text Stab Links !!!  !!!

%Querkraftverlauf Stab oben
VySO=h-(VSupSO.*dV)
VxSO=linspace(0,ba,length(VSupSO))
plot(VxSO,VySO,'b','LineWidth',2)                   %Querkraft Stab oben
plot([0,0],[h,VySO(1)],'b','LineWidth',2)           %Querkraft Stab oben Ergänzungslinie links
plot([ba,ba],[h,VySO(end)],'b','LineWidth',2)       %Querkraft Stab oben Ergänzungslinie rechts
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
plot([0,-NSupSL*dN],[0,0],'g','LineWidth',2)                     %Normalkraft Stab links Ergänzunglinie unten
plot([0,-NSupSL*dN],[h,h],'g','LineWidth',2)                     %Normalkraft Stab links Ergänzunglinie oben
text(-NSupSL*dN,h*0.5,num2str(roundn(NSupSL,-2)))                %Text Stab Links !!!  !!!

%Normalkraftverlauf Stab Rechts
plot([ba-NSupSR*dN,ba-NSupSR*dN],[0,h],'g','LineWidth',2)            %Normalkraft Stab rechts
plot([ba,ba-NSupSR*dN],[0,0],'g','LineWidth',2)                      %Normalkraft Stab rechts Ergänzunglinie unten
plot([ba,ba-NSupSR*dN],[h,h],'g','LineWidth',2)                      %Normalkraft Stab rechts Ergänzunglinie oben
text(ba-NSupSR*dN,h*0.5,num2str(roundn(NSupSR,-2)))                  %Text Stab Links !!!  !!!

%Querkraftverlauf Stab Mitte
if AZB==2
plot([(1/AZB)*ba-NSupS1*dN,(1/AZB)*ba-NSupS1*dN],[0,h],'g','LineWidth',2)            %Normalkraft Stab rechts
plot([(1/AZB)*ba,(1/AZB)*ba-NSupS1*dN],[0,0],'g','LineWidth',2)                      %Normalkraft Stab rechts Ergänzunglinie unten
plot([(1/AZB)*ba,(1/AZB)*ba-NSupS1*dN],[h,h],'g','LineWidth',2)                      %Normalkraft Stab rechts Ergänzunglinie oben
text((1/AZB)*ba-NSupS1*dN,h*0.5,num2str(roundn(NSupS1,-2)))                  %Text Stab Links !!!  !!!
elseif AZB==3
    
end
%Normalkraftverlauf Stab oben
plot([0,ba],[h+NSupSO*dN,h+NSupSO*dN],'g','LineWidth',2)            %Normalkraft Stab oben
plot([0,0],[h,h+NSupSO*dN],'g','LineWidth',2)                      %Normalkraft Stab oben Ergänzunglinie unten
plot([ba,ba],[h,h+NSupSO*dN],'g','LineWidth',2)                      %Normalkraft Stab oben Ergänzunglinie oben
text(ba*0.5,h+NSupSR*dN,num2str(roundn(NSupSO,-2)))                  %Text Stab Links !!!  !!!

hold off
end

