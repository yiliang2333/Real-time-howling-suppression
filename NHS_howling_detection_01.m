function notch_fre = NHS_howling_detection(frame, T_papr, T_ptpr, T_pnpr,T_phpr,last_index, last_index_1)
    
%%%%%Args:
        %frame: Spectrum of one frame.
        %T_...: Power threshold value in dB for different methods.
    %Returns:
        %Notch Frequency for current frame
    power = abs(frame).^2;
    papr = zeros(length(power),1);
    avarage = mean(power);
    ret_papr = [];
    ret_ptpr = [];
    ret_pnpr = [];
    ret_phpr = [];
    for i = 4:1:length(frame)-3 % take 4:end-3
        papr(i) = 10*log10(power(i)/avarage) ;
%%%%% Peak-to-Avarage Power Ratio (PAPR)
        if papr(i) > T_papr
            ret_papr = [ret_papr, i];
        end
%%%%% Peak-to-Threshold Power Ratio (PTPR)
        if (10*log10(power(i)) > T_ptpr)
            ret_ptpr = [ret_ptpr, i];
        end
%%%%% Peak-to-Neighboring Power Ratio (PNPR)
        if (10*log10(power(i)/power(i-2)) > T_pnpr) ...
            && (10*log10(power(i)/power(i-3)) > T_pnpr)...
            && (10*log10(power(i)/power(i+2)) > T_pnpr )...
            && (10*log10(power(i)/power(i+3)) > T_pnpr)
            ret_pnpr = [ret_pnpr, i];
        end
    end
    % %%%%% Peak-to-Harmonic Power Ratio (PHPR)
    for i = 1:1:floor(length(frame)/3)
        if (10*log10(power(i)/power(2*i)) > T_phpr) && (10*log10(power(i)/power(3*i)) > T_phpr)
            ret_phpr = [ret_phpr, i];
        end
    end
    
    % interselect 
    
    fre_index = intersect(intersect(intersect(ret_papr,ret_ptpr,'stable'),ret_pnpr,'stable'),ret_phpr,'stable');
    if ~isempty(fre_index) 
        fre_index_1 = min(fre_index);
    else
%         fre_index_1 = fre_index_1+1;
        fre_index_1 = 1;
    end

    if fre_index_1 ~= last_index && fre_index_1 ~= last_index_1 
        notch_fre = fre_index_1;
    else
        notch_fre = last_index;
    end

end



