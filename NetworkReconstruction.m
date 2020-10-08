function [F]=NetworkReconstruction(W,xx,par)

%  Nicolo Pollini nicolo@alumni.technion.ac.il, 
%  Technion - Israel Institute of Technology, Haifa July 2016

Ntest=par.Ntest;
input=par.input;
output=par.output;
neurons1=par.neurons1;
neurons2=par.neurons2;

W1=reshape(W(1:input*neurons1),[input,neurons1]);
count=input*neurons1;

W2=reshape(W(count+1:count+neurons1*neurons2),[neurons1,neurons2]);
count=count + neurons1*neurons2;

W3=reshape(W(count+1:count+neurons2*output),[neurons2,output]);
count=count + neurons2*output;

b1=W(count+1:count+neurons1);
count=count +neurons1;

b2=W(count+1:count+neurons2);
count=count +neurons2;

b3=W(count+1:count+output);

F=zeros(Ntest,1);

for i=1:Ntest
    x=xx(:,i);
    f=W3'*phi2(W2'*phi1(W1'*x+b1)+b2)+b3;
    F(i)=f;
end

