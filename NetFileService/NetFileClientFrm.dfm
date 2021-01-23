object NetFileClientForm: TNetFileClientForm
  Left = 0
  Top = 0
  Caption = 'Net File Client.'
  ClientHeight = 432
  ClientWidth = 709
  Color = clBtnFace
  Constraints.MinHeight = 470
  Constraints.MinWidth = 725
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GlobalCliPanel: TPanel
    Left = 0
    Top = 0
    Width = 709
    Height = 432
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter: TSplitter
      Left = 0
      Top = 338
      Width = 709
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      AutoSnap = False
      ResizeStyle = rsUpdate
      ExplicitTop = 375
      ExplicitWidth = 716
    end
    object topPanel: TPanel
      Left = 0
      Top = 0
      Width = 709
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
      DesignSize = (
        709
        33)
      object DelayLabel: TLabel
        Left = 691
        Top = 8
        Width = 8
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '..'
        OnClick = DelayLabelClick
        ExplicitLeft = 760
      end
      object HostEdit: TLabeledEdit
        Left = 76
        Top = 5
        Width = 69
        Height = 21
        EditLabel.Width = 66
        EditLabel.Height = 13
        EditLabel.Caption = 'Host(ip:port):'
        LabelPosition = lpLeft
        TabOrder = 0
        Text = '127.0.0.1'
      end
      object PasswdEdit: TLabeledEdit
        Left = 204
        Top = 5
        Width = 53
        Height = 21
        EditLabel.Width = 50
        EditLabel.Height = 13
        EditLabel.Caption = 'Password:'
        LabelPosition = lpLeft
        PasswordChar = '*'
        TabOrder = 1
        Text = 'admin'
      end
      object GoButton: TButton
        Left = 263
        Top = 3
        Width = 42
        Height = 25
        Caption = 'GO'
        TabOrder = 2
        OnClick = GoButtonClick
      end
      object RefreshButton: TButton
        Left = 375
        Top = 3
        Width = 47
        Height = 25
        Caption = 'refresh'
        TabOrder = 4
        OnClick = RefreshButtonClick
      end
      object FilterEdit: TLabeledEdit
        Left = 339
        Top = 6
        Width = 33
        Height = 21
        EditLabel.Width = 26
        EditLabel.Height = 13
        EditLabel.Caption = 'filter:'
        LabelPosition = lpLeft
        TabOrder = 3
        Text = '*'
      end
      object DownloadButton: TButton
        Left = 471
        Top = 3
        Width = 57
        Height = 25
        Caption = 'Download'
        TabOrder = 6
        OnClick = DownloadButtonClick
      end
      object UploadButton: TButton
        Left = 425
        Top = 3
        Width = 46
        Height = 25
        Caption = 'Upload'
        TabOrder = 5
        OnClick = UploadButtonClick
      end
      object DeleteButton: TButton
        Left = 533
        Top = 3
        Width = 42
        Height = 25
        Caption = 'Delete'
        TabOrder = 7
        OnClick = DeleteButtonClick
      end
    end
    object ListView: TListView
      Left = 0
      Top = 33
      Width = 709
      Height = 305
      Align = alClient
      Columns = <
        item
          AutoSize = True
          Caption = 'File'
        end
        item
          Caption = 'Size'
          Width = 90
        end
        item
          Caption = 'Time'
          Width = 120
        end
        item
          Alignment = taCenter
          Caption = 'ext'
          Width = 60
        end>
      HideSelection = False
      HotTrack = True
      MultiSelect = True
      ReadOnly = True
      ShowWorkAreas = True
      TabOrder = 1
      ViewStyle = vsReport
      OnColumnClick = ListViewColumnClick
      OnKeyUp = ListViewKeyUp
    end
    object Memo: TMemo
      Left = 0
      Top = 343
      Width = 709
      Height = 89
      Align = alBottom
      ScrollBars = ssVertical
      TabOrder = 2
      WordWrap = False
    end
  end
  object progressTimer: TTimer
    Interval = 10
    OnTimer = progressTimerTimer
    Left = 240
    Top = 120
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 240
    Top = 192
  end
  object StateTimer: TTimer
    Interval = 500
    OnTimer = StateTimerTimer
    Left = 328
    Top = 120
  end
  object OpenDialog: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 328
    Top = 192
  end
end
