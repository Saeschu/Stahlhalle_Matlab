function mygui()
f= figure(1)
set(f,'NumberTitle', 'off', 'Name', sprintf('Date: %s', datestr(now, 0)))
%title (' Input Window Lagerhalle ')

%Eingabe Länge [left bottom width height]

txtLaenge = uicontrol('Style','text',...
        'Position',[10 367 120 20],...
        'String','Länge [m]'); 
EditLaenge = uicontrol('style','edit',...
            'units','pixels',...
             'position',[105 367 100 25])       
%Eingabe Breite
        
txtBreit = uicontrol('Style','text',...
        'Position',[10 337 120 20],...
        'String','Breite [m]'); 
EditBreite = uicontrol('style','edit',...
            'units','pixels',...
            'position',[105 337 100 25])
%Eingabe Höhe

txtHoehe = uicontrol('Style','text',...
        'Position',[10 307 120 20],...
        'String','Höhe [m]'); 
EditHoehe = uicontrol('style','edit','position',[105 307 100 25])  
            

%Eingabe Binderabstand
txtBabst = uicontrol('Style','text',...
        'Position',[0 277 120 20],...
        'String','Binderabstand [m]'); 
EditBabst = uicontrol('style','edit',...
            'units','pixels',...
            'position',[105 277 100 25])
%Eingabe Bauteildimension
txtBabst = uicontrol('Style','text',...
        'Position',[0 245 120 20],...
        'String','Profiel Träger'); 
DdownBauDimT= uicontrol('Style', 'popup',...
             'String', {'IPE200', 'IPE220', 'IPE240', 'IPE270', 'HEA200', 'HEA220', 'HEA240', 'HEA260'},...
             'Position', [105 247 100 20],'background','w');
         
txtBabst = uicontrol('Style','text',...
        'Position',[0 220 120 20],...
        'String','Profiel Stütze'); 
DdownBauDimS= uicontrol('Style', 'popup',...
             'String', {'IPE200', 'IPE220', 'IPE240', 'IPE270', 'HEA200', 'HEA220', 'HEA240', 'HEA260'},...
             'Position', [105 220 100 20],'background','w');
% Festlegung ob Hallenhöe unter oder oberkannte Balken
txtBedH = uicontrol('Style','text',...
        'Position',[300 245 120 20],...
        'String','Profiel Träger'); 
DdownBedH= uicontrol('Style', 'popup',...
             'String', {'Oberkannte', 'Unterkannte'},...
             'Position', [405 247 100 20],'background','w');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
%Matrix    %[Höhe Breite Iy]
element= [0.2 0.1 19.4e6;...        %IPE200
          0.22 0.11 27.7e6;...      %IPE220
          0.24 0.12 38.9e6;...      %IPE240
          0.27 0.135 57.9e6;...     %IPE270
          0.2 0.19 36.9e6;...       %HEA200
          0.22 0.21 54.1e6;...      %HEA220
          0.24 0.23 77.6e6;...      %HEA240
          0.26 0.25 104.5e6]        %HEA260
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
%Übernahme Input        
%Editfield
l= (str2num(get(EditLaenge, 'String')))
b= (str2num(get(EditBreite, 'string')))
h= (str2num(get(EditHoehe, 'String')))
a= (str2num(get(EditBabst, 'String')))


%Inpunt dropdown Profiele
ProfS= get(DdownBauDimS, 'Value') %Profiel Stütze
ProfSb= element(ProfS, 1) 
ProfSt= element(ProfS, 2)
IS= element(ProfS, 3)

ProfT= get(DdownBauDimT, 'Value') %Profiel Träger
ProfTh= element(ProfT, 1) 
ProfTb= element(ProfT, 2)
IT= element(ProfT, 3)

BedH= get(DdownBedH, 'Value')  % oberkannte oder Unterkannte 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            

        end
    
        end
        
        

        
        
        
