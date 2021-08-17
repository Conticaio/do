	function[Y] = tryhard(R)
        tam=max(max(R(:,1),R(:,2)));
		Y=zeros(tam);
		[lin,col]=size(R);
		for i=1:lin     %Varre R
			if R(i,1)~=R(i,2)
               Y(R(i,1),R(i,2))=-1/R(i,3);
               Y(R(i,2),R(i,1))=Y(R(i,1),R(i,2));
            end
        end
        
        for c=1:tam
            ax_soma=0;
            for l=1:tam
                ax_soma=ax_soma+Y(l,c);
            end
            Y(c,c)=-ax_soma;
        end
        
          for i=1:lin     %Varre R
            if R(i,1)==R(i,2)
                 Y(R(i,1),R(i,1))=Y(R(i,1),R(i,1))+1/R(i,3);
            end
          end
          %Z=inv(Y);
	end