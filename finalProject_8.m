%% Final Project
% Alden "Mac" Lamp, Eric Kostoss, Nathan Orsini; 11-25-2019
%% init
clear all
%% I
nu=1.5e-5; rho=1.2;%[m^2/s]; [kg/m^3] with laminar valued Reynolds Number
%nondimensional y: eta=y/x*(Re^.25); velocity: df/d'eta = u/Uo
%Uo/Ui = 4/(Re^.5) to ODE  d3f/d'eta^3 + f*d2f/d'eta^2 + 2*(df/d'eta)^2 = 0
%for eta=0, f=df/d'eta=0;  for eta=H=10, df/d'eta=d2f/d'eta^2 = 0
%% I.a
% implicit solution given as
eta=@(f) log(sqrt(1+sqrt(f)+f)./(1-sqrt(f)))+...
    sqrt(3)*atan(sqrt(3.*f)./(2+sqrt(f)));
f=[linspace(0,.0198),linspace(.02,.97,96),linspace(.9701,.9999,150)];
etaf=eta(f);%346 elements
figure(1); plot(etaf,f); xlim([0,10]); xlabel('eta'); ylabel('script f')
%% I.b
% derivative
detaf=[diffc2(etaf(1:100),.0002); diffc2(etaf(101:196),.01);...
    diffc2(etaf(197:346),.0002)]; df=1./detaf;
figure(2); plot(etaf,df); xlim([0,10]);
xlabel('eta'); ylabel('derivative script f')