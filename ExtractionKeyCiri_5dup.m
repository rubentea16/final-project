for data=38:50
    tic;
    switch data
        case 1
            judulvideo = '3_7_Y.mp4';
        case 2
            judulvideo = '3_9_Y.mp4';
        case 3
            judulvideo = '3_13_Y.mp4';
        case 4
            judulvideo = '3_5_Y.mp4';
        case 5
            judulvideo = '3_12_Y.mp4';
        case 6
            judulvideo = '3_10_Y.mp4';
        case 7
            judulvideo = '3_15_Y.mp4';
        case 8
            judulvideo = '3_21_Y.mp4';
        case 9
            judulvideo = '3_22_Y.mp4';
        case 10
            judulvideo = '3_26_Y.mp4';
        case 11
            judulvideo = '3_29_Y.mp4';
        case 12
            judulvideo = '3_37_Y.mp4';
        case 13
            judulvideo = '3_39_Y.mp4';
        case 14
            judulvideo = '3_41_Y.mp4';
        case 15
            judulvideo = '3_43_Y.mp4';
        case 16
            judulvideo = '3_45_Y.mp4';
        case 17
            judulvideo = '3_55_Y.mp4';
        case 18
            judulvideo = '3_59_Y.mp4';
        case 19
            judulvideo = '3_62_Y.mp4';
        case 20
            judulvideo = '3_66_Y.mp4';
        case 21
            judulvideo = '3_67_Y.mp4';
        case 22
            judulvideo = '3_68_Y.mp4';
        case 23
            judulvideo = '3_75_Y.mp4';
        case 24
            judulvideo = '3_83_Y.mp4';
        case 25
            judulvideo = '3_85_Y.mp4';
        case 26
            judulvideo = '4_3_Y.mp4';
        case 27
            judulvideo = '4_34_Y.mp4';
        case 28
            judulvideo = '4_1_Y.mp4';
        case 29
            judulvideo = '4_5_Y.mp4';
        case 30
            judulvideo = '4_6_Y.mp4';
        case 31
            judulvideo = '4_2_Y.mp4';
        case 32
            judulvideo = '4_4_Y.mp4';
        case 33
            judulvideo = '4_7_Y.mp4';
        case 34
            judulvideo = '4_8_Y.mp4';
        case 35
            judulvideo = '4_15_Y.mp4';
        case 36
            judulvideo = '4_18_Y.mp4';
        case 37
            judulvideo = '4_19_Y.mp4';
        case 38
            judulvideo = '4_20_Y.mp4';
        case 39
            judulvideo = '4_21_Y.mp4';
        case 40
            judulvideo = '4_25_Y.mp4';
        case 41
            judulvideo = '4_28_Y.mp4';
        case 42
            judulvideo = '4_29_Y.mp4';
        case 43
            judulvideo = '4_39_Y.mp4';
        case 44
            judulvideo = '4_41_Y.mp4';
        case 45
            judulvideo = '4_42_Y.mp4';
        case 46
            judulvideo = '4_44_Y.mp4';
        case 47
            judulvideo = '4_48_Y.mp4';
        case 48
            judulvideo = '4_49_Y.mp4';
        case 49
            judulvideo = '4_53_Y.mp4';
        case 50
            judulvideo = '4_55_Y.mp4';
    end
    
    a=VideoReader(judulvideo);
    framerate = ceil(a.FrameRate);
    durasi = ceil(a.Duration);
    totalframe = a.NumberOfFrames;
    condition=0;
    compareimg=1;
    nokeyframe=1;
    n1=framerate+1;
    n2=framerate+framerate;

    for frame=1:totalframe
        citra(:,:,:,frame) = read(a,frame); %video jadi citra
        citragray(:,:,frame) = rgb2gray(citra(:,:,:,frame)); %rgb to grayscale
        edgecanny(:,:,frame)=edge(citragray(:,:,frame),'canny',0.1); %deteksi tepi canny
    end
    
    while condition == 0
        for indeks=n1:n2 %jarak hausdorff antara keyframe dengan semua citra detik n+1
            distance(indeks,1) = hausdorff(edgecanny(:,:,compareimg),edgecanny(:,:,indeks));
        end
        [p,q]=sort(distance); %sorting ascending
        keyframe(nokeyframe,1) = q(n2); %nilai hausdorff terbesar
        compareimg = q(n2);
        disp(compareimg);
        n1=n1+framerate;
        if n1 > totalframe
            condition = 1;
        end
        n2=n2+framerate;
        if n2 > totalframe
            n2= totalframe;
        end
        nokeyframe=nokeyframe+1;
        clear distance
    end
    
    %Sisipin indeks 1 keyframe
    for k=size(keyframe,1):-1:1 %for mundur
        keyframe(k+1,1)=keyframe(k,1);
    end
    keyframe(1,1) = 1;
    
    %Ekstraksi Ciri
    for k=1:size(keyframe,1)
        ikey = keyframe(k,1);
        hist_LDP = LDP(citragray(:,:,ikey));
        ciriLDP(k,:) = hist_LDP;
        hsv = quantizeHSV(citra(:,:,:,ikey));
        ciriHSV(k,:) = hsv;
        string1 = ['indeks=',num2str(ikey)];
        disp(string1);
    end           
    
        
        
    switch data
        case 1
            LDP_1 = ciriLDP;
            HSV_1 = ciriHSV;
            save('LDP_1.mat','LDP_1');
            save('HSV_1.mat','HSV_1');
        case 2
            LDP_2 = ciriLDP;
            HSV_2 = ciriHSV;
            save('LDP_2.mat','LDP_2');
            save('HSV_2.mat','HSV_2');
        case 3
            LDP_3 = ciriLDP;
            HSV_3 = ciriHSV;
            save('LDP_3.mat','LDP_3');
            save('HSV_3.mat','HSV_3');
        case 4
            LDP_4 = ciriLDP;
            HSV_4 = ciriHSV;
            save('LDP_4.mat','LDP_4');
            save('HSV_4.mat','HSV_4');
        case 5
            LDP_5 = ciriLDP;
            HSV_5 = ciriHSV;
            save('LDP_5.mat','LDP_5');
            save('HSV_5.mat','HSV_5');
        case 6
            LDP_6 = ciriLDP;
            HSV_6 = ciriHSV;
            save('LDP_6.mat','LDP_6');
            save('HSV_6.mat','HSV_6');
        case 7
            LDP_7 = ciriLDP;
            HSV_7 = ciriHSV;
            save('LDP_7.mat','LDP_7');
            save('HSV_7.mat','HSV_7');
        case 8
            LDP_8 = ciriLDP;
            HSV_8 = ciriHSV;
            save('LDP_8.mat','LDP_8');
            save('HSV_8.mat','HSV_8');
        case 9
            LDP_9 = ciriLDP;
            HSV_9 = ciriHSV;
            save('LDP_9.mat','LDP_9');
            save('HSV_9.mat','HSV_9');
        case 10
            LDP_10 = ciriLDP;
            HSV_10 = ciriHSV;
            save('LDP_10.mat','LDP_10');
            save('HSV_10.mat','HSV_10');
        case 11
            LDP_11 = ciriLDP;
            HSV_11 = ciriHSV;
            save('LDP_11.mat','LDP_11');
            save('HSV_11.mat','HSV_11');
        case 12
            LDP_12 = ciriLDP;
            HSV_12 = ciriHSV;
            save('LDP_12.mat','LDP_12');
            save('HSV_12.mat','HSV_12');
        case 13
            LDP_13 = ciriLDP;
            HSV_13 = ciriHSV;
            save('LDP_13.mat','LDP_13');
            save('HSV_13.mat','HSV_13');
        case 14
            LDP_14 = ciriLDP;
            HSV_14 = ciriHSV;
            save('LDP_14.mat','LDP_14');
            save('HSV_14.mat','HSV_14');
        case 15
            LDP_15 = ciriLDP;
            HSV_15 = ciriHSV;
            save('LDP_15.mat','LDP_15');
            save('HSV_15.mat','HSV_15');
        case 16
            LDP_16 = ciriLDP;
            HSV_16 = ciriHSV;
            save('LDP_16.mat','LDP_16');
            save('HSV_16.mat','HSV_16');
        case 17
            LDP_17 = ciriLDP;
            HSV_17 = ciriHSV;
            save('LDP_17.mat','LDP_17');
            save('HSV_17.mat','HSV_17');
        case 18
            LDP_18 = ciriLDP;
            HSV_18 = ciriHSV;
            save('LDP_18.mat','LDP_18');
            save('HSV_18.mat','HSV_18');
        case 19
            LDP_19 = ciriLDP;
            HSV_19 = ciriHSV;
            save('LDP_19.mat','LDP_19');
            save('HSV_19.mat','HSV_19');
        case 20
            LDP_20 = ciriLDP;
            HSV_20 = ciriHSV;
            save('LDP_20.mat','LDP_20');
            save('HSV_20.mat','HSV_20');
        case 21
            LDP_21 = ciriLDP;
            HSV_21 = ciriHSV;
            save('LDP_21.mat','LDP_21');
            save('HSV_21.mat','HSV_21');
        case 22
            LDP_22 = ciriLDP;
            HSV_22 = ciriHSV;
            save('LDP_22.mat','LDP_22');
            save('HSV_22.mat','HSV_22');
        case 23
            LDP_23 = ciriLDP;
            HSV_23 = ciriHSV;
            save('LDP_23.mat','LDP_23');
            save('HSV_23.mat','HSV_23');
        case 24
            LDP_24 = ciriLDP;
            HSV_24 = ciriHSV;
            save('LDP_24.mat','LDP_24');
            save('HSV_24.mat','HSV_24');
        case 25
            LDP_25 = ciriLDP;
            HSV_25 = ciriHSV;
            save('LDP_25.mat','LDP_25');
            save('HSV_25.mat','HSV_25');
        case 26
            LDP_26 = ciriLDP;
            HSV_26 = ciriHSV;
            save('LDP_26.mat','LDP_26');
            save('HSV_26.mat','HSV_26');
        case 27
            LDP_27 = ciriLDP;
            HSV_27 = ciriHSV;
            save('LDP_27.mat','LDP_27');
            save('HSV_27.mat','HSV_27');
        case 28
            LDP_28 = ciriLDP;
            HSV_28 = ciriHSV;
            save('LDP_28.mat','LDP_28');
            save('HSV_28.mat','HSV_28');
        case 29
            LDP_29 = ciriLDP;
            HSV_29 = ciriHSV;
            save('LDP_29.mat','LDP_29');
            save('HSV_29.mat','HSV_29');
        case 30
            LDP_30 = ciriLDP;
            HSV_30 = ciriHSV;
            save('LDP_30.mat','LDP_30');
            save('HSV_30.mat','HSV_30');
        case 31
            LDP_31 = ciriLDP;
            HSV_31 = ciriHSV;
            save('LDP_31.mat','LDP_31');
            save('HSV_31.mat','HSV_31');
        case 32
            LDP_32 = ciriLDP;
            HSV_32 = ciriHSV;
            save('LDP_32.mat','LDP_32');
            save('HSV_32.mat','HSV_32');
        case 33
            LDP_33 = ciriLDP;
            HSV_33 = ciriHSV;
            save('LDP_33.mat','LDP_33');
            save('HSV_33.mat','HSV_33');
        case 34
            LDP_34 = ciriLDP;
            HSV_34 = ciriHSV;
            save('LDP_34.mat','LDP_34');
            save('HSV_34.mat','HSV_34');
        case 35
            LDP_35 = ciriLDP;
            HSV_35 = ciriHSV;
            save('LDP_35.mat','LDP_35');
            save('HSV_35.mat','HSV_35');
        case 36
            LDP_36 = ciriLDP;
            HSV_36 = ciriHSV;
            save('LDP_36.mat','LDP_36');
            save('HSV_36.mat','HSV_36');
        case 37
            LDP_37 = ciriLDP;
            HSV_37 = ciriHSV;
            save('LDP_37.mat','LDP_37');
            save('HSV_37.mat','HSV_37');
        case 38
            LDP_38 = ciriLDP;
            HSV_38 = ciriHSV;
            save('LDP_38.mat','LDP_38');
            save('HSV_38.mat','HSV_38');
        case 39
            LDP_39 = ciriLDP;
            HSV_39 = ciriHSV;
            save('LDP_39.mat','LDP_39');
            save('HSV_39.mat','HSV_39');
        case 40
            LDP_40 = ciriLDP;
            HSV_40 = ciriHSV;
            save('LDP_40.mat','LDP_40');
            save('HSV_40.mat','HSV_40');
        case 41
            LDP_41 = ciriLDP;
            HSV_41 = ciriHSV;
            save('LDP_41.mat','LDP_41');
            save('HSV_41.mat','HSV_41');
        case 42
            LDP_42 = ciriLDP;
            HSV_42 = ciriHSV;
            save('LDP_42.mat','LDP_42');
            save('HSV_42.mat','HSV_42');
        case 43
            LDP_43 = ciriLDP;
            HSV_43 = ciriHSV;
            save('LDP_43.mat','LDP_43');
            save('HSV_43.mat','HSV_43');
        case 44
            LDP_44 = ciriLDP;
            HSV_44 = ciriHSV;
            save('LDP_44.mat','LDP_44');
            save('HSV_44.mat','HSV_44');
        case 45
            LDP_45 = ciriLDP;
            HSV_45 = ciriHSV;
            save('LDP_45.mat','LDP_45');
            save('HSV_45.mat','HSV_45');
        case 46
            LDP_46 = ciriLDP;
            HSV_46 = ciriHSV;
            save('LDP_46.mat','LDP_46');
            save('HSV_46.mat','HSV_46');
        case 47
            LDP_47 = ciriLDP;
            HSV_47 = ciriHSV;
            save('LDP_47.mat','LDP_47');
            save('HSV_47.mat','HSV_47');
        case 48
            LDP_48 = ciriLDP;
            HSV_48 = ciriHSV;
            save('LDP_48.mat','LDP_48');
            save('HSV_48.mat','HSV_48');
        case 49
            LDP_49 = ciriLDP;
            HSV_49 = ciriHSV;
            save('LDP_49.mat','LDP_49');
            save('HSV_49.mat','HSV_49');
        case 50
            LDP_50 = ciriLDP;
            HSV_50 = ciriHSV;
            save('LDP_50.mat','LDP_50');
            save('HSV_50.mat','HSV_50');
    end

        
        clear all;
        toc;
end
     
