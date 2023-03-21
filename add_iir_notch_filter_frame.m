function [filtered_signal,x_n_2, x_n_1, y_n_2, y_n_1] = add_iir_notch_filter_frame(f_0, Q, fs,signal, x1 ,x2, y1, y2)
    % ARG: f_0 center Frequency, Q: quality factor, fs: sampling frequency,
    % original signal
    % RETURN: filtered signal 
    if f_0 == 0
        x_n_1 = signal(end);%x(n-1)
        x_n_2 = signal(end-1); %x(n-2)
        y = [y1; y2 ;signal];
        filtered_signal=y(3:884);
        y_n_2 = y(end-1); %the one before last, y(n-2)
        y_n_1 = y(end); %last sample , y(n-1)
    else
        x_n_1 = signal(end);%x(n-1)
        x_n_2 = signal(end-1); %x(n-2)
        dw = 1; %3 dB bandwidth
        w_0 = 2*pi*f_0/fs;
        b = 1/(1+tan(dw/2)); % formula reference: help dsp.NotchPeakFilter
%         notch_b = b * [1, -2*cos(w_0) ,1]; %numerator
%         notch_a = [1, -2*b*cos(w_0), 2*b-1]; %denominator 
        N=length(signal);
        x = [x1 ;x2;signal];
        y = zeros(length(signal),1);
        y = [y1; y2 ;y];
           
        mu = 0.001;
        for k=1:N
            %%%% sng-sng LMS %%%%% to get optimized b
            %ADAPTIVE HOWLING CANCELLER USING ADAPTIVE IIR NOTCH FILTER: SIMULATION AND IMPLIMENTATION 
            %W. Leotwassana, R. Punchalard, and K Silaphan  
            notch_b = b * [1, -2*cos(w_0) ,1]; %numerator
            notch_a = [1, -2*b*cos(w_0), 2*b-1]; %denominator 
            W = [notch_b,-notch_a(2:3)]'; % notch filter coefficients
            y(k+2) = [x(k+2) x(k+1) x(k) y(k+1) y(k)] * W;%convolution with filter coefficients
            w = [1 (-0.95)]';
            g = [y(k+2) x(k+2)] * w; %g(n) is the gradient signal, g>0 the signal is increasing
            dw = dw + mu * sign(sign(abs(y(k+1))-abs(y(k)))*g); % dw decrease , filter is with less amplitue
            dw = min(dw,0.4*pi);
            dw = max(dw, 0.001);
            b = 1/(1+tan(dw/2));
            
        end
        filtered_signal=y(3:884);
        y_n_2 = y(end-1); %the one before last, y(n-2)
        y_n_1 = y(end); %last sample , y(n-1)
    
    end
end

