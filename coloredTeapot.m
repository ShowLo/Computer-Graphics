teapot;
%画出上色之后的茶壶
hold on;
colormap([1 1 1]);
surf(X_body, Y_body, Z_body, ones(size(Z_body)));
surf(X_lid, Y_lid, Z_lid, ones(size(Z_lid)));
surf(X_base, Y_base, Z_base, ones(size(Z_base)));
surf(X_handle, Y_handle, Z_handle, ones(size(Z_handle)));
surf(X_spout, Y_spout, Z_spout, ones(size(Z_spout)));
shading interp;
lighting phong;
light('color', 'w', 'style', 'infinite', 'position', [1, 2, 1]);