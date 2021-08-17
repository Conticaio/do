function [Ybus]=Ybus_Trafo(Bus,Branch)
    j=sqrt(-1);
    Ybus=zeros(length(Bus.n));
    
    TRANSMISSION_LINE=0;
    FIXED_TAP=1;
    VARIABLE_TAP_FOR_VOLTAGE_CONTROL=2;
    VARIABLE_TAP_FOR_MVAR_CONTROL=3;    
    VARIABLE_PHASE_ANGLE=4;
    b=zeros(1,length(Bus.n));
    for i=1:length(Branch.n)

            switch Branch.type(i)
                case TRANSMISSION_LINE
                    Ybus(Branch.n(i),Branch.Zb(i))=-(1/(Branch.br(i)+j*Branch.bx(i)));
                    Ybus(Branch.Zb(i),Branch.n(i))=Ybus(Branch.n(i),Branch.Zb(i));            
                
                case FIXED_TAP
                    Ybus(Branch.n(i),Branch.Zb(i))=Branch.Tratio(i)-(1/(Branch.br(i)+j*Branch.bx(i)));
                    Ybus(Branch.Zb(i),Branch.n(i))=Ybus(Branch.n(i),Branch.Zb(i));
                    b(1,Branch.n(i))=b(1,Branch.n(i))+Branch.Tratio(i)*(Branch.Tratio(i)-1)*Ybus(Branch.Zb(i),Branch.n(i));
                    b(1,Branch.Zb(i))=b(1,Branch.Zb(i))+(1-Branch.Tratio(i))*Ybus(Branch.Zb(i),Branch.n(i)) ;
                    
                case VARIABLE_TAP_FOR_VOLTAGE_CONTROL
                    disp('x2')

                case VARIABLE_TAP_FOR_MVAR_CONTROL
                    disp('x3')

                case VARIABLE_PHASE_ANGLE
                    disp('x4')
                    Branch.Tangl(i)

                otherwise
                    disp('Other')
            end
             
    end
    
    a=-sum(Ybus,2)
    
    
    for i=1:length(Bus.n)
        b(1,Branch.Zb(i))=b(1,Branch.Zb(i))+Branch.lb(i)/2;
        b(1,Branch.n(i))=b(1,Branch.n(i))+Branch.lb(i)/2;
    end
    
    for i=1:length(Bus.n)
        Ybus(i,i)=a(i)+j*b(i);
    end

end















