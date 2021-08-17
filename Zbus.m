	function[Z,exist] = Zbus(R)
        clc;
        tam=max(max(R(:,1),R(:,2)));
		Z=zeros(tam);
		exist=zeros(tam,1);
		cont=1;
		flag=true;
		[lin,]=size(R);
		for i=1:lin     %Varre R
			R(i,3);
            Z;
			flag=true; %controle de caos 3 e 4;
			%verifica
			if R(i,1)==R(i,2)
				%Caso 1
				exist(cont)=R(i,1);
				cont=cont+1;
				Z(R(i,1),R(i,1))=R(i,3);
                 disp('Caso 1');
                disp(Z);

				
				
			else
				
				for n=1:tam
					
					if R(i,1)==exist(n)
						if R(i,2)==1
                        
                        end
						for o=1:tam
							if R(i,2)==exist(o)
								%Caso4 -- Adicionando uma impedancia entre duas barras Existentes
								k=R(i,1); m=R(i,2); Zb=R(i,3);

								Ax_C=zeros(2,length(Z)); Ax_L=zeros(length(Z),2);

								aux=Z(k,k)+Z(m,m)-2*Z(k,m)+Zb;

								Ax_L(:,1)=Z(:,k); Ax_L(:,2)=Z(:,m); AXL=Ax_L(:,1)-Ax_L(:,2);

								Ax_C(1,:)=Z(k,:); Ax_C(2,:)=Z(m,:); AXC=Ax_C(1,:)-Ax_C(2,:);

								Resu=AXL*AXC; Resu=Resu/aux;

								Z=Z-Resu; 
                                disp('Caso 4');
                                disp(Z);
								flag=false;
							end
						end	

						
						if flag 
							%%Caso2-- Adicionando uma impedancia e uma barra
							exist(cont)=R(i,2);
							cont=cont+1;
							
							k=R(i,1);
							Zb=R(i,3);

							AXL=zeros(1,length(Z));
							AXC=zeros(length(Z),1);

							aux=Z(k,k)+Zb;

							AXL=Z(:,k);
							AXC=Z(k,:);
                            
                            
                            Z(:,R(i,2))=AXL;
                            Z(R(i,2),:)=AXC;
                            Z(R(i,2),R(i,2))=aux;
                             disp('Z:');
 							%disp(Z);
 							disp('Caso 2');
                            disp(Z); 							
						end

						
					end
					
				end
				
				
			end
		

			
        end
    
            
	end