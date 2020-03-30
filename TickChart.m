function [tick] = TickChart(price,volume,varargin)
% Description: Creates an artificial tick chart from price & volume series
%
% When X ticks are reached, a new block is added. Used to show price
% movement independent of time. 
%
% DOES NOT FILTER OUT PRICE MOVEMENT... NEEDS TO CAPTURE ONLY VOL CHANGE W
% DIRECTION
%
%% Section 1: Assemble Chain
%tick = zeros(size(price)); %creates empty vector to fill

priceChange = 0.01*(price-backshift(1,price))./backshift(1,price)
priceChange(1) = []; %removes NaN
priceChange(2) = []; %removes NaN
for j = 1:length(volume) %removes any 0 volumes
    if volume(j) < 1
        volume(j) = volume(j+1); 
    end
end
volChange = 1000*abs((volume-backshift(1,volume))./backshift(1,volume)); %volume change always positive so only price influences direction
volChange(1) = []; %removes NaN
volChange(2) = []; %removes NaN
subTick = (priceChange.*volChange)*10000 %calculates number of ticks per period

chart = []; %empty vector to fill with full ticks
sum = 0; %initializes tick counter
for i = 1:length(subTick)
    sum = sum + subTick(i); %adds daily tick value
    if sum > 1 %bullish outlook
        chart = [chart price(i)]; %adds price to vector once tick reaches sum
        sum = 0; %resets sum
    elseif sum < -1 %bearish outlook
        chart = [chart price(i)]; %adds price to vector once tick reaches sum
        sum = 0; %resets sum
    end
end

tick = chart'; 
%% Section 2: Plot results
if nargin > 2
    x = (1:length(chart))';
    s10 = SMA(chart,5);
    s30 = SMA(chart,9);
    plot(x,chart,x,s30,x,s10)
end
end