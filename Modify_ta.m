function [T,Tr,Mc,V,Vbarras]=Modify_ta(Positiva,Negativa,Zero, PontoInteresse,Tensao_Base,RF,def) 
    tb=Tensao_Base;
    Potbase=100*1e6;
    PI=PontoInteresse;
    %RF=40*Potbase/tb(1)^2;
    po=size(Positiva);
     p3d=length(po);
       
    if p3d==3
        [Zt,Yt]=tryharder_def(Positiva(:,:,1),Negativa,Zero,def);
        [Z,Y]=tryharder_def(Positiva(:,:,2),Negativa,Zero,def);
        [V,Id,Z1f,Z1fm]=CCgeral(Z,RF,Y,def);
        [Vt,Idt,Z1ft,Z1fmt]=CCgeral(Zt,RF,Y,def);
        [Mcc]=mcc(V,Y);     
        [Mcct]=mcc(Vt,Yt);
        [T,Tr,Mc,Vbarras]=relatoriot_Mod(Id,Idt,Mcc,Mcct,PI,tb,Z,Zt,Vt,Y);
     else
        
        [Z,Y]=tryharder_def(Positiva,Negativa,Zero,def);    
        [V,Id,Z1f,Z1fm]=CCgeral(Z,RF,Y,def);
        [Mcc]=mcc(V,Y);     
        [T,Tr,Mc,Vbarras]=relatorio_Mod(Id,Mcc,PI,tb,Z,V,Y);   
    end



end