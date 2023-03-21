function [SFM_in_band,howling_bands] = SFM_howling_detection(frame,threshold,fs,nfft,bw)
% Args:
%   - frame: Spectrum of one frame. The frequency range should be between
%     0 and fs/2 Hz, with a total of nfft/2 frequency bins.
%   - threshold: SFM threshold value for howling detection.
%   - fs: Sampling frequency in Hz.
%   - nfft: FFT length.
%   - bw: Bandwidth of each frequency band in Hz.

% Returns:
%   - SFM_in_band: A binary vector of length nfft/2bw, where 1 indicates howling
%     in the corresponding frequency band, and 0 indicates no howling.
%       (1-20 array) eg.0 0 1 0 0 means the 3rd band is howling 
%   - howling_bands: A vector containing the indices of the frequency bands with
%     howling noise, or an empty array if no howling is detected.
%% with 20 1/3 octave bands, variable bw 
frame = abs(frame);

f_center = [36.1767908943890	47.7165473068120	62.9372819034748	83.0131616172483	109.492891864320	144.419187695662	190.486354132649	251.248131842519	331.391841907987	437.099977929402	576.527139611757	760.429099730129	1002.99253233036	1322.92940954980	1744.92049166657	2301.51926494252	3035.66320196194	4003.98606959998	5281.18680464596	6965.79198347538];
% bw_vector = [10.0479428386143	13.2530588795051	17.4805502464275	23.0565365849553	30.4111639393061	40.1117873335244	52.9067380091402	69.7830516375018	92.0426108107617	121.402575640709	160.127849942245	211.205801786369	278.576716819166	367.437762113383	484.643909112229	639.236743900871	843.141958601118	1112.08933018402	1466.82615625138	1934.71775536878];
bw_vector = [30	30	40	50	100	150	300 400	500	600	800	900	1000	1000	1200	1400	1600	1800	2000	2000];
f_lower = f_center - bw_vector/2;
f_upper = f_center + bw_vector/2;
idx_lower = round(f_lower/(fs/nfft)) + 1;
idx_upper = round(f_upper/(fs/nfft)) + 1;

% Initialize SFM values to 1 (for non-empty bands)
SFM_in_band = ones(20, 1);
howling_bands =  ones(20, 1);
bw_vector = bw_vector/fs*nfft;
% Compute SFM for each band
for b = 1:20
    idx = idx_lower(b):idx_upper(b);
    if any(idx)
        numerator = prod(frame(idx)).^(1/bw_vector(b));
        denominator = sum(frame(idx))./bw_vector(b);
        SFM_in_band(b) = numerator/denominator;
%%%%%%%%%% Howling in bands is marked by a flag updated as %%%%%%%%%%
        if SFM_in_band(b) < threshold
            howling_bands(b) = 0;
        end
    end
end

% Mark bands with SFM below threshold as howling
 % Mark howling in a band with a flag

end