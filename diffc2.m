function df=diffc2(f,h)
%%Compute second-order accuracy first derivative
%   input 3+ dependent values at equally spaced intervals, and supply the
%   interval and get derivatives for all the points.
l=length(f);
df=zeros(l,1);
if l>2
    df(1)=(-f(3)+4*f(2)-3*f(1))/(2*h);
    for b=[2:l-1]
        df(b)=(f(b+1)-f(b-1))/(2*h);
    end
    df(l)=(3*f(l)-4*f(l-1)+f(l-2))/(2*h);
else
    disp('not enough points for second-order accuracy')
end