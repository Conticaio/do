function faz(arquivo,M,teste)
    fprintf(arquivo,'\n');
    fprintf(arquivo,'TABELA|%s',teste);
    for p=1:length(M)
        fprintf(arquivo,'\n');
        fprintf(arquivo,'%.2f|%.8f',M(p,1),M(p,2));
    end
    fprintf(arquivo,'\n');
    fprintf(arquivo,'FECHATABELA');
end
    