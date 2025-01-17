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
f=[linspace(0,.9999,3334)]';
etaf=eta(f);
figure(1); plot(etaf,f); xlim([0,10]); xlabel('eta'); ylabel('script f')
%% I.b
% derivative
detaf=diffc2(etaf(2:end),.0003); df=1./detaf;
figure(2); hold off; plot(etaf(2:end),df); xlim([0,10]);
xlabel('eta'); ylabel('derivative script f')
%% I.c
% derivative and proving the thing
dtf=diffc2(df,.0003);
figure(3); plot(etaf(2:end),dtf); xlim([0,10]);%may dump first 2 and last 2
xlabel('eta'); ylabel('second derivative script f')
%the thing about shear and skin friction
%% I.d
% maximum velocity
[high,indx]=max(df);
ply=polyfit(etaf((indx-5):(indx+5)),df((indx-5):(indx+5)),2);
figure(2); hold on;
plot(etaf((indx-5):(indx+5)),polyval(ply,etaf((indx-5):(indx+5))))