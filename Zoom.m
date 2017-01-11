function im = Zoom(image, initials, finals)

[yyy, xxx, h] = size(image);
xi1=initials(1, 1);
yi1=initials(1, 2);
xi2=initials(2, 1);
yi2=initials(2, 2);

xf1=finals(1, 1);
yf1=finals(1, 2);
xf2=finals(2, 1);
yf2=finals(2, 2);

di = sqrt((xi2-xi1)*(xi2-xi1) + (yi2-yi1)*(yi2-yi1));
df = sqrt((xf2-xf1)*(xf2-xf1) + (yf2-yf1)*(yf2-yf1));
a = 1*df/di;
if a > 1
    cx=(xf1+xf2)/2;
    cy=(yf1+yf2)/2;

    lx = xxx/a;
    ly = yyy/a;

    startx = cx-lx/2;
    stopx = cx+lx/2;
    starty = cy-ly/2;
    stopy = cy+ly/2;
    if startx<0
        extra = 0 - startx;
        stopx = stopx + extra;
        startx = 0;
    end

    if stopx>xxx
        extra = stopx - xxx;
        startx = startx - extra;
        stopx = xxx;
    end


    if starty<0
        extra = 0 - starty;
        stopy = stopy + extra;
        starty = 0;
    end

    if stopy>yyy
        extra = stopy - yyy;
        starty = starty - extra;
        stopy = yyy;
    end  
    im = imcrop(image, [startx, starty, stopx, stopy]);
    im = imresize(im, [yyy, xxx]);
else
    im = image;
end