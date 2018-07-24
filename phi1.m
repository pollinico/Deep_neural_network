function [f,g]=phi1(x)

sizeinput=4;
if length(x)~=sizeinput
    fprintf('Wrong size of the input of Phi1 !!')
else
    f=zeros(sizeinput,1);
    g=zeros(sizeinput,sizeinput);
    for i=1:sizeinput
        f(i)=(1-exp(-2*x(i)))/(1+exp(-2*x(i)));
        g(i,i)=4*exp(+2*x(i))/(1+exp(+2*x(i)))^2;
    end
end

