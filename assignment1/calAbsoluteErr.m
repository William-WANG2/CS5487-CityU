%% Calculate the mean-squared error
function err = calAbsoluteErr(f, y)
    err = sum(abs(f-y))/size(y,1);
end