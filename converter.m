function L1=converter(snap1, avgr, avgg, avgb)
min_area=400; 
snap2 = decorrstretch(snap1, 'Tol', 0.005);
rr=snap1(:,:,1);
gg=snap1(:,:,2);
bb=snap1(:,:,3);
redz2 = snap2(:, :, 1)>=225;
redz=((rr>=avgr - 40) & (rr<=avgr + 40) & (gg>=avgg -40) & (gg<=avgg + 40) & (bb>=avgb - 40) & (bb<=avgb + 40));

redz = redz & redz2;
  
se=strel('disk',10);
redz=imclose(redz,se);
%figure,imshow(bluez);
redz=imfill(redz,'holes'); %connected component ke ander vali noise ka removal
%figure,imshow(bluez);
L1 = bwlabel(redz);
a1 = regionprops(L1, 'Area');
area=[a1.Area];
f1=find(area>min_area);
im1=ismember(L1,f1);%% returns 1 jaha pe area required limit mein hai
L1=im1.*L1;