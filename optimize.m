rng default

% Bayesian optimization
Kp = optimizableVariable('Kp',[0,1500],'Type','real');
Ki = optimizableVariable('Ki',[0,1],'Type','real');
Kd = optimizableVariable('Kd',[0,1500],'Type','real');
results = bayesopt(@(k)elevator(k, "Bayesian"), [Kp, Ki, Kd], 'MaxTime', 60, 'MaxObjectiveEvaluations', 500);

% x0 = [10 10 10];
% options = optimoptions(@simulannealbnd,'MaxTime', 60)
% results = simulannealbnd(@(k)elevator(k, "simulannealbnd"), x0, 0, 200, options)

% results = ga(@(k)elevator(k, "No"), 3)