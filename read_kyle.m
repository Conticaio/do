function [Curva]=read_kyle(filename) 
file=strcat('C:\Users\CAIO.CONTI\Desktop\Biblioteca\Curvas Kyle\',filename);
num=xlsread(file,'UserCurve');  
[fim,l]=size(num);
Curva=num(2:fim,1:2);
end

