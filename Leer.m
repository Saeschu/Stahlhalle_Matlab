AZB=3
bf= 2
ba=2

if AZB==1 & bf >= ba
    msgbox('Fundamente werden sich �berschneiden,w�hlen Sie ein st�rkeres Profil oder eine kleinere Last.',...
        'Infobox')
    return
    
elseif AZB==2 & bf >= (ba/2)
    msgbox('Fundamente werden sich �berschneiden,w�hlen Sie ein st�rkeres Profil oder eine kleinere Last.',...
        'Infobox')
    return 
end
   


msgbox('halloo idiot')