dat_dir = '../result/' ;
dat_out =  '../result/';
str1 = '_mean';
str2 = '_dispersion';
%     item = '_ct_sa';
item = '_sa_ct';
%%
for i = 1:3

    
    img_name = [int2str(i),str1,item];
    mydata = SurfStatReadData({[dat_dir,img_name,'_lh.mgh'], [dat_dir,img_name,'_rh.mgh']});
    mysurfaces = SurfStatReadSurf({'../data/lh.pial','../data/rh.pial'});

    figure(1) 
    cus_map = othercolor('BuOr_12');
    NewColorMap = AdjustColorMap(cus_map,[1 1 1],min(mydata),0,0,max(mydata));
    SurfStatViewData(mydata, mysurfaces, '','white',NewColorMap);

    gaf=figure(1);
    scrsz=get(0,'ScreenSize');
    set(gaf,'Position',[scrsz(1:2),scrsz(3)-300,scrsz(4)]);
    set(gaf,'paperpositionmode','auto')
    print(gaf,'-dtiff','-r300',['../result/',img_name,'.tiff']) 
    close all
    %
    img_name = [int2str(i),str2,item];

    mydata = SurfStatReadData({[dat_dir,img_name,'_lh.mgh'], [dat_dir,img_name,'_rh.mgh']});
    mysurfaces = SurfStatReadSurf({'../data/lh.pial','../data/rh.pial'});
    figure(1)
    cus_map = othercolor('BuOr_12');
    NewColorMap = AdjustColorMap(cus_map,[1 1 1],min(mydata),0,0,max(mydata));
    SurfStatViewData(mydata, mysurfaces, '','white',NewColorMap);
    gaf=figure(1);
    scrsz=get(0,'ScreenSize');
    set(gaf,'Position',[scrsz(1:2),scrsz(3)-300,scrsz(4)]);
    set(gaf,'paperpositionmode','auto')
    print(gaf,'-dtiff','-r300',['../result/',img_name,'.tiff']) 
    close all
end