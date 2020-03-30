function ROC = RateOfChange(timeSeries)
% Function to plot Rate of Change vs original time series. Can be used with
% price series (best w SMA smoothing), ATR, or even RoC to plot velocity vs
% acceleration
% Inputs: price series vector

%% section 1: differentiate
dp = diff(timeSeries); %rate of change of price - velocity
s = 0;
dp = vertcat(s,dp);

%% Section 2: plot results
time = 1:1:(length(timeSeries)); %creates evenly spaced vector length of time series for plotting purposes

yyaxis left
plot(time,timeSeries,'LineWidth',2)

name = inputname(1);
if isempty(name)
  name = 'unknown';
end
title(sprintf('Graph of %s', name),'Fontsize',12) %adds title of ticker

ylabel('price')
yyaxis right
plot(time,dp)
ylabel('rate of change')

end