function [a, r2] = linregrE(x,y,varargin)
% linregr: linear regression curve fitting
%   [a, r2] = linregr(x,y): Least squares fit of straight
%           line to data by solving the normal equations
% input:
%   x = independent variable
%   y = dependent variable
%   [opt] fig = figure to plot on; default do not plot.
%   [if fig] 'grid' = grid on; default off
% output:
%   a = vector of slope, a(1), and intercept, a(2)
%   r2 = coefficient of determination
ipLR=inputParser;%get the optional parameters for tolerance, iterations
addRequired(ipLR,'x'); addRequired(ipLR,'y');
addOptional(ipLR,'fig',0,@(x) x==abs(round(x)));
addOptional(ipLR,'grd','',@(x) any(validatestring(x,{'grid'})));
parse(ipLR,x,y,varargin{:})%ip.Results.[var] to call arguments
n = length(x);
if length(y)~=n, error('x and y must be same length'); end
x = x(:); y = y(:); % convert to column vectors
sx = sum(x); sy = sum(y);
sx2 = sum(x.*x); sxy = sum(x.*y); sy2 = sum(y.*y);
a(1) = (n*sxy-sx*sy)/(n*sx2-sx^2);
a(2) = sy/n-a(1)*sx/n;
r2 = ((n*sxy-sx*sy)/sqrt(n*sx2-sx^2)/sqrt(n*sy2-sy^2))^2;
% create plot of data and best fit line
if ipLR.Results.fig
    xp = linspace(min(x),max(x),2);
    yp = a(1)*xp+a(2);
    figure(ipLR.Results.fig); plot(x,y,'o',xp,yp)
    if ipLR.Results.grd
        grid on
    end
end