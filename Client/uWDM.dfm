object WDM: TWDM
  Height = 247
  Width = 342
  PixelsPerInch = 96
  object XDataWebConnection: TXDataWebConnection
    URL = 'http://localhost/bg'
    Left = 47
    Top = 20
  end
  object XDataWebClient: TXDataWebClient
    Connection = XDataWebConnection
    Left = 47
    Top = 80
  end
end
