function [PT] = thrrw(M,D,A,B,C,L, l, r, s,alpha,lamda,betal)


if sum(A(:)) > 0
    A1 = A/ sum(A(:));
end
if sum(B(:)) > 0
    B1 = B / sum(B(:));
end
if sum(C(:)) > 0
    C1 = C / sum(C(:));
end

RR=A1;
k = 1;

if (l<r)
    da=r;
else
    da=l;
end
t1=0;
t2=0;

% while  (k <= da) % && (delta>1e-10)
for k=1:da
    [P, V1, V2]=bNetrw(B1,C1,L,betal,s);

    if(k <= l)
        RR1 = alpha*M*RR+(1-alpha)*(lamda*P+(1-lamda)*A);
        t1=1;
    end
    if(k <= r)
        RR2= alpha*RR*D+(1-alpha)*(lamda*P+(1-lamda)*A);
        t2=1;
    end
    RR=(t1*RR1 + t2*RR2)/(t1 + t2);
    PT = RR;
    % k = k + 1;
    t1=0;
    t2=0;
    B=V1;
    C=V2;
end

