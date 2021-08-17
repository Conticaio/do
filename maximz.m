function [Vx] = maximz(V)
fim=length(V(:,1));
a=log10(V(1,1));
b=log10(V(fim,1));
max=1e4;
V1=logspace(a,b,max);
V2=interp1(V(:,1),V(:,2),V1,'spline');
Vx=[V1',V2'];
% loglog(V(:,1),V(:,2),'-r','LineWidth',2)
% loglog(Vx(:,1),Vx(:,2),'-g','LineWidth',2)
end
