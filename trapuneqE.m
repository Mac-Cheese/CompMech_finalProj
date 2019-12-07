function I = trapuneqE(x,y)
% trapuneq: unequal spaced trapezoidal rule quadrature
%   I = trapuneq(x,y):
%   Applies the trapezoidal rule to determine the integral
%   for n data points (x, y) where x and y must be of the
%   same length and x must be monotonically ascending
% input:
%   x = vector of independent variables
%   y = vector of dependent variables
% output:
%   I = integral estimate
if nargin<2,error('at least 2 input arguments required'),end
n = length(x);
if length(y)~=n,error('x and y must be same length'); end
if any(diff(x)<0)
    srt=zeros(n,2); srt(:,1)=x(:); srt(:,2)=y(:);
    for o=[1:n]
        [smll,here]=min(srt(o:end,1));
        if srt(o,1)~=smll
            srt([o,here+(o-1)],:)=srt([here+(o-1),o],:);
        end
    end
    x(:)=srt(:,1); y(:)=srt(:,2);
end
s = 0;
for k = 1:n-1
  s = s + (x(k+1)-x(k))*(y(k)+y(k+1))/2;
end
I = s;