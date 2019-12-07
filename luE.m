function [L,U] = luE(A)
%%GaussNaive() based L-U Factorization
%   return lower and upper matrices for solving many of the same system.
%   input only square matrix A, no b (does not solve)
[m,n] = size(A);
if m~=n, error('A must be square'); end
L=eye(n); U=A;
for col = 1:n-1
  for row = col+1:n
    fctr = U(row,col)/U(col,col); L(row,col)=fctr;
    U(row,col:n) = U(row,col:n)-fctr*U(col,col:n);
  end
end