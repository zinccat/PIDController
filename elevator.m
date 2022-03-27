function [loss] = elevator(k, method)
    if method == 'Bayesian'
        k = table2array(k);
    end

    Kp = k(1);
    Ki = k(2);
    Kd = k(3);

    n = 500;
    endtime = 10;

    f = @(s) (Kp+Ki/s+Kd*s)*(s+10)/(s*(s+1)*(s+20)*(s+50));
    transfer_close = @(s) f(s)/(1+f(s))*4/s;

    % Fast numerical inverse laplace transform using 
    % Numerical Inverse Laplace Transform 
    % by Tucker McClure
    x = linspace(0, endtime, n);
    y = talbot_inversion(transfer_close, x);
    loss_overshoot = abs(max(y)-4);
    loss_setting = find(abs(y-4)>0.015*4, 1, 'last');
    loss_setting = loss_setting/n*endtime;
    if isempty(loss_setting)
        loss_setting = 0;
    end
    loss_bumpy = bumpy(y)/n;

    % Penalize if it is not settled in the end
    if loss_setting == endtime
        loss_setting = 2*endtime;
    end

    loss = 500*loss_overshoot + loss_setting + 100*loss_bumpy;