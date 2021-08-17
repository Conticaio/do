	function[Z,Y] = tryharder_def(y_1,y_2,y_0,def_ang)
        %função que retorna as Matrizes de Admitâcia e Impedância do sistema, prevendo barra fictícia. 
        %falta: defasador de trafo
    
        %% Readequando as Matrizes y1,y2,y0
        ax_0=isnan(y_0);
        ax_1=isnan(y_1);
        ax_2=isnan(y_2);
        [lin,col]=size(y_0);
        happen_y0=true;
        happen_y1=true;
        happen_y2=true;
        for q=1:lin
        
            if ax_0(q,1) && happen_y0
                ax_y0=y_0(1:q-1,1:3);
                y0(:,:)=ax_y0;
                happen_y0=false;
            end
        
            if ax_1(q,1) && happen_y1
                ax_y1=y_1(1:q-1,1:3);
                y1(:,:)=ax_y1;
                happen_y1=false;
            end
        
            if ax_2(q,1) && happen_y2
                ax_y2=y_2(1:q-1,1:3);
                y2(:,:)=ax_y2;
                happen_y2=false;
            end
        
        end
        
        if happen_y0
            y0=y_0;
        end
        if happen_y1
            y1=y_1;
        end
        if happen_y2
            y2=y_2;
        end

        y0;
        y1;
        y2;
        
        
         %% Seq. Positiva

    Y1=tryhard_def(y1,def_ang);
    
        %% Seq. Neg

    Y2=tryhard_def(y2,-def_ang);

        %% Seq. Zero

    Y0=tryhard(y0);

    %% Ajuste Barra fictícia.
    
        Z1=inv(Y1);Z2=inv(Y2);Z0=inv(Y0);
         
        nbar=length(Z1);
        nfic=length(Z0);
        
        if nbar~=nfic
            for p=nbar+1:nfic
                Z1(p,p)=1e6;
                Z2(p,p)=1e6;
            end
            
            
        end
        
    Z(:,:,1)=Z1;Z(:,:,2)=Z2;Z(:,:,3)=Z0;         
    Y(:,:,1)=inv(Z1);Y(:,:,2)=inv(Z2);Y(:,:,3)=inv(Z0);
    
    for z=1:3
        for y=1:nfic
            for x=1:nfic
                if abs(Y(x,y,z))<1e-6
                    Y(x,y,z)=0;
                end
            end
        end
        
    end
    

    
    end