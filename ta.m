	function[] = ta(Positiva,Negativa,Zero, PontoInteresse,Tensao_Base,RF)
    tb=Tensao_Base;
    Potbase=100*1e6;
    PI=PontoInteresse;
    %RF=40*Potbase/tb(1)^2;
    po=size(Positiva);
     p3d=length(po);
       
    if p3d==3
        [Zt,Yt]=tryharder(Positiva(:,:,1),Negativa,Zero);
        [Z,Y]=tryharder(Positiva(:,:,2),Negativa,Zero);
        [V,Id]=CCgeral(Z,RF);
        [Vt,Idt]=CCgeral(Zt,RF);
        [Mcc]=mcc(V,Y);     
        [Mcct]=mcc(Vt,Yt);     
        relatoriot(Id,Idt,Mcc,Mcct,PI,tb);
     else
        
        [Z,Y]=tryharder(Positiva,Negativa,Zero);    
        [V,Id,Z1f,Z1fm]=CCgeral(Z,RF);
        [Mcc]=mcc(V,Y);     
        relatorio(Id,Mcc,PI,tb,Z);   
     end
   
    
    end