function [x, y, z] = bezierFace(Px, Py, Pz, uDotNum, wDotNum)
%�������
%Px: ���Ƶ��x����
%Py: ���Ƶ��y����
%Pz: ���Ƶ��z����
%uDotNum: ��u����ĵ���
%wDotNum: ��w����ĵ���
%�������
%x: bezier�����ϵĵ��x����
%y: bezier�����ϵĵ��y����
%z: bezier�����ϵĵ��z����
    Mz = [-1, 3, -3, 1; 3, -6, 3, 0; -3, 3, 0, 0; 1, 0, 0, 0];
    u = linspace(0, 1, uDotNum);
    w = linspace(0, 1, wDotNum);
    
    x = zeros(uDotNum, wDotNum);
    y = zeros(uDotNum, wDotNum);
    z = zeros(uDotNum, wDotNum);
    
    for i = 1 : uDotNum
        U = [u(i)^3, u(i)^2, u(i), 1];
        for j = 1 : wDotNum
            %����bezier����ĵ��x��y����
            W = [w(j)^3, w(j)^2, w(j), 1];
            x(i, j) = U*Mz*Px*Mz'*W';
            y(i, j) = U*Mz*Py*Mz'*W';
            z(i, j) = U*Mz*Pz*Mz'*W';
        end
    end