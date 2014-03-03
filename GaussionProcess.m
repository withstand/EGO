function gp = GaussionProcess(mean_f, corr_f)


if nargin<2
    corr_f = @default_corr_f;
end
if nargin<1
    mean_f = @default_mean_f;
end

gp.corr_f = corr_f;
gp.mean_f = mean_f;
gp.sample = @sample_f;
gp.update = @update;

    function [nn,d] = get_dim(X)
        [nn,d] = size(X);
        if nn==1
            % make sure is a vector of x1, x2,..., xn
            nn = d;
            d = 1;
            X = X';
        end       
        
    end

    function mu = default_mean_f(X)
        [nn,~] = get_dim(X);
        mu = zeros(nn,1);
    end
    function Kxx = default_corr_f(X,theta, p)
        [nn,~] = get_dim(X);

        if nargin < 3
            p = 2 * ones(nn,1);
            if nargin <2
                theta = ones(nn,1);
            end
        end
        
        if length(theta)==1
            theta = theta * ones(nn,1);
        end
        if length(p)==1
            p = p * ones(nn,1);
        end
        
        Kxx = zeros(nn,nn);
        for ii=1:nn
            for j = 1:ii
                Kxx(ii,j) = exp(-theta(ii) * (norm(X(ii,:)-X(j,:)))^p(ii));
                Kxx(j,ii) = Kxx(ii,j);
            end
        end
    end

    function update(X)
        [nn,~] = get_dim(X);       
        mu = gp.mean_f(X); % nn * 1
        K = gp.corr_f(X);  % nn * nn
        multiple = 1;
        while (1)
        try
            L = chol(K + eye(nn) * 100 * eps )';   %nn * nn      
            break;
        catch
            multiple = multiple * 10;
            if multiple > 1e5
                error('check setup eps = %f', multiple * eps);
            end
        end
        end
        gp.mu = mu;
        gp.L = L;
        gp.nn = nn;
    end

    function [Y, u] = sample_f()
        u = randn(gp.nn,1);
        Y = gp.mu + gp.L * u;
    end
end