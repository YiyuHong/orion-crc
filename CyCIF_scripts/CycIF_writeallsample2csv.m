%% New Triplet normalization of data 
%% Jerry LIn 2017/10/27

slideNames = {'BP_40b_176',...
'i074_40a_132',...
'i074_40b_132',...
'i109_40_80',...
'i151_40_90',...
'i221_40a_18',...
'i221_40b_156',...
'i493_40a_117',...
'i493_40b_165',...
'i779_40b_460',...
'i781_40a_156',...
'i781_40b_132',...
'i943_40_150',...
'LP1_40a_90',...
'LP1_40b_63',...
'LP2_40a_180',...
'LP2_40b_170',...
'NL1_40_110',...
'NL2_40_484',...
'PS1_40a_63',...
'PS1_40b_42',...
'PS2_40_100',...
'PS3_40a_42',...
'PS3_40b_90',...
'PS4_40a_135',...
'PS4_40b_54',...
'PS5_40a_108',...
'PS5_40b_120',...
'PS6_40b_56'};

%samplesize = 5000;

for i =1:length(slideNames)
        display(strcat('Writing:',slideNames{i}));
        name3 = strcat('sample',slideNames{i});
        name4 = strcat('sample',slideNames{i},'.csv');
        eval(strcat('sample1=',name3,';'));
        writetable(sample1,name4);
end


clear sample1;
