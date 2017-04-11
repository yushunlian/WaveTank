function [ H,D1,D2,D3,S2_1,S2_m,S_1,S_m,e_1,e_m ] = SBP6(m,h)
% Constructs 6th order SBP operatos
%
%   Input:    m, number of grid points
%             h, grid size
%
%   Output:   H, diagonal norm matrix
%             D1, D3, derivative operators
%             S2_1, S2,m, second derivative at boundary
%             S_m, first derivate at right boundary
%             e_1, e_m, unit vectors
%


% Diagonal norm matrix
H=diag(ones(m,1),0);    
H_U=[0.318365e6 / 0.1016064e7 0 0 0 0 0 0 0; 0 0.145979e6 / 0.103680e6 0 0 0 0 0 0; 0 0 0.139177e6 / 0.241920e6 0 0 0 0 0; 0 0 0 0.964969e6 / 0.725760e6 0 0 0 0; 0 0 0 0 0.593477e6 / 0.725760e6 0 0 0; 0 0 0 0 0 0.52009e5 / 0.48384e5 0 0; 0 0 0 0 0 0 0.141893e6 / 0.145152e6 0; 0 0 0 0 0 0 0 0.1019713e7 / 0.1016064e7;];

H(1:8,1:8)=H_U;
H(m-7:m,m-7:m)=rot90(H_U,2);
H=H*h;
        %HI=inv(H);


% First derivative SBP operator, 1st order accurate at first 6 boundary points

q3=1/60;q2=-3/20;q1=3/4;
Q=q3*(diag(ones(m-3,1),3) - diag(ones(m-3,1),-3))+q2*(diag(ones(m-2,1),2) - diag(ones(m-2,1),-2))+q1*(diag(ones(m-1,1),1)-diag(ones(m-1,1),-1));

Q_U = [0 0.1547358409e10 / 0.2421619200e10 -0.422423e6 / 0.11211200e8 -0.1002751721e10 / 0.8717829120e10 -0.15605263e8 / 0.484323840e9 0.1023865e7 / 0.24216192e8 0.291943739e9 / 0.21794572800e11 -0.24659e5 / 0.2534400e7; -0.1547358409e10 / 0.2421619200e10 0 0.23031829e8 / 0.62899200e8 0.10784027e8 / 0.34594560e8 0.2859215e7 / 0.31135104e8 -0.45982103e8 / 0.345945600e9 -0.26681e5 / 0.1182720e7 0.538846039e9 / 0.21794572800e11; 0.422423e6 / 0.11211200e8 -0.23031829e8 / 0.62899200e8 0 0.28368209e8 / 0.69189120e8 -0.9693137e7 / 0.69189120e8 0.1289363e7 / 0.17740800e8 -0.39181e5 / 0.5491200e7 -0.168647e6 / 0.24216192e8; 0.1002751721e10 / 0.8717829120e10 -0.10784027e8 / 0.34594560e8 -0.28368209e8 / 0.69189120e8 0 0.5833151e7 / 0.10644480e8 0.4353179e7 / 0.69189120e8 0.2462459e7 / 0.155675520e9 -0.215471e6 / 0.10762752e8; 0.15605263e8 / 0.484323840e9 -0.2859215e7 / 0.31135104e8 0.9693137e7 / 0.69189120e8 -0.5833151e7 / 0.10644480e8 0 0.7521509e7 / 0.13837824e8 -0.1013231e7 / 0.11531520e8 0.103152839e9 / 0.8717829120e10; -0.1023865e7 / 0.24216192e8 0.45982103e8 / 0.345945600e9 -0.1289363e7 / 0.17740800e8 -0.4353179e7 / 0.69189120e8 -0.7521509e7 / 0.13837824e8 0 0.67795697e8 / 0.98841600e8 -0.17263733e8 / 0.151351200e9; -0.291943739e9 / 0.21794572800e11 0.26681e5 / 0.1182720e7 0.39181e5 / 0.5491200e7 -0.2462459e7 / 0.155675520e9 0.1013231e7 / 0.11531520e8 -0.67795697e8 / 0.98841600e8 0 0.1769933569e10 / 0.2421619200e10; 0.24659e5 / 0.2534400e7 -0.538846039e9 / 0.21794572800e11 0.168647e6 / 0.24216192e8 0.215471e6 / 0.10762752e8 -0.103152839e9 / 0.8717829120e10 0.17263733e8 / 0.151351200e9 -0.1769933569e10 / 0.2421619200e10 0;];

Q(1:8,1:8)=Q_U;
Q(m-7:m,m-7:m)=rot90(  -Q_U ,2 );

e_1=zeros(m,1);e_1(1)=1;
e_m=zeros(m,1);e_m(m)=1;


D1=H\(Q-1/2*(e_1*e_1')+1/2*(e_m*e_m')) ;



% Second derivative, 1st order accurate at first 6 boundary points
m3=-1/90;m2=3/20;m1=-3/2;m0=49/18;

M=m3*(diag(ones(m-3,1),3)+diag(ones(m-3,1),-3))+m2*(diag(ones(m-2,1),2)+diag(ones(m-2,1),-2))+m1*(diag(ones(m-1,1),1)+diag(ones(m-1,1),-1))+m0*diag(ones(m,1),0);
M_U=[0.4347276223e10 / 0.3736212480e10 -0.1534657609e10 / 0.1210809600e10 0.68879e5 / 0.3057600e7 0.1092927401e10 / 0.13076743680e11 0.18145423e8 / 0.968647680e9 -0.1143817e7 / 0.60540480e8 -0.355447739e9 / 0.65383718400e11 0.56081e5 / 0.16473600e8; -0.1534657609e10 / 0.1210809600e10 0.42416226217e11 / 0.18681062400e11 -0.228654119e9 / 0.345945600e9 -0.12245627e8 / 0.34594560e8 -0.2995295e7 / 0.46702656e8 0.52836503e8 / 0.691891200e9 0.119351e6 / 0.12812800e8 -0.634102039e9 / 0.65383718400e11; 0.68879e5 / 0.3057600e7 -0.228654119e9 / 0.345945600e9 0.5399287e7 / 0.4193280e7 -0.24739409e8 / 0.34594560e8 0.7878737e7 / 0.69189120e8 -0.1917829e7 / 0.31449600e8 0.39727e5 / 0.3660800e7 0.10259e5 / 0.4656960e7; 0.1092927401e10 / 0.13076743680e11 -0.12245627e8 / 0.34594560e8 -0.24739409e8 / 0.34594560e8 0.7780367599e10 / 0.3736212480e10 -0.70085363e8 / 0.69189120e8 -0.500209e6 / 0.6289920e7 -0.311543e6 / 0.17962560e8 0.278191e6 / 0.21525504e8; 0.18145423e8 / 0.968647680e9 -0.2995295e7 / 0.46702656e8 0.7878737e7 / 0.69189120e8 -0.70085363e8 / 0.69189120e8 0.7116321131e10 / 0.3736212480e10 -0.545081e6 / 0.532224e6 0.811631e6 / 0.11531520e8 -0.84101639e8 / 0.13076743680e11; -0.1143817e7 / 0.60540480e8 0.52836503e8 / 0.691891200e9 -0.1917829e7 / 0.31449600e8 -0.500209e6 / 0.6289920e7 -0.545081e6 / 0.532224e6 0.324760747e9 / 0.138378240e9 -0.65995697e8 / 0.49420800e8 0.1469203e7 / 0.13759200e8; -0.355447739e9 / 0.65383718400e11 0.119351e6 / 0.12812800e8 0.39727e5 / 0.3660800e7 -0.311543e6 / 0.17962560e8 0.811631e6 / 0.11531520e8 -0.65995697e8 / 0.49420800e8 0.48284442317e11 / 0.18681062400e11 -0.1762877569e10 / 0.1210809600e10; 0.56081e5 / 0.16473600e8 -0.634102039e9 / 0.65383718400e11 0.10259e5 / 0.4656960e7 0.278191e6 / 0.21525504e8 -0.84101639e8 / 0.13076743680e11 0.1469203e7 / 0.13759200e8 -0.1762877569e10 / 0.1210809600e10 0.10117212851e11 / 0.3736212480e10;];

M(1:8,1:8)=M_U;

M(m-7:m,m-7:m)=rot90(  M_U ,2 );
M=M/h;
    
S_U=[-0.25e2 / 0.12e2 4 -3 0.4e1 / 0.3e1 -0.1e1 / 0.4e1;]/h;
S_1=zeros(1,m);
S_1(1:5)=S_U;
S_m=zeros(1,m);

S_m(m-4:m)=fliplr(-S_U);

D2=H\(-M-e_1*S_1+e_m*S_m);


% Third derivative, 1st order accurate at first 6 boundary points

q4=7/240;q3=-3/10;q2=169/120;q1=-61/30;
Q3=q4*(diag(ones(m-4,1),4)-diag(ones(m-4,1),-4))+q3*(diag(ones(m-3,1),3)-diag(ones(m-3,1),-3))+q2*(diag(ones(m-2,1),2)-diag(ones(m-2,1),-2))+q1*(diag(ones(m-1,1),1)-diag(ones(m-1,1),-1));   

Q3_U = [0 -0.10882810591e11 / 0.5811886080e10 0.398713069e9 / 0.132088320e9 -0.1746657571e10 / 0.1162377216e10 0.56050639e8 / 0.145297152e9 -0.11473393e8 / 0.1162377216e10 -0.38062741e8 / 0.1452971520e10 0.30473e5 / 0.4392960e7; 0.10882810591e11 / 0.5811886080e10 0 -0.3720544343e10 / 0.830269440e9 0.767707019e9 / 0.207567360e9 -0.1047978301e10 / 0.830269440e9 0.1240729e7 / 0.14826240e8 0.6807397e7 / 0.55351296e8 -0.50022767e8 / 0.1452971520e10; -0.398713069e9 / 0.132088320e9 0.3720544343e10 / 0.830269440e9 0 -0.2870078009e10 / 0.830269440e9 0.74962049e8 / 0.29652480e8 -0.12944857e8 / 0.30750720e8 -0.17846623e8 / 0.103783680e9 0.68707591e8 / 0.1162377216e10; 0.1746657571e10 / 0.1162377216e10 -0.767707019e9 / 0.207567360e9 0.2870078009e10 / 0.830269440e9 0 -0.727867087e9 / 0.276756480e9 0.327603877e9 / 0.207567360e9 -0.175223717e9 / 0.830269440e9 0.1353613e7 / 0.726485760e9; -0.56050639e8 / 0.145297152e9 0.1047978301e10 / 0.830269440e9 -0.74962049e8 / 0.29652480e8 0.727867087e9 / 0.276756480e9 0 -0.1804641793e10 / 0.830269440e9 0.311038417e9 / 0.207567360e9 -0.1932566239e10 / 0.5811886080e10; 0.11473393e8 / 0.1162377216e10 -0.1240729e7 / 0.14826240e8 0.12944857e8 / 0.30750720e8 -0.327603877e9 / 0.207567360e9 0.1804641793e10 / 0.830269440e9 0 -0.1760949511e10 / 0.830269440e9 0.2105883973e10 / 0.1452971520e10; 0.38062741e8 / 0.1452971520e10 -0.6807397e7 / 0.55351296e8 0.17846623e8 / 0.103783680e9 0.175223717e9 / 0.830269440e9 -0.311038417e9 / 0.207567360e9 0.1760949511e10 / 0.830269440e9 0 -0.1081094773e10 / 0.528353280e9; -0.30473e5 / 0.4392960e7 0.50022767e8 / 0.1452971520e10 -0.68707591e8 / 0.1162377216e10 -0.1353613e7 / 0.726485760e9 0.1932566239e10 / 0.5811886080e10 -0.2105883973e10 / 0.1452971520e10 0.1081094773e10 / 0.528353280e9 0;];

Q3(1:8,1:8)=Q3_U;
Q3(m-7:m,m-7:m)=rot90(  -Q3_U ,2 );
Q3=Q3/h^2;

S2_U=[0.35e2 / 0.12e2 -0.26e2 / 0.3e1 0.19e2 / 0.2e1 -0.14e2 / 0.3e1 0.11e2 / 0.12e2;]/h^2;
S2_1=zeros(1,m);
S2_1(1:5)=S2_U;
S2_m=zeros(1,m);
S2_m(m-4:m)=fliplr(S2_U);

D3=H\(Q3 - e_1*S2_1 + e_m*S2_m +1/2*(S_1'*S_1) -1/2*(S_m'*S_m) ) ;

end
