object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'CLoader'
  ClientHeight = 529
  ClientWidth = 751
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 248
    Top = 16
    Width = 37
    Height = 13
    Caption = 'Region:'
  end
  object Button1: TButton
    Left = 640
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object LOG: TMemo
    Left = 0
    Top = 39
    Width = 753
    Height = 491
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 1
    ExplicitHeight = 482
  end
  object Button2: TButton
    Left = 55
    Top = 8
    Width = 75
    Height = 25
    Caption = 'GO'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 136
    Top = 8
    Width = 75
    Height = 25
    Caption = 'STOP'
    TabOrder = 3
    OnClick = Button3Click
  end
  object txtRegion: TEdit
    Left = 297
    Top = 12
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'Vilnius'
  end
  object Button4: TButton
    Left = 543
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Save LOG'
    TabOrder = 5
    OnClick = Button4Click
  end
  object cbSaveLOG: TCheckBox
    Left = 440
    Top = 13
    Width = 97
    Height = 17
    Caption = 'Auto save LOG'
    Checked = True
    State = cbChecked
    TabOrder = 6
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
    Left = 16
    Top = 8
  end
  object MyHtmlParser: TDIHtmlParser
    Left = 568
    Top = 40
  end
  object ADConnection1: TADConnection
    Params.Strings = (
      'Server=84.32.118.87'
      'Database=siosclients_db'
      'User_Name=siosnordic'
      'Password=H5k6inF3'
      'DriverID=pG')
    ConnectedStoredUsage = [auRunTime]
    Connected = True
    Left = 640
    Top = 48
  end
  object ADPhysPgDriverLink1: TADPhysPgDriverLink
    Left = 640
    Top = 112
  end
  object qryExistContact: TADQuery
    Connection = ADConnection1
    SQL.Strings = (
      'Select * from "Contacts"'
      'where "Name"= :Name'
      'and "Phone"= :Phone')
    Left = 640
    Top = 168
    ParamData = <
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PHONE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object qryExistContactID: TIntegerField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object qryExistContactName: TWideStringField
      FieldName = 'Name'
      Origin = '"Name"'
      Size = 100
    end
    object qryExistContactPhone: TWideStringField
      FieldName = 'Phone'
      Origin = '"Phone"'
      Size = 30
    end
    object qryExistContactPhoneOperator: TWideStringField
      FieldName = 'PhoneOperator'
      Origin = '"PhoneOperator"'
      Size = 50
    end
    object qryExistContactAddress1: TWideStringField
      FieldName = 'Address1'
      Origin = '"Address1"'
      Size = 80
    end
    object qryExistContactAddress2: TWideStringField
      FieldName = 'Address2'
      Origin = '"Address2"'
      Size = 100
    end
    object qryExistContactPostCode: TWideStringField
      FieldName = 'PostCode'
      Origin = '"PostCode"'
      FixedChar = True
      Size = 10
    end
  end
  object ADGUIxWaitCursor1: TADGUIxWaitCursor
    Left = 640
    Top = 224
  end
end
