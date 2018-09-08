clear;clc;close all;

%控制点坐标
body_y = [1.4, 1.3375, 1.4375, 1.5, 1.75, 2.0, 2.0, 2.0, 1.5, 1.5];
body_z = [2.25, 2.38125, 2.38125, 2.25, 1.725, 1.20, 0.75, 0.3, 0.075, 0.0];
lid_y = [0.0, 0.8, 0.0, 0.2, 0.4, 1.3, 1.3];
lid_z = [3.0, 3.0, 2.7, 2.55, 2.4, 2.4, 2.25];
handle_y1 = [-1.6, -2.3, -2.7, -2.7, -2.7, -2.5, -2.0];
handle_z1 = [1.875, 1.875, 1.875, 1.65, 1.42, 0.975, 0.75];
handle_y2 = [-1.5, -2.5, -3.0, -3.0, -3.0, -2.65, -1.9];
handle_z2 = [2.1, 2.1, 2.1, 1.65, 1.2, 0.7875, 0.45];
spout_y1 = [1.7, 2.6, 2.3, 2.7, 2.8, 2.9, 2.8];
spout_z1 = [1.275, 1.275, 1.95, 2.25, 2.325, 2.325, 2.25];
spout_y2 = [1.7, 3.1, 2.4, 3.3, 3.525, 3.45,3.2];
spout_z2 = [0.45, 0.675, 1.875, 2.25, 2.34375, 2.3625, 2.25];

%自己加了个底座
base_y = [1.5, 1.5, 0.75, 0];
base_z = [0, -0.075, 0, 0];


%长度的精度
lenAccuracy = 0.01;
%角度的精度
angleAccuracy = pi/180;
%每一段bezier曲线的点数
dotNum = floor(1/lenAccuracy);
%角度数
angleNum = floor(2*pi/angleAccuracy);


%产生茶壶体的bezier曲线
body_bezier_y = zeros(1, dotNum*3-2);
body_bezier_z = zeros(1, dotNum*3-2);
index = 1;
for i = 0 : 2
    [body_bezier_y(i*dotNum-i+1 : (i+1)*dotNum-i), body_bezier_z(i*dotNum-i+1 : (i+1)*dotNum-i)] = bezier(body_y(index : index+3), body_z(index : index+3), dotNum);
    index = index + 3;
end


%产生茶壶盖的bezier曲线
lid_bezier_y = zeros(1, dotNum*2-1);
lid_bezier_z = zeros(1, dotNum*2-1);
index = 1;
for i = 0 : 1
    [lid_bezier_y(i*dotNum-i+1 : (i+1)*dotNum-i), lid_bezier_z(i*dotNum-i+1 : (i+1)*dotNum-i)] = bezier(lid_y(index : index+3), lid_z(index : index+3), dotNum);
    index = index + 3;
end


%产生茶壶柄两侧线的bezier曲线
handle_bezier_y1 = zeros(1, dotNum*2-1);
handle_bezier_y2 = zeros(1, dotNum*2-1);
handle_bezier_z1 = zeros(1, dotNum*2-1);
handle_bezier_z2 = zeros(1, dotNum*2-1);
index = 1;
for i = 0 : 1
    [handle_bezier_y1(i*dotNum-i+1 : (i+1)*dotNum-i), handle_bezier_z1(i*dotNum-i+1 : (i+1)*dotNum-i)] = bezier(handle_y1(index : index+3), handle_z1(index : index+3), dotNum);
    [handle_bezier_y2(i*dotNum-i+1 : (i+1)*dotNum-i), handle_bezier_z2(i*dotNum-i+1 : (i+1)*dotNum-i)] = bezier(handle_y2(index : index+3), handle_z2(index : index+3), dotNum);
    index = index + 3;
end

   
halfNum = floor((angleNum+1)/2);   
%产生茶壶柄的bezier曲面
X_handle = zeros(angleNum+1, dotNum*2-1);
Y_handle = zeros(angleNum+1, dotNum*2-1);
Z_handle = zeros(angleNum+1, dotNum*2-1);
Px = [zeros(1,4); ones(1,4)*0.3; ones(1,4)*0.3; zeros(1,4)];
index = 1;
for i = 1 : 2
    Py = [handle_y1(index:index+3); handle_y1(index:index+3); handle_y2(index:index+3); handle_y2(index:index+3)];
    Pz = [handle_z1(index:index+3); handle_z1(index:index+3); handle_z2(index:index+3); handle_z2(index:index+3)];
    [X_handle(1:halfNum+1, (i-1)*dotNum+2-i:i*dotNum+1-i), Y_handle(1:halfNum+1, (i-1)*dotNum+2-i:i*dotNum+1-i), Z_handle(1:halfNum+1, (i-1)*dotNum+2-i:i*dotNum+1-i)] = bezierFace(Px, Py, Pz, halfNum+1, dotNum);
    index = index + 3;
end
%镜像对称
for i = halfNum+2 : angleNum+1
    X_handle(i, :) = -X_handle(angleNum+2-i, :);
    Y_handle(i, :) = Y_handle(angleNum+2-i, :);
    Z_handle(i, :) = Z_handle(angleNum+2-i, :);
end
    

%产生茶壶嘴两侧线的bezier曲线
spout_bezier_y1 = zeros(1, dotNum*2-1);
spout_bezier_y2 = zeros(1, dotNum*2-1);
spout_bezier_z1 = zeros(1, dotNum*2-1);
spout_bezier_z2 = zeros(1, dotNum*2-1);
index = 1;
for i = 0 : 1
    [spout_bezier_y1(i*dotNum-i+1 : (i+1)*dotNum-i), spout_bezier_z1(i*dotNum-i+1 : (i+1)*dotNum-i)] = bezier(spout_y1(index : index+3), spout_z1(index : index+3), dotNum);
    [spout_bezier_y2(i*dotNum-i+1 : (i+1)*dotNum-i), spout_bezier_z2(i*dotNum-i+1 : (i+1)*dotNum-i)] = bezier(spout_y2(index : index+3), spout_z2(index : index+3), dotNum);
    index = index + 3;
end

  
%产生茶壶嘴的bezier曲面
halfNum = floor((angleNum+1)/2);
X_spout = zeros(angleNum+1, dotNum*2-1);
Y_spout = zeros(angleNum+1, dotNum*2-1);
Z_spout = zeros(angleNum+1, dotNum*2-1);
Px = [zeros(1,4); ones(1,4)*0.3; ones(1,4)*0.3; zeros(1,4)];
index = 1;
for i = 1 : 2
    Py = [spout_y1(index:index+3); spout_y1(index:index+3); spout_y2(index:index+3); spout_y2(index:index+3)];
    Pz = [spout_z1(index:index+3); spout_z1(index:index+3); spout_z2(index:index+3); spout_z2(index:index+3)];
    [X_spout(1:halfNum+1, (i-1)*dotNum+2-i:i*dotNum+1-i), Y_spout(1:halfNum+1, (i-1)*dotNum+2-i:i*dotNum+1-i), Z_spout(1:halfNum+1, (i-1)*dotNum+2-i:i*dotNum+1-i)] = bezierFace(Px, Py, Pz, halfNum+1, dotNum);
    index = index + 3;
end
%镜像对称
for i = halfNum+2 :  angleNum+1
    X_spout(i, :) = -X_spout(angleNum+2-i, :);
    Y_spout(i, :) = Y_spout(angleNum+2-i, :);
    Z_spout(i, :) = Z_spout(angleNum+2-i, :);
end

    
%产生茶壶底的bezier曲线
[base_bezier_y, base_bezier_z] = bezier(base_y, base_z, dotNum);

%产生均匀于0到2pi的角度
angle = linspace(0, 2*pi, angleNum+1);

%生成绕z轴的茶壶体、茶壶盖、茶壶底
X_body = zeros(angleNum+1, dotNum*3-2); Y_body = zeros(angleNum+1, dotNum*3-2); Z_body = zeros(angleNum+1, dotNum*3-2);
X_lid = zeros(angleNum+1, dotNum*2-1); Y_lid = zeros(angleNum+1, dotNum*2-1); Z_lid = zeros(angleNum+1, dotNum*2-1);
X_base = zeros(angleNum+1, dotNum); Y_base = zeros(angleNum+1, dotNum); Z_base = zeros(angleNum+1, dotNum);
for i = 1 : angleNum+1
    X_body(i, :) = body_bezier_y*cos(angle(i));
    X_lid(i, :) = lid_bezier_y*cos(angle(i));
    X_base(i, :) = base_bezier_y*cos(angle(i));
    Y_body(i, :) = body_bezier_y*sin(angle(i));
    Y_lid(i, :) = lid_bezier_y*sin(angle(i));
    Y_base(i, :) = base_bezier_y*sin(angle(i));
    Z_body(i, :) = body_bezier_z;
    Z_lid(i, :) = lid_bezier_z;
    Z_base(i, :) = base_bezier_z;
end