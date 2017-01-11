function im = Arial_Zoom(image, initial_area, final_area, posx, posy)

[yyy, xxx, h] = size(image);
a = final_area/initial_area;
if a > 1
    cx=posx;
    cy=posy;

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