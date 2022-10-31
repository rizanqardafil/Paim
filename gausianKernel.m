function kernel = gausianKernel(k)

kernel = zeros(k,k);
temp = (k-1)/2;
temp1 = (-1*temp);
x = temp1:1:temp;
y = temp1:1:temp;
sigma = 1.5;



n = length(x);

for i=1:n
    for j=1:n
        kernel(i,j) = (1/(2*pi*(sigma^2)))*exp(-((x(i)^2+y(j)^2)/(2*sigma^2)));
    end;
end;
