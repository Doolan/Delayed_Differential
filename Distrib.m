function [G] = Distrib(y,pp,stack,damp,num)
%PS Stands for Processing speed, Size is the available space
% 1 is the core that is sharing its data
% 2 and 3 are cores receiving data
% G is the amount to go to each of the boxes
    

amountToReAssign=(stack(num)-(stack(num)-y(num))-.15*stack(num));
if(amountToReAssign < 0)
   G=[0;0;0];
   
    return;
end

remains=stack-y;
k=pp.*remains;
W=k/(sum(k));

dataChunk=amountToReAssign/(sum(W));

G=W*dataChunk;
G=damp*G';
return;
end
