function [PhiOUT,acc] = HMCanarm2(m0,lambda0,NT,epsilon,Nhmc,Niter,Phi0)
%Implementation of the Monte Carlo method for the amarmonic(quartic)
%potential
x0=1/m0;
    if (nargin==6)
        Phi = zeros(1,round(NT))+x0;
    else
        Phi = Phi0;
    end
    
    PhiOUT = zeros(Niter,round(NT));
    acc = 0;

for i = 1:Niter

    Pi = randn(size(Phi));
    Phi_p = [Phi(2:end) Phi(1)];
    Phi_m = [Phi(end) Phi(1:end-1)];

    
    
    S = sum(0.5*m0*((Phi_p-Phi).^2)+lambda0*((Phi.^2-x0^2).^2));
    T = 0.5*sum(Pi.^2);
    
    Pi = Pi + 0.5*epsilon *(m0*(-2*Phi+Phi_p+Phi_m)-4*lambda0*(Phi.^2-x0^2).*Phi);
    Phi1 = Phi;
    for t = 1:Nhmc
        Phi1 = Phi1 + epsilon*Pi;
        Phi_p = [Phi1(2:end) Phi1(1)];
        Phi_m = [Phi1(end) Phi1(1:end-1)];
        Pi = Pi + epsilon *(m0*(-2*Phi1+Phi_p+Phi_m)-4*lambda0*(Phi1.^2-x0^2).*Phi1);
    end
    Phi1 = Phi1 + epsilon*Pi;
    Phi_p = [Phi1(2:end) Phi1(1)];
    Phi_m = [Phi1(end) Phi1(1:end-1)];
    Pi = Pi + 0.5*epsilon *(m0*(-2*Phi1+Phi_p+Phi_m)-4*lambda0*(Phi1.^2-x0^2).*Phi1);
    
    S1 = sum(0.5*m0*((Phi_p-Phi1).^2)+lambda0*((Phi1.^2-x0^2).^2));
    T1 = 0.5*sum(Pi.^2);
    
    dH = T1 - T + S1 - S;
    if (dH > 0) 
        if ( rand()<exp(-dH) )
            Phi = Phi1;
            acc = acc+1;
        end
    else
        Phi = Phi1;
        acc = acc+1;
    end
    
    PhiOUT(i,:) = Phi;
    
end

acc = acc/Niter;

end

