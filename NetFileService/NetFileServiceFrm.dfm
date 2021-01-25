object NetFileServiceForm: TNetFileServiceForm
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  BorderWidth = 20
  Caption = 'NetFile Service.'
  ClientHeight = 264
  ClientWidth = 493
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ListenStateLabel: TLabel
    Left = 195
    Top = 3
    Width = 8
    Height = 13
    Caption = '..'
  end
  object BindEdit: TLabeledEdit
    Left = 84
    Top = 0
    Width = 105
    Height = 21
    EditLabel.Width = 81
    EditLabel.Height = 13
    EditLabel.Caption = 'Bind IP(IP4/IP6):'
    LabelPosition = lpLeft
    TabOrder = 0
    Text = '0.0.0.0'
  end
  object PortEdit: TLabeledEdit
    Left = 84
    Top = 27
    Width = 41
    Height = 21
    EditLabel.Width = 55
    EditLabel.Height = 13
    EditLabel.Caption = 'Listen port:'
    LabelPosition = lpLeft
    TabOrder = 1
    Text = '7456'
  end
  object ShareDirEdit: TLabeledEdit
    Left = 84
    Top = 86
    Width = 377
    Height = 21
    EditLabel.Width = 79
    EditLabel.Height = 13
    EditLabel.Caption = 'Share Directory:'
    LabelPosition = lpLeft
    TabOrder = 3
    OnExit = ShareDirEditExit
  end
  object BrowseButton: TButton
    Left = 467
    Top = 84
    Width = 26
    Height = 25
    Caption = '..'
    TabOrder = 4
    OnClick = BrowseButtonClick
  end
  object StartServiceButton: TButton
    Left = 84
    Top = 129
    Width = 105
    Height = 32
    Caption = 'Start Service.'
    TabOrder = 5
    OnClick = StartServiceButtonClick
  end
  object PasswdEdit: TLabeledEdit
    Left = 84
    Top = 54
    Width = 81
    Height = 21
    EditLabel.Width = 50
    EditLabel.Height = 13
    EditLabel.Caption = 'Password:'
    LabelPosition = lpLeft
    PasswordChar = '*'
    TabOrder = 2
    Text = 'admin'
  end
  object StopServiceButton: TButton
    Left = 195
    Top = 129
    Width = 50
    Height = 32
    Caption = 'Stop.'
    TabOrder = 6
    OnClick = StopServiceButtonClick
  end
  object Memo: TMemo
    Left = 8
    Top = 175
    Width = 477
    Height = 89
    ScrollBars = ssVertical
    TabOrder = 7
    WordWrap = False
  end
  object ShowPasswdCheckBox: TCheckBox
    Left = 171
    Top = 56
    Width = 54
    Height = 17
    Caption = 'Show'
    TabOrder = 8
    OnClick = ShowPasswdCheckBoxClick
  end
  object progressTimer: TTimer
    Interval = 5
    OnTimer = progressTimerTimer
    Left = 272
    Top = 32
  end
  object StateTimer: TTimer
    Interval = 500
    OnTimer = StateTimerTimer
    Left = 352
    Top = 32
  end
end
