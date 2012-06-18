object LoadAdvertisementsForm: TLoadAdvertisementsForm
  Left = 0
  Top = 0
  Caption = 'LoadAdvertisementsForm'
  ClientHeight = 254
  ClientWidth = 541
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
  object dxLayoutControl1: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 541
    Height = 254
    Align = alClient
    TabOrder = 0
    object Log: TcxMemo
      Left = 54
      Top = 110
      Lines.Strings = (
        '')
      Properties.ScrollBars = ssVertical
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      TabOrder = 8
      Height = 134
      Width = 477
    end
    object Button3: TButton
      Left = 172
      Top = 10
      Width = 75
      Height = 25
      Caption = 'BRC'
      TabOrder = 2
      OnClick = Button3Click
    end
    object ButtonAutoplius: TButton
      Left = 10
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Autoplius'
      TabOrder = 0
      OnClick = ButtonAutopliusClick
    end
    object ButtonAutogidas: TButton
      Left = 91
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Autogidas'
      TabOrder = 1
      OnClick = ButtonAutogidasClick
    end
    object Button1: TButton
      Left = 253
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Stop'
      TabOrder = 3
      OnClick = Button1Click
    end
    object RepeatCheckBox: TCheckBox
      Left = 334
      Top = 10
      Width = 97
      Height = 17
      Caption = 'Kartoti visada'
      TabOrder = 4
    end
    object MakeComboBox: TcxLookupComboBox
      Left = 54
      Top = 56
      ParentCustomHint = False
      Properties.ClearKey = 46
      Properties.DropDownListStyle = lsEditList
      Properties.DropDownSizeable = True
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'ID'
      Properties.ListColumns = <
        item
          FieldName = 'MAKE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = CarMakesDataSource
      Properties.OnEditValueChanged = MakeComboBoxPropertiesEditValueChanged
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 6
      Width = 145
    end
    object ModelComboBox: TcxLookupComboBox
      Left = 54
      Top = 83
      ParentCustomHint = False
      Properties.ClearKey = 46
      Properties.DropDownListStyle = lsEditList
      Properties.DropDownSizeable = True
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'ID'
      Properties.ListColumns = <
        item
          FieldName = 'MODEL'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = ModelsDataSource
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.ButtonStyle = bts3D
      Style.PopupBorderStyle = epbsFrame3D
      TabOrder = 7
      Width = 145
    end
    object OnlyOld: TCheckBox
      Left = 334
      Top = 33
      Width = 97
      Height = 17
      Caption = 'Tik senus'
      TabOrder = 5
    end
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      AlignHorz = ahParentManaged
      AlignVert = avParentManaged
      CaptionOptions.Visible = False
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutControl1Group1: TdxLayoutGroup
      CaptionOptions.Text = 'Hidden Group'
      CaptionOptions.Visible = False
      Parent = dxLayoutControl1Group_Root
      ButtonOptions.Buttons = <>
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Item4: TdxLayoutItem
      CaptionOptions.Visible = False
      Parent = dxLayoutControl1Group1
      Control = ButtonAutoplius
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Group3: TdxLayoutGroup
      CaptionOptions.Text = 'Hidden Group'
      CaptionOptions.Visible = False
      Parent = dxLayoutControl1Group1
      ButtonOptions.Buttons = <>
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutControl1Item5: TdxLayoutItem
      CaptionOptions.Visible = False
      Parent = dxLayoutControl1Group3
      Control = ButtonAutogidas
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Item2: TdxLayoutItem
      CaptionOptions.Visible = False
      Parent = dxLayoutControl1Group3
      Control = Button3
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutControl1Group4: TdxLayoutGroup
      CaptionOptions.Text = 'Hidden Group'
      CaptionOptions.Visible = False
      Parent = dxLayoutControl1Group1
      ButtonOptions.Buttons = <>
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 2
    end
    object dxLayoutControl1Item6: TdxLayoutItem
      CaptionOptions.Visible = False
      Parent = dxLayoutControl1Group4
      Control = Button1
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Group2: TdxLayoutGroup
      CaptionOptions.Text = 'Hidden Group'
      CaptionOptions.Visible = False
      Parent = dxLayoutControl1Group4
      ButtonOptions.Buttons = <>
      Hidden = True
      ShowBorder = False
      Index = 1
    end
    object dxLayoutControl1Item7: TdxLayoutItem
      CaptionOptions.Visible = False
      Parent = dxLayoutControl1Group2
      Control = RepeatCheckBox
      ControlOptions.AutoColor = True
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutControl1Item10: TdxLayoutItem
      CaptionOptions.Visible = False
      Parent = dxLayoutControl1Group2
      Control = OnlyOld
      ControlOptions.AutoColor = True
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutControl1Item8: TdxLayoutItem
      AlignHorz = ahLeft
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = 'Mark'#279':'
      Parent = dxLayoutControl1Group_Root
      Control = MakeComboBox
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutControl1Item9: TdxLayoutItem
      AlignHorz = ahLeft
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = 'Modelis:'
      Parent = dxLayoutControl1Group_Root
      Control = ModelComboBox
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutControl1Item1: TdxLayoutItem
      AlignVert = avClient
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Text = 'Logas:'
      Parent = dxLayoutControl1Group_Root
      Control = Log
      ControlOptions.ShowBorder = False
      Index = 3
    end
  end
  object ADGUIxWaitCursor1: TADGUIxWaitCursor
    ScreenCursor = gcrHourGlass
    Left = 216
    Top = 48
  end
  object ADPhysPgDriverLink1: TADPhysPgDriverLink
    Left = 248
    Top = 48
  end
  object BodyTypesDataSet: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "BODY_TYPE"')
    Left = 96
    Top = 96
    object BodyTypesDataSetID: TADAutoIncField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object BodyTypesDataSetTYPE: TWideStringField
      FieldName = 'TYPE'
      Origin = '"TYPE"'
      FixedChar = True
      Size = 50
    end
  end
  object CarMakesDataSet: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "CARMAKE"')
    Left = 136
    Top = 96
    object CarMakesDataSetMAKE: TWideStringField
      FieldName = 'MAKE'
      Origin = '"MAKE"'
      Required = True
      FixedChar = True
      Size = 50
    end
    object CarMakesDataSetID: TADAutoIncField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
  end
  object CarModelsDataSet: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "CARMODEL"')
    Left = 176
    Top = 96
    object CarModelsDataSetCARMAKE_ID: TLargeintField
      FieldName = 'CARMAKE_ID'
      Origin = '"CARMAKE_ID"'
    end
    object CarModelsDataSetMODEL: TWideStringField
      FieldName = 'MODEL'
      Origin = '"MODEL"'
      FixedChar = True
      Size = 50
    end
    object CarModelsDataSetID: TADAutoIncField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
  end
  object ColorsDataSet: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "COLOR"')
    Left = 216
    Top = 96
    object ColorsDataSetID: TADAutoIncField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object ColorsDataSetCOLOR: TWideStringField
      FieldName = 'COLOR'
      Origin = '"COLOR"'
      FixedChar = True
      Size = 50
    end
  end
  object DamagedDataSet: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "DAMAGED"')
    Left = 256
    Top = 96
    object DamagedDataSetID: TADAutoIncField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object DamagedDataSetDAMAGED: TWideStringField
      FieldName = 'DAMAGED'
      Origin = '"DAMAGED"'
      FixedChar = True
      Size = 50
    end
  end
  object DoorsDataSet: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "DOORS"')
    Left = 96
    Top = 144
    object DoorsDataSetID: TADAutoIncField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object DoorsDataSetDOORS: TWideStringField
      FieldName = 'DOORS'
      Origin = '"DOORS"'
      FixedChar = True
      Size = 5
    end
  end
  object EnginesDataSet: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "ENGINE"')
    Left = 136
    Top = 144
    object EnginesDataSetID: TADAutoIncField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object EnginesDataSetENGINE: TIntegerField
      FieldName = 'ENGINE'
      Origin = '"ENGINE"'
    end
  end
  object FuelsDataSet: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "FUEL"')
    Left = 176
    Top = 144
    object FuelsDataSetID: TADAutoIncField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FuelsDataSetFUEL: TWideStringField
      FieldName = 'FUEL'
      Origin = '"FUEL"'
      FixedChar = True
      Size = 50
    end
  end
  object GearBoxDataSet: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "GEARBOX"')
    Left = 216
    Top = 144
    object GearBoxDataSetID: TADAutoIncField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object GearBoxDataSetGEARBOX: TWideStringField
      FieldName = 'GEARBOX'
      Origin = '"GEARBOX"'
      FixedChar = True
      Size = 50
    end
  end
  object SellersDataSet: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "SELLER"')
    Left = 96
    Top = 192
    object SellersDataSetID: TADAutoIncField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object SellersDataSetNAME: TWideStringField
      FieldName = 'NAME'
      Origin = '"NAME"'
      FixedChar = True
      Size = 100
    end
    object SellersDataSetTOWN: TWideStringField
      FieldName = 'TOWN'
      Origin = '"TOWN"'
      FixedChar = True
      Size = 50
    end
    object SellersDataSetADDRESS: TWideStringField
      FieldName = 'ADDRESS'
      Origin = '"ADDRESS"'
      FixedChar = True
      Size = 100
    end
    object SellersDataSetEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Origin = '"EMAIL"'
      FixedChar = True
      Size = 50
    end
    object SellersDataSetPHONE: TWideStringField
      FieldName = 'PHONE'
      Origin = '"PHONE"'
      FixedChar = True
      Size = 50
    end
    object SellersDataSetPHONE1: TWideStringField
      FieldName = 'PHONE1'
      Origin = '"PHONE1"'
      FixedChar = True
      Size = 50
    end
    object SellersDataSetCOUNTRY: TWideStringField
      FieldName = 'COUNTRY'
      Origin = '"COUNTRY"'
      FixedChar = True
      Size = 50
    end
  end
  object SteeringWheelDataSet: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "STEERING_WHEEL"')
    Left = 136
    Top = 192
    object SteeringWheelDataSetID: TADAutoIncField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object SteeringWheelDataSetWHEEL: TWideStringField
      FieldName = 'WHEEL'
      Origin = '"WHEEL"'
      FixedChar = True
      Size = 50
    end
  end
  object WebPageDataSet: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "WEBSITE"')
    Left = 176
    Top = 192
    object WebPageDataSetID: TIntegerField
      FieldName = 'ID'
      Origin = '"ID"'
    end
    object WebPageDataSetWEBSITE: TWideStringField
      FieldName = 'WEBSITE'
      Origin = '"WEBSITE"'
      FixedChar = True
      Size = 50
    end
  end
  object PowerDataSet: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "POWER_KW"')
    Left = 264
    Top = 192
    object PowerDataSetID: TADAutoIncField
      FieldName = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object PowerDataSetPOWER: TIntegerField
      FieldName = 'POWER'
      Origin = '"POWER"'
    end
  end
  object MainConnection: TADConnection
    Params.Strings = (
      'User_Name=siosnordic'
      'Password=H5k6inF3'
      'Server=84.32.118.87'
      'Database=siosnordic_db'
      'DriverID=PG')
    ConnectedStoredUsage = [auRunTime]
    LoginPrompt = False
    OnLosted = MainConnectionLosted
    Left = 144
    Top = 40
  end
  object AdvertisementsDataSet: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "ADVERTISEMENTS"')
    Left = 32
    Top = 160
    object AdvertisementsDataSetID: TADAutoIncField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object AdvertisementsDataSetADD_DATE: TDateField
      FieldName = 'ADD_DATE'
      Origin = '"ADD_DATE"'
    end
    object AdvertisementsDataSetCARMODEL_ID: TIntegerField
      FieldName = 'CARMODEL_ID'
      Origin = '"CARMODEL_ID"'
    end
    object AdvertisementsDataSetYEAR: TIntegerField
      FieldName = 'YEAR'
      Origin = '"YEAR"'
    end
    object AdvertisementsDataSetPRICE: TBCDField
      FieldName = 'PRICE'
      Origin = '"PRICE"'
      Precision = 12
      Size = 2
    end
    object AdvertisementsDataSetFUEL_ID: TIntegerField
      FieldName = 'FUEL_ID'
      Origin = '"FUEL_ID"'
    end
    object AdvertisementsDataSetGEARBOX_ID: TIntegerField
      FieldName = 'GEARBOX_ID'
      Origin = '"GEARBOX_ID"'
    end
    object AdvertisementsDataSetBODY_TYPE_ID: TIntegerField
      FieldName = 'BODY_TYPE_ID'
      Origin = '"BODY_TYPE_ID"'
    end
    object AdvertisementsDataSetSTEERING_WHEEL_ID: TIntegerField
      FieldName = 'STEERING_WHEEL_ID'
      Origin = '"STEERING_WHEEL_ID"'
    end
    object AdvertisementsDataSetENGINE_ID: TIntegerField
      FieldName = 'ENGINE_ID'
      Origin = '"ENGINE_ID"'
    end
    object AdvertisementsDataSetPOWER_KW_ID: TIntegerField
      FieldName = 'POWER_KW_ID'
      Origin = '"POWER_KW_ID"'
    end
    object AdvertisementsDataSetKILOMETRAGE: TIntegerField
      FieldName = 'KILOMETRAGE'
      Origin = '"KILOMETRAGE"'
    end
    object AdvertisementsDataSetCOLOR_ID: TIntegerField
      FieldName = 'COLOR_ID'
      Origin = '"COLOR_ID"'
    end
    object AdvertisementsDataSetDAMAGED_ID: TIntegerField
      FieldName = 'DAMAGED_ID'
      Origin = '"DAMAGED_ID"'
    end
    object AdvertisementsDataSetDOORS_ID: TIntegerField
      FieldName = 'DOORS_ID'
      Origin = '"DOORS_ID"'
    end
    object AdvertisementsDataSetSELLER_ID: TIntegerField
      FieldName = 'SELLER_ID'
      Origin = '"SELLER_ID"'
    end
    object AdvertisementsDataSetWEBSITE_ID: TIntegerField
      FieldName = 'WEBSITE_ID'
      Origin = '"WEBSITE_ID"'
    end
    object AdvertisementsDataSetADVERTISEMENTID: TIntegerField
      FieldName = 'ADVERTISEMENTID'
      Origin = '"ADVERTISEMENTID"'
    end
    object AdvertisementsDataSetDATE: TSQLTimeStampField
      FieldName = 'DATE'
      Origin = '"DATE"'
    end
    object AdvertisementsDataSetUPDATEDATE: TDateField
      FieldName = 'UPDATEDATE'
      Origin = '"UPDATEDATE"'
    end
    object AdvertisementsDataSetWEBPAGE: TADWideMemoField
      FieldName = 'WEBPAGE'
      Origin = '"WEBPAGE"'
      BlobType = ftWideMemo
    end
    object AdvertisementsDataSetENDED: TBooleanField
      FieldName = 'ENDED'
      Origin = '"ENDED"'
    end
    object AdvertisementsDataSetUSEDINLITHUANIA: TBooleanField
      FieldName = 'USEDINLITHUANIA'
      Origin = '"USEDINLITHUANIA"'
    end
  end
  object CarMakesDataSource: TDataSource
    DataSet = CarMakesDataSet
    Left = 264
    Top = 144
  end
  object WEBSITEMAKE: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      
        'select * from "WEBSITE_CARMAKE" where "WEBSITE_ID"=:WEBSITE and ' +
        '"CARMAKE_ID"=:CARMAKE')
    Left = 328
    Top = 96
    ParamData = <
      item
        Name = 'WEBSITE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CARMAKE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object ModelsDataSource: TDataSource
    DataSet = ADQuery1
    Left = 336
    Top = 144
  end
  object WEBSITEMODEL: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      
        'select * from "WEBSITE_CARMODEL" where "WEBSITE_ID"=:WEBSITE and' +
        ' "CARMODEL_ID"=:CARMODEL')
    Left = 392
    Top = 96
    ParamData = <
      item
        Name = 'WEBSITE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CARMODEL'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object ADQuery1: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "CARMODEL" where "CARMAKE_ID"=:CARMAKE')
    Left = 336
    Top = 192
    ParamData = <
      item
        Name = 'CARMAKE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object LargeintField1: TLargeintField
      FieldName = 'CARMAKE_ID'
      Origin = '"CARMAKE_ID"'
    end
    object WideStringField1: TWideStringField
      FieldName = 'MODEL'
      Origin = '"MODEL"'
      FixedChar = True
      Size = 50
    end
    object ADAutoIncField1: TADAutoIncField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
  end
  object CarMakeMapping: TADQuery
    Connection = MainConnection
    SQL.Strings = (
      'select * from "CARMAKEMAPPING"')
    Left = 464
    Top = 96
    object CarMakeMappingID: TADAutoIncField
      FieldName = 'ID'
      Origin = '"ID"'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object CarMakeMappingCARMAKE_ID: TIntegerField
      FieldName = 'CARMAKE_ID'
      Origin = '"CARMAKE_ID"'
    end
    object CarMakeMappingMAKE: TWideStringField
      FieldName = 'MAKE'
      Origin = '"MAKE"'
      FixedChar = True
      Size = 50
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 344
    Top = 56
  end
  object MyHtmlParser: TDIHtmlParser
    Left = 480
    Top = 8
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
    Left = 480
    Top = 56
  end
end
