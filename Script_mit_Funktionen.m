%Ablauf:

%   - Lagerhalle_Darstellung 3d mit Eingabe Fenster run
%   - Abst�ende Rhamen u Pfetten f�r Simon 

%AZB=2
%ba=20
%h=6
%hI=6

%-> diese 4 Werte kommen aus Lagerhalle Darstellung 3d




[ Auflagermatrix_1, MMX_1,QMX_1,NMX_1 ] = Funktion_Berechnung_Stahlhalle( 1,AZB,EinwirkungenaufRahmen,ba,h,hI )

[ Auflagermatrix_2, MMX_2,QMX_2,NMX_2 ] = Funktion_Berechnung_Stahlhalle( 2,AZB,EinwirkungenaufRahmen,ba,h,hI )


%   - Berechnung Fundamente


Funktion_Darstellung_2d_Stahlhalle( 1,AZB,ba,h,MMX_1,QMX_1,NMX_1 )