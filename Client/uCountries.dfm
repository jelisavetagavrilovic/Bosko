object frmCountries: TfrmCountries
  Width = 431
  Height = 143
  PixelsPerInch = 96
  object wp: TWebPanel
    Left = 0
    Top = 0
    Width = 431
    Height = 143
    Align = alClient
    DesignSize = (
      431
      143)
    object WebLabel1: TWebLabel
      Left = 24
      Top = 32
      Width = 112
      Height = 15
      Caption = 'Country Short Name:'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object WebLabel2: TWebLabel
      Left = 24
      Top = 72
      Width = 81
      Height = 15
      Caption = 'Country Name:'
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object edCountryShortName: TWebEdit
      Left = 152
      Top = 24
      Width = 241
      Height = 22
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object edtCountryName: TWebEdit
      Left = 152
      Top = 64
      Width = 241
      Height = 22
      ChildOrder = 1
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
    end
    object btnSave: TWebButton
      Left = 210
      Top = 109
      Width = 96
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Save'
      ChildOrder = 4
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = btnSaveClick
    end
    object btnCancel: TWebButton
      Left = 322
      Top = 109
      Width = 96
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancel'
      ChildOrder = 5
      HeightPercent = 100.000000000000000000
      WidthPercent = 100.000000000000000000
      OnClick = btnCancelClick
    end
  end
end
