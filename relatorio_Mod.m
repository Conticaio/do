function [T,Tr,Mc,Vbarras]=relatorio_Mod(Id, mcc, PI,TB,Z,V,Y) 
%Irá apresentar de uma forma BUNITHINHA XD os dados
%clc

jj=sqrt(-1);
alph=exp(jj*+2*pi/3);
A=[1 1 1; 1 alph^2 alph;1 alph alph^2];

auxl=length(PI);
        IB=100e6./(TB.*sqrt(3));
    %Id_m=Id_m.*IB';
    cont=1;
    cont_rjx=1;
    conti_mc=1;
    for p=1:auxl
      %% Curto no Ponto de interesse
       for kx=1:2
            Id_m=Id.*IB(:,kx);
                if TB(PI(p),kx)>0
                        VB(1,cont)=TB(PI(p),kx);
                        falta(1,cont)=PI(p);
                        tipo(1,cont)={'I3Fsim'};
                        Mag(1,cont)=abs(Id_m(PI(p),1));
                        Ang(1,cont)=radtodeg(angle(Id_m(PI(p),1)));
                        cont=cont+1;

                %         disp('--**  POTÊNCIA  **--')
                %             fprintf('PCC: %4.2f MVA \n \n',abs(PI(p))*TB(PI(p))/1e6 );
                        potencia=abs(Id_m(PI(p),1))*TB(PI(p),kx)*sqrt(3)/1e6;            
                        VB(1,cont)=TB(PI(p),kx);
                        falta(1,cont)=PI(p);
                        tipo(1,cont)={"PCC"};
                        Mag(1,cont)= potencia;
                        Ang(1,cont)=radtodeg(angle(Id_m(PI(p),1)));
                        cont=cont+1;  

                            FA1=sqrt( 1+ 2*exp(-2*pi/tan(angle(1/Id_m(PI(p),1))) ));
                            Iass=FA1*Id_m(PI(p),1);

                        VB(1,cont)=TB(PI(p),kx);
                        falta(1,cont)=PI(p);
                        tipo(1,cont)={'I3Fass'};
                        Mag(1,cont)=abs(Iass);
                        Ang(1,cont)=radtodeg(angle(Iass));
                        cont=cont+1;


                        VB(1,cont)=TB(PI(p),kx);
                        falta(1,cont)=PI(p);
                        tipo(1,cont)={'I1Fsim'};
                        Mag(1,cont)=abs(Id_m(PI(p),2)*3);
                        Ang(1,cont)=radtodeg(angle(Id_m(PI(p),2)));
                        cont=cont+1;


                            FAT=sqrt( 1+ 2*exp(-2*pi/tan(angle(1/Id_m(PI(p),2))) ));
                            IassT=FAT*3*Id_m(PI(p),2);

                        VB(1,cont)=TB(PI(p),kx);
                        falta(1,cont)=PI(p);
                        tipo(1,cont)={'I1Fass'};
                        Mag(1,cont)=abs(IassT);
                        Ang(1,cont)=radtodeg(angle(IassT));
                        cont=cont+1;


                        VB(1,cont)=TB(PI(p),kx);
                        falta(1,cont)=PI(p);
                        tipo(1,cont)={'I1Fmin'};
                        Mag(1,cont)=abs(Id_m(PI(p),3))*3;
                        Ang(1,cont)=radtodeg(angle(Id_m(PI(p),3)));
                        cont=cont+1;

                            I2f_p=mcc(:,:,PI(p),8); ax_p=sum(I2f_p);
                            I2f_n=mcc(:,:,PI(p),9); ax_n=sum(I2f_n);
                            I2f=ax_p(PI(p))+ax_n(PI(p));
                            I2f=I2f*100e6/(TB(PI(p),kx)*sqrt(3));;

                        VB(1,cont)=TB(PI(p),kx);
                        falta(1,cont)=PI(p);
                        tipo(1,cont)={'I2F'};
                        Mag(1,cont)=abs(I2f);
                        Ang(1,cont)=radtodeg(angle(I2f));
                        cont=cont+1;

                        %% Gerando Potência de Falta/ e Impedancias de falta

                        falta_rjx(1,cont_rjx)=PI(p);
                        R(1,cont_rjx)=real(Z(PI(p),PI(p),1));        
                        jX(1,cont_rjx)=imag(Z(PI(p),PI(p),1));
                        cont_rjx=cont_rjx+1;
                        falta_rjx(1,cont_rjx)=PI(p);
                        R(1,cont_rjx)=real(Z(PI(p),PI(p),2));
                        jX(1,cont_rjx)=imag(Z(PI(p),PI(p),2));
                        cont_rjx=cont_rjx+1;
                        falta_rjx(1,cont_rjx)=PI(p);
                        R(1,cont_rjx)=real(Z(PI(p),PI(p),3));
                        jX(1,cont_rjx)=imag(Z(PI(p),PI(p),3));
                        cont_rjx=cont_rjx+1;



                        %% Contribuições da falta

                        [M,axM]=matter(PI(p),mcc);
                        [lin_axM,col]=size(axM);

                        for k=1:lin_axM
                            if IB(axM(k,2))>0
                                I3F=M(k,1)*IB(axM(k,2),kx);
                                if abs(I3F)>1e-4 
                                    VB_mc(1,conti_mc)=TB(axM(k,2),kx);
                                    falta_mc(1,conti_mc)=PI(p);
                                    de(1,conti_mc)=axM(k,1);
                                    para(1,conti_mc)=axM(k,2);
                                    tipo_mc(1,conti_mc)={'I3Fsim'};
                                    Mag_mc(1,conti_mc)=abs(I3F);
                                    Ang_mc(1,conti_mc)=radtodeg(angle(I3F));
                                    conti_mc=conti_mc+1;
                                end

                                I3ass_mcc=FA1*I3F;
                                if abs(I3ass_mcc)>1e-4
                                    VB_mc(1,conti_mc)=TB(axM(k,2),kx);
                                    falta_mc(1,conti_mc)=PI(p);
                                    de(1,conti_mc)=axM(k,1);
                                    para(1,conti_mc)=axM(k,2);
                                    tipo_mc(1,conti_mc)={'I3Fass'};
                                    Mag_mc(1,conti_mc)=abs(I3ass_mcc);
                                    Ang_mc(1,conti_mc)=radtodeg(angle(I3ass_mcc));
                                    conti_mc=conti_mc+1;
                                end

                                ICC_3I0=M(k,4);
                                ICC_3I0=ICC_3I0*IB(axM(k,2),kx)*3;                                
                                if abs(ICC_3I0)>1e-4
                                
                                    I1F=sum(A*[M(k,4);M(k,3);M(k,2)]);
                                    I1F=I1F*IB(axM(k,2),kx);
                                    if abs(I1F)>1e-4
                                        VB_mc(1,conti_mc)=TB(axM(k,2),kx);
                                        falta_mc(1,conti_mc)=PI(p);
                                        de(1,conti_mc)=axM(k,1);
                                        para(1,conti_mc)=axM(k,2);
                                        tipo_mc(1,conti_mc)={'I1Fsim'};
                                        Mag_mc(1,conti_mc)=abs(I1F);
                                        Ang_mc(1,conti_mc)=radtodeg(angle(I1F));
                                        conti_mc=conti_mc+1;

                                    end

                                    I1ass_mcc=FAT*I1F;
                                    if abs(I1ass_mcc)>1e-4
                                        VB_mc(1,conti_mc)=TB(axM(k,2),kx);
                                        falta_mc(1,conti_mc)=PI(p);
                                        de(1,conti_mc)=axM(k,1);
                                        para(1,conti_mc)=axM(k,2);
                                        tipo_mc(1,conti_mc)={'I1Fass'};
                                        Mag_mc(1,conti_mc)=abs(I1ass_mcc);
                                        Ang_mc(1,conti_mc)=radtodeg(angle(I1ass_mcc));
                                        conti_mc=conti_mc+1;

                                    end

                                    I1Fmin=sum(A*[M(k,7);M(k,6);M(k,5)]);
                                    I1Fmin=I1Fmin*IB(axM(k,2),kx);
                                    if abs(I1Fmin)>1e-4
                                        VB_mc(1,conti_mc)=TB(axM(k,2),kx);
                                        falta_mc(1,conti_mc)=PI(p);
                                        de(1,conti_mc)=axM(k,1);
                                        para(1,conti_mc)=axM(k,2);
                                        tipo_mc(1,conti_mc)={'I1Fmin'};
                                        Mag_mc(1,conti_mc)=abs(I1Fmin);
                                        Ang_mc(1,conti_mc)=radtodeg(angle(I1Fmin));
                                        conti_mc=conti_mc+1;

                                    end
                                end

                                I2F=M(k,8)+M(k,9);
                                I2F=I2F*IB(axM(k,2),kx);
                                if abs(I2F)>1e-4
                                    VB_mc(1,conti_mc)=TB(axM(k,2),kx);
                                    falta_mc(1,conti_mc)=PI(p);
                                    de(1,conti_mc)=axM(k,1);
                                    para(1,conti_mc)=axM(k,2);
                                    tipo_mc(1,conti_mc)={'I2F'};
                                    Mag_mc(1,conti_mc)=abs(I2F);
                                    Ang_mc(1,conti_mc)=radtodeg(angle(I2F));
                                    conti_mc=conti_mc+1;

                                end

                                I1F0=M(k,4);
                                I1F0=I1F0*IB(axM(k,2),kx)*3;                                
                                
                                    VB_mc(1,conti_mc)=TB(axM(k,2),kx);
                                    falta_mc(1,conti_mc)=PI(p);
                                    de(1,conti_mc)=axM(k,1);
                                    para(1,conti_mc)=axM(k,2);
                                    tipo_mc(1,conti_mc)={"3.I0.sim"};
                                    Mag_mc(1,conti_mc)=abs(I1F0);
                                    Ang_mc(1,conti_mc)=radtodeg(angle(I1F0));
                                    conti_mc=conti_mc+1;
                                if abs(I1F0)>1e-4
                                    I1F0ass=I1F0*FAT;
                                    VB_mc(1,conti_mc)=TB(axM(k,2),kx);
                                    falta_mc(1,conti_mc)=PI(p);
                                    de(1,conti_mc)=axM(k,1);
                                    para(1,conti_mc)=axM(k,2);
                                    tipo_mc(1,conti_mc)={'3.I0.ass'};
                                    Mag_mc(1,conti_mc)=abs(I1F0ass);
                                    Ang_mc(1,conti_mc)=radtodeg(angle(I1F0ass));
                                    conti_mc=conti_mc+1;
                                end
                                    
                                I1F0m=M(k,7);
                                I1F0m=I1F0m*IB(axM(k,2),kx)*3;                                
                                if abs(I1F0m)>1e-4
                                    VB_mc(1,conti_mc)=TB(axM(k,2),kx);
                                    falta_mc(1,conti_mc)=PI(p);
                                    de(1,conti_mc)=axM(k,1);
                                    para(1,conti_mc)=axM(k,2);
                                    tipo_mc(1,conti_mc)={'3.I0.min'};
                                    Mag_mc(1,conti_mc)=abs(I1F0m);
                                    Ang_mc(1,conti_mc)=radtodeg(angle(I1F0m));
                                    conti_mc=conti_mc+1;
                                end

                            end
                        end
                end
        end
    end
       
    Vbarras=Tensoes(V,mcc,TB,Y);

    T=table(VB',falta',tipo',Mag',Ang');
    T.Properties.VariableNames = {'Vbase' 'Falta' 'Tipo' 'Mag' 'Ang'};

    Tr=table(falta_rjx',R',jX');
    Tr.Properties.VariableNames = {'Falta' 'R' 'X'};

    Mc=table(VB_mc',falta_mc',de',para',tipo_mc',Mag_mc',Ang_mc');
    Mc.Properties.VariableNames = {'Vbase' 'Falta' 'De' 'Para' 'Tipo' 'Mag' 'Ang'};
    
end