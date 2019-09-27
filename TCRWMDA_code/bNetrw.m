function [R,R1,R2]=bNetrw(B1,C1, L, betal,s)
% %%      R1 = betal * ML * L + (1-betal) * B;
%       R2 = betal * LD* C + (1-betal) * C;
for j = 1:s
      R1 = betal * B1 * L + (1-betal) * B1;
      R2 = betal * L * C1 + (1-betal) * C1;
end

R =R1*R2;
% R =(2*R1+1*R2)/3;
% if(s>0)
%     PT=PT/s;
% end

end



