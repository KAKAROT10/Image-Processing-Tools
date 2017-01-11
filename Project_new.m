close all force;
clear all force;
vid = videoinput('winvideo', 1, 'YUY2_640x360');
vid.ReturnedColorspace = 'rgb';
preview(vid);
%flushdata(vidtest);
pause(2);
threshold_tester = getsnapshot(vid);
averager = imcrop(threshold_tester);
avgr = mean(mean(averager(:,:,1)));
avgg = mean(mean(averager(:,:,2)));
avgb = mean(mean(averager(:,:,3)));

%flushdata(vid);
videoPlayer  = vision.VideoPlayer;%actualimageplayer
videoPlayer2 = vision.VideoPlayer;%binaryimageplayer
videoPlayer3 = vision.VideoPlayer;

target = imread('Test_image.jpg');
[yyy, xxx, h] = size(target);
itemp = target;
step(videoPlayer3, target);
    initialiazation = 0;
    zoom_mode = 0;
%% ===========================================================

%% Image Processing(Zoom)
i = 1;
while (1)
    %% Initial Image
tic
    while initialiazation == 0
        initial_image = getsnapshot(vid);
        initial_image = flipdim(initial_image, 2);
        initial_image_bw = converter(initial_image, avgr, avgg, avgb);
        c1= regionprops(initial_image_bw, 'Centroid');
        g1=[c1.Centroid];
        g1(isnan(g1))=[]; %remove nan eroor 
        
        if length(g1) == 4
            initials(1, 1) = g1(1);
            initials(1, 2) = g1(2);
            initials(2, 1) = g1(3);
            initials(2, 2) = g1(4);
            slope_initial = (initials(2,2) - initials(1, 2))/(initials(2, 1) - initials(1, 1));
            initialiazation = 1;
        end
        step(videoPlayer, initial_image);
        step(videoPlayer2, initial_image_bw);
        
    end

    temp_image = getsnapshot(vid);
    temp_image = flipdim(temp_image, 2);
    temp_image_bw = converter(temp_image, avgr, avgg, avgb);
    c1= regionprops(temp_image_bw, 'Centroid');
    g1=[c1.Centroid];
    g1(isnan(g1))=[]; %remove nan eroor 
    if length(g1) == 4
        zoom_mode = 0;
        finals(1, 1) = g1(1);
        finals(1, 2) = g1(2);
        finals(2, 1) = g1(3);
        finals(2, 2) = g1(4);
        slope_final = (finals(2,2) - finals(1, 2))/(finals(2, 1) - finals(1, 1));
       
        %%Zoom function
        itemp = Zoom(target, initials, finals);
        %%Rotatioin function
        angle = 5*(((slope_initial-slope_final)/(1+slope_initial*slope_final)));
        if angle < -3 || angle > 3
            itemp = imrotate(itemp, 2 * angle);
            itemp = imresize(itemp, [yyy, xxx]);
        end
    elseif length(g1) == 2
        if zoom_mode == 0;
            a1 = regionprops(temp_image_bw, 'Area');
            area=[a1.Area];
            initial_area = max(area);
        end
        if zoom_mode
            ac = regionprops(temp_image_bw, 'Area');
            area=[ac.Area];
            final_area = max(area);
            posx = g1(1);
            posy = g1(2);
            itemp = Arial_Zoom(target, initial_area, final_area, posx, posy);
            
        end
        zoom_mode = 1;
        initiaziation = 0;
    else
        zoom_mode = 0;
        initiaziation = 0;
    end
    
    step(videoPlayer, temp_image);
    step(videoPlayer2, temp_image_bw);
    step(videoPlayer3, itemp);
    i = i+1;
    toc
end
    
%% ===========================================================