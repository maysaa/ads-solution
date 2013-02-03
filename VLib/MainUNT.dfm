object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Main'
  ClientHeight = 298
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  DesignSize = (
    475
    298)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 19
    Width = 29
    Height = 13
    Caption = 'Code:'
  end
  object Label2: TLabel
    Left = 8
    Top = 43
    Width = 34
    Height = 13
    Caption = 'Result:'
  end
  object Button1: TButton
    Left = 275
    Top = 14
    Width = 75
    Height = 25
    Caption = 'Get'
    TabOrder = 0
    OnClick = Button1Click
  end
  object WB1: TEmbeddedWB
    Left = 0
    Top = 296
    Width = 473
    Height = 0
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    Silent = False
    OnNavigateComplete2 = WB1NavigateComplete2
    OnDocumentComplete = WB1DocumentComplete
    DisableCtrlShortcuts = 'N'
    DownloadOptions = [DownloadVideos, DownloadBGSounds]
    UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
    About = ' EmbeddedWB http://bsalsa.com/'
    PrintOptions.Header = '&w&bPage &p of &P'
    PrintOptions.HTMLHeader.Strings = (
      '<HTML></HTML>')
    PrintOptions.Footer = '&u&b&d'
    PrintOptions.Orientation = poPortrait
    ExplicitWidth = 737
    ExplicitHeight = 241
    ControlData = {
      4C0000002C4C0000452A00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Button2: TButton
    Left = 559
    Top = 14
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 640
    Top = 14
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 3
    OnClick = Button3Click
  end
  object txtCode: TEdit
    Left = 43
    Top = 16
    Width = 216
    Height = 21
    NumbersOnly = True
    TabOrder = 4
    Text = '46008281120'
  end
  object memResult: TMemo
    Left = 8
    Top = 62
    Width = 449
    Height = 219
    ScrollBars = ssBoth
    TabOrder = 5
  end
end
