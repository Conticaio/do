clear all
clc
disp('  ***        Olá, esse é um programa para simulação UFV     ****      ')
pause(4);
disp('Você realizou as alterações necessárias no simulink?')
yes=input('[y/n]: ','s');
clc
if yes=='y'
 disp('     ==>GOOD WORK!')
 
dest=input('copie o destino do projeto aqui: ','s');
sys=input('Nome do Sistema Simulink: ','s');
sys=strcat(dest,'\',sys);
leve=input('CARGA COPEL LEVE [MVA] W+jVAR: ');
pesada=input('CARGA COPEL PESADA [MVA] W+jVAR: ');
gd=input('CARGA GD [MVA] W+jVAR: ');
rc=input('Impedância de falta-tera leve (40?): ');
rd=input('Impedância de falta-terra pesada (500?): ');
Ir_v=input('Usina a Vazio (50 W/m?): ');
Ir_m=input('Usina a Media (400 W/m?): ');
Ir_t=input('Usina a Total (800 W/m?): ');
Temp=input('Temperatura de Simulação(45ºC?): ');
%excel_out=input('Nome do Excel para saídas: ','s');
clc
disp('running system...')
pause(1);
Untitled2
 
else
 disp('     ==>VAI FAZER ENTÃO VACILÃO')
end




