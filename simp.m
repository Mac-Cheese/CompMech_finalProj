function a=simp(f,intrvl,n)
%%compute Simpson's rule, quadratic polynomial approximation integration
%   f, a function
%   intrvl, an interval (2 element array)
%   n, even number of intervals (n+1 points)
a=0;
if (rem(n,2)<1e-4)&&(n==abs(round(n)))
    h=((intrvl(2)-intrvl(1))/n); x=zeros(n+1,1);
    for o=[1:n+1]
        x(o)=intrvl(1)+((intrvl(2)-intrvl(1))*(o/(n+1)));
    end
    for p=[1:2:n]
        a=a+((h/3)*(4*f(x(p))+2*f(x(p+1))));
    end
else
    disp('number of intervals not even')
end