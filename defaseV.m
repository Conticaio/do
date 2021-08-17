function [Vax]=defaseV(V,Y,def_ang)
    clc
    j=sqrt(-1);
    Vax=V;
    tr=length(def_ang);
    tam=length(Y);
         t=def_ang;
         for p=1:tr
              if t(p)~=0
                 [aux_r,aux_j]=pol2cart(deg2rad(def_ang(p)),1);
                 aux=aux_r+aux_j*j;             
                    
                 Vdef=V(p:tam,p:tam);
                 ax_ydef=Y(p:tam,p)~=0;
                 
                 ax_ydef=ax_ydef*aux;
                 Mdef=diag(ax_ydef);

                 Vdef=Vdef*Mdef;
                 Vax(p:tam,p:tam)=Vdef;
              end
         end

end