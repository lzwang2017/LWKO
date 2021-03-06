function lwko = LWKO_MILP(x, y, k)
    sM = 1e6;
    [n, p] = size(x);
    IP_c = -[zeros(3 * n, 1); y; -y; ones(n, 1); zeros(1 + p, 1)] / (n - k);
    Am0 = 0;
    IP_A = zeros(7 * n, 6 * n + 1 + p);
    IP_b = zeros(7 * n, 1);
    IP_A(Am0 + [1:4 * n], 5 * n + [1:n]) = [eye(n); eye(n); -eye(n); -eye(n)];
    IP_A(Am0 + [1:4 * n], n + [1:2 * n]) = [-2 * sM * eye(2 * n); zeros(2 * n)];
    IP_A(Am0 + [1:4 * n], 6 * n + [1:(1 + p)]) = [-ones(n, 1), -x; ones(n, 1), x; -ones(n, 1), -x; ones(n, 1), x];
    IP_b(Am0 + [1:4 * n]) = [-y; y; -y; y];
    Am0 = Am0 + 4 * n;
    IP_A(Am0 + [1:n], n + [1:2 * n]) = [eye(n), eye(n)];
    IP_b(Am0 + [1:n]) = 1;
    Am0 = Am0 + n;
    IP_A(Am0 + [1:2 * n], n + [1:4 * n]) = [eye(2 * n), eye(2 * n)];
    IP_b(Am0 + [1:2 * n]) = 1;
    Am0 = Am0 + 2 * n;
    Ae0 = 0;
    IP_Aeq = zeros(1 + n + 1 + p, 6 * n + 1 + p);
    IP_beq = zeros(1 + n + 1 + p, 1);
    IP_Aeq(Ae0 + 1, 1:n) = 1;
    IP_beq(Ae0 + 1) = k;
    Ae0 = Ae0 + 1;
    IP_Aeq(Ae0 + [1:n], 3 * n + [1:2 * n]) = [eye(n), eye(n)];
    IP_Aeq(Ae0 + [1:n], 1:n) = -eye(n);
    IP_beq(Ae0 + [1:n]) = 0;
    Ae0 = Ae0 + n;
    IP_Aeq(Ae0 + [1:(1 + p)], 3 * n + [1:2 * n]) = [-ones(1, n), ones(1, n); -x', x'];
    IP_beq(Ae0 + [1:(1 + p)]) = 0;
    Ae0 = Ae0 + 1 + p;
    IP_lx = [zeros(6 * n, 1); -inf(1 + p, 1)];
    IP_ux = [ones(5 * n, 1); sM * ones(n, 1); inf(1 + p, 1)];
    IP_IntVars = 1:3 * n;
    [~, lwko] = intlinprog(IP_c, IP_IntVars, IP_A, IP_b, IP_Aeq, IP_beq, IP_lx, IP_ux);
end
