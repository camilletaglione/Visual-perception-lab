clear all 
close all 
clc

%% Load the data 

load C.txt % load optical center matrix
load K.txt % load intrinsec parameter (focal length)
load R.txt % load rotation matrix
load pts3D.txt % load the image matrix

%% Create the image 

C2 = -(R*C);
RC = [R,C2]; % compute the extrinsec matrix
Pth = K*RC; % projection  matrix
pts = pts3D;
pts3D(:,4) = 1; % add a column full of 1
I = Pth*pts3D'; % compute the image by projection

%% Normalize the image 

ptst = pts'; 
IMG = I';
IMG1 =  IMG(:, 1)./IMG(:, 3);
IMG2 =  IMG(:, 2)./IMG(:, 3);
RIMG =  [IMG1 IMG2];



%% DLT Algorithm 

[A,Ppra] = DLT(pts3D,IMG);

% Compute the extrinsic pratical matrix
EX = Ppra/K;

fprintf("The extrinsic parameter is ")
EX

%% Add noise

H = imnoise(RIMG,'gaussian',0,0.25);
J = imnoise(RIMG,'gaussian',0,0.5);
K = imnoise(RIMG,'gaussian',0,0.75);
L = imnoise(RIMG,'gaussian',0,1);

%% Plot the whole thing

figure
plot(-RIMG(:, 1),-RIMG(:, 2),'*')
title('The 2D image') 

figure;
plot3(pts3D(:, 1),pts3D(:, 2),pts3D(:, 3),'*')

figure
hold on 
cam = plotCamera('Location',[C],'Orientation',R,'Opacity',0,'Size',20);
plot3(pts(:, 1),pts(:, 2),pts(:, 3),'*' )
title('The 3D world point') 
hold off

figure
subplot(221)
plot(-H(:, 1),-H(:, 2),'*')
title('0.25 pixel gaussain noise') 

subplot(222)
plot(-J(:, 1),-J(:, 2),'*')
title('0.5 pixel gaussain noise') 

subplot(223)
plot(-K(:, 1),-K(:, 2),'*')
title(' 0.75 pixel gaussain noise') 

subplot(224)
plot(-L(:, 1),-L(:, 2),'*')
title(' 1 pixel gaussain noise') 



