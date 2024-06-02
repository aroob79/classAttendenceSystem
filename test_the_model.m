function [prediction]=test_the_model()

path="E:\matlab\code\attendence system\final_rec_audio\test";
feature_extraction(path);
load feature_database;
load train_model;

%% knn model

% prediction=predict(model,data_feature);
% 
% figure(Units="normalized",Position=[0.4 0.4 0.4 0.4])
% confusionchart(id(:),prediction,title="Test Accuracy (Per Frame)", ...
%     ColumnSummary="column-normalized",RowSummary="row-normalized");
% title('knn model');



%% subspace knn model

prediction1 = predict(model2,data_feature);

save prediction1;

% cp=classperf(id);
% 
% classperf(cp,prediction1);
% disp(cp.CorrectRate*100);
% 
% % figure(Units="normalized",Position=[0.4 0.4 0.4 0.4])
% % confusionchart(id(:),prediction1,title="Test Accuracy (Per Frame)", ...
% %     ColumnSummary="column-normalized",RowSummary="row-normalized");
% cm=confusionmat(id,prediction1);
% cmt=cm';
% diagonal=diag(cmt);
% sum_of_rows=sum(cmt,2);
% presission=mean(diagonal./sum_of_rows);
% disp(presission)
% sum_of_columns=sum(cmt,1);
% recall=mean(diagonal./sum_of_columns');
% disp(recall);
% f1_score=2*((presission*recall)/(recall+presission));
% disp(f1_score);
% disp(cm);



end
