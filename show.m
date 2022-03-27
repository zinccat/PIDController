function [] = show(k)
    % accurate (?) drawing using symbolic inverse laplace transform

    Kp = k(1);
    Ki = k(2);
    Kd = k(3);

    n = 500;
    endtime = 10;

    syms s t;
    G = (Kp+Ki/s+Kd*s)*(s+10)/(s*(s+1)*(s+20)*(s+50));
    transfer_close = G/(1+G)*4/s;
    % f = @(s) (Kp+Ki/s+Kd*s)*(s+10)/(s*(s+1)*(s+20)*(s+50));
    % transfer_close = @(s) f(s)/(1+f(s))*4/s;

    % Fast numerical inverse laplace transform using 
    % Numerical Inverse Laplace Transform 
    % by Tucker McClure
    x = linspace(0, endtime, n);
    f = ilaplace(transfer_close);
    % sub f using x
    y = double(subs(f, t, x));
    
    % y = talbot_inversion(transfer_close, x);

    plot(x, y)