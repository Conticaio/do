function [zeq]=p(Z)

    l=length(Z);
    ax_s=0;
    for i=1:l
        ax_s=ax_s+1/Z(i);
    end
    zeq=1/ax_s;
end