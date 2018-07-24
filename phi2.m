function [f,g]=phi2(x)

sizeinput=3;
if length(x)~=sizeinput
    fprintf('Wrong size of the input of Phi2 !!')
else
    f=zeros(sizeinput,1);
    if nargout>1
        g=zeros(sizeinput,sizeinput);
    end
    for i=1:sizeinput
        f(i)=(1-exp(-2*x(i)))/(1+exp(-2*x(i)));
        if nargout>1
            g(i,i)=4*exp(+2*x(i))/(1+exp(+2*x(i)))^2;
        end
    end
end
