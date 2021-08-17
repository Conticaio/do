function [Aj_Curva] = mod_mst(Ipkp,Curva, Mult, Add,MRT,SEF,Tempo)
MAX_Curva=maximz(Curva);
[l,c]=size(MAX_Curva);
Aj_Curva=ones(l,c);
Aj_Curva(:,1)=Ipkp*MAX_Curva(:,1);
Aj_Curva(:,2)=Mult*MAX_Curva(:,2);
Aj_Curva(:,2)=Add+MAX_Curva(:,2);

    if ~isempty(MRT)
        Ax_MRT=find(Aj_Curva(:,2)<MRT,1);
        if ~isempty(Ax_MRT)
            Aj_Curva(Ax_MRT:l,2)=MRT;
        end
    end
    
    if ~isempty(SEF)
        if ~isempty(Tempo)
            Ax_Tempo=find(Aj_Curva(:,2)<Tempo,1);
            if ~isempty(Ax_Tempo)
                Aj_Curva(1:Ax_Tempo,1)=SEF;
            end
        end
    end
           
end    