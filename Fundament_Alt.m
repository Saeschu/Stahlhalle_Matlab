   bf=((MaT+(AhT*hf))/AvT)*6   %Breite aufgrund von Kernpunkt
if bf>0.4          %Mindesbreite
     bf=          
else bf=((MaT+(AhT*hf))/AvT)*6 %gr�sser als Mindesbreite
end

tf=(2*AvT)/(o2*bf)      %L�nge aufgrund Einwirkung
if tf<=0.4              %Mindesl�nge
    tf=0.4
else tf=(2*AvT)/(o2*bf)      %L�nge aufgrund Einwirkung
end