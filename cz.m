



gp = GaussionProcess;


%% one-dimension
x = [-5:0.1:5];
gp.update(x);
while(1)
    pause(0.1);
    
    cla
    plot(x,gp.sample(x),'LineWidth',2);
    set(gca,'XLim', [-5,5],'YLim',[-5,5]);
    set(gcf,'MenuBar','none','Toolbar','none');
    axis off
    hold on
end


%% two-dimesnions

[x,y] = meshgrid(-5:0.1:5, -5:0.1:5);
x = reshape(x,numel(x),1);
y = reshape(y,numel(y),1);
X = [x,y];
NN = sqrt(numel(x));

gp = GaussionProcess;
gp.update(X);

while(1)
    cla
    Y = gp.sample();
    
    surf(reshape(X(:,1),NN,NN), reshape(X(:,2),NN,NN),...
        reshape(Y, NN,NN));
    set(gca,'XLim', [-5,5],'YLim',[-5,5], 'XLim',[-5,5]);
    set(gcf,'MenuBar','none','Toolbar','none');
    axis off
    hold on    
    
    pause(0.1);    

end


