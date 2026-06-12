 % =========================================================
%  plot_imu.m
%  Loads imu_data.csv produced by imu_logger.py and
%  plots Roll, Pitch, and Yaw over time.
%
%  Usage:
%    1. Copy imu_data.csv from Raspberry Pi to this folder.
%    2. Run this script:  >> plot_imu
% =========================================================

clear; clc; close all;

% ── 1. Load CSV ──────────────────────────────────────────
fname = 'imu_data.csv';
if ~isfile(fname)
    error('CSV file "%s" not found. Copy it from the Raspberry Pi first.', fname);
end

T = readtable(fname);

% Column names (must match CSV header written by imu_logger.py)
t     = T.time_s;
roll  = T.roll_deg;
pitch = T.pitch_deg;
yaw   = T.yaw_deg;

fprintf('Loaded %d samples  |  Duration: %.2f s\n', height(T), t(end));

% ── 2. Figure: Roll, Pitch, Yaw ──────────────────────────
figure('Name', 'MPU9250 Kalman Filter — Time Series', ...
       'NumberTitle', 'off', ...
       'Position', [80 80 1100 700]);

%% ── Plot 1: Roll ─────────────────────────────────────────
subplot(3, 1, 1);
plot(t, roll, 'b', 'LineWidth', 1.4);
title('Roll Angle (Kalman Filtered)');
xlabel('Time (s)');
ylabel('Angle (°)');
grid on;
xlim([t(1) t(end)]);

%% ── Plot 2: Pitch ────────────────────────────────────────
subplot(3, 1, 2);
plot(t, pitch, 'r', 'LineWidth', 1.4);
title('Pitch Angle (Kalman Filtered)');
xlabel('Time (s)');
ylabel('Angle (°)');
grid on;
xlim([t(1) t(end)]);

%% ── Plot 3: Yaw ──────────────────────────────────────────
subplot(3, 1, 3);
plot(t, yaw, 'Color', [0.13 0.55 0.13], 'LineWidth', 1.4);
title('Yaw Angle (Mag or Gyro integrated)');
xlabel('Time (s)');
ylabel('Angle (°)');
grid on;
xlim([t(1) t(end)]);

sgtitle('MPU9250 Kalman Filter — Raspberry Pi 5', ...
        'FontSize', 14, 'FontWeight', 'bold');

% ── 3. Print summary stats ─────────────────────────────────
fprintf('\n── Summary ──────────────────────────────────\n');
fprintf('Roll  : min=%6.2f°   max=%6.2f°\n', min(roll),  max(roll));
fprintf('Pitch : min=%6.2f°   max=%6.2f°\n', min(pitch), max(pitch));
fprintf('Yaw   : min=%6.2f°   max=%6.2f°\n', min(yaw),   max(yaw));
fprintf('─────────────────────────────────────────────\n');
