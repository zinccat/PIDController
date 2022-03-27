function [loss] = bumpy(arr)
    loss = 0;
    for i = 2:length(arr)-1
        if ~(isnan(arr(i)) || isnan(arr(i+1)))
            loss = loss + abs(arr(i+1) - arr(i));
        end
    end
end