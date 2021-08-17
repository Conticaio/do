function [Ib]=upperM(M)
    fim=length(M);
    Aux_M=M;
    for i=1:fim
        Aux_m(i,i)=0;
    end
    Ib=sum(Aux_m,2);
    if Ib(1)<0.0001
        Ib(1)=M(1,1);
    end
    
end