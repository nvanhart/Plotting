function atr = AverageTrueRange(high, low, close, period)
%average true range
%high,low,close = price series vector, period = lookback 
%
% True Range = max((high-low),abs(high-prevClose),abs(low-prevClose))
% ATR = EMA(True Range,period)
% Higher ATR = trending market
% Lower ATR = non-trending, stagnant market; consolidation region
% Useful for creating trailing stop - https://www.youtube.com/watch?v=-WEfltVcN0Q

%% Section 1: Calculate Range

prevClose = backshift(1,close); %calculates previous period's close
current = high - low; %calculates range over current period
prevHigh = abs(high - prevClose); %calculates range from prev period's close to today's high
prevLow = abs(low - prevClose); 

trueRange = zeros(size(close)); %empty vector to fill

for j = 1:length(trueRange)
    c = current(j); %extracts current value to create array
    h = prevHigh(j);
    l = prevLow(j);
    v = [c,h,l]; %create array for max function
    trueRange(j) = max(v); %finds maximum range
end

atr = EMA(trueRange,period); %sums true range over period and calculates average

%% Section 2: Output Results
time = 1:1:(length(close)); %creates evenly spaced vector length of time series for plotting purposes
title(sprintf('ATR vs Close'),'Fontsize',12) %adds title of ticker

yyaxis left
plot(time,close,'LineWidth',2)
ylabel('Close')

yyaxis right
plot(time,atr)
ylabel('rate of change')

end

