function r=res(za,pick,varargin)%varargin (fn,x)
if pick==1
    [~,y]=ode45(@dydx,[0,10],[0,0,za],[],pick);
    r=y(end,1)-1;
elseif pick==2
    [~,y]=ode45(@dydx,[0 10],[1 za],[],pick,varargin{:});
    r=y(end,1)-0;
end