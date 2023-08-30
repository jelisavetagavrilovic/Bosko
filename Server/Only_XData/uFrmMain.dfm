object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'TMS XData Server'
  ClientHeight = 556
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  DesignSize = (
    780
    556)
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 5
    Width = 43
    Height = 13
    Caption = 'DB Name'
  end
  object Label2: TLabel
    Left = 304
    Top = 5
    Width = 51
    Height = 13
    Caption = 'User name'
  end
  object Label3: TLabel
    Left = 392
    Top = 5
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object mmInfo: TMemo
    Left = 8
    Top = 80
    Width = 764
    Height = 468
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    TabOrder = 0
  end
  object btStart: TButton
    Left = 8
    Top = 49
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = btStartClick
  end
  object btStop: TButton
    Left = 89
    Top = 49
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = btStopClick
  end
  object edtDBName: TEdit
    Left = 25
    Top = 24
    Width = 273
    Height = 21
    TabOrder = 3
  end
  object edtUserName: TEdit
    Left = 304
    Top = 24
    Width = 73
    Height = 21
    TabOrder = 4
  end
  object edtPassword: TEdit
    Left = 392
    Top = 24
    Width = 273
    Height = 21
    TabOrder = 5
  end
end
