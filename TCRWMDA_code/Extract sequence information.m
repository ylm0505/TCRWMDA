

clc
clear
%%%%%提取代谢物代谢酶的蛋白质序列
% [~,lncrna]=xlsread(['lncrna name.xlsx']);

     data = fastaread('MAP3K14.fasta');
data2=fastaread('DGCR5.fasta')
str1=data.Sequence;
str2=data2.Sequence;
% findstr1={'A' 'T' 'C' 'G' 'AA' 'AT' 'AC' ...
% 'AG' };%需要查找的字符串
% tb1=tabulate(str1');
idx1=strfind(str1,'A');
idx2=strfind(str1,'T');
idx3=strfind(str1,'C');
idx4=strfind(str1,'G');
idx5=strfind(str1,'AA');
idx6=strfind(str1,'AT');
idx7=strfind(str1,'AC');
idx8=strfind(str1,'AG');
idx9=strfind(str1,'TA');
idx10=strfind(str1,'TT');
idx11=strfind(str1,'TC');
idx12=strfind(str1,'TG');
idx13=strfind(str1,'CA');
idx14=strfind(str1,'CT');
idx15=strfind(str1,'CC');
idx16=strfind(str1,'CG');
idx17=strfind(str1,'GA');
idx18=strfind(str1,'GT');
idx19=strfind(str1,'GC');
idx20=strfind(str1,'GG');
IDX=length(idx1)+length(idx2)+length(idx3)+length(idx4)+...
    length(idx5)+length(idx6)+length(idx7)+length(idx8)+...
    length(idx9)+length(idx10)+length(idx11)+length(idx12)+...
    length(idx13)+length(idx14)+length(idx15)+length(idx16)+...
    length(idx17)+length(idx18)+length(idx19)+length(idx20);
idx=[length(idx1),length(idx2),length(idx3),length(idx4),
    length(idx5),length(idx6),length(idx7),length(idx8),
    length(idx9),length(idx10),length(idx11),length(idx12),
    length(idx13),length(idx14),length(idx15),length(idx16),
    length(idx17),length(idx18),length(idx19),length(idx20)];
idx=idx/(IDX);
B = reshape(idx,1,20)
