function[] = test1
tspan=[0 20];
 sol = ddensd(@ddefun,@dely,@delyp,@history,tspan);
tn=linspace(0,20);
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
inflow=30;
pp=[30;40;20];
stack=[400;400;400];

damping=1;
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
tp=.1;

        
for i=1:3;
    if y(i)/pp(i)>1
        pp(i)=pp(i);
    elseif (y(i)/pp(i))<1 & (y(i)/pp(i))>0
        pp(i)=pp(i)*(y(i)/pp(i))^.1;
    else
        pp(i)=0;
    end
    
%k(i,i)=k(i,i)-pp(i);
   k(i,i)=k(i,i)-(pp(i)-tp*sum(k(k(:,i)>0,i))); 
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
    y(1:3,1)=60;
 
   
end

