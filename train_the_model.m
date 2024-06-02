function [model1,model2]=train_the_model()
audio_path="E:\matlab\code\attendence system\final_rec_audio\train"; %% path of the audio directory

[data,id_label]=feature_extraction(audio_path);

load feature_database;


% trainnig the knn model

% trainedClassifier = fitcknn(data_feature,id, ...
%     Distance="euclidean", ...
%     NumNeighbors=1, ...
%     DistanceWeight="equal", ...
%     Standardize=true, ...
%     ClassNames=unique(id));
% 
% 
% 
% % cross validation of the model
% k = 5;
% group = id;
% c = cvpartition(group,KFold=k); % 5-fold stratified cross validation
% partitionedModel = crossval(trainedClassifier,CVPartition=c);
% 
% validationAccuracy = 1 - kfoldLoss(partitionedModel,LossFun="ClassifError");
% fprintf('\nValidation accuracy = %.2f%%\n', validationAccuracy*100);
% 
% validationPredictions = kfoldPredict(partitionedModel);
% figure(Units="normalized",Position=[0.4 0.4 0.4 0.4])
% confusionchart(id,validationPredictions,title="Validation Accuracy", ...
%     ColumnSummary="column-normalized",RowSummary="row-normalized");
% 
% model1=trainedClassifier;
model1=[];

%% subspace knn

learner = templateKNN('NumNeighbors',2);

ens = fitcensemble(data_feature,id, ...
                  'Method','Subspace', ...
                  'NumLearningCycles',30,...
                  'Learners',learner, ...
                  'NPredToSample',14);
cens = compact(ens);

% k = 10;
% group = id;
% c = cvpartition(group,KFold=k); % 10-fold stratified cross validation
% partitionedModel = crossval(ens,CVPartition=c);
% 
% validationAccuracy = 1 - kfoldLoss(partitionedModel,LossFun="ClassifError");
% fprintf('\nValidation accuracy subknn= %.2f%%\n', validationAccuracy*100);
% 
% validationPredictions = kfoldPredict(partitionedModel);
% figure(Units="normalized",Position=[0.4 0.4 0.4 0.4])
% confusionchart(id,validationPredictions,title="Validation Accuracy", ...
%     ColumnSummary="column-normalized",RowSummary="row-normalized");

 model2=cens;

 save train_model model2

end
