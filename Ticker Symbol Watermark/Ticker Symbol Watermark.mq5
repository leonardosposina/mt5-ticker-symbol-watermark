//+------------------------------------------------------------------+
//|                                      Ticker Symbol Watermark.mq5 |
//|                                Copyright 2019, Leonardo Sposina. |
//|           https://www.mql5.com/en/users/leonardo_splinter/seller |
//+------------------------------------------------------------------+

#include "TickerSymbolWatermark.mqh"

input color fontColor = clrLightGray; // Font Color
input int fontSize = 65;              // Font Size

TickerSymbolWatermark* watermark;

int OnInit() {
  watermark = new TickerSymbolWatermark(fontColor, fontSize);

  return(INIT_SUCCEEDED);
}

int OnCalculate(
  const int rates_total,
  const int prev_calculated,
  const int begin,
  const double &price[]
) {

  return(rates_total);
}

void OnChartEvent(
  const int id,
  const long &lparam,
  const double &dparam,
  const string &sparam
) {

  if (id == CHARTEVENT_CHART_CHANGE)
    watermark.updateLabelsOnChart();
}

void OnDeinit(const int reason) {
  delete watermark;
  ChartRedraw();
}
