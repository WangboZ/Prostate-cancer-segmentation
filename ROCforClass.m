function ROCforClass(predicted_label,NMC_opMATRIX,kNN_opMATRIX)
% function of roc plot for three classifiers
% the input are the output of three classifiers: predicted_label,NMC_opMATRIX,
% kNN_opMATRIX 
%% Author Information
%   Wangbo Zheng,Hao Wang
%   patrecgroup08
%	University of Stuttgart
%% calculate FA and TP ,plot roc for nearest mean classifier
hold off;
kNN_opMATRIX=[kNN_opMATRIX NMC_opMATRIX(:,2)];
SVM_opMATRIX=[predicted_label NMC_opMATRIX(:,2)];
NMC_opMATRIX(NMC_opMATRIX==1)=0;
NMC_opMATRIX(NMC_opMATRIX==2)=1;
predictNM=NMC_opMATRIX(:,1);
ground_truthnm=NMC_opMATRIX(:,2);
n=size(NMC_opMATRIX,1);
pos_numnm=sum(ground_truthnm==1);
neg_numnm=sum(ground_truthnm==0);
[preNM,indexNM]=sort(predictNM);
ground_truthnm=ground_truthnm(indexNM);
x1=zeros(n+1,1);
y1=zeros(n+1,1);
aucnm=0;
x1(1)=1;
y1(1)=1;
for i=2:n
    TPNM=sum(ground_truthnm(i:n)==1);
    FPNM=sum(ground_truthnm(i:n)==0);
    x1(i)=FPNM/neg_numnm;
    y1(i)=TPNM/pos_numnm;
    aucnm=aucnm+(y1(i)+y1(i-1))*(x1(i-1)-x1(i))/2;
end
x1(n+1)=0;
y1(n+1)=0;
aucnm=aucnm+y1(n)*x1(n)/2;
plot(x1,y1);
%% calculate FA and TP ,plot roc for kNN classifier
kNN_opMATRIX(kNN_opMATRIX==1)=0;
kNN_opMATRIX(kNN_opMATRIX==2)=1;
predictKNN=kNN_opMATRIX(:,1);
ground_truthKNN=kNN_opMATRIX(:,2);
n=size(kNN_opMATRIX,1);
pos_numKNN=sum(ground_truthKNN==1);
neg_numKNN=sum(ground_truthKNN==0);
[preKNN,indexKNN]=sort(predictKNN);
ground_truthKNN=ground_truthKNN(indexKNN);
x2=zeros(n+1,1);
y2=zeros(n+1,1);
aucknn=0;
x2(1)=1;
y2(1)=1;
for i=2:n
    TPKNN=sum(ground_truthKNN(i:n)==1);
    FPKNN=sum(ground_truthKNN(i:n)==0);
    x2(i)=FPKNN/neg_numKNN;
    y2(i)=TPKNN/pos_numKNN;
    aucknn=aucknn+(y2(i)+y2(i-1))*(x2(i-1)-x2(i))/2;
end
x2(n+1)=0;
y2(n+1)=0;
aucknn=aucknn+y2(n)*x2(n)/2;
hold on;
plot(x2,y2);
legend('kNN');
hold on
%% calculate FA and TP ,plot roc for SVM classifier
SVM_opMATRIX(SVM_opMATRIX==1)=0;
SVM_opMATRIX(SVM_opMATRIX==2)=1;
predictSVM=SVM_opMATRIX(:,1);
ground_truthSVM=SVM_opMATRIX(:,2);
n=size(SVM_opMATRIX,1);
pos_numSVM=sum(ground_truthSVM==1);
neg_numSVM=sum(ground_truthSVM==0);
[preSVM,indexSVM]=sort(predictSVM);
ground_truthSVM=ground_truthSVM(indexSVM);
x3=zeros(n+1,1);
y3=zeros(n+1,1);
aucsvm=0;
x3(1)=1;
y3(1)=1;
for i=2:n
    TPSVM=sum(ground_truthSVM(i:n)==1);
    FPSVM=sum(ground_truthSVM(i:n)==0);
    x3(i)=FPSVM/neg_numSVM;
    y3(i)=TPSVM/pos_numSVM;
    aucsvm=aucsvm+(y3(i)+y3(i-1))*(x3(i-1)-x3(i))/2;
end
x3(n+1)=0;
y3(n+1)=0;
aucsvm=aucsvm+y3(n)*x3(n)/2;
hold on;
plot(x3,y3);
legend('nearest mean','kNN','SVM');
xlabel('False positive rate');
ylabel('True positive rate');
title('ROC');