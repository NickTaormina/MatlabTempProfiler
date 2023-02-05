clc;
clear;
%matlab

filename = 'coherent_tmp.profile'; % specify the filename here
fid = fopen(filename);
if fid == -1
    error('Cannot open file %s', filename);
end

% Get the total number of lines in the file
total_lines = 0;
while (fgets(fid) ~= -1)
    total_lines = total_lines + 1;
end

% Go back to the beginning of the file
frewind(fid);

% Read the last 100 lines
lines_to_read = 100;
start_line = max(1, total_lines - lines_to_read + 1);
for i = 1:start_line-1
    fgets(fid);
end
last_100_lines = cell(lines_to_read, 1);
for i = 1:lines_to_read
    last_100_lines{i} = fgets(fid);
end

% Close the file
fclose(fid);

% Print the last 100 lines
disp(last_100_lines);

% Create a cell array to store the values
data = cell(lines_to_read, 6);

%split each line of last_100_lines into a cell array of 4 columns
for i = 1:lines_to_read
    
    data(i,:) = strsplit(last_100_lines{i});

end
data = cell2mat(cellfun(@str2num, data, 'UniformOutput', false));
x = data(:,1);
y = data(:,4);
screen_size = get(groot, 'ScreenSize');


windowSizeX = screen_size(3)*.5
windowSizeY = screen_size(4)*.5
screenCenterX = screen_size(3)*.50 - windowSizeX/2
screenCenterY = screen_size(4)*.50 - windowSizeY/2
figure('Position', [screenCenterX screenCenterY windowSizeX windowSizeY]);
scatter(x, y, 'MarkerEdgeColor', 'red', 'Marker', 'o', 'SizeData', 5);
hold on


%creates a scatter of lines 25-40 of data and shows trendline with equation and r^2 value
scatter(data(25:40,1), data(25:40,4), 'MarkerEdgeColor', 'red', 'Marker', 'o', 'SizeData', 5);
hold on
p = polyfit(data(25:40,1), data(25:40,4), 1);
yfit = polyval(p, data(25:40,1));
plot(data(25:40,1), yfit, 'b-');
xlabel('Point');
ylabel('Temp (K)');
title('Temp Profile');
%prints the equation of the trendline
text(0.05, 0.1, sprintf('y = %0.5f x + %0.5f', p(1), p(2)), 'Units', 'normalized');
%calculates r^2 value
rsquare = @(y, yfit) 1 - sum((y - yfit).^2)/sum((y - mean(y)).^2);
%prints the r^2 value
text(0.05, 0.2, sprintf('R^2 = %0.5f', rsquare(data(25:40,4), yfit)), 'Units', 'normalized');

%creates a scatter of lines 65-80 of data and shows trendline with equation and r^2 value
scatter(data(65:80,1), data(65:80,4), 'MarkerEdgeColor', 'red', 'Marker', 'o', 'SizeData', 5);
hold on
p = polyfit(data(65:80,1), data(65:80,4), 1);
yfit = polyval(p, data(65:80,1));
plot(data(65:80,1), yfit, 'b-');
%prints the equation of the trendline
text(0.6, 0.8, sprintf('y = %0.5f x + %0.5f', p(1), p(2)), 'Units', 'normalized');
%calculates r^2 value
rsquare2 = @(y, yfit) 1 - sum((y - yfit).^2)/sum((y - mean(y)).^2);
%prints the r^2 value
text(0.7, 0.7, sprintf('R^2 = %0.5f', rsquare2(data(65:80,4), yfit)), 'Units', 'normalized');








