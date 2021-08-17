function [M,axM]=matter(ponto_de_curto,mcc)

    [lin,col,h]=size(mcc);
    k=0;
    for r=1:lin
        for q=r:lin
            ax_sum=0;
            for type=1:9
                ax_sum=mcc(r,q,ponto_de_curto,type);
                if abs(ax_sum)>1e-4
                 k=k+1;
                 axM(k,1)=r;
                 axM(k,2)=q;
                 
                 M(k,:)=mcc(r,q,ponto_de_curto,:);
                 break;
                end
             
            end
            
        end
        
            
    end

end