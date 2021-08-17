function [T,Tr,Mc,Vbarras]=relatoriot_Mod(Id,Idt,mcc,mcct,PI,TB,Z,Zt,V,Y) 
print(Z)
%Irá apresentar de uma forma BUNITHINHA XD os dados
%clc
jj=sqrt(-1);
alph=exp(jj*+2*pi/3);
A=[1 1 1; 1 alph^2 alph;1 alph alph^2];
auxl=length(PI);
        IB=100e6./(TB.*sqrt(3));
%    Id_m=Id_m.*IB';
%    Idt_m=Idt_m.*IB';
    
    cont=1;
    cont_rjx=1;
    conti_mc=1;
    
    for p=1:auxl
      %% Curto no Ponto de interesse
       for kx=1:2

            Id_m=Id.*IB(:,kx);
            Idt_m=Idt.*IB(:,kx);
            if TB(PI(p),kx)>0

                VB(1,cont)=TB(PI(p),kx);
                falta(1,cont)=PI(p);
                tipo(1,cont)={'I"3Fsim'};
                Mag(1,cont)=abs(Idt_m(PI(p),1));
                Ang(1,cont)=radtodeg(angle(Idt_m(PI(p),1)));
                cont=cont+1;

                %disp('--**CORRENTE DE CC TRIFÁSICO SUB-TRANSITÓRIO Assimétrico**--')
                    FA1=sqrt( 1+ 2*exp(-2*pi/tan(angle(1/Idt_m(PI(p),1)) )));
                    Iass=FA1*abs(Idt_m(PI(p),1));
                %fprintf('I"3Fassi: %4.0f ang: %4.0f \n \n',abs(Iass),radtodeg(angle(Iass)));

                VB(1,cont)=TB(PI(p),kx);
                falta(1,cont)=PI(p);
                tipo(1,cont)={'I"3Fass'};
                Mag(1,cont)=abs(Iass);
                Ang(1,cont)=radtodeg(angle(Idt_m(PI(p),1)));
                cont=cont+1;   


                %disp('--**  POTÊNCIA  **--')
                    potencia=abs(Idt_m(PI(p),1))*TB(PI(p),kx)*sqrt(3)/1e6;
                    %fprintf('PCC: %4.2f MVA \n \n', potencia);

                VB(1,cont)=TB(PI(p),kx);
                falta(1,cont)=PI(p);
                tipo(1,cont)={"PCC"};
                Mag(1,cont)= potencia;
                Ang(1,cont)=radtodeg(angle(Idt_m(PI(p),1)));
                cont=cont+1;   

                %disp('--**CORRENTE DE CC TRIFÁSICO TRANSITÓRIO Simétrico**--')
                %fprintf("I'3Fsim: %4.0f  ang: %4.0f \n \n",abs(Id_m(PI(p),1)), radtodeg(angle(Id_m(p,1))));

                VB(1,cont)=TB(PI(p),kx);
                falta(1,cont)=PI(p);
                tipo(1,cont)={"I'3F"};
                I3Fsim=Id_m(PI(p),1);
                Mag(1,cont)=abs(Id_m(PI(p),1));
                Ang(1,cont)=radtodeg(angle(Id_m(PI(p),1)));
                cont=cont+1;   

%                                 disp('--**CORRENTE DE CC TRIFÁSICO SUB-TRANSITÓRIO Assimétrico**--')
%                     FA1t=sqrt( 1+ 2*exp(-2*pi/tan(angle(1/I3Fsim) )));
%                     Iasst=FA1t*abs(Idt_m(PI(p),1));
%                 fprintf('I"3Fassi: %4.0f ang: %4.0f \n \n',abs(Iass),radtodeg(angle(Iass)));
% 
%                 VB(1,cont)=TB(PI(p),kx);
%                 falta(1,cont)=PI(p);
%                 tipo(1,cont)={"I'3Fass"};
%                 Mag(1,cont)=abs(Iasst);
%                 Ang(1,cont)=radtodeg(angle(Idt_m(PI(p),1)));
%                 cont=cont+1;   

                
                %disp('--**CORRENTE DE CC FASE-TERRA SUB-TRANSITÓRIO**--')
                %fprintf('I"1Fsim: %4.0f ang: %4.0f \n \n',abs(Idt_m(PI(p),2)*3),radtodeg(angle(Idt_m(PI(p),2))));

                VB(1,cont)=TB(PI(p),kx);
                falta(1,cont)=PI(p);
                tipo(1,cont)={'I"1Fsim'};
                Mag(1,cont)=abs(Idt_m(PI(p),2)*3);
                Ang(1,cont)=radtodeg(angle(Idt_m(PI(p),2)));
                cont=cont+1;   


                    FAT=sqrt( 1+ 2*exp(-2*pi/tan(angle(1/Idt_m(PI(p),2))) ));
                    IassT=FAT*Idt_m(PI(p),2)*3;
                %fprintf('I"1Fass: %4.0f ang: %4.0f \n \n',abs(IassT),radtodeg(angle(IassT)));

                VB(1,cont)=TB(PI(p),kx);
                falta(1,cont)=PI(p);
                tipo(1,cont)={'I"1Fass'};
                Mag(1,cont)=abs(IassT);
                Ang(1,cont)=radtodeg(angle(IassT));
                cont=cont+1;   

                %disp('--**CORRENTE DE CC FASE-TERRA TRANSITÓRIO**--')
                %fprintf("I'1Fsim: %4.0f ang: %4.0f \n \n",abs(Id_m(PI(p),2)*3),radtodeg(angle(Id_m(PI(p),2))));

                VB(1,cont)=TB(PI(p),kx);
                falta(1,cont)=PI(p);
                tipo(1,cont)={"I'1F"};
                Mag(1,cont)=abs(Id_m(PI(p),2)*3);
                Ang(1,cont)=radtodeg(angle(Id_m(PI(p),2)));
                cont=cont+1;   

                %disp('--**CORRENTE DE CC FASE-TERRA MÍNIMO**--')
                %fprintf("I'1Fmin: %4.0f ang: %4.0f \n \n",abs(Id_m(PI(p),3))*3,radtodeg(angle(Id_m(PI(p),3))));

                VB(1,cont)=TB(PI(p),kx);
                falta(1,cont)=PI(p);
                tipo(1,cont)={"I'1Fmin"};
                Mag(1,cont)=abs(Id_m(PI(p),3)*3);
                Ang(1,cont)=radtodeg(angle(Id_m(PI(p),3)));
                cont=cont+1;   

                %disp('-**CORRENTE DE CC BIFÁSICO**--')
                    I2f_pt=mcct(:,:,PI(p),8); ax_pt=sum(I2f_pt);
                    I2f_nt=mcct(:,:,PI(p),9); ax_nt=sum(I2f_nt);
                    I2ft=ax_pt(PI(p))+ax_nt(PI(p));
                    I2ft=I2ft*100e6/(TB(PI(p),kx)*sqrt(3));
                %fprintf('I2F: %4.0f ang: %4.0f \n \n',abs(I2f),radtodeg(angle(I2f)));

%                 VB(1,cont)=TB(PI(p),kx);
%                 falta(1,cont)=PI(p);
%                 tipo(1,cont)={'I"2F'};
%                 Mag(1,cont)=abs(I2ft);
%                 Ang(1,cont)=radtodeg(angle(I2ft));
%                 cont=cont+1;   
%                 
                %disp('-**CORRENTE DE CC BIFÁSICO**--')
                    I2f_p=mcc(:,:,PI(p),8); ax_p=sum(I2f_p);
                    I2f_n=mcc(:,:,PI(p),9); ax_n=sum(I2f_n);
                    I2f=ax_p(PI(p))+ax_n(PI(p));
                    I2f=I2f*100e6/(TB(PI(p),kx)*sqrt(3));
                %fprintf('I2F: %4.0f ang: %4.0f \n \n',abs(I2f),radtodeg(angle(I2f)));

                VB(1,cont)=TB(PI(p),kx);
                falta(1,cont)=PI(p);
                tipo(1,cont)={"I'2F"};
                Mag(1,cont)=abs(I2f);
                Ang(1,cont)=radtodeg(angle(I2f));
                cont=cont+1;   

                %% Gerando Potência de Falta/ e Impedancias de falta
                falta_rjx(1,cont_rjx)=PI(p);
                R(1,cont_rjx)=real(Zt(PI(p),PI(p),1));        
                jX(1,cont_rjx)=imag(Zt(PI(p),PI(p),1));
                cont_rjx=cont_rjx+1;
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
                [Mt,axMt]=matter(PI(p),mcct);
                [lin_axM,col]=size(axM);
                for k=1:lin_axM
                    if TB(axMt(k,2),kx)>0
                    
                        I3Fst=Mt(k,1)*IB(axMt(k,2),kx);
                        if abs(I3Fst)>1e-4 
                            VB_mc(1,conti_mc)=TB(axMt(k,2),kx);
                            falta_mc(1,conti_mc)=PI(p);
                            de(1,conti_mc)=axM(k,1);
                            para(1,conti_mc)=axM(k,2);
                            tipo_mc(1,conti_mc)={'I"3Fsim'};
                            Mag_mc(1,conti_mc)=abs(I3Fst);
                            Ang_mc(1,conti_mc)=radtodeg(angle(I3Fst));
                            conti_mc=conti_mc+1;                    
                        end

                        Iass_mcc=FA1*I3Fst;
                        if abs(Iass_mcc)>1e-4
                            VB_mc(1,conti_mc)=TB(axMt(k,2),kx);
                            falta_mc(1,conti_mc)=PI(p);
                            de(1,conti_mc)=axM(k,1);
                            para(1,conti_mc)=axM(k,2);
                            tipo_mc(1,conti_mc)={'I"3Fass'};
                            Mag_mc(1,conti_mc)=abs(Iass_mcc);
                            Ang_mc(1,conti_mc)=radtodeg(angle(Iass_mcc));
                            conti_mc=conti_mc+1;                    
                        end

                        I3F=M(k,1)*IB(axMt(k,2),kx);
                        if abs(I3F)>1e-4 
                            VB_mc(1,conti_mc)=TB(axMt(k,2),kx);
                            falta_mc(1,conti_mc)=PI(p);
                            de(1,conti_mc)=axM(k,1);
                            para(1,conti_mc)=axM(k,2);
                            tipo_mc(1,conti_mc)={'I3F'};
                            Mag_mc(1,conti_mc)=abs(I3F);
                            Ang_mc(1,conti_mc)=radtodeg(angle(I3F));
                            conti_mc=conti_mc+1;                    
                        end


                        ICC_3I0=M(k,4);
                        ICC_3I0=ICC_3I0*IB(axM(k,2),kx)*3;
                        if abs(ICC_3I0)>1e-4
                            
                            I1Fst=sum(A*[Mt(k,2);Mt(k,3);Mt(k,4)]);
                            I1Fst=I1Fst*IB(axMt(k,2),kx);
                            if abs(I1Fst)>1e-4
                                VB_mc(1,conti_mc)=TB(axMt(k,2),kx);
                                falta_mc(1,conti_mc)=PI(p);
                                de(1,conti_mc)=axM(k,1);
                                para(1,conti_mc)=axM(k,2);
                                tipo_mc(1,conti_mc)={'I"1Fsim'};
                                Mag_mc(1,conti_mc)=abs(I1Fst);
                                Ang_mc(1,conti_mc)=radtodeg(angle(I1Fst));
                                conti_mc=conti_mc+1;                    
                            end

                            I1ass_mcc=FAT*I1Fst;
                            if abs(I1ass_mcc)>1e-4
                                VB_mc(1,conti_mc)=TB(axMt(k,2),kx);
                                falta_mc(1,conti_mc)=PI(p);
                                de(1,conti_mc)=axM(k,1);
                                para(1,conti_mc)=axM(k,2);
                                tipo_mc(1,conti_mc)={'I"1Fass'};
                                Mag_mc(1,conti_mc)=abs(I1ass_mcc);
                                Ang_mc(1,conti_mc)=radtodeg(angle(I1ass_mcc));
                                conti_mc=conti_mc+1;                    
                            end

                            I1F=sum(A*[M(k,2);M(k,3);M(k,4)]);
                            I1F=I1F*IB(axMt(k,2),kx);
                            if abs(I1F)>1e-4
                                VB_mc(1,conti_mc)=TB(axMt(k,2),kx);
                                falta_mc(1,conti_mc)=PI(p);
                                de(1,conti_mc)=axM(k,1);
                                para(1,conti_mc)=axM(k,2);
                                tipo_mc(1,conti_mc)={"I'1F"};
                                Mag_mc(1,conti_mc)=abs(I1F);
                                Ang_mc(1,conti_mc)=radtodeg(angle(I1F));
                                conti_mc=conti_mc+1;                    
                            end

                            I1Fmin=sum(A*[M(k,5);M(k,6);M(k,7)]);
                            I1Fmin=I1Fmin*IB(axMt(k,2),kx);
                            if abs(I1Fmin)>1e-4
                                VB_mc(1,conti_mc)=TB(axMt(k,2),kx);
                                falta_mc(1,conti_mc)=PI(p);
                                de(1,conti_mc)=axM(k,1);
                                para(1,conti_mc)=axM(k,2);
                                tipo_mc(1,conti_mc)={'I1Fmin'};
                                Mag_mc(1,conti_mc)=abs(I1Fmin);
                                Ang_mc(1,conti_mc)=radtodeg(angle(I1Fmin));
                                conti_mc=conti_mc+1;                    
                            end 
                        end

%                         I2Ft=Mt(k,8)+Mt(k,9);
%                         I2Ft=I2Ft*IB(axMt(k,2),kx);
%                         if abs(I2Ft)>1e-4 
%                          %   fprintf('I2F: %4.0f ang: %4.0f \n',abs(I2F),radtodeg(angle(I2F)));
%                             VB_mc(1,conti_mc)=TB(axMt(k,2),kx);
%                             falta_mc(1,conti_mc)=PI(p);
%                             de(1,conti_mc)=axM(k,1);
%                             para(1,conti_mc)=axM(k,2);
%                             tipo_mc(1,conti_mc)={'I"2Fsim'};
%                             Mag_mc(1,conti_mc)=abs(I2Ft);
%                             Ang_mc(1,conti_mc)=radtodeg(angle(I2Ft));
%                             conti_mc=conti_mc+1;                    
%                         end   
                        
                        I2F=M(k,8)+M(k,9);
                        I2F=I2F*IB(axMt(k,2),kx);
                        if abs(I2F)>1e-4 
                         %   fprintf('I2F: %4.0f ang: %4.0f \n',abs(I2F),radtodeg(angle(I2F)));
                            VB_mc(1,conti_mc)=TB(axMt(k,2),kx);
                            falta_mc(1,conti_mc)=PI(p);
                            de(1,conti_mc)=axM(k,1);
                            para(1,conti_mc)=axM(k,2);
                            tipo_mc(1,conti_mc)={"I'2F"};
                            Mag_mc(1,conti_mc)=abs(I2F);
                            Ang_mc(1,conti_mc)=radtodeg(angle(I2F));
                            conti_mc=conti_mc+1;                    
                        end              
                                     
   
                       I1F0t=Mt(k,4);
                       I1F0t=I1F0t*IB(axMt(k,2),kx)*3;
                       if abs(I1F0m)>1e-4
                            VB_mc(1,conti_mc)=TB(axMt(k,2),kx); 
                            falta_mc(1,conti_mc)=PI(p);
                            de(1,conti_mc)=axM(k,1);
                            para(1,conti_mc)=axM(k,2);
                            tipo_mc(1,conti_mc)={'3.I"0.sim'};
                            Mag_mc(1,conti_mc)=abs(I1F0t);
                            Ang_mc(1,conti_mc)=radtodeg(angle(I1F0t));
                            conti_mc=conti_mc+1;                    
                        
                            I1F0tass=I1F0t*FAT;
                            VB_mc(1,conti_mc)=TB(axMt(k,2),kx);
                            falta_mc(1,conti_mc)=PI(p);
                            de(1,conti_mc)=axM(k,1);
                            para(1,conti_mc)=axM(k,2);
                            tipo_mc(1,conti_mc)={'3.I"0.ass'};
                            Mag_mc(1,conti_mc)=abs(I1F0tass);
                            Ang_mc(1,conti_mc)=radtodeg(angle(I1F0tass));
                            conti_mc=conti_mc+1;
                       end
                       
                        I1F0m=Mt(k,7);
                        I1F0m=I1F0m*IB(axMt(k,2),kx)*3;
                        if abs(I1F0m)>1e-4
                            VB_mc(1,conti_mc)=TB(axM(k,2),kx);
                            falta_mc(1,conti_mc)=PI(p);
                            de(1,conti_mc)=axM(k,1);
                            para(1,conti_mc)=axM(k,2);
                            tipo_mc(1,conti_mc)={'3.I"0.min'};
                            Mag_mc(1,conti_mc)=abs(I1F0m);
                            Ang_mc(1,conti_mc)=radtodeg(angle(I1F0m));
                            conti_mc=conti_mc+1;                    
                        end
                            
                        I1F0t=M(k,4);
                        I1F0t=I1F0t*IB(axM(k,2),kx)*3;
                        if abs(I1F0t)>1e-4
                            VB_mc(1,conti_mc)=TB(axMt(k,2),kx); 
                            falta_mc(1,conti_mc)=PI(p);
                            de(1,conti_mc)=axM(k,1);
                            para(1,conti_mc)=axM(k,2);
                            tipo_mc(1,conti_mc)={"3.I'0"};
                            Mag_mc(1,conti_mc)=abs(I1F0t);
                            Ang_mc(1,conti_mc)=radtodeg(angle(I1F0t));
                            conti_mc=conti_mc+1;                    
                        end

%                         I1F0tass=I1F0t*FAT;
%                         if abs(I1F0tass)>1e-4
%                             %fprintf('3*I".0ass: %4.0f ang: %4.0f \n',abs(I1F0tass),radtodeg(angle(I1F0tass)));
%                             VB_mc(1,conti_mc)=TB(axMt(k,2),kx);
%                             falta_mc(1,conti_mc)=PI(p);
%                             de(1,conti_mc)=axM(k,1);
%                             para(1,conti_mc)=axM(k,2);
%                             tipo_mc(1,conti_mc)={"3.I'0.ass"};
%                             Mag_mc(1,conti_mc)=abs(I1F0tass);
%                             Ang_mc(1,conti_mc)=radtodeg(angle(I1F0tass));
%                             conti_mc=conti_mc+1;                    
%                         end

                        I1F0m=M(k,7);
                        I1F0m=I1F0m*IB(axM(k,2),kx)*3;
                        if abs(I1F0m)>1e-4
                            %fprintf('3.I 0min: %4.0f ang: %4.0f \n',abs(I1F0m),radtodeg(angle(I1F0m)));
                            VB_mc(1,conti_mc)=TB(axM(k,2),kx);
                            falta_mc(1,conti_mc)=PI(p);
                            de(1,conti_mc)=axM(k,1);
                            para(1,conti_mc)=axM(k,2);
                            tipo_mc(1,conti_mc)={"3.I'0.min"};
                            Mag_mc(1,conti_mc)=abs(I1F0m);
                            Ang_mc(1,conti_mc)=radtodeg(angle(I1F0m));
                            conti_mc=conti_mc+1;                    
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
    
    
    
    
end