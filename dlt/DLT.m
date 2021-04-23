function  [A,P] = DLT( Wpts, Ipts )
%% DLT Algorithm 

% Initialize A 
m = size(Wpts',2);
A = zeros(2*m,9);

%Create a loop which for eache line of the image we have two line of A 
 for i = 1:m
  
    XI = Ipts(i,1);
    YI = Ipts(i,2);
    WI = Ipts(i,3);
    XW = Wpts(i,1);
    YW = Wpts(i,2);
    ZW = Wpts(i,3);
    
   A(2*i-1,:) = [XI,YI,1,0,0,0,-XI*XW,-XW*YI,-XW];
   A(2*i, :) = [0,0,0,XI,YI,1, -XI*YW,-YW*YI,-YW];
    
 end

%Solve the homography of A
[u,s,v] = svd(A);
x = v(:,9);

%Compile the projection matrice
P = reshape(x,3,3);

end

