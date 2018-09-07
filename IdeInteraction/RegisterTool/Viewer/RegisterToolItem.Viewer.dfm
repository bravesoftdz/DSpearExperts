object fraRegisterToolItem: TfraRegisterToolItem
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object gbGeneral: TGroupBox
    Left = 0
    Top = 0
    Width = 451
    Height = 53
    Align = alTop
    Caption = 'gbGeneral'
    TabOrder = 0
    object Label1: TLabel
      Left = 152
      Top = 24
      Width = 45
      Height = 13
      Caption = 'Shortcut:'
    end
    object chbEnabled: TCheckBox
      Left = 24
      Top = 25
      Width = 97
      Height = 17
      Caption = 'Enabled'
      TabOrder = 0
    end
    object cbCtrl: TCheckBox
      Left = 203
      Top = 23
      Width = 46
      Height = 17
      Caption = 'Ctrl +'
      TabOrder = 1
    end
    object cbAlt: TCheckBox
      Left = 255
      Top = 23
      Width = 50
      Height = 17
      Caption = 'Alt +'
      TabOrder = 2
    end
    object cbShift: TCheckBox
      Left = 303
      Top = 23
      Width = 49
      Height = 17
      Caption = 'Shift +'
      TabOrder = 3
    end
    object meChar: TMaskEdit
      Left = 358
      Top = 23
      Width = 19
      Height = 21
      EditMask = '>L;1;A'
      MaxLength = 1
      TabOrder = 4
      Text = ' '
      OnClick = meCharClick
    end
  end
end
