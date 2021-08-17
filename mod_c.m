function [Aj_Curva] = mod_c(Ipkp,Curva, Mult, Add)
[l,c]=size(Curva);
Aj_Curva=ones(l,c);
Aj_Curva(:,1)=Ipkp*Curva(:,1);
Aj_Curva(:,2)=Mult*Curva(:,2);
Aj_Curva(:,2)=Add+Aj_Curva(:,2);

end