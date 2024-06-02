function [predictrd_id]=take_attendece(app,name,id)

path=test_audio_recorder(app,name,id);
[all,lab]=feature_extraction(path);
load feature_database;
load train_model;
load record;
% predicting the data
prediction=predict(model2,data_feature);

% find the uique id in the predicted data
label=unique(prediction);

l=length(label);
prdn=[];
disp([label']);

for i=1:l

    prdn=[prdn,sum(prediction==label(i))];
end

[val,ind]=max(prdn);

predictrd_id=label(ind);
disp(predictrd_id);

% prdn(ind)=0;
% [val2,ind2]=max(prdn);
% predictrd_id2=label(ind2);
% thres=((val-val2)/val)*100;


% if thres>55
%     date=string(datetime);
%     date1=[date1;date];
%     Id1=string(predictrd_id);
%     Id=[Id;Id1];
%     save record  date1 Id
%     try
%         load record
%         date1=[date1;date];
%         Id=[Id;predictrd_id];
%         save record
%     catch
%         date1=date;
%         Id=predictrd_id;
%         save record date1 Id;
%     end
    app.CommandTextArea.Value="hello "+string(predictrd_id)+" your attendence has been taken";
% else
%     if id==predictrd_id
% 
%         app.CommandTextArea.Value=("the attendence is not taken try again recomended id "+string(predictrd_id2));
% 
%         disp(["the attendence is not taken try again"+"recomended id "+string(predictrd_id2)])
%     else
%         app.CommandTextArea.Value=("the attendence is not taken try again recomended id "+string(predictrd_id));
% 
% 
%         disp(["the attendence is not taken try again"+"recomended id "+string(predictrd_id)]);
%     end
% end


disp(std(prdn));

rmdir((path+"\"+int2str(unique(id))),'s');

disp(label(ind));
disp(prdn);


end