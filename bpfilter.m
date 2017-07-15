function Hd = bpfilter
%BPFILTER Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 8.1 and the Signal Processing Toolbox 6.19.
% Generated on: 16-Jul-2016 21:42:30

% Equiripple Bandpass filter designed using the FIRPM function.

% All frequency values are in Hz.
Fs = 1000;  % Sampling Frequency

N      = 30;    % Order
Fstop1 = 0.09;  % First Stopband Frequency
Fpass1 = 0.1;   % First Passband Frequency
Fpass2 = 57;    % Second Passband Frequency
Fstop2 = 70;    % Second Stopband Frequency
Wstop1 = 1;     % First Stopband Weight
Wpass  = 1;     % Passband Weight
Wstop2 = 1;     % Second Stopband Weight
dens   = 20;    % Density Factor

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, [0 Fstop1 Fpass1 Fpass2 Fstop2 Fs/2]/(Fs/2), [0 0 1 1 0 ...
           0], [Wstop1 Wpass Wstop2], {dens});
Hd = dfilt.dffir(b);

% [EOF]