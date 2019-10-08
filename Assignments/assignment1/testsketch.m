image = imread('beach.bmp');
rows = size(image, 1);
cols = size(image, 2);
pixels = zeros(rows*cols, 3);

for i=1:rows
    for j=1:cols
    pixels((j-1)*rows+i, 1:3) = image(i,j,:);
    end
end

%tic;
[class1, centroid1] = mykmeans(pixels, 100000);
disp(size(centroid1))
