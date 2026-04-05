clc; clear; clf;

x = [1, 2, -3, 2, 1];
h = [1, 0, -1, -1, 1];
N = length(x);

y_circ = zeros(1, N);
for n = 0:N-1
    for k = 0:N-1
        idx = pmodulo(n - k, N) + 1;
        y_circ(n+1) = y_circ(n+1) + h(k+1) * x(idx);
    end
end
disp('y(n) circular - Folding & Shifting:'); disp(y_circ);

H_circ = zeros(N, N);
for i = 1:N
    row = [h(i:N), h(1:i-1)];
    H_circ(i, :) = row;
end
disp('Circulant Matrix H:'); disp(H_circ);

y_mat = (H_circ * x')';
disp('y(n) circular - Matrix Method:'); disp(y_mat);

Y = ifft(fft(x) .* fft(h));
disp('y(n) circular - via FFT:'); disp(real(Y));

n = 0:N-1;

subplot(3,1,1);
plot2d3(n, x, style=2);
for i = 1:N
    xstring(n(i), x(i)+0.1, string(x(i)));
end
a = gca(); a.data_bounds = [-0.5, -3; 4.5, 3];
title('x(n)'); xlabel('n'); ylabel('Amplitude');

subplot(3,1,2);
plot2d3(n, y_circ, style=5);
for i = 1:N
    xstring(n(i), y_circ(i)+0.1, string(y_circ(i)));
end
a = gca(); a.data_bounds = [-0.5, -4; 4.5, 5];
title('y(n) = Circular Convolution of x and h');
xlabel('n'); ylabel('Amplitude');

Ex = sum(x.^2);
Ey = sum(y_circ.^2);
disp('Energy of x(n):'); disp(Ex);
disp('Energy of y(n):'); disp(Ey);

subplot(3,1,3);
bar(1:2, [Ex, Ey]);
for i = 1:2
    xstring(i, [Ex, Ey](i)+1, string([Ex, Ey](i)));
end
a = gca();
a.data_bounds = [0, 0; 3, 70];
a.x_ticks = tlist(["ticks","locations","labels"], [1,2], ["E_x","E_y"]);
title('Energy of Signals'); ylabel('Energy');
