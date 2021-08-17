function [V,Id,Z1f,Z1fm]=CCgeral(Z,RF,Y,def)

    a=(1+j*sqrt(3))/2;
    A=[1 1 1; 1 a a^2; 1 a^2 a];
    
        %% Tensão devido a um curto trifásico
        
        Id(:,1)=-1./diag(Z(:,:,1));
        Iaux(:,:,1)=eye(length(Id)).*Id(:,1);
        V(:,:,1)=Z(:,:,1)*Iaux(:,:,1);        
        
        %% tensão devido a um curto monofásico 
        
        [lin,col]=size(Z(:,:,1));
        
         Z1f=zeros(lin(1),1);
        for k=1:lin
            for s=1:3 
                Z1f(k)=Z1f(k)+Z(k,k,s);
            end
        end
        Id(:,2)=-1./Z1f;
        [linI,col]=size(Id);
        Iaux(:,:,1)=eye(linI).*Id(:,2);
        V(:,:,2)=Z(:,:,1)*Iaux(:,:,1);  % V1
        V(:,:,3)=Z(:,:,2)*Iaux(:,:,1);  % V2
        V(:,:,4)=Z(:,:,3)*Iaux(:,:,1);  % V0
        
        %% tensão devido a um curto monofásico com a terra 1Fm
        
        [lin,col]=size(Z(:,:,1));
        Z1fm=zeros(lin,1);
        for k=1:lin
            for s=1:3 
                Z1fm(k)=Z1fm(k)+Z(k,k,s);
            end
            Z1fm(k)=Z1fm(k)+RF;
        end
        Id(:,3)=-1./Z1fm;
        [linI,col]=size(Id);
        Iaux(:,:,1)=eye(linI).*Id(:,3);
        V(:,:,5)=Z(:,:,1)*Iaux(:,:,1);  % V1m
        V(:,:,6)=Z(:,:,2)*Iaux(:,:,1);  % V2m
        V(:,:,7)=Z(:,:,3)*Iaux(:,:,1);  % V0m
        
        %% tensão devido a um curto Fase Fase 
        Id(:,4)=-1./(diag(Z(:,:,1))+diag(Z(:,:,2)));
        [linI,col]=size(Id);
        %j=sqrt(-1);
        [IB_r,IB_i]=pol2cart(pi*4/3,1);%defasando 240 degrees
        IB=IB_r+j*IB_i;
        [IC_r,IC_i]=pol2cart(pi*2/3,1);%defasando 120 degrees
        IC=IC_r+j*IC_i;
        Iaux(:,:,1)=eye(linI).*Id(:,4);
        V(:,:,8)=Z(:,:,1)*Iaux(:,:,1)*IB;  % VP
        V(:,:,9)=Z(:,:,2)*-Iaux(:,:,1)*IC;  % VN
        
        %% defase 
%         [Iax]=defaseI(Id,Y(:,:,2),def);
%         Id=Iax;
%         [Vax]=defaseV(V(:,:,9),Y(:,:,2),-def);
%         V(:,:,9)=Vax;
%         [Vax]=defaseV(V(:,:,8),Y(:,:,1),def);
%         V(:,:,8)=Vax;
%         [Vax]=defaseV(V(:,:,6),Y(:,:,2),-def);
%         V(:,:,6)=Vax;
%         [Vax]=defaseV(V(:,:,5),Y(:,:,1),def);
%         V(:,:,5)=Vax;
%         [Vax]=defaseV(V(:,:,3),Y(:,:,2),-def);
%         V(:,:,3)=Vax;
%         [Vax]=defaseV(V(:,:,2),Y(:,:,1),def);
%         V(:,:,2)=Vax;
%         [Vax]=defaseV(V(:,:,1),Y(:,:,1),def);
%         V(:,:,1)=Vax;
 
    
end




































