function [new_signal]=removing_silentpart(y,Fs)


% removint the silent part
        frame_duration=0.01;  %% the frame length is 10ms
        frame_length=Fs*frame_duration;
        N=length(y);
        frame_number=floor(N/frame_length);
        new_signal=zeros(N,1);
        count=1;
        threshold=0.05;

        for i=1:frame_number

            % extracting the frame
            frame=y((((i-1)*frame_length)+1):(frame_length*i));

            % finding the maximum value of the frame

            max_val=max(frame);

            % finding the silent frame and removing it

            if (max_val>threshold)

                count=count+1;
                new_signal((((count-1)*frame_length)+1):(frame_length*count))=frame;
            end
        end

        % end point detection
        
        post=find(new_signal~=0);
        length1=length(new_signal);
        new_signal(post(end):length1)=[];

end
