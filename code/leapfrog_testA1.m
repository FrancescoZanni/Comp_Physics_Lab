function diff = leapfrog_testA1(epsilon,Nhmc)
%Same test for reversibility but for quartic potential
lambda0=1;
m0=1;
omg2=1;


Phi0=zeros(1,1000);
if nargin==3
Phi0=term;
end
Phi=Phi0;
 Pi = randn();
    Phi_p = [Phi(2:end) Phi(1)];
    Phi_m = [Phi(end) Phi(1:end-1)];
    
    
    Pi = Pi + 0.5*epsilon *(m0.*((Phi_p+Phi_m)-(2+omg2).*Phi.^2)-4*lambda0*(Phi.^3));
    Phi1 = Phi;
    for t = 1:Nhmc
        Phi1 = Phi1 + epsilon*Pi;
        Phi_p = [Phi1(2:end) Phi1(1)];
        Phi_m = [Phi1(end) Phi1(1:end-1)];
        Pi = Pi + epsilon *(m0.*((Phi_p+Phi_m)-(2+omg2).*Phi1.^2)-4*lambda0*(Phi1.^3));
    end
    Phi1 = Phi1 + epsilon*Pi;
    Phi_p = [Phi1(2:end) Phi1(1)];
    Phi_m = [Phi1(end) Phi1(1:end-1)];
    Pi = Pi + 0.5*epsilon *(m0.*((Phi_p+Phi_m)-(2+omg2).*Phi1.^2)-4*lambda0*(Phi1.^3));
    
   
    %inversione
    Pi=-Pi;
    Pi = Pi + 0.5*epsilon *(m0.*((Phi_p+Phi_m)-(2+omg2).*Phi1.^2)-4*lambda0*(Phi1.^3));
    phi2=Phi1;
      for t = 1:Nhmc
        Phi1 = Phi1 + epsilon*Pi;
        Phi_p = [Phi1(2:end) Phi1(1)];
        Phi_m = [Phi1(end) Phi1(1:end-1)];
        Pi = Pi + epsilon *(m0.*((Phi_p+Phi_m)-(2+omg2).*Phi1.^2)-4*lambda0*(Phi1.^3));
      end
    Phi1 = Phi1 + epsilon*Pi;
    %Phi_p = [Phi1(2:end) Phi1(1)];
    %Phi_m = [Phi1(end) Phi1(1:end-1)];
    %Pi = Pi + 0.5*epsilon *(m0.*((Phi_p+Phi_m)-(2+omg2).*Phi1.^2)-4*lambda0*(Phi1.^3));
    diff= Phi1-Phi0;
    end

