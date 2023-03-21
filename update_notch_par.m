function notchFrequency = update_notch_par(take_10_notch_fre_id, fs, nfft)
    current_notch_fre_id = 2;
    if any(take_10_notch_fre_id == 2)
        notchFrequency = 0;
    else
        % 计算A中每个元素出现的次数
        [counts, bins] = histcounts(take_10_notch_fre_id);

        % 找到出现次数最大的元素的索引
        [max_count, max_idx] = max(counts);

        % 判断最大出现次数是否大于等于3，如果是，则将b赋值为对应的元素
        if max_count >= 1
            current_notch_fre_id = bins(max_idx);
        else
            current_notch_fre_id = 1;
        end
    
        freqs = linspace(0, fs, nfft);
    %     if current_notch_fre_id == 0 
    %         current_notch_fre_id = 2 ;
    %     end
        if current_notch_fre_id > 0 && current_notch_fre_id <= length(freqs)
        notchFrequency = floor(floor(max(freqs(current_notch_fre_id+1) + 20, 0)));
        else
            notchFrequency = 0;
        end
    end
end