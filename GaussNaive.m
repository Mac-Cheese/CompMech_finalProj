function x = GaussNaive(A,varargin)
% GaussNaive: naive Gauss elimination
%   x = GaussNaive(A,b): Gauss elimination without pivoting.
% input:
%   A = coefficient matrix
%   b = right hand side vector
% output:
%   x = solution vector
ipGN=inputParser;
addRequired(ipGN,'A'); addOptional(ipGN,'b','b');
parse(ipGN,A,varargin{:})
assignAb=0; assignb=0;
[m,n] = size(ipGN.Results.A); [o,p]=size(ipGN.Results.b);
if m~=n
    if n==(m+1)
    disp('Assuming Augmented'); Aug=A; assignAb=1;
    else
        error('A must be square')
    end
else
    A=ipGN.Results.A;
end
if ~assignAb&&~ischar(ipGN.Results.b)
    if (p>1)
        disp('ignoring extraneous b columns'); b=ipGN.Results.b; assignb=1;
    end
    if (o>m)
        if assignb
            fprintf('Taking first %d rows of b',round(m)); b=b(1:m,1);
        else
            fprintf('Taking first %d rows of b',round(m));
            b=ipGN.Results.b(1:m,1); assignb=1;
        end
    end
    if o<m
        error('b not sufficiently supplied')
    elseif ~assignb
        b=ipGN.Results.b;
    end
    nb = n+1;
    Aug = [A b];
elseif ~assignAb
    error('b not sufficiently supplied')
elseif assignAb&&(ipGN.Results.b(1)~='b')
    disp('Extraneous b supplied; ignoring'); nb=n; n=n-1;
elseif assignAb
    nb=n; n=n-1;
end
% forward elimination
for k = 1:n-1
  for i = k+1:n
    factor = Aug(i,k)/Aug(k,k);
    Aug(i,k:nb) = Aug(i,k:nb)-factor*Aug(k,k:nb);
  end
end
% back substitution
x = zeros(n,1);
x(n) = Aug(n,nb)/Aug(n,n);
for i = n-1:-1:1
  x(i) = (Aug(i,nb)-Aug(i,i+1:n)*x(i+1:n))/Aug(i,i);
end