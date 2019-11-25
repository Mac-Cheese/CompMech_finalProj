function x = GaussPivot(A,varargin)
% GaussPivot: Gauss elimination pivoting
%   x = GaussPivot(A,b): Gauss elimination with pivoting.
% input:
%   A = coefficient matrix
%   b = right hand side vector
% output:
%   x = solution vector
ipGP=inputParser;
addRequired(ipGP,'A'); addOptional(ipGP,'b','b');
parse(ipGP,A,varargin{:})
assignAb=0; assignb=0;
[m,n] = size(ipGP.Results.A); [o,p]=size(ipGP.Results.b);
if m~=n
    if n==(m+1)
    disp('Assuming Augmented'); Aug=A; assignAb=1;
    else
        error('A must be square')
    end
else
    A=ipGP.Results.A;
end
if ~assignAb&&~ischar(ipGP.Results.b)
    if (p>1)
        disp('ignoring extraneous b columns'); b=ipGP.Results.b; assignb=1;
    end
    if (o>m)
        if assignb
            fprintf('Taking first %d rows of b',round(m)); b=b(1:m,1);
        else
            fprintf('Taking first %d rows of b',round(m));
            b=ipGP.Results.b(1:m,1); assignb=1;
        end
    end
    if o<m
        error('b not sufficiently supplied')
    elseif ~assignb
        b=ipGP.Results.b;
    end
    nb = n+1;
    Aug = [A b];
elseif ~assignAb
    error('b not sufficiently supplied')
elseif assignAb&&(ipGP.Results.b(1)~='b')
    disp('Extraneous b supplied; ignoring'); nb=n; n=n-1;
elseif assignAb
    nb=n; n=n-1;
end
% forward elimination
for k = 1:n-1
  % partial pivoting
  [big,i]=max(abs(Aug(k:n,k)));
  ipr=i+k-1;
  if ipr~=k
    Aug([k,ipr],:)=Aug([ipr,k],:);
  end
  for i = k+1:n
    factor=Aug(i,k)/Aug(k,k);
    Aug(i,k:nb)=Aug(i,k:nb)-factor*Aug(k,k:nb);
  end
end
% back substitution
x=zeros(n,1);
x(n)=Aug(n,nb)/Aug(n,n);
for i = n-1:-1:1
  x(i)=(Aug(i,nb)-Aug(i,i+1:n)*x(i+1:n))/Aug(i,i);
end