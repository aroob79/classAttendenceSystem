function [all_feature,labels]=feature_extraction(path)

warning off;

aud_dir=dir(path); % reading the directorey

L=length(aud_dir);
labels=[];
all_feature=[];

% define some variable
Fs=44100;
windowlength=round(0.03*Fs);  % length of the frame
overlaplength=round(0.025*Fs); % length of the overlap region
win = hann(windowlength,"periodic");

% instantiate the audiofeatureExtractor function

aFE=audioFeatureExtractor(Window=hamming(windowlength,"periodic"), ...
                          SampleRate=Fs, ...
                          zerocrossrate=true, ...
                          pitch=true, ...
                          shortTimeEnergy=true, ...
                          spectralCentroid=true, ...
                          OverlapLength=overlaplength);


for i=3:L

    temp_path=path+"\"+string(aud_dir(i).name);
    temp_dir=dir(temp_path);
    num_of_audio=length(temp_dir);

    temp_feature=[];

    for j=3:num_of_audio

        audio_name=temp_path+"\"+string(temp_dir(j).name);
        [y,Fs]=audioread(audio_name);

        %% some preprocessing of the audio

        %removing the high frequency component

        d=designfilt('lowpassfir', ...
                      'FilterOrder',5, ...
                      'CutoffFrequency',500, ...
                      'SampleRate',Fs);

        y=filtfilt(d,y);

        % removing the silent part and detecting the endpoint of the signal

        new_signal=removing_silentpart(y,Fs);
        disp(audio_name)

        % extracting the mfcc and other feature

        S = stft(new_signal, ...          %%calculating the short time fft 
                 "Window",win, ...
                 "OverlapLength",overlaplength, ...
                 "Centered",false);

        % calculating the mfcc and delta mfcc co-efficient 
        [coeffs,delta] = mfcc(S,Fs,"LogEnergy","Ignore"); % this is the mfcc feature

        %  % extracting other feature like pitch Zcr and spectral centroide

        feature=extract(aFE,new_signal);

        % storing all feature in a array
        feature1=[coeffs,delta];  %

        % filtering the voice part and non voice part using zcrthreshold and energythreshold
        idx=info(aFE);
        
        % defining the threshold value for energythreshold and zcrthreshold for filtering the non voice part 
        energythreshold=0.007;
        zcrthreshold=0.16;

        % the value of energy and zcr smaller and grater than the energy
        % threshold and zcr respectively are considered as non voice and
        % filtered out the
        % taking the index of voice part

        voice=((feature(:,idx.shortTimeEnergy))>energythreshold) & (feature(:,idx.zerocrossrate)<zcrthreshold);
        % removing non voice row from feature 
        feature(~voice,:)=[];
        feature1(~voice,:)=[];
       
        feature(:,[idx.zerocrossrate,idx.shortTimeEnergy])=[];
        

        % storing all feature in a variable
        feature=[feature1,feature];

        % storing the feature in a temporary variable
        temp_feature=[temp_feature;feature];

        % labeling the feature
        idd=str2num(aud_dir(i).name);
        label=repelem(idd,size(feature,1));
        labels=[labels;label'];

    end

    % standerizing the data
    m=mean(temp_feature,1);  % claculate mean for each colomn
    s=std(temp_feature,[],1);  % claculate standerd deviation for each column
    temp_feature=(temp_feature-m)./s;  % normalizing each value

    all_feature=[all_feature;temp_feature];
end

%saving the data in a database
try
    %         load feature_database
    data_feature=[data_feature;all_feature];
    id=[id;labels];
    save feature_database
catch
    data_feature=all_feature;
    id=labels;
    save feature_database data_feature id
end
end