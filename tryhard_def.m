	function[Y] = tryhard_def(R,def_ang)
        tam=max(max(R(:,1),R(:,2)));
		Y=zeros(tam);
		[lin,col]=size(R);
        for i=1:lin     %Varre R
            if R(i,1)~=R(i,2)
               Y(R(i,1),R(i,2))=-1/R(i,3);
               Y(R(i,2),R(i,1))=Y(R(i,1),R(i,2));
            end
        end
        
        for c=1:tam
            ax_soma=0;
            for l=1:tam
                ax_soma=ax_soma+Y(l,c);
            end
            Y(c,c)=-ax_soma;
        end
        
          for i=1:lin     %Varre R
            if R(i,1)==R(i,2)
                 Y(R(i,1),R(i,1))=Y(R(i,1),R(i,1))+1/R(i,3);
            end
          end
         %% Defasando 
%          tr=length(def_ang);
%          t=def_ang;
%          for p=1:tr
%               if t(p)~=0
%                  [aux_r,aux_j]=pol2cart(deg2rad(def_ang(p)),1);
%                  aux=aux_r+aux_j*j;             
%                     
%                  ydef=Y(p:tam,p:tam);
%                  ax_ydef=Y(p:tam,p)~=0;
%                  ax_ydef=ax_ydef*aux;
%                  Mdef=diag(ax_ydef); ax_M=length(Mdef);
%                  for w=1:ax_M
%                     if abs(Mdef(w,w))==0
%                         Mdef(w,w)=1;
%                     end
%                  end
%                  ydef=ydef*Mdef;
%                  Y(p:tam,p:tam)=ydef;
%              end
%          end

    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    