clear all
clc
disp('  ***        Ol�, esse � um programa para simula��o UFV     ****      ')
pause(4);
disp('Voc� realizou as altera��es necess�rias no simulink?')
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
rc=input('Imped�ncia de falta-tera leve (40?): ');
rd=input('Imped�ncia de falta-terra pesada (500?): ');
Ir_v=input('Usina a Vazio (50 W/m?): ');
Ir_m=input('Usina a Media (400 W/m?): ');
Ir_t=input('Usina a Total (800 W/m?): ');
Temp=input('Temperatura de Simula��o(45�C?): ');
%excel_out=input('Nome do Excel para sa�das: ','s');
clc
disp('running system...')
pause(1);
Untitled2
 
else
 disp('     ==>VAI FAZER ENT�O VACIL�O')
end




