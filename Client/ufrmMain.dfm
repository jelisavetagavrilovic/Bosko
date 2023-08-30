object frmMain: TfrmMain
  Width = 377
  Height = 398
  PixelsPerInch = 96
  object lblCountry: TWebLabel
    Left = 8
    Top = 105
    Width = 46
    Height = 15
    Caption = 'Country:'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object wlServerAddress: TWebLabel
    Left = 8
    Top = 16
    Width = 80
    Height = 15
    Caption = 'Server Address:'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object lblName: TWebLabel
    Left = 8
    Top = 144
    Width = 35
    Height = 15
    Caption = 'Name:'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object lblLastName: TWebLabel
    Left = 8
    Top = 184
    Width = 56
    Height = 15
    Caption = 'Last Name'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object lblEmail: TWebLabel
    Left = 8
    Top = 224
    Width = 29
    Height = 15
    Caption = 'Email'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object lblZIPCode: TWebLabel
    Left = 8
    Top = 272
    Width = 48
    Height = 15
    Caption = 'ZIP Code'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object wcbCountries: TWebComboBox
    Left = 70
    Top = 102
    Width = 153
    Height = 23
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnExit = wcbCountriesExit
    ItemIndex = -1
  end
  object weServerAddress: TWebEdit
    Left = 94
    Top = 13
    Width = 256
    Height = 22
    ChildOrder = 3
    HeightPercent = 100.000000000000000000
    Text = 'http://192.168.0.29:2001/tms/xdata'
    WidthPercent = 100.000000000000000000
  end
  object btnConnect: TWebButton
    Left = 8
    Top = 41
    Width = 96
    Height = 25
    Caption = 'Connect'
    ChildOrder = 4
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = btnConnectClick
  end
  object btnAddCountry: TWebButton
    Left = 254
    Top = 101
    Width = 96
    Height = 25
    Caption = 'Add Country'
    ChildOrder = 5
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = btnAddCountryClick
  end
  object edtName: TWebEdit
    Left = 70
    Top = 141
    Width = 280
    Height = 22
    ChildOrder = 7
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object edtLastName: TWebEdit
    Left = 70
    Top = 181
    Width = 280
    Height = 22
    ChildOrder = 9
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object edtEmail: TWebEdit
    Left = 70
    Top = 221
    Width = 280
    Height = 22
    ChildOrder = 11
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object wcbZipCode: TWebComboBox
    Left = 70
    Top = 269
    Width = 153
    Height = 23
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    ItemIndex = -1
  end
  object btnAddZipCode: TWebButton
    Left = 254
    Top = 268
    Width = 96
    Height = 25
    Caption = 'Add Zip Code'
    ChildOrder = 14
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = btnAddZipCodeClick
  end
  object btnAddNewContact: TWebButton
    Left = 8
    Top = 320
    Width = 121
    Height = 25
    Caption = 'Add New Contact'
    ChildOrder = 15
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
end
