function gp_sample(n)
if nargin < 1
    n = 10;
end


x  =-10:0.1:10;
xl =[-10,10];
yl =[-5,5];
cla
plot(x,gp(x),'LineWidth',2);
set(gca,'XLim', xl,'YLim',yl);
set(gcf,'MenuBar','none','Toolbar','none');
axis off
hold on

for i = 1:n-1
    plot(x,gp(x),'LineWidth',2);
end

    function fx = gp(x)
        L = chol(mycov(x,1,2)+eye(length(x)) * 10 * eps )';
        fx = L * randn(length(x),1);
        
        
        
        function c = mycov(x,theta, p)
            len = length(x);
            if nargin < 3
                p = 2 * ones(len,1);
                if nargin <2
                    theta = ones(len,1);
                end
            end
            
            if length(theta)==1
                theta = theta * ones(len,1);
            end
            if length(p)==1
                p = p * ones(len,1);
            end
                
            c = zeros(len,len);
            for ii=1:len
                for j = 1:ii
                    c(ii,j) = exp(-theta(ii) * (abs(x(ii)-x(j)))^p(ii));
                    c(j,ii) = c(ii,j);
                end
            end
        end
    end





end