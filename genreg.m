function [a,rSqr]=genreg(func,x,y,varargin)
% Generates a general regression curve and
% plots the curve along with data points
% [a,r2]=genreg(func,x,y)
% Input:
%     func: function handle horizontal array of basis functions (z)
%     x,y: data points
% Output:
%     a: regression curve coefficients
%     r2: coefficient of determination
%calculate the regression curve coefficients (a)
ipGR=inputParser;%get the optional parameters for tolerance, iterations
addRequired(ipGR,'func'); addRequired(ipGR,'x'); addRequired(ipGR,'y');
addOptional(ipGR,'fig',0,@(x) x==abs(round(x)));
addOptional(ipGR,'grd','',@(x) any(validatestring(x,{'grid'})));
parse(ipGR,func,x,y,varargin{:})%ip.Results.[var] to call arguments
dimx=size(x); dimy=size(y);
if dimx(1)<dimx(2)
    x=x';
end
if dimy(1)<dimy(2)
    y=y';
end
var=incsort(x,y);
z=func(var(:,1)); Z=z'*z; d=z'*var(:,2);
a=Z\d;
%calculate r2
St=sum((var(:,2)-mean(var(:,2))).^2); Sr=sum((var(:,2)-z*a).^2);
rSqr=(St-Sr)/St;
%plot the regression curve along with the data
if ipGR.Results.fig
    xReg=linspace(var(1,1),var(end,1))'; yReg=func(xReg)*a;
    figure(ipGR.Results.fig); plot(var(:,1),var(:,2),'o',xReg,yReg)
    if ipGR.Results.grd
        grid on
    end
end
end