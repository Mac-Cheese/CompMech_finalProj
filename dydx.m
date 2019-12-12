function dy=dydx(n,y,fn,x)
fnx=spline(x,fn(:,1),n);
dy=[y(2);-0.7*fnx*y(2)];