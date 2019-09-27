
function LM = normFun( M )

DM = diag(sum(M));
DM2 = diag(sum(M).^(-1/2));
LM =  DM2*(DM-M)*DM2; 

end