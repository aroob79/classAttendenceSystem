function []=audio_recorder()
Fs=44100;
nbits=16;
chnl=1;
Nsecond=3;
num_aud=20;
name=input('Enter name :','s');
id=input('Enter id :');
path="E:\matlab\code\attendence system\final_rec_audio\train\"+int2str(id);
mkdir("E:\matlab\code\attendence system\final_rec_audio\train",int2str(id));

% for others
% % path=string(pwd)+"\"+int2str(id);
% % mkdir(pwd,int2str(id))


for i=1:num_aud
    fullpath=path+"\"+name+"_"+string(i)+".wav";

    if i<=num_aud/2
        disp('say id !!!!');
        
    else
        disp('say name !!!');
    end

    record=audiorecorder(Fs,nbits,chnl);
    disp('start recording');
    %pause(1)
    disp('3');
    pause(1)
    disp('2');
    pause(1)
    disp('1');
    pause(1)
    disp('G0!');
    recordblocking(record,Nsecond);
    disp('End recording');
    
    audio_array=getaudiodata(record);

    audiowrite(fullpath,audio_array,Fs);
    pause(1)
end

