function Rt = Laplacian_Regularized(SM,SD,A,yitaM,yitaD,yita)
  %SM: adjacency matrix of the miRNA similarity network
  %SD: adjacency matrix of the disease similarity network
  %A: adjacency matrix of the miRNA-disease association network
  %normFun: Laplacian normalization for miRNA similarity and disease similarity
  LM = normFun(SM);
  LD = normFun(SD);
  FM = SM*pinv((SM+yitaM*LM*SM))*A';
  FD = SD*pinv((SD+yitaD*LD*SD))*A;
  Rt = yita*FM'+(1-yita)*FD;
end

function LM = normFun( M )

DM = diag(sum(M));
DM2 = diag(sum(M).^(-1/2));
LM =  DM2*(DM-M)*DM2; 

end
