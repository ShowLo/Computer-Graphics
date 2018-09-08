function [x, y, z] = bezier(Px, Py, dotNum, Pz)
%输入参数
%Px: 控制点的x坐标
%Py: 控制点的y坐标
%dotNum: bezier曲线的点数
%Pz: 控制点的z坐标
%输出参数
%x: bezier曲线上的点的x坐标
%y: bezier曲线上的点的y坐标
%z: bezier曲线上的点的z坐标
    coefficient = [-1, 3, -3, 1; 3, -6, 3, 0; -3, 3, 0, 0; 1, 0, 0, 0];
    t = linspace(0, 1, dotNum);
    x = zeros(1, dotNum);
    y = zeros(1, dotNum);
    for i = 1 : dotNum
        %计算bezier曲线上的点的x，y坐标
        T = [t(i)^3, t(i)^2, t(i), 1];
        x(i) = T * coefficient * Px';
        y(i) = T * coefficient * Py';
    end
    %没有z坐标的话返回x轴和y轴数据
    if(nargin <= 3)
        return;
    end
    
    %有z坐标的话再计算z轴数据
    z = zeros(1, dotNum);
    for i = 1 : dotNum
        T = [t(i)^3, t(i)^2, t(i), 1];
        z(i) = T * coefficient * Pz';
    end