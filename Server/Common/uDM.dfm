object DM: TDM
  Height = 228
  Width = 589
  PixelsPerInch = 96
  object FDConn: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'CharacterSet=utf8'
      'User_Name=root'
      'Password=Tajeta2001!')
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 224
    Top = 8
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Apache24\modules\libmysql.dll'
    Left = 224
    Top = 72
  end
end
