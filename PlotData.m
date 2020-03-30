function output = PlotData(symbol, lookback, frequency, smaPeriod)
% IN PROGRESS, MAY BE WASTE OF TIME.
% Function to plot equities and currencies. Optional indicator
% functionality, renko charts, axis settings. Support for range of
% granularities.
%
% Example: PlotData('EUR_USD',5,'H4','log') - 4 hour log(price) over 5 days
%          PlotData('CRON',365,D) - daily price series over past year
%% Section 1: Obtain base time series
if char(symbol(4)) == '_' %checks for currency pair
    oapi; %initializes Oanda
    history = GetPriceHistory(symbol,lookback,frequency);
    close = history.closeAsk;
else
    fs = '%sd';
    lookback = sprintf(fs,lookback); %adds 'd'
    history  = RealTimeData(symbol,frequency,lookback,'false');
    close = history.close
end

%% Section 2: Add options



% Indicators
DailyRet =100*(adjClose-backshift(1,adjClose))./backshift(1,adjClose); %needs to be fixed, gives returns for next day rather than from previous
OHLC = [open+high+low+close]/4;
dp = diff(SMA(OHLC,smaPeriod)); %rate of change of price series
s = 0;
dp = vertcat(s,dp);

% Plot results
t = (table(dates,adjClose));
yyaxis left
plot(dates,adjClose,'LineWidth',3)
ylabel('price ($)')
yyaxis right
plot(dates,dp)
ylabel('rate of change (dp/dt)')

end