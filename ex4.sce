clear; clf; clc;

// Read audio file
[y, Fs] = wavread('/Users/vohoangnguyen/Documents/DSP_Lab/DSP_Lab4/audio.wav');

// Plot waveform (zoom 0.02s for clarity)
N_show = int(Fs * 0.02);
t = (0:N_show-1) / Fs;
subplot(2,1,1);
plot(t, y(1:N_show), 'r', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude');
title('Waveform');
xgrid(5);

// Compute and plot frequency spectrum using FFT
N = length(y);
Y = fft(y);
mag = abs(Y(1:N/2)) / N;
f = (0:N/2-1) * Fs / N;
subplot(2,1,2);
plot(f, mag, 'b', 'LineWidth', 1.5);
xlabel('Frequency (Hz)'); ylabel('Magnitude');
title('Frequency Spectrum');
xgrid(5);
