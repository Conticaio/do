function [MCC]=mcc(V,Y)
   %% Matriz de correntes de curto TODAS
    nbar=length(V(:,:,1));
    Yax(:,:,1)=Y(:,:,1);
    Yax(:,:,2)=Y(:,:,1);
    Yax(:,:,3)=Y(:,:,2);
    Yax(:,:,4)=Y(:,:,3);
    Yax(:,:,5)=Y(:,:,1);
    Yax(:,:,6)=Y(:,:,2);
    Yax(:,:,7)=Y(:,:,3);
    Yax(:,:,8)=Y(:,:,1);
    Yax(:,:,9)=Y(:,:,2);
     
    %MCC(De:A, Para:B, Localização da Falta, Tipo da falta)
    for tipo=1:9
        for local_falta=1:nbar
            MCC(:,:,local_falta,tipo)=zeros(nbar);
            for p=1:nbar
                sum_aux_y=0;
                for q=1:nbar
                    sum_aux_y=sum_aux_y+Yax(p,q,tipo);
                    if p~=q
                        MCC(q,p,local_falta,tipo)=(V(q,local_falta,tipo)-V(p,local_falta,tipo))* Yax(p,q,tipo);
                    end
                end
                MCC(p,p,local_falta,tipo)=sum_aux_y*V(p,local_falta,tipo);
            end
            
        end
    end
end