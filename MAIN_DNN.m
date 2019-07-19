%% Neural Network, 2 layers, 5+4 neuronx, 
%  Nicolo Pollini nicolo@campus.technion.ac.il, 
%  Technion - Israel Institute of Technology, Haifa July 2016
%
% Disclaimer:                                                             
% The author reserves all rights but does not guarantee that the code is  
% free from errors. Furthermore, the author shall not be liable in any    
% event caused by the use of the program. 
 
clear all
close all
clc
commandwindow;


%% Plot function to approximate
[X1, X2] = meshgrid(-2:.2:2, -2:.2:2);
Y = X1 .* exp(-X1.^2 - X2.^2);
figure(101)
surf(X1, X2, Y)
az = 25;
el = 25;
view(az, el);
title('Contour of f(x_{1},x_{2})')
xlabel('x_{1}')
ylabel('x_{2}')
zlabel('f')
%% DATA

%Neurons in first layer 
input=2;
output=1;
neurons1=4;
neurons2=3;

% W1=zeros(input,neurons1);
W1=randn(input,neurons1)/sqrt(neurons1);
% W2=zeros(neurons1,neurons2);
W2=randn(neurons1,neurons2)/sqrt(neurons2);
% W3=zeros(neurons2,output);
W3=randn(neurons2,output)/sqrt(output);

b1=zeros(neurons1,1);
b2=zeros(neurons2,1);
b3=zeros(output,1);

W=[W1(:);W2(:);W3(:);b1;b2;b3];



%% Finite differences check
% x0=[1;1];
% [f,gW]=myDNNapprox(W,x0,par)
% [gWnum]=finitediff(W,x0,par)
% gW./gWnum



%% Generate training and test sets
Ntrain=500;
X_train= 4*rand(2,Ntrain)-2;

Ntest=200;
X_test= 4*rand(2,Ntest)-2;

Y_train=zeros(Ntrain,1);
for i=1:Ntrain
Y_train(i)=myfunction(X_train(:,i));
end

Y_test=zeros(Ntest,1);
for i=1:Ntest
Y_test(i)=myfunction(X_test(:,i));
end

par=struct('input',input,'output',output,'neurons1',neurons1,...
    'neurons2',neurons2,'Ntrain',Ntrain,'Ntest',Ntest);

%% Train network
W=quasi_newton_BFGS(@myErrorFunc,W,X_train,Y_train,X_test,Y_test,par,'train');


%% Plot function to approximate
[X1, X2] = meshgrid(-2:.2:2, -2:.2:2);
Y = X1 .* exp(-X1.^2 - X2.^2);
figure(1)
hold on
surf(X1, X2, Y)
az = 25;
el = 25;
view(az, el);
title('Contour of f(x_{1},x_{2})')
xlabel('x_{1}')
ylabel('x_{2}')
zlabel('f')

%% Network reconstruction
network_reconstruction=NetworkReconstruction(W,X_test,par);

ff = fit([X_test(1,:)', X_test(2,:)'], network_reconstruction,'linearinterp');
plot( ff, [X_test(1,:)', X_test(2,:)'], network_reconstruction)

%% Plot results 

W1=reshape(W(1:input*neurons1),[input,neurons1])
count=input*neurons1;

W2=reshape(W(count+1:count+neurons1*neurons2),[neurons1,neurons2])
count=count + neurons1*neurons2;

W3=reshape(W(count+1:count+neurons2*output),[neurons2,output])
count=count + neurons2*output;

b1=W(count+1:count+neurons1)
count=count +neurons1;

b2=W(count+1:count+neurons2)
count=count +neurons2;

b3=W(count+1:count+output)
