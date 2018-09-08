function [x, y, z] = bezierFace(Px, Py, Pz, uDotNum, wDotNum)
%输入参数
%Px: 控制点的x坐标
%Py: 控制点的y坐标
%Pz: 控制点的z坐标
%uDotNum: 沿u方向的点数
%wDotNum: 沿w方向的点数
%输出参数
%x: bezier曲面上的点的x坐标
%y: bezier曲面上的点的y坐标
%z: bezier曲面上的点的z坐标
    Mz = [-1, 3, -3, 1; 3, -6, 3, 0; -3, 3, 0, 0; 1, 0, 0, 0];
    u = linspace(0, 1, uDotNum);
    w = linspace(0, 1, wDotNum);
    
    x = zeros(uDotNum, wDotNum);
    y = zeros(uDotNum, wDotNum);
    z = zeros(uDotNum, wDotNum);
    
    for i = 1 : uDotNum
        U = [u(i)^3, u(i)^2, u(i), 1];
        for j = 1 : wDotNum
            %计算bezier曲面的点的x，y坐标
            W = [w(j)^3, w(j)^2, w(j), 1];
            x(i, j) = U*Mz*Px*Mz'*W';
            y(i, j) = U*Mz*Py*Mz'*W';
            z(i, j) = U*Mz*Pz*Mz'*W';
        end
    end