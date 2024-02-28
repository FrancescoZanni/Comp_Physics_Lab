function [ diff] = leapfrog_testHO(epsilon,Nhmc,term)
%Function that checks the reversibility of the leapfrog method. Returns the
%difference between the initial state and the state obtained by doing Nhmc
%steps forwards and backwards (aim value is 0)
m0=1;
omg2=1;
Phi0=zeros(1,100);
if nargin==3
Phi0=term;
end
Phi=Phi0;
 Pi = randn(size(Phi));
    Phi_p = [Phi(2:end) Phi(1)];
    Phi_m = [Phi(end) Phi(1:end-1)];
    
    
    Pi = Pi + 0.5*epsilon * m0*(Phi_p + Phi_m - (2+omg2)*Phi);
    Phi1 = Phi;
    for t = 1:Nhmc
        Phi1 = Phi1 + epsilon*Pi;
        Phi_p = [Phi1(2:end) Phi1(1)];
        Phi_m = [Phi1(end) Phi1(1:end-1)];
        Pi = Pi + epsilon * m0*(Phi_p + Phi_m - (2+omg2)*Phi1);
    end
    Phi1 = Phi1 + epsilon*Pi;
    Phi_p = [Phi1(2:end) Phi1(1)];
    Phi_m = [Phi1(end) Phi1(1:end-1)];
    Pi = Pi + 0.5*epsilon * m0*(Phi_p + Phi_m - (2+omg2)*Phi1);
   
    %inversione
    Pi=-Pi;
    phimiddle=Phi1;
     Pi = Pi + 0.5*epsilon * m0*(Phi_p + Phi_m - (2+omg2)*Phi1);
     for t = 1:Nhmc
        Phi1 = Phi1 + epsilon*Pi;
        Phi_p = [Phi1(2:end) Phi1(1)];
        Phi_m = [Phi1(end) Phi1(1:end-1)];
        Pi = Pi + epsilon * m0*(Phi_p + Phi_m - (2+omg2)*Phi1);
    end
    Phi1 = Phi1 + epsilon*Pi;
    Phi_p = [Phi1(2:end) Phi1(1)];
    Phi_m = [Phi1(end) Phi1(1:end-1)];
    Pi = Pi + 0.5*epsilon * m0*(Phi_p + Phi_m - (2+omg2)*Phi1);
    diff= Phi1-Phi0;
    end

