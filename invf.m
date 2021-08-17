function [M012]=invf(Mabc)
%Transformada de Fortscue de fase para Seq.
j=sqrt(-1);
a=exp(2*pi/3*j);
A=[1 1 1 ; 1 a^2 a; 1 a a^2];
M012=A\Mabc;
end