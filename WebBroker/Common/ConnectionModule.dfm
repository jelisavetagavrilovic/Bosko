object FireDacMySqlConnection: TFireDacMySqlConnection
  Height = 198
  Width = 282
  PixelsPerInch = 96
  object AureliusConn: TAureliusConnection
    AdapterName = 'FireDac'
    AdaptedConnection = Connection
    SQLDialect = 'MySql'
    Left = 64
    Top = 64
  end
  object Connection: TFDConnection
    Params.Strings = (
      'Database=TestVenecuela'
      'User_Name=root'
      'Password=Tajeta2001!'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 64
    Top = 8
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Apache24\modules\libmysql.dll'
    Left = 160
    Top = 24
  end
end
