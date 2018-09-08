picTeapot;
%进行旋转并保存为gif
N = 90;
axis([-4 4 -4 4 -1 4]);
M = moviein(N);
for i = 1 : N
    view(i*4, 0);
    M(i) = getframe;
    v = frame2im(M(i));
    [v, c] = rgb2ind(v, 256);
    if v == 1
        imwrite(v,c, 'rotate.gif','gif', 'Loopcount',inf,'DelayTime',0.1);
    else
        imwrite(v,c,'rotate.gif','gif','WriteMode','append','DelayTime',0.1);
    end
end
movie(M);