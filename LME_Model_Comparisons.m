%%% NOTE: 7/1/24
% THIS SCRIPT USES POST-PRE RESPONSES FROM NORMALIZED DATA, ANALYSIS IS VIA
% LINEAR MIXED MODEL AND CAN ACCOUNT FOR RANDOM EFFECTS, BUT CANNOT PERFORM
% A REPEATED MEASURES ANOVA

addpath( 'C:\plimon\SSRP_analysis_branch\Subj_Dataframes\');
data = importdata("Subject_ANOVA_DF_ExptGroup_RCA1_2F4F_PostMinPre_As1DependentVar_20240701_140749.mat");

dataFrame_converted = double(data.CRF_Difference_Values_1DPVAR); % import actual dataframe
dataFrame_label = cellstr(data.Headers); % import column labels for MANOVA

SSRP_df = array2table(dataFrame_converted,'VariableNames',{'sID','harmonic','contrast','hemifield','attnTo','postminpre'});

SSRP_df.sID         =categorical(SSRP_df.sID); % categorical and should be nested
SSRP_df.harmonic    = categorical(SSRP_df.harmonic); % categorical
SSRP_df.contrast    = categorical(SSRP_df.contrast); % categorical
SSRP_df.hemifield   = categorical(SSRP_df.hemifield); % categorical
SSRP_df.attnTo = categorical(SSRP_df.attnTo); % categorical

% depedent varible is post - pre for notrmalized CRFs, accounts for random
%                                                                                                 
modelDesign1 = 'postminpre ~ attnTo+hemifield*contrast+harmonic+(1|sID)';                         
modelDesign2 = 'postminpre ~ attnTo*hemifield*contrast+harmonic+(1|sID)+(attnTo-1|sID)';         
modelDesign3 = 'postminpre ~ attnTo*hemifield*contrast+harmonic+(1|contrast:harmonic)+(1|sID)+(attnTo-1|sID)';

lme_1 = fitlme(SSRP_df, modelDesign1);
lme_2 = fitlme(SSRP_df, modelDesign2);
lme_3 = fitlme(SSRP_df, modelDesign3);

disp(compare(lme_1,lme_2));%, 'Nsim', 10));
disp(compare(lme_1,lme_3,'CheckNesting', true));%,'Nsim', 10))
% disp(lme);
% disp('done running');
% 
% plotResiduals(lme, 'fitted'); % Residuals vs. Fitted values
% figure;
% plotResiduals(lme, 'histogram'); % Histogram of residuals
% figure;
% plotResiduals(lme, 'probability'); % Q-Q plot
