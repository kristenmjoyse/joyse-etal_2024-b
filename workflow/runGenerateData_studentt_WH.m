% Last updated by Kristen Joyse, 2020-12-03 13:38:57

% import data - daily maximum tide gauge data from The Battery, NY
data = importdata(fullfile('WH_DailyMaxTG.csv'));

date = data.textdata(2:19995, 11);
date = datetime(date, 'InputFormat', 'MM/dd/yyyy');
wl = data.data(:, 1);

figure ();
subplot(2, 1, 1); 
plot(date, wl);

xlabel('Date');
ylabel('Water Level (mm)');
title('Daily Maximum Water Levels at the Woods Hole, MA');

hold on;

% detrend data

% have NOT declustered to make sure events are separated by at least one
% day (Buchanan et al. 2016)
dtwl = wl;
subplot(2, 1, 2);
plot(date,dtwl);
xlabel('Date');
ylabel('Water Level (mm)');
title('Detrended Daily Maximum Water Levels at Woods Hole, MA');

% fit student t-distribution to data for st parameters
st = fitdist(dtwl, 'tLocationScale');

x = -1400:1:2700;
y = pdf(st, x);

figure;
plot(x, y, 'LineWidth', 1);
xlabel('Water Level');

%%

% generate sample dataset from normal distribution

% take 1 sample per day over 2000 yrs
Nperyear = 365;
t1 = 1000; % start year
t2 = 2000; % end year
t = linspace(t1, t2, (t2-t1) * Nperyear + 1);

% sample data from st over t
h = tinv(rand(size(t)), st.nu);

figure;

plot(t, h);
xlabel('Date');
ylabel('Water Level (mm)');
title('Synthetic Tide Gauge Data Sampled from Student t-distribution');

