%% Calculate the mean-squared error
function err = calMeanSquaredErr(f, y)
    err = sum((f-y).^2)/size(y,1);
end