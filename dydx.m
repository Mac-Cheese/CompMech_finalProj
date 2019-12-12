function dy=dydx(n,y,pick,varargin)
if pick==1
    dy=[y(2);y(3);-y(1).*y(3)-2.*y(2).^2];%solving for f' f" f"' from eq(1)
elseif pick==2
    fnx=spline(varargin{2},varargin{1},n);
    dy=[y(2);-0.7*fnx*y(2)];%solving for dTHETA and dtTHETA from eq(4)
end