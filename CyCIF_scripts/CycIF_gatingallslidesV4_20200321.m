%% CycIF gating all
%  Need slidename & gateTable & doubeGates 
%  Gating each slide independently
%  Jerry Lin 2020/03/21
%  Jerry Lin 2021/08/26  fix bugs and add 0 sample function

%% -- Initialization --

samplesize = input('Please input sample size:'); %5000;
doubleflag = input('Double gating (1:yes, 0:no):');  
allmarkers = gateTable.Properties.VariableNames;

if samplesize > 0
    allsample = table;
end
%allnames = gateTable.Properties.VariableNames;


%% -- Gating all  & resampling --

for i =1:size(gateTable,1)
        name1 = strcat('data',gateTable.slideName{i});
        %idx1 = find(ismember(gateTable.slideName,slideName{i}));
        
        disp(strcat('Gating:',name1));
        data1 = eval(name1);
        disp(strcat('Processing:',gateTable.slideName{i}));
        
        %--  Gating all channels (single-gate) --
        for g = 2:length(allmarkers)
            data1 = CycIF_setgate(data1,allmarkers{g},gateTable{i,g},'none');
        end
        
        %-- Double gating --
        if doubleflag ==1
            for j=1:size(doubleGates,1)
                %gatename = strcat(doubleGates{i,1},'p',doubleGates{i,2},'p');
                gate1 = strcat(doubleGates{j,1},'p');
                gate2 = strcat(doubleGates{j,2},'p');
                gatename = strcat(gate1,gate2);
                data1{:,gatename}=data1{:,gate1} & data1{:,gate2};
            end
        end
        
        %-- Resampling --
        if samplesize>0
            sample1 = datasample(data1,samplesize);
            eval(strcat('sample',gateTable.slideName{i},'=sample1;'));
            sample1.slidename = repmat(gateTable.slideName(i),length(sample1.X),1);
            if(isempty(allsample))
                allsample = sample1;
            else
                allsample = vertcat(allsample,sample1);
            end      
        end
        
        %-- re-assign --
        eval(strcat(name1,'=data1;'));
end

clear data1;