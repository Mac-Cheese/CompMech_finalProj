function dy=dydx(n,y,fn,x)
fnx=spline(x,fn(:,1),n);%tailored to take the ODE ouput of f and f(eta)
dy=[y(2);-0.7*fnx*y(2)];%solving for dTHETA and dtTHETA from eq(4)