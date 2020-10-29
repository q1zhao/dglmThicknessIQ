function plot2_surface09(tvalue,pvalue,thre,savefile)


FDR = mafdr(pvalue,'BHFDR',true);
rh_item = find(FDR(75:end)<thre);
lh_item = find(FDR(1:74)<thre);


[vertices_rh,label_rh,colortable_rh] = read_annotation('..\data\rh.aparc.a2009s.annot');
colortable_rh.struct_names([1,43])=[];
colortable_rh.table([1,43],:)=[];

v_rh = zeros(size(vertices_rh));
for i = 1:numel(rh_item)
        temp = colortable_rh.table(rh_item(i),5);
        idx = find(label_rh==temp);
        v_rh(idx) = tvalue(74+rh_item(i));
end

save([savefile,'_rh.mat'],'v_rh')


[vertices_lh,label_lh,colortable_lh] = read_annotation('..\data\lh.aparc.a2009s.annot');
colortable_lh.struct_names([1,43])=[];
colortable_lh.table([1,43],:)=[];
v_lh = zeros(size(vertices_lh));
for i = 1:numel(lh_item)
        temp = colortable_lh.table(lh_item(i),5);
        idx = find(label_lh==temp);
        v_lh(idx) = tvalue(lh_item(i));
end


save([savefile,'_lh.mat'],'v_lh')