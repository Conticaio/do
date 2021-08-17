function [Vbarras]=Tensoes(V,mcc,TB,Y) 

jj=sqrt(-1);
alph=exp(jj*+2*pi/3);
A=[1 1 1; 1 alph^2 alph;1 alph alph^2];
cnt=1;
nbar=length(V(:,:,1));

    for k=1:nbar %representa o Local da Falta
%         mcc(:,:,k,1)
        I3cc=Y(:,:,1)*(1+V(:,k,1));
        I0=upperM(mcc(:,:,k,4));
        I1=upperM(mcc(:,:,k,2));
        I2=upperM(mcc(:,:,k,3));
        I0m=upperM(mcc(:,:,k,7));
        I1m=upperM(mcc(:,:,k,5));
        I2m=upperM(mcc(:,:,k,6));
        
        
        for i=1:nbar %representa a Barra analisada
            VB=TB(i,1)/sqrt(3);
            IB=100e6/(TB(i,1)*sqrt(3));
            
            for p=1:4 %representa o TIPO da Falta
                
                if p==1
                    Vs=[0;1+V(i,k,1);0];
                    Vf=A*Vs;

                    Is=[0;I3cc(i);0];
                    If=A*Is;
                    
                    falta(1,cnt)=k;
                    Barra(1,cnt)=i;
                    tipo(1,cnt)={'I3F'};
                    Vfname(1,cnt)={'Va'};
                    Vfm(1,cnt)=abs(Vf(1))*VB; 
                    Vfang(1,cnt)=radtodeg(angle(Vf(1)));
                    Vsname(1,cnt)={'V0'};
                    Vsm(1,cnt)=abs(Vs(1))*VB;
                    Ifname(1,cnt)={'Ia'};
                    Ifm(1,cnt)=abs(If(1))*IB;
                    Ifang(1,cnt)=radtodeg(angle(If(1)));
                    Isname(1,cnt)={'I0'};
                    Ism(1,cnt)=abs(Is(1))*IB;
                    cnt=cnt+1;
                
                    falta(1,cnt)=k;
                    Barra(1,cnt)=i;
                    tipo(1,cnt)={'I3F'};
                    Vfname(1,cnt)={'Vb'};
                    Vfm(1,cnt)=abs(Vf(2))*VB; 
                    Vfang(1,cnt)=radtodeg(angle(Vf(2)));
                    Vsname(1,cnt)={'V1'};
                    Vsm(1,cnt)=abs(Vs(2))*VB;
                    Ifname(1,cnt)={'Ib'};
                    Ifm(1,cnt)=abs(If(2))*IB;
                    Ifang(1,cnt)=radtodeg(angle(If(2)));
                    Isname(1,cnt)={'I1'};
                    Ism(1,cnt)=abs(Is(2))*IB;
                    cnt=cnt+1;
     
                    falta(1,cnt)=k;
                    Barra(1,cnt)=i;
                    tipo(1,cnt)={'I3F'};
                    Vfname(1,cnt)={'Vc'};
                    Vfm(1,cnt)=abs(Vf(3))*VB; 
                    Vfang(1,cnt)=radtodeg(angle(Vf(3)));
                    Vsname(1,cnt)={'V2'};
                    Vsm(1,cnt)=abs(Vs(3))*VB;
                    Ifname(1,cnt)={'Ic'};
                    Ifm(1,cnt)=abs(If(3))*IB;
                    Ifang(1,cnt)=radtodeg(angle(If(3)));
                    Isname(1,cnt)={'I2'};
                    Ism(1,cnt)=abs(Is(3))*IB;
                    cnt=cnt+1;
     
                end
                if p==2 %TIPO I1F
                    Vs=[V(i,k,4);1+V(i,k,2);V(i,k,3)];
                    Vf=A*Vs;
                    Is=[I0(i);I1(i);I2(i)];
                    If=A*Is;

                    
                    falta(1,cnt)=k;
                    Barra(1,cnt)=i;
                    tipo(1,cnt)={'I1F'};
                    Vfname(1,cnt)={'Va'};
                    Vfm(1,cnt)=abs(Vf(1))*VB; 
                    Vfang(1,cnt)=radtodeg(angle(Vf(1)));
                    Vsname(1,cnt)={'V0'};
                    Vsm(1,cnt)=abs(Vs(1))*VB;
                    Ifname(1,cnt)={'Ia'};
                    Ifm(1,cnt)=abs(If(1))*IB;
                    Ifang(1,cnt)=radtodeg(angle(If(1)));
                    Isname(1,cnt)={'I0'};
                    Ism(1,cnt)=abs(Is(1))*IB;
                    cnt=cnt+1;
                
                    falta(1,cnt)=k;
                    Barra(1,cnt)=i;
                    tipo(1,cnt)={'I1F'};
                    Vfname(1,cnt)={'Vb'};
                    Vfm(1,cnt)=abs(Vf(2))*VB; 
                    Vfang(1,cnt)=radtodeg(angle(Vf(2)));
                    Vsname(1,cnt)={'V1'};
                    Vsm(1,cnt)=abs(Vs(2))*VB;
                    Ifname(1,cnt)={'Ib'};
                    Ifm(1,cnt)=abs(If(2))*IB;
                    Ifang(1,cnt)=radtodeg(angle(If(2)));
                    Isname(1,cnt)={'I1'};
                    Ism(1,cnt)=abs(Is(2))*IB;
                    cnt=cnt+1;
     
                    falta(1,cnt)=k;
                    Barra(1,cnt)=i;
                    tipo(1,cnt)={'I1F'};
                    Vfname(1,cnt)={'Vc'};
                    Vfm(1,cnt)=abs(Vf(3))*VB; 
                    Vfang(1,cnt)=radtodeg(angle(Vf(3)));
                    Vsname(1,cnt)={'V2'};
                    Vsm(1,cnt)=abs(Vs(3))*VB;
                    Ifname(1,cnt)={'Ic'};
                    Ifm(1,cnt)=abs(If(3))*IB;
                    Ifang(1,cnt)=radtodeg(angle(If(3)));
                    Isname(1,cnt)={'I2'};
                    Ism(1,cnt)=abs(Is(3))*IB;
                    cnt=cnt+1;
                    
                end
                if p==3 %TIPO I1Fm
                    Vs=[V(i,k,7);1+V(i,k,5);V(i,k,6)];                    
                    Vf=A*Vs;
                    Is=[I0m(i);I1m(i);I2m(i)];
                    If=A*Is;

                    
                    falta(1,cnt)=k;
                    Barra(1,cnt)=i;
                    tipo(1,cnt)={'I1Fm'};
                    Vfname(1,cnt)={'Va'};
                    Vfm(1,cnt)=abs(Vf(1))*VB; 
                    Vfang(1,cnt)=radtodeg(angle(Vf(1)));
                    Vsname(1,cnt)={'V0'};
                    Vsm(1,cnt)=abs(Vs(1))*VB;
                    Ifname(1,cnt)={'Ia'};
                    Ifm(1,cnt)=abs(If(1))*IB;
                    Ifang(1,cnt)=radtodeg(angle(If(1)));
                    Isname(1,cnt)={'I0'};
                    Ism(1,cnt)=abs(Is(1))*IB;
                    cnt=cnt+1;
                
                    falta(1,cnt)=k;
                    Barra(1,cnt)=i;
                    tipo(1,cnt)={'I1Fm'};
                    Vfname(1,cnt)={'Vb'};
                    Vfm(1,cnt)=abs(Vf(2))*VB; 
                    Vfang(1,cnt)=radtodeg(angle(Vf(2)));
                    Vsname(1,cnt)={'V1'};
                    Vsm(1,cnt)=abs(Vs(2))*VB;
                    Ifname(1,cnt)={'Ib'};
                    Ifm(1,cnt)=abs(If(2))*IB;
                    Ifang(1,cnt)=radtodeg(angle(If(2)));
                    Isname(1,cnt)={'I1'};
                    Ism(1,cnt)=abs(Is(2))*IB;
                    cnt=cnt+1;
     
                    falta(1,cnt)=k;
                    Barra(1,cnt)=i;
                    tipo(1,cnt)={'I1Fm'};
                    Vfname(1,cnt)={'Vc'};
                    Vfm(1,cnt)=abs(Vf(3))*VB; 
                    Vfang(1,cnt)=radtodeg(angle(Vf(3)));
                    Vsname(1,cnt)={'V2'};
                    Vsm(1,cnt)=abs(Vs(3))*VB;
                    Ifname(1,cnt)={'Ic'};
                    Ifm(1,cnt)=abs(If(3))*IB;
                    Ifang(1,cnt)=radtodeg(angle(If(3)));
                    Isname(1,cnt)={'I2'};
                    Ism(1,cnt)=abs(Is(3))*IB;
                    cnt=cnt+1;
                    
                end
                
            end
        end
    end

    Vbarras=table(falta',Barra',tipo',Vfname',Vfm',Vfang',Vsname',Vsm',Ifname',Ifm',Ifang',Isname',Ism');
    Vbarras.Properties.VariableNames = {'Falta' 'Barra' 'Tipo' 'Vabc' 'V' 'VFang' 'V012' 'MV012' 'A' 'MIabc' 'IFang' 'I012' 'MI012'};
    
    
    
end