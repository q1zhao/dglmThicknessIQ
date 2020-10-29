[~, M1] = load_mgh('../data/rh.ribbon.mgz');
[~, M2] = load_mgh('../data/lh.ribbon.mgz');
%%
str1 = '_mean';
str2 = '_dispersion';
% item = '_ct_sa';
item = '_sa_ct';
for i = 1:3

    % mean model
    load(['../result/',int2str(i),'_dglm',str1,item,'_rh.mat'])  % right hemisphere
    save_mgh(v_rh,['../result/',int2str(i),str1,item,'_rh.mgh'],M1) 
    load(['../result/',int2str(i),'_dglm',str1,item,'_lh.mat']) % left hemisphere
    save_mgh(v_lh,['../result/',int2str(i),str1,item,'_lh.mgh'],M2) 

    % dispersion model 
    load(['../result/',int2str(i),'_dglm',str2,item,'_rh.mat'])  % right hemisphere
    save_mgh(v_rh,['../result/',int2str(i),str2,item,'_rh.mgh'],M1) 
    load(['../result/',int2str(i),'_dglm',str2,item,'_lh.mat']) % left hemisphere
    save_mgh(v_lh,['../result/',int2str(i),str2,item,'_lh.mgh'],M2) 

end

