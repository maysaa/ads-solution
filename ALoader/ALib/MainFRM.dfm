object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Main'
  ClientHeight = 491
  ClientWidth = 759
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 759
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 674
    DesignSize = (
      759
      41)
    object lblAnimalNo: TLabel
      Left = 489
      Top = 11
      Width = 55
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Animal No.:'
      ExplicitLeft = 202
    end
    object lblUser: TLabel
      Left = 192
      Top = 11
      Width = 26
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'User:'
      ExplicitLeft = 55
    end
    object lblPassword: TLabel
      Left = 299
      Top = 11
      Width = 50
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Password:'
      ExplicitLeft = 162
    end
    object Bevel1: TBevel
      Left = 474
      Top = 11
      Width = 9
      Height = 16
      Anchors = [akTop, akRight]
      Shape = bsLeftLine
      ExplicitLeft = 337
    end
    object lblCompany: TLabel
      Left = 16
      Top = 11
      Width = 49
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Company:'
    end
    object txtAnimalNo: TEdit
      Left = 550
      Top = 8
      Width = 121
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 0
      Text = 'LT0000'
      ExplicitLeft = 465
    end
    object btnSubmit: TButton
      Left = 677
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight]
      Caption = 'Submit'
      TabOrder = 1
      OnClick = btnSubmitClick
      ExplicitLeft = 592
    end
    object txtUser: TEdit
      Left = 224
      Top = 8
      Width = 69
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 2
      Text = 'VG0344'
      ExplicitLeft = 139
    end
    object txtpassword: TEdit
      Left = 355
      Top = 8
      Width = 90
      Height = 21
      Anchors = [akTop, akRight]
      PasswordChar = '*'
      TabOrder = 3
      Text = 'DMANT_3K'
      ExplicitLeft = 270
    end
    object CheckBox1: TCheckBox
      Left = 451
      Top = 10
      Width = 17
      Height = 17
      Anchors = [akTop, akRight]
      TabOrder = 4
      OnClick = CheckBox1Click
      ExplicitLeft = 366
    end
    object txtCompany: TEdit
      Left = 71
      Top = 8
      Width = 115
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 5
      Text = 'UAB" BARTYNCO "'
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 41
    Width = 759
    Height = 431
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 674
    ExplicitHeight = 384
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 759
      Height = 431
      ActivePage = TabSheet2
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 674
      ExplicitHeight = 384
      object TabSheet1: TTabSheet
        Caption = 'Browser'
        ExplicitWidth = 666
        ExplicitHeight = 356
        object WB1: TEmbeddedWB
          Left = 0
          Top = 0
          Width = 751
          Height = 403
          Align = alClient
          TabOrder = 0
          Silent = False
          DisableCtrlShortcuts = 'N'
          UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
          OnAuthenticate = WB1Authenticate
          About = ' EmbeddedWB http://bsalsa.com/'
          PrintOptions.Header = '&w&bPage &p of &P'
          PrintOptions.HTMLHeader.Strings = (
            '<HTML></HTML>')
          PrintOptions.Footer = '&u&b&d'
          PrintOptions.Orientation = poPortrait
          ExplicitLeft = 120
          ExplicitTop = 80
          ExplicitWidth = 300
          ExplicitHeight = 150
          ControlData = {
            4C000000D5440000CB2400000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E12620A000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Result'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 32
        object Memo1: TMemo
          Left = 29
          Top = 24
          Width = 652
          Height = 329
          Lines.Strings = (
            'Memo1')
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 472
    Width = 759
    Height = 19
    Panels = <
      item
        Width = 500
      end
      item
        Width = 500
      end>
    ExplicitLeft = 552
    ExplicitTop = 480
    ExplicitWidth = 0
  end
end
