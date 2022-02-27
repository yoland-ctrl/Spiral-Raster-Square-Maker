clear; clc;
%% Square Maker (Raster or Spiral)
printType = input('Raster or Spiral? ','s');
length = input('Enter shape side length (um): ','s');
dsp = input('Enter drop spacing (um): ','s');
length = str2num(length);
dsp = str2num(dsp);
maxDrops = round(length/dsp);
maxDrops2 = round(length/dsp);
x1 = zeros(maxDrops, 1);
for i=1:maxDrops
    x1(i) = dsp;
    x_drop = x1;
end
x_zeroes = zeros(maxDrops, 1);
A = [x_zeroes, x_drop];
B = [x_drop, x_zeroes];
mmSize = length/1000; 
s = strcat(printType,'_', num2str(mmSize),'mm_', num2str(dsp),'dsp.txt');
fileID = fopen(s,'w');
fprintf(fileID,'%5d,%5d \n', 0,0);
%%
if printType == 'Spiral'
    for i=1:maxDrops
        fprintf(fileID,'%5d,', A(i, 1));
        fprintf(fileID,'%5d \n', A(i, 2));
    end
    for i=1:maxDrops
        fprintf(fileID,'%5d,', B(i, 1));
        fprintf(fileID,'%5d \n', B(i, 2));
    end
    for i=1:maxDrops
        fprintf(fileID,'%5d,', A(i, 1));
        fprintf(fileID,'%5d \n', -A(i, 2));
    end
    for i=1:maxDrops-1
        fprintf(fileID,'%5d,', -B(i, 1));
        fprintf(fileID,'%5d \n', B(i, 2));
    end
    maxDrops = maxDrops-1;
 while maxDrops > 0
    for i=1:maxDrops
        fprintf(fileID,'%5d,', A(i, 1));
        fprintf(fileID,'%5d \n', A(i, 2));
    end
    for i=1:maxDrops-1
        fprintf(fileID,'%5d,', B(i, 1));
        fprintf(fileID,'%5d \n', B(i, 2));
    end
    for i=1:maxDrops-1
        fprintf(fileID,'%5d,', A(i, 1));
        fprintf(fileID,'%5d \n', -A(i, 2));
    end
    for i=1:maxDrops-2
        fprintf(fileID,'%5d,', -B(i, 1));
        fprintf(fileID,'%5d \n', B(i, 2));
    end
    maxDrops = maxDrops-2;
 end
end
%%
if printType == 'Raster'
    while maxDrops2 > 0
    for i=1:maxDrops
        fprintf(fileID,'%5d,', A(i, 1));
        fprintf(fileID,'%5d \n', A(i, 2));
    end
    fprintf(fileID,'%5d,%5d \n', B(1, :));
    for i=1:maxDrops
        fprintf(fileID,'%5d,', A(i, 1));
        fprintf(fileID,'%5d \n', -A(i, 2));
    end
    fprintf(fileID,'%5d,%5d \n', B(1, :));
    maxDrops2 = maxDrops2-2;
    end
    for i=1:maxDrops
        fprintf(fileID,'%5d,', A(i, 1));
        fprintf(fileID,'%5d \n', A(i, 2));
    end
end