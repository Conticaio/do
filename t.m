clc
clear all

%SI
k=.14;
alph=.02;
a=log10(1.02);
b=log10(40);
i=logspace(a,b,1e4);
SI=k./((i).^alph-1)';
SI=[i',SI];

%VI
k=13.5;
alph=1;
VI=k./((i).^alph-1)';
VI=[i',VI];

%LI
k=120;
alph=1;
LI=k./((i).^alph-1)';
LI=[i',LI];

%EI
k=80;
alph=2;
EI=k./((i).^alph-1)';
EI=[i',EI];


clear a
clear b
clear i
clear b
clear k
clear alph

save curvasIEC.mat