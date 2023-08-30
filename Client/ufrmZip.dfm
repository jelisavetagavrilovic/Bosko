object frmZipCode: TfrmZipCode
  Width = 374
  Height = 191
  OnCloseQuery = WebFormCloseQuery
  PixelsPerInch = 96
  object WebLabel1: TWebLabel
    Left = 16
    Top = 24
    Width = 43
    Height = 15
    Caption = 'Country'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object WebLabel2: TWebLabel
    Left = 16
    Top = 64
    Width = 51
    Height = 15
    Caption = 'Zip Code:'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object WebLabel3: TWebLabel
    Left = 16
    Top = 104
    Width = 21
    Height = 15
    Caption = 'City'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object edtZipCode: TWebEdit
    Left = 88
    Top = 61
    Width = 121
    Height = 22
    ChildOrder = 2
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object edtCity: TWebEdit
    Left = 88
    Top = 96
    Width = 233
    Height = 22
    ChildOrder = 4
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object btnSave: TWebButton
    Left = 152
    Top = 158
    Width = 96
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Save'
    ChildOrder = 5
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = btnSaveClick
  end
  object btnClose: TWebButton
    Left = 254
    Top = 158
    Width = 96
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    ChildOrder = 6
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = btnCloseClick
  end
end
