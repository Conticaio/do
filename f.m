function [Mabc]=f(M012)
%%Transformada de Fortscue
j=sqrt(-1);
a=exp(2*pi/3*j);
A=[1 1 1 ; 1 a^2 a; 1 a a^2];
Mabc=A*M012;
end