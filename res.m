function r=res(za,fn,x)
[n,y]=ode45(@dydx,[0 10],[1 za],[],fn,x);
r=y(end,1)-0;