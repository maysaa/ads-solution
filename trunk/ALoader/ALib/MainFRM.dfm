object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Main'
  ClientHeight = 425
  ClientWidth = 674
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 674
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 72
    ExplicitWidth = 472
    DesignSize = (
      674
      41)
    object lblAnimalNo: TLabel
      Left = 404
      Top = 11
      Width = 55
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Animal No.:'
      ExplicitLeft = 202
    end
    object lblUser: TLabel
      Left = 107
      Top = 11
      Width = 26
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'User:'
      ExplicitLeft = 55
    end
    object lblPassword: TLabel
      Left = 214
      Top = 11
      Width = 50
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Password:'
      ExplicitLeft = 162
    end
    object Bevel1: TBevel
      Left = 389
      Top = 11
      Width = 9
      Height = 16
      Anchors = [akTop, akRight]
      Shape = bsLeftLine
      ExplicitLeft = 337
    end
    object txtAnimalNo: TEdit
      Left = 465
      Top = 8
      Width = 121
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 0
      Text = 'LT0000'
      ExplicitLeft = 263
    end
    object btnSubmit: TButton
      Left = 592
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight]
      Caption = 'Submit'
      TabOrder = 1
      OnClick = btnSubmitClick
      ExplicitLeft = 390
    end
    object txtUser: TEdit
      Left = 139
      Top = 8
      Width = 69
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 2
      Text = 'VG0344'
      ExplicitLeft = 87
    end
    object txtpassword: TEdit
      Left = 270
      Top = 8
      Width = 90
      Height = 21
      Anchors = [akTop, akRight]
      PasswordChar = '*'
      TabOrder = 3
      Text = 'DMANT_3K'
      ExplicitLeft = 218
    end
    object CheckBox1: TCheckBox
      Left = 366
      Top = 10
      Width = 17
      Height = 17
      Anchors = [akTop, akRight]
      TabOrder = 4
      OnClick = CheckBox1Click
      ExplicitLeft = 314
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 41
    Width = 674
    Height = 384
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 96
    ExplicitTop = 96
    ExplicitWidth = 185
    ExplicitHeight = 41
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 674
      Height = 384
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 472
      ExplicitHeight = 202
      object TabSheet1: TTabSheet
        Caption = 'Browser'
        ExplicitWidth = 281
        ExplicitHeight = 165
        object WB1: TEmbeddedWB
          Left = 0
          Top = 0
          Width = 666
          Height = 356
          Align = alClient
          TabOrder = 0
          DisableCtrlShortcuts = 'N'
          UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
          OnAuthenticate = WB1Authenticate
          About = ' EmbeddedWB http://bsalsa.com/'
          PrintOptions.HTMLHeader.Strings = (
            '<HTML></HTML>')
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
        ExplicitWidth = 281
        ExplicitHeight = 165
      end
    end
  end
end
