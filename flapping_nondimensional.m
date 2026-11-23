r0  = 0.1;
dom = [r0 1];

A = chebop(dom);
B = chebop(dom);

Jv = linspace(0.1, 1, 20);

for ii = 1:length(Jv)

    J = Jv(ii);

    A.op = @(x,W) diff(W,4) - J*diff((1-x^2)*diff(W));
    B.op = @(x,W) W;

    A.lbc = @(W) [W; diff(W)];
    A.rbc = @(W) [diff(W,2); diff(W,3)];

    NE = 2;

    [WW, lambda] = eigs(A, B, NE);
    lambda = diag(lambda);

    lambda1(ii) = lambda(1);
    lambda2(ii) = lambda(2);

end

%%

figure(158); hold on 
plot(Jv, sqrt(lambda1))
plot(Jv, sqrt(lambda2))

figure(15389); hold on 
plot(WW)
xlabel $\xi$
ylabel $w_n$