clc
clear

wrong_cog{1} = 'NDAR_INVRV0X5P44';
wrong_cog{2} = 'NDAR_INV4XT06HUA';

%% qc info
% filename = 'F:\OHBM\ABCD_release2.0\freesqc01.txt';
filename = '..\data\ABCDFixRelease\freesqc01.txt';
fsqc = importdata(filename);
for i = 1:length(fsqc)
    u = strfind(fsqc{i},'"');
    temp =fsqc{i};
    k=0;
    for j = 1:2:length(u)-1
        k=k+1;
        fsqc2{i,k} = temp(u(j)+1:u(j+1)-1);
    end
end
fsqc_item = fsqc2(:,[4,15]);
%% cognition score
filename = '..\data\ABCDFixRelease\abcd_tbss01.txt';

tbss = importdata(filename);
for i = 1:length(tbss)
    u = strfind(tbss{i},'"');
    temp =tbss{i};
    k=0;
    for j = 1:2:length(u)-1
        k=k+1;
        tbss2{i,k} = temp(u(j)+1:u(j+1)-1);
    end
end
idx =[];
for j =1:size(tbss2,2)
if ~isempty(tbss2{3,j})
    idx = [idx,j];
end
end
tbss3 = tbss2(:,idx);
cog_item = tbss3(:,[4,47,51,55,13,18,23,28,33,38,43]);% age,gender
%% site,age,sex info
filename = '..\data\ABCDFixRelease\abcd_lt01.txt';
cov_info = importdata(filename);
for i = 1:length(cov_info)
    u = strfind(cov_info{i},'"');
    temp =cov_info{i};
    k=0;
    for j = 1:2:length(u)-1
        k=k+1;
        cov{i,k} = temp(u(j)+1:u(j+1)-1);
    end
end
baseline = strfind(cov(:,9),'baseline_year_1_arm_1');
base = zeros(length(baseline),1);
for i = 1:length(baseline)
   if ~isnan(baseline{i})
       base(i)=1;   
   end
end

cov_item = cov(base==1,[4,7,8,10]);
%% freesurfer
filename = '..\data\ABCDFixRelease\abcd_mrisdp101.txt';
fs_info = importdata(filename);
for i = 1:length(fs_info)
    u = strfind(fs_info{i},'"');
    temp =fs_info{i};
    k=0;
    for j = 1:2:length(u)-1
        k=k+1;
        fs{i,k} = temp(u(j)+1:u(j+1)-1);
    end
end
fs_thickness_item = fs(:,[4,10:160]);
fs_sulcal_deep = fs(:,[4,161:311]);
fs_cortical_area = fs(:,[4,312:462]);
fs_cortical_vol= fs(:,[4,463:613]);
fs_t1_white= fs(:,[4,614:764]);
fs_t1_gray_white= fs(:,[4,765:915]);
%% freesurfer2
filename = '..\data\ABCDFixRelease\abcd_mrisdp201.txt';
fs2_info = importdata(filename);
for i = 1:length(fs2_info)
    u = strfind(fs2_info{i},'"');
    temp =fs2_info{i};
    k=0;
    for j = 1:2:length(u)-1
        k=k+1;
        fs2{i,k} = temp(u(j)+1:u(j+1)-1);
    end
end
fs2_t1_contrast = fs2(:,[4,10:160]);
fs2_t2_white = fs2(:,[4,161:311]);
fs2_t2_gray = fs2(:,[4,312:462]);
fs2_t2_contrast= fs2(:,[4,463:613]);

%% freesurfer3
filename = '..\data\ABCDFixRelease\abcd_smrip201.txt';
fs3_info = importdata(filename);
for i = 1:length(fs3_info)
    u = strfind(fs3_info{i},'"');
    temp =fs3_info{i};
    k=0;
    for j = 1:2:length(u)-1
        k=k+1;
        fs3{i,k} = temp(u(j)+1:u(j+1)-1);
    end
end
fs3_sub_vol = fs3(:,[4,330:375]);
fs3_t1_sub = fs3(:,[4,376:415]);
fs2_t2_sub  = fs3(:,[4,416:455]);
%% intersect
id1 = find(str2double(fsqc_item(:,2))==1);
[id2,a1,b1] = intersect(fsqc_item(id1,1),fs_thickness_item(:,1));
fs_thick1 = fs_thickness_item(b1,:);
[id3,a2,b2] = intersect(fs_thick1(:,1),cov_item(:,1));
fs_thick2 = fs_thick1(a2,:);cov_item2 = cov_item(b2,:);
[id4,a3,b3] = intersect(fs_thick2(:,1),cog_item(:,1));
fs_thick3 = fs_thick2(a3,:);cog_item2 = cog_item(b3,:);
[id5,a4,b4] = intersect(fs_thick3(:,1),cov_item2(:,1));
fs_thick4 = fs_thick3(a4,:);cov_item3 = cov_item2(b4,:);
site_raw = cov_item3(:,4);
site = str2double(strrep(site_raw,'site',''));
abcd_full = table(cov_item3(:,1),cov_item3(:,2),cov_item3(:,3),site,...
    cog_item2(:,2:end),fs_thick4(:,2:end),'VariableNames',{'subjectkey','age','sex','site','cog','thick'});
cog_item_name = cog_item(1:2,2:end);
thickeness_item_name = fs_thickness_item(1:2,2:end);
% save abcd_thickness_clean_u abcd_full cog_item_name thickeness_item_name
%
[subjectkey_right,iia] =setdiff(abcd_full.subjectkey,wrong_cog);
[idx_f,ia,ib] = intersect(subjectkey_right,fs_cortical_area(:,1));
area = fs_cortical_area(ib,:);
vol = fs_cortical_vol(ib,:);
sub_vol = fs3_sub_vol(ib,:);
t1_contrast = fs2_t1_contrast(ib,:);
t2_contrast = fs2_t2_contrast(ib,:);
abcd_full2 = table(cov_item3(iia(ia),1),cov_item3(iia(ia),2),cov_item3(iia(ia),3),site(iia(ia),:),...
    cog_item2(iia(ia),2:end),fs_thick4(iia(ia),2:end),area,vol,sub_vol,t1_contrast,t2_contrast,'VariableNames',{'subjectkey','age','sex','site','cog','thick','area','vol','sub_vol','t1_contrast','t2_contrast'});
sub_item_name = fs3_sub_vol(2,2:end);
save('../data/abcd_morph_clean.mat','abcd_full2','cog_item_name','sub_item_name','thickeness_item_name')