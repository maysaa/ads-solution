object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'ALoader'
  ClientHeight = 528
  ClientWidth = 826
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    826
    528)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 197
    Top = 16
    Width = 75
    Height = 26
    Caption = 'Open URL'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 405
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Set value'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 278
    Top = 18
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'LT000005816667'
  end
  object Button3: TButton
    Left = 486
    Top = 16
    Width = 88
    Height = 25
    Caption = 'Exec JavaScript'
    TabOrder = 4
    OnClick = Button3Click
  end
  object RadioGroup1: TRadioGroup
    Left = 6
    Top = 1
    Width = 185
    Height = 50
    Caption = 'Variants'
    Columns = 2
    ItemIndex = 1
    Items.Strings = (
      'First'
      'Second')
    TabOrder = 0
  end
  object Button4: TButton
    Left = 664
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Memo1: TMemo
    Left = 40
    Top = 57
    Width = 649
    Height = 88
    Lines.Strings = (
      'Memo1')
    TabOrder = 6
  end
  object WB1: TEmbeddedWB
    Left = 8
    Top = 165
    Width = 802
    Height = 359
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 7
    DisableCtrlShortcuts = 'N'
    UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
    OnShowMessage = WB1ShowMessage
    OnAuthenticate = WB1Authenticate
    OnPreRefresh = WB1PreRefresh
    About = ' EmbeddedWB http://bsalsa.com/'
    OnShowDialog = WB1ShowDialog
    PrintOptions.HTMLHeader.Strings = (
      '<HTML></HTML>')
    PrintOptions.Orientation = poPortrait
    ControlData = {
      4C000000E45200001B2500000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Button5: TButton
    Left = 735
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Button5'
    TabOrder = 8
    OnClick = Button5Click
  end
  object WebBrowser1: TWebBrowser
    Left = 8
    Top = 72
    Width = 706
    Height = 56
    TabOrder = 9
    ControlData = {
      4C000000F8480000CA0500000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Button6: TButton
    Left = 735
    Top = 103
    Width = 75
    Height = 25
    Caption = 'Button6'
    TabOrder = 10
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 735
    Top = 134
    Width = 75
    Height = 25
    Caption = 'Button7'
    TabOrder = 11
    OnClick = Button7Click
  end
  object EwbC1: TEwbCore
    Left = 8
    Top = 134
    Width = 721
    Height = 71
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 12
    UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
    OnAuthenticate = EwbC1Authenticate
    ControlData = {
      4C000000844A0000570700000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 624
    Top = 16
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 584
    Top = 16
  end
  object SecurityManager1: TSecurityManager
    OnSetSecuritySite = SecurityManager1SetSecuritySite
    OnGetSecuritySite = SecurityManager1GetSecuritySite
    OnMapUrlToZone = SecurityManager1MapUrlToZone
    OnGetSecurityID = SecurityManager1GetSecurityID
    OnProcessUrlAction = SecurityManager1ProcessUrlAction
    OnQueryCustomPolicy = SecurityManager1QueryCustomPolicy
    OnSetZoneMapping = SecurityManager1SetZoneMapping
    OnGetZoneMappings = SecurityManager1GetZoneMappings
    UrlPolicy.ActiveX = Allow
    UrlPolicy.CrossDomainData = Allow
    UrlPolicy.SubmitForms = Allow
    UrlPolicy.JavaPermissions = Prohibited
    UrlPolicy.Scripts = Allow
    Left = 760
    Top = 24
  end
  object HtmlListener1: THtmlListener
    Handlers = <>
    Left = 656
    Top = 152
  end
end
