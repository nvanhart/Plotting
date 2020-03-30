function output = Plot3D(symbol, lookback, frequency)
% IN PROGRESS, MAY BE WASTE OF TIME.
% Function to plot equities and currencies in 3D, where x axis is time, z
% axis is price, and y axis is volume.
%
% Example: PlotData('EUR_USD',5,'H4','log') - 4 hour log(price) over 5 days
%          PlotData('CRON',365,D) - daily price series over past year
%% Section 1: Obtain base time series
if char(symbol(4)) == '_' %checks for currency pair
    oapi; %initializes Oanda
    history = GetPriceHistory(symbol,lookback,frequency);
    z = [datetime(history.time); datetime(history.time(1))];
    y = [history.volume; history.volume(1)];
    x = [(history.closeBid+history.closeAsk)/2; (history.closeBid(1)+history.closeAsk(1))/2];
else
    fs = '%sd';
    lookback = sprintf(fs,lookback); %adds 'd'
    history  = RealTimeData(symbol,frequency,lookback,'false');
    x = datetime(history.dates);
    y = history.vol;
    z = history.close;
end


plot3(x,y,z)
xlabel('Price')
ylabel('Volume')
zlabel('Time')
%cla
%patch([x nan],[y nan],[z nan],[z nan],'EdgeColor','interp','FaceColor','none')

