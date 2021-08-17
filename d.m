function d(destino,filename,filecreat)
clc
aux='\';
filename=strcat(destino,aux,filename);
[RF,TB,Y,def,PI]=read_ta(filename);
[lin,col,tam]=size(Y);

filename_template='results.xls';
filename_template_geracao='geracao.xls';
filecreat=strcat(destino,filecreat);


    if tam==3
        [T,Tr,Mc,V,Vbarras]=Modify_ta(Y(:,:,1),Y(:,:,2),Y(:,:,3),PI,TB,RF,def);
        
        copyfile(filename_template,filecreat);
        writetable(Mc,filecreat,'sheet','MCC');
        writetable(T,filecreat,'sheet','CURTO');
        writetable(Tr,filecreat,'sheet','CURTO','Range','I1');
        writetable(Vbarras,filecreat,'sheet','CFA');
        winopen(filecreat);
    end
    if tam==4
        %fprintf('\n ------- COM TRANSITÓRIO -------------- \n')
        Positiva(:,:,1)=Y(:,:,4);Positiva(:,:,2)=Y(:,:,1);
        [T,Tr,Mc,V,Vbarras]=Modify_ta(Positiva,Y(:,:,2),Y(:,:,3),PI,TB,RF,def);        
        copyfile(filename_template,filecreat);
        writetable(Mc,filecreat,'sheet','MCC');
        writetable(T,filecreat,'sheet','CURTO');
        writetable(Tr,filecreat,'sheet','CURTO','Range','I1');
        writetable(Vbarras,filecreat,'sheet','CFA');
        winopen(filecreat);

    end
    if tam>=7
        copyfile(filename_template_geracao,filecreat);
        Positiva(:,:,1)=Y(:,:,4);Positiva(:,:,2)=Y(:,:,1);
        [Tg,Trg,Mcg,V,Vbarras]=Modify_ta(Positiva,Y(:,:,2),Y(:,:,3),PI,TB,RF,def);        
        writetable(Mcg,filecreat,'sheet','MCC-CONTRIBUIÇÃO GD');
        writetable(Tg,filecreat,'sheet','CURTO-CONTRIBUIÇÃO GD');
        writetable(Trg,filecreat,'sheet','CURTO-CONTRIBUIÇÃO GD','Range','I1');
        writetable(Vbarras,filecreat,'sheet','Vbarras-CONTRIBUIÇÃO GD');
        
        [T,Tr,Mc,V,Vbarras1]=Modify_ta(Y(:,:,5),Y(:,:,6),Y(:,:,7),PI,TB,RF,def);        

        writetable(Mc,filecreat,'sheet','MCC');
        writetable(T,filecreat,'sheet','CURTO');
        writetable(Tr,filecreat,'sheet','CURTO','Range','I1');
        writetable(T,filecreat,'sheet','CURTO');
        writetable(Vbarras1,filecreat,'sheet','Vbarras');
        
        winopen(filecreat);

    
    end
   
    

end