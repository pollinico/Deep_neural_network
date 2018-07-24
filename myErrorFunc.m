function [F,GW]=myErrorFunc(W,xx,yy,par,phase)

Ntest=par.Ntest;
Ntrain=par.Ntrain;
input=par.input;
output=par.output;
neurons1=par.neurons1;
neurons2=par.neurons2;

nvars=length(W);

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

F=0;

if (strcmp(phase,'train') == 1)
    GW=zeros(nvars,1);
    for i=1:Ntrain
        x=xx(:,i);
        f=W3'*phi2(W2'*phi1(W1'*x+b1)+b2)+b3;
        
        [fphi1,gphi1]=phi1(W1'*x+b1);
        [fphi2,gphi2]=phi2(W2'*phi1(W1'*x+b1)+b2);
        y=yy(i);
        
        F=F+(f-y)^2;
        
        gW1=2*(f-y)*x*W3'*gphi2*W2'*gphi1;
        gW2=2*(f-y)*fphi1*W3'*gphi2;
        gW3=2*(f-y)*fphi2;
        
        gb1=2*(f-y)*gphi1*W2*gphi2*W3;
        gb2=2*(f-y)*gphi2*W3;
        gb3=2*(f-y);
        
        gW=[gW1(:);gW2(:);gW3(:);gb1;gb2;gb3];
        GW=GW+gW;
    end
    F=F/Ntrain;
    GW=GW/Ntrain;
end

if (strcmp(phase,'test') == 1)
    
    for i=1:Ntest
        x=xx(:,i);
        f=W3'*phi2(W2'*phi1(W1'*x+b1)+b2)+b3;
        y=yy(i);
        F=F+(f-y)^2;
    end
    F=F/Ntest;
end







