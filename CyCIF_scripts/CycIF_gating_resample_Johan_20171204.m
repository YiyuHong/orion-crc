%% CycIF gated resampling for all data/slides 
%  Jerry Lin 2017/12/04

%%Initialization 

slideNames = {'Parental_T2',...
'Parental_T3',...
'Parental_T4',...
'SCP01B_T1',...
'SCP01B_T2',...
'SCP01B_T3',...
'SCP3B_T1',...
'SCP3B_T2',...
'SCP3B_T3',...
'SCP17B_T1',...
'SCP17B_T2',...
'SCP17B_T3',...
'SCP29_T1',...
'SCP29_T2',...
'SCP29_T3',...
'SCP32_T1',...
'SCP32_T2',...
'SCP32_T3'};

samplesize = 10000;
gatesample = table;
gatename = 'EGFR';
cutoff = 7.5;


%% remove autofluorescence background on A488 & A555 channels

for i =1:length(slideNames)
        name1 = strcat('data',slideNames{i});
        disp(strcat('Gating',{' '},name1));
        data1 = eval(name1);        
        data2 = data1(log(data1{:,gatename})>cutoff,:);
        %eval(strcat(name1,'=data2;'));
        sample1 = datasample(data2,samplesize);
        eval(strcat(gatename,slideNames{i},'=sample1;'));
        
        sample1.slidename = repmat(slideNames(i),length(sample1.X),1);
        if(isempty(gatesample))
            gatesample = sample1;
        else
            gatesample = vertcat(gatesample,sample1);
        end
end

clear data1 data2 sample1;