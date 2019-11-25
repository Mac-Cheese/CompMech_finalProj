function x = GaussPivot(A,b)
% GaussPivot: Gauss elimination pivoting
%   x = GaussPivot(A,b): Gauss elimination with pivoting.
% input:
%   A = coefficient matrix
%   b = right hand side vector
% output:
%   x = solution vector
[m,n]=size(A);
if m~=n, error('Matrix A must be square'); end
nb=n+1;
% forward elimination
for k = 1:n-1
  % partial pivoting
  [big,i]=max(abs(A(k:n,k)));
  ipr=i+k-1;
  if ipr~=k
    A([k,ipr],:)=A([ipr,k],:);
  end
  for i = k+1:n
    factor=A(i,k)/A(k,k);
    A(i,k:nb)=A(i,k:nb)-factor*A(k,k:nb);
  end
end
% back substitution
x=zeros(n,1);
x(n)=A(n,nb)/A(n,n);
for i = n-1:-1:1
  x(i)=(A(i,nb)-A(i,i+1:n)*x(i+1:n))/A(i,i);
end