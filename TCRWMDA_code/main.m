%%%Three-layer heterogeneous network combined with unbalanced random walk 
%for miRNA-disease association prediction
clc
clear
%%%load data
A=textread('knowndiseasemirnainteraction.txt');
B=textread('mirna-lncrna.txt');
C=textread('lncrna-disease.txt');
lncrnafeature=textread('lncrnafeature.txt');

[~,disease]=xlsread(['.\1.miRNA-disease association\disease name.xlsx']);
[~,miRNA]=xlsread(['.\1.miRNA-disease association\miRNA name.xlsx']);
[~,lncrna]=xlsread(['lncrna name.xlsx']);
alpha=0.4; l=2;r=2;
nm=max(A(:,1)); % nd=495:the number of mirnas
nd=max(A(:,2)); % nd=383:the number of diseases
nl=max(B(:,2));% nl=34:the number of lncrnas
[aa,]=size(A);
[bb,]=size(B);
[cc,]=size(C);
% aa:the number of known mirna-disease associations
%interaction: adjacency matrix for the mirna-disease association network
%interaction(i,j)=1 means there is a known association between micrna j and disease i
% FS:the functional similarity between m(i) and m(j)
% FSP:Functional similarity weighting matrix
% SS:the semantic similarity between d(i) and d(j).
% SSP:semantic similarity weighting matrix
%
FS = load(['.\4.miNA functional simialrity\functional similarity matrix.txt']);
FSP = load(['.\4.miNA functional simialrity\Functional similarity weighting matrix.txt']);
SS1 = load(['.\2.disease semantic similarity 1\disease semantic similarity matrix 1.txt']);
SS2 = load(['.\3.disease semantic similarity 2\disease semantic similarity matrix 2.txt']);
SS = (SS1+SS2)/2;
SSP = load(['.\2.disease semantic similarity 1\disease semantic similarity weighting matrix1.txt']);
%interaction: adajency matrix for the disease-miRNA association network
%interaction(i,j)=1 means miRNA j is related to disease i
interactionA = zeros(nm,nd);
interactionB = zeros(nm,nl);
interactionC = zeros(nl,nd);
for i=1:aa
    interactionA(A(i,1),A(i,2))=1;   
end
for i=1:bb%%
    interactionB(B(i,1),B(i,2))=1;
end
for i=1:cc
    interactionC(C(i,1),C(i,2))=1;
end


yitaM = 0.5;yitaD=0.5;  yita=0.5;
warning('off');
seed = 1;


%%%%
CV=5;    %%We take 5-fold crossvalidation 
rand('state',seed);
[row,col]=size(interactionA);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[row_index,col_index]=find(interactionA==1); %%find all the elments that its value is 1
link_num=sum(interactionA(:));  %% caculate the numbers of the interaction
rand('state',seed);
random_index=randperm(link_num);
size_of_CV=round(link_num/CV);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
result=zeros(1,7);
for k=1:CV  %%%
    fprintf('begin to implement the cross validation:round =%d/%d\n', k, CV);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (k~=CV) %% We allocate all the interaction elements into 5 parts
        test_row_index=row_index(random_index((size_of_CV*(k-1)+1):(size_of_CV*k)));
        test_col_index=col_index(random_index((size_of_CV*(k-1)+1):(size_of_CV*k)));
    else
        test_row_index=row_index(random_index((size_of_CV*(k-1)+1):end));
        test_col_index=col_index(random_index((size_of_CV*(k-1)+1):end));
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    train_set=interactionA;
    test_link_num=size(test_row_index,1);
    for i=1:test_link_num %% let interaction elements' value equal to 0 in the test matrix
        train_set(test_row_index(i),test_col_index(i))=0;  %
    end
    
 %calculate gaussiansimilarity%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [kd,km] = gaussiansimilarity(train_set,nd,nm);              
    [sd,sm] = integratedsimilarity(FS,FSP,SS,SSP,kd,km);
    sl=CosineSmilarity(lncrnafeature);
    %%%%%%%%%thrrw%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %M£ºTransition probability matrix of miRNA
    %D£ºTransition probability matrix of disease
   %L£ºTransition probability matrix of lncRNA
    M=transition_matrix_network_propagation1(sm);
    D=transition_matrix_network_propagation1(sd);
    L=transition_matrix_network_propagation1(sl);
    [score]=thrrw(M,D,train_set,interactionB,interactionC,L, 1, 1, 1,0.1,0.1,0.9);
% [score]=thrrw(M,D,interactionA,interactionB,interactionC,L, l, r, s,alpha,lamda,betal);
    allresult(disease,miRNA,interactionA,score);

    result=result+model_evaluate(interactionA,score,train_set);
    result/k
end
result=result/CV;
disp('aupr,auc,sen,spec,precision,accuracy,f1')
result



