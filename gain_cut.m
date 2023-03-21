function y = gain_cut(howling, signal)
    persistent counter;
    if isempty(counter)
        counter = 0;
    end
    if howling == 0 % howling detected
        counter = 50;
    end
    if counter > 0 % mute output for 3 frames
        y = zeros(size(signal));
        counter = counter - 1;
    else
        y = signal;
    end
end
