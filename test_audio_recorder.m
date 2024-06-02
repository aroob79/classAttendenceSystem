function [all_path]=test_audio_recorder(app,name,id)

Fs=44100;
nbits=16;
chnl=1;
Nsecond=3;
%name=input('Enter name :','s');
%id=input('Enter id :');
path="E:\matlab\code\attendence system\final_rec_audio\run_test";
[ststs,msg]=mkdir("E:\matlab\code\attendence system\final_rec_audio\run_test",int2str(id));

% removing the folder if exist

if string(msg)==string('Directory already exists.')
    rmdir(path+"\"+int2str(id),'s');
end
% recreating the folder

[ststs,msg]=mkdir("E:\matlab\code\attendence system\final_rec_audio\run_test",int2str(id));

num_aud=2;
all_path=[];
for i=1:num_aud
    fullpath=path+"\"+int2str(id)+"\"+name+string(i)+".wav";

    if i<=num_aud/2
        %disp('say id !!!');
        app.CommandTextArea.Value{1}='say id !!!';
    else
       % disp('say name !!!');
       app.CommandTextArea.Value{1}='say name !!!';
    end

    record=audiorecorder(Fs,nbits,chnl);
   %app.CommandTextArea.Value{2}=('start recording');
    pause(1)
    app.CommandTextArea.Value{2}=('3');
    pause(1)
    app.CommandTextArea.Value{3}=('2');
    pause(1)
    app.CommandTextArea.Value{4}=('1');
    pause(1)
    app.CommandTextArea.Value{5}=('G0!');
    recordblocking(record,Nsecond);
    app.CommandTextArea.Value{6}=('End recording');
    audio_array=getaudiodata(record);
    audiowrite(fullpath,audio_array,Fs);
    %all_path=[all_path;fullpath];
    pause(1)
    app.CommandTextArea.Value='';

end
all_path=path;
end