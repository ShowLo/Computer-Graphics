teapot;
hold on;
%画出最原始的三维茶壶
mesh(X_body, Y_body, Z_body, ones(size(Z_body)));
mesh(X_lid, Y_lid, Z_lid, ones(size(Z_lid)));
mesh(X_base, Y_base, Z_base, ones(size(Z_base)));
mesh(X_handle, Y_handle, Z_handle, ones(size(Z_handle)));
mesh(X_spout, Y_spout, Z_spout, ones(size(Z_spout)));