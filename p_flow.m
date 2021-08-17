function [] = p_flow(local)

[Bus,Branch]=readI3E(local);
Ybus=Ybus_Trafo(Bus,Branch);
clc
tol=10e-6;

G=real(Ybus);
B=imag(Ybus);
Bus0=Bus;
Branch0=Branch;

% Seleciona tipo de Barra
dPi=0;
dQi=0;
ip=0; iq=0;
    for i=1:length(Bus.n)
        
        if Bus.type(i)==0 || Bus.type(i)==1 %PQ
            ip=ip+1; iq=iq+1;
            dPi(ip)=Bus.n(i);
            dQi(iq)=Bus.n(i);
        end
        
        if Bus.type(i)==2 % PV
            ip=ip+1;
            dPi(ip)=Bus.n(i);
        end 
    end
    iteracao=1;
    md=1;
while(md>tol)    
% Pcalc & Qcalc0 

    k=1;
    while k<=length(Bus.n) %vetor de Erros dP
            Sum=0;
            for m=1:length(Bus.n)
                Sum=Sum+Bus.fv(m)*(G(k,m)*cos(Bus.fang(k)-Bus.fang(m))+B(k,m)*sin(Bus.fang(k)-Bus.fang(m)));
            end
            Pcalc(k,1)=Bus.fv(k)*Sum;
            Pesp(k,1)=(Bus.Gw(k)-Bus.loadw(k))/100;
        k=k+1;
    end
    
    k=1;
    while k<=length(Bus.n) % vetor de erros dQ
            Sum=0;
            for m=1:length(Bus.n)
                Sum=Sum+Bus.fv(m)*(G(k,m)*sin(Bus.fang(k)-Bus.fang(m))-B(k,m)*cos(Bus.fang(k)-Bus.fang(m)));
            end
            Qcalc(k,1)=Bus.fv(k)*Sum;
            Qesp(k,1)=(Bus.Gvar(k)-Bus.loadvar(k))/100;
         k=k+1;
    end
    
        cond=0; nogood=0;
        for t=1:length(Bus.n)
            
            if Bus.Maxvar(t)~=0 && Qcalc(t,1)>Bus.Maxvar(t)
                disp('Max')
                Qcalc(t,1)
                Bus.Maxvar(t)
                Qcalc(t,1)=Bus.Maxvar(t);
                cond=1;
            end
            if Bus.Minvar(t)~=0 && Qcalc(t,1)<Bus.Minvar(t)
                disp('Min')
                Qcalc(t,1)
                Bus.Minvar(t)
                Qcalc(t,1)=Bus.Minvar(t);
                cond=1;
            end
            %transformar PV em PQ
            if cond==1    
                for jj=1:length(dPi)-1
                    if t==dPi(jj)
                        dPi(jj)=[];
                        length(dPi);
                    end
                end
                for jj=1:length(dQi)-1
                    if t==dQi(jj)
                        nogood=1;
                    end
                end
                if nogood==1;
                    dQi(length(dQi)+1)=t;
                    nogood=0;                    
                end
                
                cond=0;
            end
        end
        
    dP=Pcalc(dPi);
    dQ=Qcalc(dQi);
    P=Pesp(dPi);
    Q=Qesp(dQi);
    
    for i=1:length(dPi) 
        dP(i)=dP(i)-P(i);
    end
    for i=1:length(dQi)
        dQ(i)=dQ(i)-Q(i);
    end
    Delt=[dP;dQ];

%% Jacobiana
    ih=union(dPi,dQi);
    il=dQi;

    for k=1:length(Bus.n)
        for m=1:length(Bus.n)
            if k~=m
                H(k,m)=Bus.fv(k)*Bus.fv(m)*( G(k,m)*sin( Bus.fang(k)-Bus.fang(m) )-B(k,m)*cos(Bus.fang(k)- Bus.fang(m))    );
                N(k,m)=Bus.fv(k)*( G(k,m)*cos( Bus.fang(k)-Bus.fang(m) )+B(k,m)*sin(Bus.fang(k)- Bus.fang(m))    );
                M(k,m)=-Bus.fv(k)*Bus.fv(m)*( G(k,m)*cos( Bus.fang(k)-Bus.fang(m) )+B(k,m)*sin(Bus.fang(k)- Bus.fang(m))    );
                L(k,m)=Bus.fv(k)*( G(k,m)*sin( Bus.fang(k)-Bus.fang(m) )-B(k,m)*cos(Bus.fang(k)- Bus.fang(m))    );
            end
           if k==m
               H(k,k)=-Qcalc(k)-Bus.fv(k)^2*B(k,k);
               N(k,k)=Bus.fv(k)^-1*(Pcalc(k)+Bus.fv(k)^2*G(k,k));
               M(k,k)=Pcalc(k)-Bus.fv(k)^2*G(k,k);
               L(k,k)=Bus.fv(k)^-1*(Qcalc(k)-Bus.fv(k)^2*B(k,k));
               
           end
           
        end
    end
     
    Jacob=[H(ih,ih) N(ih,il); M(il,ih) L(il,il)];
    
    f5=-Jacob\Delt;
    
   for i=1:length(f5)
       if i<=length(ih) %angulo
            ih(i);
            Bus.fang(ih(i))=Bus.fang(ih(i))+f5(i);
       end
       if i>length(ih)
            j=i-length(ih);
            Bus.fv(il(j))=Bus.fv(il(j))+f5(i);
       end
   end
   
   md=max(abs(Delt));
   iteracao=iteracao+1;
end

Bus.Gw(1)=Pcalc(1)*100;   
BUS = Bus.n;
V = Bus.fv;
Deg = rad2deg(Bus.fang);
Pg = Bus.Gw;
Qg = (Qcalc(:)-Qesp(:))*100;
Pl = Bus.loadw(:);
Ql = -Qesp(:)*100;


RESULTADOS_DE_BARRAS = table(BUS,V,Deg,Pg,Qg,Pl,Ql)   

BUS = 0;
V = 0;
Deg = 0;
Pg = sum(Bus.Gw);
Qg = sum(Qg);
Pl = sum(Pl);
Ql = sum(Ql);

TOTAL = table(BUS,V,Deg,Pg,Qg,Pl,Ql)

Active_MW=sum(Bus.Gw)-sum(Pl);
Reactive_Mvar=sum(Qg)-sum(Ql);

NET_LOSS = table(Active_MW,Reactive_Mvar)



end
















    