object FormFindUnit: TFormFindUnit
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Find Unit'
  ClientHeight = 412
  ClientWidth = 547
  Color = clBtnFace
  Constraints.MinHeight = 451
  Constraints.MinWidth = 563
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object grpResult: TGroupBox
    Left = 0
    Top = 51
    Width = 547
    Height = 361
    Align = alClient
    Caption = 'Result'
    TabOrder = 0
    object lstResult: TListBox
      Left = 2
      Top = 15
      Width = 543
      Height = 344
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object grpSearch: TGroupBox
    Left = 0
    Top = 0
    Width = 547
    Height = 51
    Align = alTop
    Caption = 'Search'
    TabOrder = 1
    object edtSearch: TEdit
      Left = 11
      Top = 19
      Width = 430
      Height = 21
      TabOrder = 0
    end
    object btnAdd: TButton
      Left = 453
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Add'
      TabOrder = 1
    end
  end
end
