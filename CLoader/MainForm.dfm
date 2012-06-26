object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'CLoader'
  ClientHeight = 520
  ClientWidth = 751
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    751
    520)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 152
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 88
    Width = 705
    Height = 209
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      
        '<!--This is a comment. Comments are not displayed in the browser' +
        '-->'#11
      #11
      '<p>This is a paragraph.</p> ')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Button2: TButton
    Left = 152
    Top = 1
    Width = 75
    Height = 25
    Caption = 'URL'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Memo2: TMemo
    Left = 8
    Top = 303
    Width = 705
    Height = 194
    Lines.Strings = (
      'Memo2')
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object IdHTTP1: TIdHTTP
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
    Left = 24
    Top = 24
  end
  object MyHtmlParser: TDIHtmlParser
    Left = 568
    Top = 40
  end
end
