function [RF,TB,Yx,def_ang,PI]=read_ta(filename) 
file=filename;
num=xlsread(file,'ligacoes');      
relevant=isfinite(num);
[l,c]=size(num);

%% Informaçoes

    PI=num(1:l,6);
    for p=1:l
        if ~relevant(p,6)
            PI(p)=0;
        end
    end
    [a,b,d]=find(PI);
    PI=d;

    %y1-10,y2-15,y0-20,y11-25 e y1-30,y2-35,y0-40,y11-45
   cont=1; 
   for q=11:5:c
        if relevant(1,10)
            Y(:,:,cont)=num(1:l,q-3:q);
            cont=cont+1;
        end
   end
   
   
    Y(:,3,:)=Y(:,3,:)+j*Y(:,4,:);
    Yx=Y(:,1:3,:);

    RF=num(1,5);
    TB=num(1:l,2:3);  
    for p=1:l
        if ~relevant(p,3)
            TB(p,2)=0;
        end
        if ~relevant(p,2)
            TB(p,1)=0;
        end
        
    end
    tam_y=max(max(Y(:,1,3),Y(:,2,3)));
    TB=TB(1:tam_y,:);
    
    def_ang=num(1:tam_y,4);
    
    for p=1:tam_y
        if ~relevant(p,4)
            def_ang(p)=0;
        end
    end
end