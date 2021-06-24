function lwko = RSAlg1(x, y, k, s)
    n = size(x, 1);

    for i = 1:s
        fvi = ft(randperm(n, k));
        fti = setdiff(1:n, fvi);
        yh(fvi) = h(x(fti, :), y(fti), x(fvi, :));
        rs(i) = mean(abs(y(fvi) - yh(fvi)));
    end

    lwko = max(rs);

end

function yh = h(xt, yt, xv)
    % user defined prediction function
end
