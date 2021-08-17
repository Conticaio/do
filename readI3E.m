function [Bus,Branch]=readI3E(c)

encontrouBus = 0;
encontrouBranch = 0;
fileid = fopen(c,'r')
%fileid = fopen('C:\Users\conti\Desktop\TopEsp\Padrão IEEE\WSCC9bus.cdf','r')

%fclose(fileid)


% s = fgetl(fileid)
%i = 0;

%BUS= struct('No',{[1],[1]},'Nome',{2});

i=1;j=1;
   while ~ feof(fileid)
    
     s = fgetl(fileid);
     compara =  strncmp(s,'BRANCH',6); %Ramos
     comp = strncmp(s,'BUS',3); %Ramos
     
     if comp == 1
        encontrouBus = 1;
     end
     
     if comp==0 && encontrouBus == 1
        if compara~=1
            if ~strcmp(s(1:4),'-999')
       
                Bus.n(i,1)=sscanf(s(1:4),'%f');
                Bus.Nome(i,1:11)=s(7:17);
                Bus.load(i,1)=sscanf(s(19:20),'%f');
                Bus.loss(i,1)=sscanf(s(21:23),'%f');
                Bus.type(i,1)=sscanf(s(25:26),'%f');
                Bus.fv(i,1)=sscanf(s(28:33),'%f');
                Bus.fang(i,1)=sscanf(s(34:40),'%f');
                Bus.loadw(i,1)=sscanf(s(41:49),'%f');
                Bus.loadvar(i,1)=sscanf(s(50:59),'%f');
                Bus.Gw(i,1)=sscanf(s(60:67),'%f');
                Bus.Gvar(i,1)=sscanf(s(68:75),'%f');
                Bus.base(i,1)=sscanf(s(77:83),'%f');
                Bus.D(i,1)=sscanf(s(85:90),'%f');
                Bus.Maxvar(i,1)=sscanf(s(91:98),'%f');
                Bus.Minvar(i,1)=sscanf(s(99:106),'%f');
                Bus.ShuntG(i,1)=sscanf(s(107:114),'%f');
                Bus.ShuntB(i,1)=sscanf(s(115:122),'%f');
                Bus.remote(i,1)=sscanf(s(124:127),'%f');
                           
                i=i+1;
            end
        else
            encontrouBus=0;
        end
        
     end
     
     if compara == 1
        encontrouBranch = 1;
     end
     
     if compara==0 && encontrouBranch == 1
            if ~strcmp(s(1:4),'-999')
                Branch.n(j,1)=sscanf(s(1:4),'%f');
                Branch.Zb(j,1)=sscanf(s(6:9),'%f');
                Branch.load(j,1)=sscanf(s(11:12),'%f');
                Branch.loss(j,1)=sscanf(s(13:14),'%f');
                Branch.cir(j,1)=sscanf(s(17),'%f');
                Branch.type(j,1)=sscanf(s(19),'%f');
                Branch.br(j,1)=sscanf(s(20:29),'%f');
                Branch.bx(j,1)=sscanf(s(30:40),'%f');
                Branch.lb(j,1)=sscanf(s(41:50),'%f');
                Branch.LMVA1(j,1)=sscanf(s(51:55),'%f');
                Branch.LMVA2(j,1)=sscanf(s(57:61),'%f');
                Branch.LMVA3(j,1)=sscanf(s(63:67),'%f');
                Branch.C(j,1)=sscanf(s(69:72),'%f');
                Branch.S(j,1)=sscanf(s(74),'%f');
                Branch.Tratio(j,1)=sscanf(s(77:82),'%f');
                Branch.Tangl(j,1)=sscanf(s(84:90),'%f');
                Branch.MinPh(j,1)=sscanf(s(91:97),'%f');
                Branch.MaxPh(j,1)=sscanf(s(98:104),'%f');
                Branch.Step(j,1)=sscanf(s(106:111),'%f');
                Branch.MinV(j,1)=sscanf(s(113:119),'%f');
                Branch.MaxV(j,1)=sscanf(s(120:126),'%f');
                
                j=j+1;
            else
                encontrouBranch=0;
            
            end
        
     end
     
     
   end
 fclose(fileid);

end
    
      

 
    
    
    
    
 
 
 
 
 
 