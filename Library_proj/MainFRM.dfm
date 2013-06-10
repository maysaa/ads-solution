object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsToolWindow
  ClientHeight = 536
  ClientWidth = 830
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 220
    Width = 830
    Height = 316
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object WB1: TEmbeddedWB
      Left = 0
      Top = 0
      Width = 830
      Height = 316
      Align = alClient
      TabOrder = 0
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
      ExplicitTop = 1
      ExplicitWidth = 465
      ExplicitHeight = 233
      ControlData = {
        4C0000002C4C0000452A00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object pnlCenter: TPanel
    Left = 0
    Top = 30
    Width = 830
    Height = 190
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object memResult: TMemo
      Left = 0
      Top = 0
      Width = 830
      Height = 190
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
      ExplicitTop = 1
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 830
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object PB1: TProgressBar
      Left = 0
      Top = 0
      Width = 830
      Height = 30
      Align = alClient
      TabOrder = 0
    end
  end
end
