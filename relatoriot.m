function []=relatoriot(Id,Idt,mcc,mcct,PI,TB) 
%Irá apresentar de uma forma BUNITHINHA XD os dados
%clc
jj=sqrt(-1);
alph=exp(jj*+2*pi/3);
A=[1 1 1; 1 alph^2 alph;1 alph alph^2];
auxl=length(PI);
        IB=100e6./(TB.*sqrt(3));
   Id=Id.*IB';
   Idt=Idt.*IB';
   
    for p=1:auxl
        fprintf('\n \n Falta em  %i \n \n',PI(p));

        disp('--**CORRENTE DE CC TRIFÁSICO SUB- TRANSITÓRIO Simétrico**--')
        fprintf('I"3Fsim: %4.0f  ang: %4.0f \n \n',abs(Idt(PI(p),1)), radtodeg(angle(Idt(p,1))));

        disp('--**CORRENTE DE CC TRIFÁSICO SUB-TRANSITÓRIO Assimétrico**--')
            FA1=sqrt( 1+ 2*exp(-2*pi/tan(angle(1/Idt(PI(p),1)) )));
            Iass=FA1*abs(Idt(PI(p),1));
        fprintf('I"3Fassi: %4.0f ang: %4.0f \n \n',abs(Iass),radtodeg(angle(Iass)));
   
        disp('--**  POTÊNCIA  **--')
            potencia=abs(Idt(PI(p),1))*TB(PI(p))*sqrt(3)/1e6;
            fprintf('PCC: %4.2f MVA \n \n', potencia);
        
        disp('--**CORRENTE DE CC TRIFÁSICO TRANSITÓRIO Simétrico**--')
        fprintf("I'3Fsim: %4.0f  ang: %4.0f \n \n",abs(Id(PI(p),1)), radtodeg(angle(Id(p,1))));
                
        disp('--**CORRENTE DE CC FASE-TERRA SUB-TRANSITÓRIO**--')
        fprintf('I"1Fsim: %4.0f ang: %4.0f \n \n',abs(Idt(PI(p),2)*3),radtodeg(angle(Idt(PI(p),2))));
            FAT=sqrt( 1+ 2*exp(-2*pi/tan(angle(1/Idt(PI(p),2))) ));
            IassT=FAT*Idt(PI(p),2)*3;
        fprintf('I"1Fss: %4.0f ang: %4.0f \n \n',abs(IassT),radtodeg(angle(IassT)));
          
        disp('--**CORRENTE DE CC FASE-TERRA TRANSITÓRIO**--')
        fprintf("I'1Fsim: %4.0f ang: %4.0f \n \n",abs(Id(PI(p),2)*3),radtodeg(angle(Id(PI(p),2))));
                       
        disp('--**CORRENTE DE CC FASE-TERRA MÍNIMO**--')
        fprintf("I'1Fmin: %4.0f ang: %4.0f \n \n",abs(Id(PI(p),3))*3,radtodeg(angle(Id(PI(p),3))));
        
        disp('-**CORRENTE DE CC BIFÁSICO**--')
            I2f_p=mcc(:,:,PI(p),8); ax_p=sum(I2f_p);
            I2f_n=mcc(:,:,PI(p),9); ax_n=sum(I2f_n);
            I2f=ax_p(PI(p))+ax_n(PI(p));
            I2f=I2f*IB(PI(p));
        fprintf('I2F: %4.0f ang: %4.0f \n \n',abs(I2f),radtodeg(angle(I2f)));
        
        
        [M,axM]=matter(PI(p),mcc);
        [Mt,axMt]=matter(PI(p),mcct);
        [lin_axM,col]=size(axM);
        for k=1:lin_axM
            
            fprintf('\n TRECHO: %d ==> %d \n',axM(k,1),axM(k,2));

                I3Fst=Mt(k,1)*IB(axMt(k,2));
                if abs(I3Fst)>1e-4 
                    fprintf('I"3Fsim: %4.0f  ang: %4.0f \n',abs(I3Fst),radtodeg(angle(I3Fst)));
                end
                
                Iass_mcc=FA1*I3Fst;
                if abs(Iass_mcc)>1e-4
                    fprintf('I"3Fass: %4.0f ang: %4.0f \n',abs(Iass_mcc),radtodeg(angle(Iass_mcc)));
                end
                
                I3F=M(k,1)*IB(axM(k,2));
                if abs(I3F)>1e-4 
                    fprintf("I'3Fsim: %4.0f  ang: %4.0f \n",abs(I3F),radtodeg(angle(I3F)));
                end
              

                I1Fst=sum(A*[Mt(k,2);Mt(k,3);Mt(k,4)]);
                I1Fst=I1Fst*IB(axMt(k,2));
                if abs(I1Fst)>1e-4
                    fprintf('I"1Fsim: %4.0f ang: %4.0f \n',abs(I1Fst),radtodeg(angle(I1Fst)));
                end
                
                I1ass_mcc=FAT*I1Fst;
                if abs(I1ass_mcc)>1e-4
                    fprintf('I"1Fass: %4.0f ang: %4.0f \n',abs(I1ass_mcc),radtodeg(angle(I1ass_mcc)));
                end
                
                I1F=sum(A*[M(k,2);M(k,3);M(k,4)]);
                I1F=I1F*IB(axM(k,2));
                if abs(I1F)>1e-4
                    fprintf('I1Fsim: %4.0f ang: %4.0f \n',abs(I1F),radtodeg(angle(I1F)));
                end
                
                I2F=M(k,8)+M(k,9);
                I2F=I2F*IB(axM(k,2));
                if abs(I2F)>1e-4 
                    fprintf('I2F: %4.0f ang: %4.0f \n',abs(I2F),radtodeg(angle(I2F)));
                end              
                I1Fmin=sum(A*[M(k,5);M(k,6);M(k,7)]);
                I1Fmin=I1Fmin*IB(axM(k,2));
                if abs(I1Fmin)>1e-4
                    fprintf('I1Fmin: %4.0f ang: %4.0f \n',abs(I1Fmin),radtodeg(angle(I1Fmin)));
                end                
                
                I1F0t=Mt(k,4);
                I1F0t=I1F0t*IB(axMt(k,2))*3;
                if abs(I1F0t)>1e-4
                    fprintf('3*I".0sim: %4.0f ang: %4.0f \n',abs(I1F0t),radtodeg(angle(I1F0t)));
                end
                
                I1F0tass=I1F0t*FAT;
                if abs(I1F0tass)>1e-4
                    fprintf('3*I".0ass: %4.0f ang: %4.0f \n',abs(I1F0tass),radtodeg(angle(I1F0tass)));
                end
            
                I1F0m=M(k,7);
                I1F0m=I1F0m*IB(axM(k,2))*3;
                if abs(I1F0m)>1e-4
                    fprintf('3.I 0min: %4.0f ang: %4.0f \n',abs(I1F0m),radtodeg(angle(I1F0m)));
                end            
                
  
                
        end

    end

end