object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Main'
  ClientHeight = 78
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 321
    Height = 67
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object PB1: TProgressBar
      Left = 0
      Top = 0
      Width = 321
      Height = 21
      Align = alTop
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 120
      Top = 27
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 67
    Width = 321
    Height = 1
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 321
      Height = 1
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Browser1'
        object WB1: TEmbeddedWB
          Left = 0
          Top = 0
          Width = 313
          Height = 0
          Align = alClient
          TabOrder = 0
          Silent = False
          RegisterAsBrowser = True
          OnNavigateComplete2 = WB1NavigateComplete2
          OnDocumentComplete = WB1DocumentComplete
          DisableCtrlShortcuts = 'N'
          UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
          OnAuthenticate = WB1Authenticate
          About = ' EmbeddedWB http://bsalsa.com/'
          PrintOptions.Header = '&w&bPage &p of &P'
          PrintOptions.HTMLHeader.Strings = (
            '<HTML></HTML>')
          PrintOptions.Footer = '&u&b&d'
          PrintOptions.Orientation = poPortrait
          ExplicitTop = -2
          ExplicitWidth = 751
          ExplicitHeight = 377
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
        ExplicitTop = 0
        ExplicitWidth = 0
        DesignSize = (
          313
          0)
        object lblCompany: TLabel
          Left = -430
          Top = 131
          Width = 49
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Company:'
          ExplicitLeft = 8
        end
        object lblUser: TLabel
          Left = -254
          Top = 131
          Width = 26
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'User:'
          ExplicitLeft = 184
        end
        object lblPassword: TLabel
          Left = -147
          Top = 131
          Width = 50
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Password:'
          ExplicitLeft = 291
        end
        object Bevel1: TBevel
          Left = 28
          Top = 131
          Width = 9
          Height = 16
          Anchors = [akTop, akRight]
          Shape = bsLeftLine
          ExplicitLeft = 466
        end
        object lblAnimalNo: TLabel
          Left = 43
          Top = 131
          Width = 55
          Height = 13
          Anchors = [akTop, akRight]
          Caption = 'Animal No.:'
          ExplicitLeft = 481
        end
        object memResult: TMemo
          Left = 0
          Top = 0
          Width = 751
          Height = 81
          ScrollBars = ssBoth
          TabOrder = 0
        end
        object txtCompany: TEdit
          Left = -375
          Top = 128
          Width = 115
          Height = 21
          Anchors = [akTop, akRight]
          TabOrder = 1
          Text = 'UAB" BARTYNCO "'
        end
        object txtUser: TEdit
          Left = -222
          Top = 128
          Width = 69
          Height = 21
          Anchors = [akTop, akRight]
          TabOrder = 2
          Text = 'VG0344'
        end
        object txtpassword: TEdit
          Left = -91
          Top = 128
          Width = 90
          Height = 21
          Anchors = [akTop, akRight]
          PasswordChar = '*'
          TabOrder = 3
          Text = 'DMANT_3K'
        end
        object CheckBox1: TCheckBox
          Left = 5
          Top = 130
          Width = 17
          Height = 17
          Anchors = [akTop, akRight]
          TabOrder = 4
          OnClick = CheckBox1Click
        end
        object txtAnimalNo: TEdit
          Left = 104
          Top = 128
          Width = 121
          Height = 21
          Anchors = [akTop, akRight]
          TabOrder = 5
          Text = 'LT000005816835'
        end
        object btnSubmit: TButton
          Left = 230
          Top = -12
          Width = 75
          Height = 25
          Anchors = [akRight]
          Caption = 'Submit'
          TabOrder = 6
          OnClick = btnSubmitClick
        end
      end
    end
  end
  object SB1: TStatusBar
    Left = 0
    Top = 59
    Width = 321
    Height = 19
    Panels = <
      item
        Width = 240
      end
      item
        Width = 500
      end>
  end
end
