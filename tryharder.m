	function[Z,Y] = tryharder(y1,y2,y0)
        %função que retorna as Matrizes de Admitâcia e Impedância do sistema, prevendo barra fictícia. 
        %falta: defasador de trafo
    
%%         %% Seq. Positiva

%         R=y1;
%         tam=max(max(R(:,1),R(:,2)));
% 		Y1=zeros(tam);
% 		[lin,col]=size(R);
%         for i=1:lin     %Varre R
% 			if R(i,1)~=R(i,2)
%                Y1(R(i,1),R(i,2))=-1/R(i,3);
%                Y1(R(i,2),R(i,1))=Y1(R(i,1),R(i,2));
%             end
%         end
%         S=sum(Y1);
%         for j=1:tam
%             Y1(j,j)=-S(j);
%         end
%         for i=1:lin     %Varre R
% 			if R(i,1)==R(i,2)
%                 Y1(R(i,1),R(i,1))=Y1(R(i,1),R(i,1)) +1/R(i,3);
%             end
%         end
%         
    Y1=tryhard(y1);
    
        %% Seq. Neg
%         R=y2;
%         tam=max(max(R(:,1),R(:,2)));
% 		Y2=zeros(tam);
% 		[lin,col]=size(R);
%         for i=1:lin     %Varre R
% 			if R(i,1)~=R(i,2)
%                Y2(R(i,1),R(i,2))=-1/R(i,3);
%                Y2(R(i,2),R(i,1))=Y2(R(i,1),R(i,2));
%             end
%         end
%         S=sum(Y2);
%         for j=1:tam
%             Y2(j,j)=-S(j);
%         end
%         for i=1:lin     %Varre R
% 			if R(i,1)==R(i,2)
%                 Y2(R(i,1),R(i,1))=Y2(R(i,1),R(i,1)) +1/R(i,3);
%             end
%         end

    Y2=tryhard(y2);

        %% Seq. Zero
%         R=y0;
%         tam=max(max(R(:,1),R(:,2)));
% 		Y0=zeros(tam);
% 		[lin,col]=size(R);
%         for i=1:lin     %Varre R
% 			if R(i,1)~=R(i,2)
%                Y0(R(i,1),R(i,2))=-1/R(i,3);
%                Y0(R(i,2),R(i,1))=Y0(R(i,1),R(i,2));
%             end
%         end
%         S=sum(Y0);
%         for j=1:tam
%             Y0(j,j)=-S(j);
%         end
%         for i=1:lin     %Varre R
% 			if R(i,1)==R(i,2)
%                 Y0(R(i,1),R(i,1))=Y0(R(i,1),R(i,1)) +1/R(i,3);
%             end
%         end

    Y0=tryhard(y0);



    %% Ajuste Barra fictícia.
    
        Z1=inv(Y1);Z2=inv(Y2);Z0=inv(Y0);
         
        nbar=length(Z1);
        nfic=length(Z0);
        
        if nbar~=nfic
            for p=nbar+1:nfic
                Z1(p,p)=1e6;
                Z2(p,p)=1e6;
            end
            
            
        end
        
    Z(:,:,1)=Z1;Z(:,:,2)=Z2;Z(:,:,3)=Z0;         
    Y(:,:,1)=inv(Z1);Y(:,:,2)=inv(Z2);Y(:,:,3)=inv(Z0);
    
    
    end