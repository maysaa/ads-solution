object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Main'
  ClientHeight = 247
  ClientWidth = 439
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object dxLayoutControl1: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 439
    Height = 247
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 80
    ExplicitTop = 32
    ExplicitWidth = 300
    ExplicitHeight = 250
    object cxTextEdit1: TcxTextEdit
      Left = 66
      Top = 10
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 0
      Text = 'LT0000'
      Width = 223
    end
    object btnGet: TcxButton
      Left = 354
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Submit'
      TabOrder = 1
    end
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      AlignHorz = ahParentManaged
      AlignVert = avParentManaged
      ButtonOptions.Buttons = <>
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = -1
    end
    object dxLayoutControl1Item1: TdxLayoutItem
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Animal No:'
      Parent = dxLayoutControl1Group_Root
      Control = cxTextEdit1
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Item2: TdxLayoutItem
      AlignHorz = ahRight
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Parent = dxLayoutControl1Group_Root
      Control = btnGet
      ControlOptions.ShowBorder = False
      Index = 1
    end
  end
end
