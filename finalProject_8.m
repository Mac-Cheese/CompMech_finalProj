%% Final Project
% Alden "Mac" Lamp, Eric Kostoss, Nathan Orsini; 11-25-2019
%% init
clc;clear;clf;
%% I
nu=1.5e-5; rho=1.2;%[m^2/s]; [kg/m^3] with laminar valued Reynolds Number
%nondimensional y: eta=y/x*(Re^.25); velocity: df/d'eta = u/Uo
%Uo/Ui = 4/(Re^.5) to ODE  d3f/d'eta^3 + f*d2f/d'eta^2 + 2*(df/d'eta)^2 = 0
%for eta=0, f=df/d'eta=0;  for eta=H=10, df/d'eta=d2f/d'eta^2 = 0
%% I.a
% implicit solution given as
func=@(f,n) log(sqrt(1+sqrt(f)+f)./(1-sqrt(f)))+sqrt(3)*atan(sqrt(3.*f)./(2+sqrt(f)))-n;
n=0:0.05:10;
for i=1:length(n)
    [root(i),fx(i)]=bisect(@(f) func(f,n(i)),0,1);
end
f=root';
n=n';
f(1)=0;
figure(1); plot(n,f); xlim([0,10]); xlabel('eta'); ylabel('script f')

%% I.b
% derivative
df=diffc2(f,0.05);
figure(2); plot(n,df); xlim([0,10]);
xlabel('eta'); ylabel('derivative script f')

%% I.c
% derivative and proving the thing
d2f=diffc2(df,0.05);
figure(3); plot(n,d2f); xlim([0,10]);
xlabel('eta'); ylabel('second derivative script f')
fprintf('f"(0): %5.4f\n',d2f(1))
fprintf('Cf: %5.4f\n',1.778/8)

%% I.d
% maximum velocity
[fx,index]=goldmin_array(df');
fprintf('n: %5.4f\n',n(index))
fprintf("f'(n): %5.4f\n",df(index))
ply=polyfit(n((index-5):(index+5)),df((index-5):(index+5)),2);
figure(2); hold on;
plot(n((index-5):(index+5)),polyval(ply,n((index-5):(index+5))));hold off;

%% I.e
% wall jet momentum flu
Z=trapz(n,df.^2)*trapz(n,df);
fprintf('Analytical: %5.4f\n',Z)
fprintf('Theoretical: %5.4f\n',128/(9*4^3))

%% I.f
% Shear thickness location
dfs=df-0.01;
for i=1:length(df)-1
    if sign(dfs(i))~=sign(dfs(i+1))
        fprintf('Eta: %6.4f\n',n(i))
    end
end

%% I.g
% Velocity at eta=h
v_h=3*n(201)*df(201)-f(201);
fprintf('Analytical: %5.4f\n',Z)

%% I.h
% Solve Eq.(1) and compare to f(n)
dn=@(x,y) [y(2);y(3);-y(1).*y(3)-2.*y(2).^2];
[x,fn]=ode45(dn,[0 10],[0 0 Z]);
figure(1);hold on;
plot(x,fn(:,1),'y--');hold off;

%% I.i
% Solve ODE
za=fzero(@res,Z,[],fn,x);
[n,theta]=ode45(@dydx,[0 10],[1 za],[],fn,x);
figure(4);
plot(theta(:,1),n); xlim([0,1]); xlabel('theta'); ylabel('eta')

%% I.j
% Thermal boundary location
theta_s=theta(:,1)-0.01;
for i=1:length(theta_s)-1
    if sign(theta_s(i))~=sign(theta_s(i+1))
        fprintf('Eta: %6.4f\n',n(i))
    end
end

%% I.k
% Tempature gradient
dtheta=diffc2(theta(:,1),n(2)-n(1));
fprintf("theta'(0): %5.4f\n",-1*dtheta(1))
fprintf('Theoretical: %5.4f\n',0.235*(0.7)^(1/3))

%% I.l
% Solve Eq.(4) and compare to theta(n)
