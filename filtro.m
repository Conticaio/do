%Filtro de Salto Vetor de 2, 3 e 4 Od.
[l,c]=size(Salt);
for axw_c=1:caso-1
    for i= 1:l-3
        if abs(Salt(i,axw_c)-Salt(i+2,axw_c))<0.5
            if abs(Salt(i,axw_c)-Salt(i+1,axw_c))>100
                Salt(i+1,axw_c)=Salt(i,axw_c);
            end
        end
        if abs(Salt(i,axw_c)-Salt(i+3,axw_c))<0.5
            if abs(Salt(i,axw_c)-Salt(i+1,axw_c))>100
                Salt(i+1,axw_c)=Salt(i,axw_c);
                Salt(i+3,axw_c)=Salt(i,axw_c);
            end
        end
    end
end
