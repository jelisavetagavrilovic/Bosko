object ServCont: TServCont
  Height = 307
  Width = 534
  PixelsPerInch = 96
  object SparkleHttpSysDispatcher: TSparkleHttpSysDispatcher
    Left = 72
    Top = 16
  end
  object XDataServer: TXDataServer
    BaseUrl = 'http://+:2001/tms/xdata'
    Dispatcher = SparkleHttpSysDispatcher
    DefaultEntitySetPermissions = [List, Get, Insert, Modify, Delete]
    EntitySetPermissions = <>
    Left = 216
    Top = 16
    object XDataServerCORS: TSparkleCorsMiddleware
    end
  end
end
