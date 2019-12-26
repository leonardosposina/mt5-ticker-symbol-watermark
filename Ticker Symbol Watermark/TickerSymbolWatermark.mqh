//+------------------------------------------------------------------+
//|                                        TickerSymbolWatermark.mqh |
//|                                Copyright 2019, Leonardo Sposina. |
//|           https://www.mql5.com/en/users/leonardo_splinter/seller |
//+------------------------------------------------------------------+

#property copyright "Copyright 2019, Leonardo Sposina."
#property link      "https://www.mql5.com/en/users/leonardo_splinter/seller"
#property version   "1.0"

class TickerSymbolWatermark {

  private:
  
    string objNameLabel;
    string objDescLabel;
    color fontColor;
    long currentWidth;
    long currentHeight;
    long fontSize;
    long resizedFont;
  
    void createObjectLabel(string objName, string strLabel);
    void resizeLabel(string objName, float ratio);
    void moveLabel(string objName, long shiftDown);
    string periodToString(ENUM_TIMEFRAMES period);
  
  public:
  
    TickerSymbolWatermark(color _fontColor, int _fontSize);
    ~TickerSymbolWatermark(void);
    void updateLabelsOnChart(void);

};

TickerSymbolWatermark::TickerSymbolWatermark(color _fontColor, int _fontSize) {
  this.objNameLabel = "Ticker Symbol Name";
  this.objDescLabel = "Ticker Symbol Description";
  this.currentWidth = 0;
  this.currentHeight = 0;
  this.fontColor = _fontColor;
  this.fontSize = _fontSize;

  string strSymbolTitle = StringFormat("%s:%s", _Symbol, periodToString(_Period));
  string strSymbolSubtitle = SymbolInfoString(_Symbol, SYMBOL_DESCRIPTION);

  this.createObjectLabel(this.objNameLabel, strSymbolTitle);
  this.createObjectLabel(this.objDescLabel, strSymbolSubtitle);
};

void TickerSymbolWatermark::updateLabelsOnChart(void) {
  long chartWidth = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS, 0);
  long chartHeight = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS, 0);

  if (this.currentWidth != chartWidth || this.currentHeight != chartHeight) {
    this.currentWidth = chartWidth;
    this.currentHeight = chartHeight;
    this.resizedFont = (this.fontSize * this.currentWidth) / 850;

    this.resizeLabel(this.objNameLabel, 1.0);
    this.resizeLabel(this.objDescLabel, 0.5);
    this.moveLabel(this.objNameLabel, 0);
    this.moveLabel(this.objDescLabel, this.resizedFont + 5);
    ChartRedraw();
  }
};

void TickerSymbolWatermark::~TickerSymbolWatermark(void) {
  ObjectDelete(0, objNameLabel);
  ObjectDelete(0, objDescLabel);
};

void TickerSymbolWatermark::createObjectLabel(string objName, string strLabel) {
  ObjectCreate(0, objName, OBJ_LABEL, 0, 0, 0);
  ObjectSetInteger(0, objName, OBJPROP_COLOR, this.fontColor);
  ObjectSetInteger(0, objName, OBJPROP_ANCHOR, ANCHOR_CENTER);
  ObjectSetInteger(0, objName, OBJPROP_BACK, true);
  ObjectSetString(0, objName, OBJPROP_TEXT, strLabel);
};

void TickerSymbolWatermark::resizeLabel(string objName, float ratio) {
  ObjectSetInteger(0, objName, OBJPROP_FONTSIZE, this.resizedFont * ratio);
};

void TickerSymbolWatermark::moveLabel(string objName, long shiftDown) {
  ObjectSetInteger(0, objName, OBJPROP_XDISTANCE, this.currentWidth / 2);
  ObjectSetInteger(0, objName, OBJPROP_YDISTANCE, this.currentHeight / 2 + shiftDown);
};

string TickerSymbolWatermark::periodToString(ENUM_TIMEFRAMES period) {
  string result = EnumToString(period);
  return StringSubstr(result, 7);
};
