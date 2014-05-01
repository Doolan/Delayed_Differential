function[] = test1
tspan=[0 20];
 sol = ddensd(@ddefun,@dely,@delyp,@history,tspan);
tn=linspace(0,10);
[queue,rate]=deval(sol,tn);
close all
figure(1)
plot(tn,queue)
title('queue')
figure(2)
plot(tn,rate)
title('rate')
% queue,rate,tn
end








function yp = ddefun(t,y,ydel,ypdel)
inflow=20*(sin(t)+1);
pp=[10;20;10];
stack=[500;500;500];

damping=.5;
for i=1:3;
k(i,:)=Distrib(ydel,pp,stack,damping,i);
end

k=Matrix(k);

for i=1:3;
k(i,i)=k(i,i)-pp(i);
end


yp(1,1)=inflow+sum(k(:,1));
yp(2,1)=sum(k(:,2));
yp(3,1)=sum(k(:,3));



end

function dy = dely(t,y);
dy(1,1)=t-1;
%time delay for function
end

function dyp = delyp(t,y);
dyp(1,1)=t-.1;



end

function y = history(t);
    y(1,1)=100;
    y(2,1)=100;
    y(3,1)=100;
   
end

