function [x, y, z] = bezier(Px, Py, dotNum, Pz)
%�������
%Px: ���Ƶ��x����
%Py: ���Ƶ��y����
%dotNum: bezier���ߵĵ���
%Pz: ���Ƶ��z����
%�������
%x: bezier�����ϵĵ��x����
%y: bezier�����ϵĵ��y����
%z: bezier�����ϵĵ��z����
    coefficient = [-1, 3, -3, 1; 3, -6, 3, 0; -3, 3, 0, 0; 1, 0, 0, 0];
    t = linspace(0, 1, dotNum);
    x = zeros(1, dotNum);
    y = zeros(1, dotNum);
    for i = 1 : dotNum
        %����bezier�����ϵĵ��x��y����
        T = [t(i)^3, t(i)^2, t(i), 1];
        x(i) = T * coefficient * Px';
        y(i) = T * coefficient * Py';
    end
    %û��z����Ļ�����x���y������
    if(nargin <= 3)
        return;
    end
    
    %��z����Ļ��ټ���z������
    z = zeros(1, dotNum);
    for i = 1 : dotNum
        T = [t(i)^3, t(i)^2, t(i), 1];
        z(i) = T * coefficient * Pz';
    end