function [ matrix ] = Matrix( matrix )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
dimensions=size(matrix,1);
for i=1: dimensions;
    for j=1: dimensions;
       if(matrix(i,j)>matrix(j,i))
           matrix(i,j)=matrix(i,j)-matrix(j,i);
           matrix(j,i)=-matrix(i,j);
       else
           matrix(j,i)=matrix(j,i)-matrix(i,j);
           matrix(i,j)=-matrix(j,i);              
       end
    end
end
end
