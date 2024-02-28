function diff = leapfrog_testA2(epsilon,Nhmc,lambda0,x0)
%Same test for reversibility but for the double well potential
m0=1;
 Phi=zeros(1,1000);

    Pi = randn(size(Phi));
    Phi_p = [Phi(2:end) Phi(1)];
    Phi_m = [Phi(end) Phi(1:end-1)];

    
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
 %inversione
    Pi=-Pi;
    Pi = Pi + 0.5*epsilon *(m0*(-2*Phi1+Phi_p+Phi_m)-4*lambda0*(Phi1.^2-x0^2).*Phi1);
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
    diff=Phi1-Phi;
end