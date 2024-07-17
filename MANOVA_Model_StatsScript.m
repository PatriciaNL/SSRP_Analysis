%%%%% NOTE: USES PRE AND POST REPSONSES 
% THIS SCRIPT IMPLIMENTS MANOVA, BUT CANNOT ACCOUNT FOR RANDOM EFFECT OF SUBJECTS

addpath( 'C:\plimon\SSRP_analysis_branch\Subj_Dataframes\');
%data = importdata("Subject_ANOVA_DF_ExptGroup_RCA1_2F4F_20240628_154051.mat");
%data = importdata("Subject_ANOVA_DF_ExptGroup_RCA1_prepostCols_2F4F_20240628_133109.mat");
%data = importdata("Subject_ANOVA_DF_ExptGroup_RCA1_2F_HarmonicOnly_20240716_172718.mat");
%data = importdata("Subject_ANOVA_DF_ExptGroup_RCA1_4F_HarmonicOnly_20240717_103812.mat");
%data = importdata("Subject_ANOVA_DF_CntrlGroup_RCA1_2F_HarmonicOnly_20240717_120450.mat");
%data = importdata("Subject_ANOVA_DF_CntrlGroup_RCA1_4F_HarmonicOnly_20240717_121456.mat");
data = importdata("Subject_ANOVA_DF_ExptGroup_RCA1_2F_HarmonicOnly_STD_3_5_20240717_142947.mat");

dataFrame_converted = double(data.CRF_Difference_Values); % import actual dataframe
dataFrame_label = cellstr(data.Headers); % import column labels for MANOVA

% append headers to dataframe for ANOVA
SSRP_df = array2table(dataFrame_converted,'VariableNames',{'sID','harmonic','contrast','hemifield','attnTo','pre','post'});

SSRP_df.sID      =categorical(SSRP_df.sID); % categorical and should be nested
SSRP_df.attnTo   =categorical(SSRP_df.attnTo); % categorical
SSRP_df.hemifield= categorical(SSRP_df.hemifield); % categorical
SSRP_df.contrast = categorical(SSRP_df.contrast); % categorical
SSRP_df.harmonic = categorical(SSRP_df.harmonic); % categorical

modelDesign = ['pre,post ~ contrast*hemifield*attnTo']; %4!
rm = fitrm(SSRP_df, modelDesign);

%manovaResults = manova(rm);
%disp(manovaResults)

ranovaResults = ranova(rm);
disp(ranovaResults)

