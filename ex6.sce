clc; clear; clf;

x = [1, 2, -3, 2, 1];
h = [1, 0, -1];

y_check = convol(h, x);
disp('y(n) by convol():'); disp(y_check);

Lx = length(x);
Lh = length(h);
Ly = Lx + Lh - 1;
y_fold = zeros(1, Ly);

for n = 1:Ly
    for k = 1:Lh
        if (n - k + 1 >= 1) && (n - k + 1 <= Lx) then
            y_fold(n) = y_fold(n) + h(k) * x(n - k + 1);
        end
    end
end
disp('y(n) by Folding & Shifting:'); disp(y_fold);

H = zeros(Ly, Lx);
for k = 1:Lh
    for n = k:k+Lx-1
        H(n, n-k+1) = h(k);
    end
end
y_mat = (H * x')';
disp('y(n) by Matrix Method:'); disp(y_mat);

n_x = 0:Lx-1;
n_y = 0:Ly-1;

subplot(3,1,1);
plot2d3(n_x, x, style=2);
for i = 1:Lx
    xstring(n_x(i), x(i)+0.1, string(x(i)));
end
a = gca(); a.data_bounds = [-0.5, -3; 4.5, 3];
title('x(n)'); xlabel('n'); ylabel('Amplitude');

subplot(3,1,2);
plot2d3(n_y, y_fold, style=5);
for i = 1:Ly
    xstring(n_y(i), y_fold(i)+0.1, string(y_fold(i)));
end
a = gca(); a.data_bounds = [-0.5, -4; 6.5, 5];
title('y(n) = x(n) * h(n) - Linear Convolution');
xlabel('n'); ylabel('Amplitude');

Ex = sum(x.^2);
Ey = sum(y_fold.^2);
disp('Energy of x(n):'); disp(Ex);
disp('Energy of y(n):'); disp(Ey);

subplot(3,1,3);
bar(1:2, [Ex, Ey]);
for i = 1:2
    xstring(i, [Ex, Ey](i)+1, string([Ex, Ey](i)));
end
a = gca();
a.data_bounds = [0, 0; 3, 50];
a.x_ticks = tlist(["ticks","locations","labels"], [1,2], ["E_x","E_y"]);
title('Energy of Signals'); ylabel('Energy');
