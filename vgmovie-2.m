
dx = 2*pi/512;
dy =dx;
%t =1:1:19;
numfiles = 300;
%addpath('/home/rahul/2021/Caustics');
for k =1:1:numfiles

mydata = cell(1, numfiles);
trajectory = cell(1,numfiles);
x = [0 2*pi];
y = [0 2*pi];



myfilename = sprintf('trajectory%d.dat',k-1);
X=readtable(myfilename);
A= zeros(314);
D= zeros(314);
%314 is via calulating the numberdensity of 10^5 particles
for i=1:1:100000
        m = floor(X.Var1(i)*314/(2*pi)); n = floor(X.Var2(i)*314/(2*pi));
        A(m+1,n+1) = A(m+1,n+1) +1;
        D(m+1,n+1,A(m+1,n+1)) = i;
end
B = A~=0;
C= A;
C(C>=5)= 4;
[row,col] = find(C>=4);
[r, g, h] = size(D);
for i = 1:1:length(row)
    for j = 1:1:h
     if (D(row(i),col(i),j) == 0)
         break
     end
    p(i) = D(row(i),col(i),j);
    end
end


myfilename = sprintf('%d.dat', k-1);
mydata{1} = importdata(myfilename);
myfilename = sprintf('trajectory%d.dat',k-1);
trajectory{1} = importdata(myfilename);
j =1;
for i = 1:512:512*512
A2(:,j) = mydata{1}(i:i+511,5);
j = j+1;
end
im = imagesc(x,y,A2); hold on
%colormap(summer(500))
%h = colorbar;

g(1)= 0; g(2)= 2/6 - 1/6; g(3)= 3/6 - 1/6; g(4) = 4/6 - 1/6; g(5) = 5/6 - 1/6; g(6) = 6/6 - 1/6; g(7) = 1;
%mycolormap = customcolormap(g', {'#fbefcb','#f5db37','#37cae5','#0f86b6','#37cae5','#f5db37','#fbefcb'});
mycolormap = customcolormap(g, {'#FFFFFF','#f5db37','#37cae5','#123f77','#37cae5','#f5db37','#fbefcb'}); 
colormap(mycolormap);
h = colorbar;

set(h, 'ylim', [-3 3])
%alpha color
%alpha scaled
%colormap(bluewhitered(256))
%im.AlphaData = .5;
scatter(trajectory{1}(:,1),trajectory{1}(:,2),3,'filled', 'MarkerFaceColor','k','MarkerFaceAlpha',0.2);
%scatter(trajectory{1}(p,1),trajectory{1}(p,2),5,'filled', 'MarkerFaceColor','r','MarkerFaceAlpha',0.2);
%quiver(trajectory{k}(:,1),trajectory{k}(:,2),trajectory{k}(:,3),trajectory{k}(:,4),'Color','r');hold on;
%quiver(trajectory{1}(p,1),trajectory{1}(p,2),trajectory{1}(p,3),trajectory{1}(p,4),'Color','k');hold on;
axis([0 2*pi 0 2*pi])
%F(k) = getframe(gcf);
%pause(0.1);
brighten(.8);
myfilename = sprintf('w%d.png', k-1);
print(gcf,myfilename,'-dpng','-r300');
hold off
clearvars A B D X p mydata trajectory
end
clearvars