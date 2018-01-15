%Ablauf:

%   - Lagerhalle_Darstellung 3d mit Eingabe Fenster run
%   - Abstäende Rhamen u Pfetten für Simon 

%AZB=2
%ba=20
%h=6
%hI=6

%-> diese 4 Werte kommen aus Lagerhalle Darstellung 3d




[ Auflagermatrix, MMX,QMX,NMX ] = Funktion_Berechnung_Stahlhalle( 1,AZB,EinwirkungenaufRahmen,ba,h,hI )

[ figure(1) ] = Funktion_Darstellung_2d_Stahlhalle( 1,AZB,ba,h,MMX,QMX,NMX )

[ Auflagermatrix, MMX,QMX,NMX ] = Funktion_Berechnung_Stahlhalle( 2,AZB,EinwirkungenaufRahmen,ba,h,hI )

[ figure(2) ] = Funktion_Darstellung_2d_Stahlhalle( 2,AZB,ba,h,MMX,QMX,NMX )

%   - Berechnung Fundamente

%{
Funktion_Darstellung_2d_Stahlhalle( 1,AZB,ba,h,MMX_1,QMX_1,NMX_1 )
Funktion_Darstellung_2d_Stahlhalle( 2,AZB,ba,h,MMX_2,QMX_2,NMX_2 )
%}