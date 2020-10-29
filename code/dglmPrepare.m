% clc
% clear

% load('../data/abcd_morph_clean.mat')
abcd_full = abcd_full2;
cog = abcd_full.cog;
C = str2double(cog);

sex = strrep(strrep(abcd_full.sex,'F','1'),'M','0');
[a,b] = find(isnan(str2double(abcd_full.thick)));
% [c,d] = find(isnan(str2double(abcd_full.area(:,2:end))));
f_idx = setdiff(find(isnan(str2double(abcd_full.age))==0&isnan(abcd_full.site)==0&isnan(str2double(sex))==0&isnan(sum(C,2))==0),unique(a));

abcd_full_clear = abcd_full(f_idx,:);
site = abcd_full_clear.site;
site_dum = dummyvar(site);
fs_ct = str2double(abcd_full_clear.thick);
fs_ca = str2double(abcd_full_clear.area(:,2:end));
age = str2double(abcd_full_clear.age);
sex = str2double(strrep(strrep(abcd_full_clear.sex,'F','1'),'M','0'));
cog = str2double(abcd_full_clear.cog);
% save data
writematrix(age,'..\data\age.txt')
writematrix(sex,'..\data\sex.txt')
writematrix(fs_ct,'..\data\thickness.txt','delimiter',' ')
writematrix(cog,'..\data\cog_agecorrected.txt','delimiter',' ')
writematrix(site_dum,'..\data\site.txt','delimiter',' ')
writematrix(fs_ca(:,2:end),'..\data\area.txt','delimiter',' ')
