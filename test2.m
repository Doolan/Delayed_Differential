function[queue] = test1
tspan=[0 20];
 sol = ddensd(@ddefun,@dely,@delyp,@history,tspan);
tn=linspace(0,20);
[queue,rate]=deval(sol,tn);
close all
figure(1)
hold on
plot(tn,queue(1:3,:))
%plot(tn,sum(queue(1:3,:),1))
hold off
title('queue')
xlabel('time')
ylabel('queue size')
figure(2)
plot(tn,rate)
title('rate')
% queue,rate,tn
end








function yp = ddefun(t,y,ydel,ypdel)
inflow=30;
pp=[10;20;30];
stack=[400;400;400];

damping=.5;
for i=1:3;
    %each row is what each individual cluster wants
k(i,:)=Distrib(y,ydel,pp,stack,damping,i);
end
% 
% for i=1:3
%     if y(i)<10
%         k(i,:)=0;
%     end
% end
% 
%     
        
k=Matrix(k);
tp=.05;

        
for i=1:3;
    if y(i)/pp(i)>1
        pp(i)=pp(i);
    elseif (y(i)/pp(i))<1 & (y(i)/pp(i))>0
        pp(i)=pp(i)*(y(i)/pp(i))^.3;
    else
        pp(i)=0;
    end
    
%k(i,i)=k(i,i)-pp(i);
 k(i,i)=k(i,i)-(pp(i)-tp*sum(k(k(:,i)>0,i))); 
end

yp(4,1)=k(1,2);
yp(5,1)=k(2,3);
yp(6,1)=k(1,3);

k_old=[pp(1),-ypdel(4,1),-ypdel(6,1);
        k(1,2),pp(2),-ypdel(5,1);
        k(1,3),k(2,3),pp(3)];


yp(1,1)=inflow-sum(k_old(:,1));
yp(2,1)=-sum(k_old(:,2));
yp(3,1)=-sum(k_old(:,3));






   


end

function dy = dely(t,y);
dy(1,1)=t-.5;
%time delay for function
end

function dyp = delyp(t,y);
dyp(1,1)=t-1;



end

function y = history(t);
    y(1,1)=60;
    y(2,1)=60;
    y(3,1)=60;
    y(4,1)=60;   
    y(5,1)=60;
    y(6,1)=60;

end

