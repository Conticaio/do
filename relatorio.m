function []=relatorio(Id, mcc, PI,TB,Z) 
%Irá apresentar de uma forma BUNITHINHA XD os dados
%clc
jj=sqrt(-1);
alph=exp(jj*+2*pi/3);
A=[1 1 1; 1 alph^2 alph;1 alph alph^2];
auxl=length(PI);
        IB=100e6./(TB.*sqrt(3));
    Id=Id.*IB';
    for p=1:auxl
        fprintf('\n \n Falta em  %i \n \n',PI(p));
        disp('--**CORRENTE DE CC TRIFÁSICO Simétrico**--')
        fprintf('I3Fsim: %4.0f  ang: %4.2f \n \n',abs(Id(PI(p),1)), radtodeg(angle(Id(p,1))));

%         disp('--**  POTÊNCIA  **--')
%             fprintf('PCC: %4.2f MVA \n \n',abs(PI(p))*TB(PI(p))/1e6 );
                        
        disp('--**CORRENTE DE CC TRIFÁSICO Assimétrico**--')
            FA1=sqrt( 1+ 2*exp(-2*pi/tan(angle(1/Id(PI(p),1))) ));
            Iass=FA1*Id(PI(p),1);
        fprintf('I3Fassi: %4.2f ang: %4.2f \n \n',abs(Iass),radtodeg(angle(Iass)));

        abs(Id(PI(p),2))/IB(p);
        Z(PI(p),PI(p),1);
        Z(PI(p),PI(p),2);
        Z(PI(p),PI(p),3);
        
        disp('--**CORRENTE DE CC FASE-TERRA Simétrico **--')
        fprintf('I1Fsim: %4.8f ang: %4.2f \n \n',abs(Id(PI(p),2)*3),radtodeg(angle(Id(PI(p),2))));
        
        disp('--**CORRENTE DE CC FASE-TERRA  Assimétrico**--')
            FAT=sqrt( 1+ 2*exp(-2*pi/tan(angle(1/Id(PI(p),2))) ));
            IassT=FAT*3*Id(PI(p),2);
        fprintf('I1Fass: %4.8f ang: %4.2f \n \n',abs(IassT),radtodeg(angle(IassT)));
                
        disp('--**CORRENTE DE CC FASE-TERRA MÍNIMO**--')
        fprintf('I1Fmin: %4.8f ang: %4.2f \n \n',abs(Id(PI(p),3))*3,radtodeg(angle(Id(PI(p),3))));
        
        disp('-**CORRENTE DE CC BIFÁSICO**--')
            I2f_p=mcc(:,:,PI(p),8); ax_p=sum(I2f_p);
            I2f_n=mcc(:,:,PI(p),9); ax_n=sum(I2f_n);
            I2f=ax_p(PI(p))+ax_n(PI(p));
            I2f=I2f*IB(PI(p));
        fprintf('I2F: %4.2f ang: %4.2f \n \n',abs(I2f),radtodeg(angle(I2f)));
        
        
        [M,axM]=matter(PI(p),mcc);
        [lin_axM,col]=size(axM);
        for k=1:lin_axM
            fprintf('\n TRECHO: %d ==> %d \n',axM(k,1),axM(k,2));

                I3F=M(k,1)*IB(axM(k,2));
                if abs(I3F)>1e-4 
                    fprintf('I3Fsim: %4.0f  ang: %4.2f \n',abs(I3F),radtodeg(angle(I3F)));
                end
              
                I3ass_mcc=FA1*I3F;
                if abs(I3ass_mcc)>1e-4
                    fprintf('I3Fasim: %4.2f ang: %4.2f \n',abs(I3ass_mcc),radtodeg(angle(I3ass_mcc)));
                end
                
                I1F=sum(A*[M(k,2);M(k,3);M(k,4)]);
                I1F=I1F*IB(axM(k,2));
                if abs(I1F)>1e-4
                    fprintf('I1Fsim: %4.2f ang: %4.2f \n',abs(I1F),radtodeg(angle(I1F)));
                end
                
                I1ass_mcc=FAT*I1F;
                if abs(I1ass_mcc)>1e-4
                    fprintf('I1Fass: %4.2f ang: %4.2f \n',abs(I1ass_mcc),radtodeg(angle(I1ass_mcc)));
                end
                
            
                I1Fmin=sum(A*[M(k,5);M(k,6);M(k,7)]);
                I1Fmin=I1Fmin*IB(axM(k,2));
                if abs(I1Fmin)>1e-4
                    fprintf('I1Fmin: %4.2f ang: %4.2f \n',abs(I1Fmin),radtodeg(angle(I1Fmin)));
                end
                
                I2F=M(k,8)+M(k,9);
                I2F=I2F*IB(axM(k,2));
                if abs(I2F)>1e-4
                    fprintf('I2F: %4.2f ang: %4.2f \n',abs(I2F),radtodeg(angle(I2F)));
                end
                
                
                I1F0=M(k,4);
                I1F0=I1F0*IB(axM(k,2))*3;
                if abs(I1F0)>1e-4
                    fprintf('3.I 0sim: %4.2f ang: %4.2f \n',abs(I1F0),radtodeg(angle(I1F0)));
                end
                
                I1F0ass=I1F0*FAT;
                if abs(I1F0ass)>1e-4
                    fprintf('3.I 0ass: %4.2f ang: %4.2f \n',abs(I1F0ass),radtodeg(angle(I1F0ass)));
                end
                
                I1F0m=M(k,7);
                I1F0m=I1F0m*IB(axM(k,2))*3;
                if abs(I1F0m)>1e-4
                    fprintf('3.I 0min: %4.2f ang: %4.2f \n',abs(I1F0m),radtodeg(angle(I1F0m)));
                end
                
           end

    end

end