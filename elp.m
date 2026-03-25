function val = elp(P, xq)

    val = zeros(size(xq));

    for k = 1:length(xq)
        x = xq(k);

        % find correct interval
        for i = 1:size(P,1)
            a = P(i,1); b = P(i,2);

            if x >= a && x <= b
                p0 = P(i,3);
                p1 = P(i,4);

                val(k) = p0 + p1 * x;
                break;
            end
        end
    end

end