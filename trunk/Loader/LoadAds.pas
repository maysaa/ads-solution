unit LoadAds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtActns, uADStanIntf, uADStanOption, uADStanParam,
  uADStanError,
  uADDatSManager, uADPhysIntf, uADDAptIntf, uADStanAsync, uADDAptManager,
  uADGUIxIntf, uADStanDef,
  uADStanPool, uADPhysManager, DB, uADCompClient, uADCompDataSet,
  uADGUIxFormsWait, uADPhysPG, unit1, DateUtils, ComCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue,
  cxProgressBar, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxMemo, dxLayoutControl, ExtCtrls, IdBaseComponent, IdComponent, IdRawBase,
  IdRawClient, IdIcmpClient, UnitPing, IdHTTP, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinscxPCPainter, dxLayoutcxEditAdapters, uADCompGUIx, dxSkinBlueprint,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinHighContrast,
  dxSkinSevenClassic, dxSkinSharpPlus, dxSkinTheAsphaltWorld, dxSkinVS2010,
  dxSkinWhiteprint, dxLayoutControlAdapters, dxLayoutContainer, DIUnicode, DIHtmlParser, IdTCPConnection, IdTCPClient,
  DIHtmlMisc, DIUtils;

type
  Adv_record = record
    skelbimo_id: string;
    marke: string;
    modelis: string;
    kaina: string;
    pagaminimo_data: string;
    kuro_tipas: string;
    Pavaru_dezes_tipas: string;
    duru_skaicius: string;
    kebulo_tipas: string;
    vairo_padetis: string;
    rida: string;
    turis: string;
    galia: string;
    spalva: string;
    vardas: string;
    telefonas: string;
    miestas: string;
    salis: string;
    dauzta: string;
    skelbimo_data: string;
    atnaujinimo_data: string;
    puslapis: string;
    lietuvoje_eksplotuota: boolean;
  end;

type
  TLoadAdvertisementsForm = class(TForm)
    ADGUIxWaitCursor1: TADGUIxWaitCursor;
    ADPhysPgDriverLink1: TADPhysPgDriverLink;
    BodyTypesDataSet: TADQuery;
    CarMakesDataSet: TADQuery;
    CarModelsDataSet: TADQuery;
    ColorsDataSet: TADQuery;
    DamagedDataSet: TADQuery;
    DoorsDataSet: TADQuery;
    EnginesDataSet: TADQuery;
    FuelsDataSet: TADQuery;
    GearBoxDataSet: TADQuery;
    SellersDataSet: TADQuery;
    SteeringWheelDataSet: TADQuery;
    WebPageDataSet: TADQuery;
    WebPageDataSetID: TIntegerField;
    WebPageDataSetWEBSITE: TWideStringField;
    CarModelsDataSetCARMAKE_ID: TLargeintField;
    CarModelsDataSetMODEL: TWideStringField;
    CarModelsDataSetID: TADAutoIncField;
    ColorsDataSetID: TADAutoIncField;
    ColorsDataSetCOLOR: TWideStringField;
    DoorsDataSetID: TADAutoIncField;
    DoorsDataSetDOORS: TWideStringField;
    GearBoxDataSetID: TADAutoIncField;
    GearBoxDataSetGEARBOX: TWideStringField;
    DamagedDataSetID: TADAutoIncField;
    DamagedDataSetDAMAGED: TWideStringField;
    EnginesDataSetID: TADAutoIncField;
    EnginesDataSetENGINE: TIntegerField;
    FuelsDataSetID: TADAutoIncField;
    FuelsDataSetFUEL: TWideStringField;
    BodyTypesDataSetID: TADAutoIncField;
    BodyTypesDataSetTYPE: TWideStringField;
    SellersDataSetID: TADAutoIncField;
    SellersDataSetNAME: TWideStringField;
    SellersDataSetTOWN: TWideStringField;
    SellersDataSetADDRESS: TWideStringField;
    SellersDataSetEMAIL: TWideStringField;
    SellersDataSetPHONE: TWideStringField;
    SellersDataSetPHONE1: TWideStringField;
    SteeringWheelDataSetID: TADAutoIncField;
    SteeringWheelDataSetWHEEL: TWideStringField;
    PowerDataSet: TADQuery;
    PowerDataSetID: TADAutoIncField;
    PowerDataSetPOWER: TIntegerField;
    CarMakesDataSetMAKE: TWideStringField;
    CarMakesDataSetID: TADAutoIncField;
    MainConnection: TADConnection;
    AdvertisementsDataSet: TADQuery;
    AdvertisementsDataSetID: TADAutoIncField;
    AdvertisementsDataSetADD_DATE: TDateField;
    AdvertisementsDataSetCARMODEL_ID: TIntegerField;
    AdvertisementsDataSetYEAR: TIntegerField;
    AdvertisementsDataSetPRICE: TBCDField;
    AdvertisementsDataSetFUEL_ID: TIntegerField;
    AdvertisementsDataSetGEARBOX_ID: TIntegerField;
    AdvertisementsDataSetBODY_TYPE_ID: TIntegerField;
    AdvertisementsDataSetSTEERING_WHEEL_ID: TIntegerField;
    AdvertisementsDataSetENGINE_ID: TIntegerField;
    AdvertisementsDataSetPOWER_KW_ID: TIntegerField;
    AdvertisementsDataSetKILOMETRAGE: TIntegerField;
    AdvertisementsDataSetCOLOR_ID: TIntegerField;
    AdvertisementsDataSetDAMAGED_ID: TIntegerField;
    AdvertisementsDataSetDOORS_ID: TIntegerField;
    AdvertisementsDataSetSELLER_ID: TIntegerField;
    AdvertisementsDataSetWEBSITE_ID: TIntegerField;
    AdvertisementsDataSetADVERTISEMENTID: TIntegerField;
    AdvertisementsDataSetDATE: TSQLTimeStampField;
    AdvertisementsDataSetUPDATEDATE: TDateField;
    AdvertisementsDataSetWEBPAGE: TADWideMemoField;
    AdvertisementsDataSetENDED: TBooleanField;
    AdvertisementsDataSetUSEDINLITHUANIA: TBooleanField;
    SellersDataSetCOUNTRY: TWideStringField;
    CarMakesDataSource: TDataSource;
    WEBSITEMAKE: TADQuery;
    ModelsDataSource: TDataSource;
    WEBSITEMODEL: TADQuery;
    ADQuery1: TADQuery;
    LargeintField1: TLargeintField;
    WideStringField1: TWideStringField;
    ADAutoIncField1: TADAutoIncField;
    dxLayoutControl1Group_Root: TdxLayoutGroup;
    dxLayoutControl1: TdxLayoutControl;
    dxLayoutControl1Item1: TdxLayoutItem;
    Log: TcxMemo;
    dxLayoutControl1Item2: TdxLayoutItem;
    Button3: TButton;
    dxLayoutControl1Item4: TdxLayoutItem;
    ButtonAutoplius: TButton;
    dxLayoutControl1Item5: TdxLayoutItem;
    ButtonAutogidas: TButton;
    dxLayoutControl1Item6: TdxLayoutItem;
    Button1: TButton;
    dxLayoutControl1Item7: TdxLayoutItem;
    RepeatCheckBox: TCheckBox;
    dxLayoutControl1Item8: TdxLayoutItem;
    MakeComboBox: TcxLookupComboBox;
    dxLayoutControl1Item9: TdxLayoutItem;
    ModelComboBox: TcxLookupComboBox;
    dxLayoutControl1Group1: TdxLayoutGroup;
    dxLayoutControl1Group3: TdxLayoutGroup;
    dxLayoutControl1Group4: TdxLayoutGroup;
    CarMakeMapping: TADQuery;
    CarMakeMappingID: TADAutoIncField;
    CarMakeMappingCARMAKE_ID: TIntegerField;
    CarMakeMappingMAKE: TWideStringField;
    dxLayoutControl1Item10: TdxLayoutItem;
    OnlyOld: TCheckBox;
    dxLayoutControl1Group2: TdxLayoutGroup;
    Timer1: TTimer;
    MyHtmlParser: TDIHtmlParser;
    IdHTTP1: TIdHTTP;
    AdvertCardParser: TDIHtmlParser;
    procedure ButtonAutopliusClick(Sender: TObject);
    procedure ButtonAutogidasClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MakeComboBoxPropertiesEditValueChanged(Sender: TObject);
    procedure MainConnectionLosted(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    Finish: boolean;
  public
    procedure Parse(tipas: integer);
    procedure UpdateOld(tipas: integer);
    procedure SaveAdvert(tipas: integer; masina: Adv_record);
    function ParseAutopliusPage(webpage: string; var masina: array of Adv_record): boolean;
    function ParseAutogidasPage(webpage: string; var masina: array of Adv_record): boolean;
    function ParseAutogidasPageExt(webpage: string; out NextWebpage: string; var masina: array of Adv_record): boolean;
    function ParseMobilePage(webpage: string; var masina: array of Adv_record): boolean;
    function ParseBRCPage(webpage: string; var masina: array of Adv_record): boolean;
  end;

var
  LoadAdvertisementsForm: TLoadAdvertisementsForm;
function ParseAutopliusAdvert(webpage: string; var masina: Adv_record): boolean;
function ParseAutogidasAdvert(webpage: string; var masina: Adv_record): boolean;
function ParseAutogidasAdvertExt(webpage: string; var masina: Adv_record): boolean;
function ParseMobileAdvert(webpage: string; var masina: Adv_record): boolean;
function ParseBRCAdvert(webpage: string; var masina: Adv_record): boolean;
function AdvertExists(tipas: integer; webpage: string): boolean;

implementation

{$R *.dfm}

function Download_HTM(const sURL, sLocalFileName: string): boolean;
var
  IdHTTP: TIdHTTP;
  FileStream: TFileStream;
begin
  try
    FileStream := TFileStream.Create(sLocalFileName, fmCreate);
    IdHTTP := TIdHTTP.Create(nil);
    try
      try
        IdHTTP.Get(sURL, FileStream);
        result := true;
      except
        result := false;
      end;
    finally
      IdHTTP.Free;
    end;
  finally
    FileStream.Free;
  end;

  { result := true;
    with TDownLoadURL.Create(nil) do
    try
    URL := sURL;
    FileName := sLocalFileName;
    try
    ExecuteTarget(nil);
    except
    on e: exception do
    begin
    result := false;
    end;
    end;
    finally
    Free;
    end; }
end;

procedure TLoadAdvertisementsForm.ButtonAutopliusClick(Sender: TObject);
begin
  Finish := false;
  if RepeatCheckBox.Checked then
  begin
    repeat
      Parse(1)
    until Finish;
  end
  else
    Parse(1);
end;

procedure TLoadAdvertisementsForm.FormCreate(Sender: TObject);
begin
  CarMakesDataSet.Open;
  CarMakeMapping.Active := true;
  ADQuery1.Open;
  Finish := false;
end;

procedure TLoadAdvertisementsForm.MainConnectionLosted(Sender: TObject);
begin
  Timer1.Enabled := true;
end;

procedure TLoadAdvertisementsForm.MakeComboBoxPropertiesEditValueChanged(Sender: TObject);
begin
  ADQuery1.Close;
  ADQuery1.ParamByName('CARMAKE').Value := MakeComboBox.EditValue;
  ADQuery1.Open();
end;

procedure TLoadAdvertisementsForm.Button1Click(Sender: TObject);
begin
  Finish := true;
  Log.Lines.SaveToFile('log.log');
  Log.Lines.Add('Sustabdytas');
end;

procedure TLoadAdvertisementsForm.Button2Click(Sender: TObject);
begin
  Finish := false;
  if RepeatCheckBox.Checked then
  begin
    repeat
      Parse(3)
    until Finish;
  end
  else
    Parse(3);
end;

procedure TLoadAdvertisementsForm.Button3Click(Sender: TObject);
begin
  Finish := false;
  if RepeatCheckBox.Checked then
  begin
    repeat
      Parse(4)
    until Finish;
  end
  else
    Parse(4);
end;

procedure TLoadAdvertisementsForm.ButtonAutogidasClick(Sender: TObject);
begin
  Finish := false;
  if RepeatCheckBox.Checked then
  begin
    repeat
      Parse(2)
    until Finish;
  end
  else
    Parse(2);
end;

function GetWindowsDir: TFileName;
var
  WinDir: array [0 .. MAX_PATH - 1] of char;
begin
  SetString(result, WinDir, GetWindowsDirectory(WinDir, MAX_PATH));
  if result = '' then
    raise exception.Create(SysErrorMessage(GetLastError));
end;

function GetTempDir: TFileName;
var
  TmpDir: array [0 .. MAX_PATH - 1] of char;
begin
  try
    SetString(result, TmpDir, GetTempPath(MAX_PATH, TmpDir));
    if not DirectoryExists(result) then
      if not CreateDirectory(PChar(result), nil) then
      begin
        result := IncludeTrailingBackslash(GetWindowsDir) + 'TEMP';
        if not DirectoryExists(result) then
          if not CreateDirectory(Pointer(result), nil) then
          begin
            result := ExtractFileDrive(result) + '\TEMP';
            if not DirectoryExists(result) then
              if not CreateDirectory(Pointer(result), nil) then
              begin
                result := ExtractFileDrive(result) + '\TMP';
                if not DirectoryExists(result) then
                  if not CreateDirectory(Pointer(result), nil) then
                  begin
                    raise exception.Create(SysErrorMessage(GetLastError));
                  end;
              end;
          end;
      end;
  except
    result := '';
    raise;
  end;
end;

function TempFileName: TFileName;
// Creates a temporal file and returns its path name
var
  TempFileName: array [0 .. MAX_PATH - 1] of char;
begin
  if GetTempFileName(PChar(GetTempDir), '~', 0, TempFileName) = 0 then
    raise exception.Create(SysErrorMessage(GetLastError));
  result := TempFileName;
end;

function ParseAutopliusAdvert(webpage: string; var masina: Adv_record): boolean;
var
  TmpFileNameMarkes: TFileName;
  m, n, o: integer;
  sl: TStringList;
  rawHTM, temp: string;
  variables: array [1 .. 50] of string;
  variablesvalues: array [1 .. 50] of string;
  variablesorder: array [1 .. 50] of string;
  vardascount: integer;
  AEncoding: TEncoding;
  i: integer;
begin
  try
    TmpFileNameMarkes := TempFileName;
    Screen.Cursor := crHourGlass;
    if NOT Download_HTM(webpage, TmpFileNameMarkes) then
    begin
      result := false;
      Exit;
    end;
    masina.puslapis := webpage;
    sl := TStringList.Create;
    AEncoding := TEncoding.UTF8;
    sl.LoadFromFile(TmpFileNameMarkes, AEncoding);
    rawHTM := '';
    for i := 0 to sl.Count - 1 do
    begin
      rawHTM := Concat(rawHTM, sl[i]);
    end;
    sl.Free;

    masina.skelbimo_id := Copy(webpage, pos('id-', webpage) + 3, length(webpage) - pos('id-', webpage) - 2);

    if pos('Vardas:</th><td><strong>', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Vardas:</th><td><strong>', rawHTM) - 1);
      Delete(rawHTM, 1, pos('var', rawHTM) - 1);
      temp := Copy(rawHTM, pos('var', rawHTM) + 4, pos(';', rawHTM) - pos('var', rawHTM) - 4);
      fillchar(variables, sizeOf(variables), 0);
      vardascount := 1;
      while length(temp) > 0 do
      begin
        if pos(',', temp) > 0 then
          variables[vardascount] := Copy(temp, 1, pos(',', temp) - 1)
        else
        begin
          variables[vardascount] := temp;
          Break;
        end;
        Delete(temp, 1, pos(',', temp));
        inc(vardascount);
      end;
      Delete(rawHTM, 1, pos(';', rawHTM));
      temp := Copy(rawHTM, 1, pos('document.write(', rawHTM) - 1);
      fillchar(variablesvalues, sizeOf(variablesvalues), 0);
      while length(trim(temp)) > 0 do
      begin
        if pos(';', temp) > 0 then
        begin
          for m := 1 to 50 do
          begin
            if variables[m] = Copy(temp, 1, pos('=', temp) - 1) then
            begin
              variablesvalues[m] := Copy(temp, pos('=', temp) + 2, 1);
              Break;
            end;
          end;
        end
        else
        begin
          for m := 1 to 50 do
          begin
            if variables[m] = Copy(temp, 1, pos('=', temp) - 1) then
            begin
              variablesvalues[m] := Copy(temp, pos('=', temp) + 2, 1);
              Break;
            end;
          end;
          Break;
        end;
        Delete(temp, 1, pos(';', temp));
      end;

      while pos('document.write(', rawHTM) < pos('Telefonas pasiteirauti:</th><td><strong>', rawHTM) do
      begin
        Delete(rawHTM, 1, pos('document.write(', rawHTM) - 1);
        temp := Copy(rawHTM, pos('document.write(', rawHTM) + 15, pos(';', rawHTM) - pos('document.write(', rawHTM) - 16);
        fillchar(variablesorder, sizeOf(variablesorder), 0);
        vardascount := 1;
        while length(temp) > 0 do
        begin
          if pos('+', temp) > 0 then
            variablesorder[vardascount] := Copy(temp, 1, pos('+', temp) - 1)
          else
          begin
            variablesorder[vardascount] := temp;
            Break;
          end;
          Delete(temp, 1, pos('+', temp));
          inc(vardascount);
        end;
        for n := 1 to 50 do
        begin
          if variablesorder[n] <> '' then
          begin
            for o := 1 to 50 do
            begin
              if variables[o] = variablesorder[n] then
              begin
                masina.vardas := masina.vardas + variablesvalues[o];
                Break;
              end;
            end;
          end;
        end;
        Delete(rawHTM, 1, pos(';', rawHTM));
      end;
    end;

    if pos('Telefonas pasiteirauti:</th><td><strong>', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Telefonas pasiteirauti:</th><td><strong>', rawHTM) - 1);
      Delete(rawHTM, 1, pos('var', rawHTM) - 1);
      temp := Copy(rawHTM, pos('var', rawHTM) + 4, pos(';', rawHTM) - pos('var', rawHTM) - 4);
      fillchar(variables, sizeOf(variables), 0);
      vardascount := 1;
      while length(temp) > 0 do
      begin
        if pos(',', temp) > 0 then
          variables[vardascount] := Copy(temp, 1, pos(',', temp) - 1)
        else
        begin
          variables[vardascount] := temp;
          Break;
        end;
        Delete(temp, 1, pos(',', temp));
        inc(vardascount);
      end;
      Delete(rawHTM, 1, pos(';', rawHTM));
      temp := Copy(rawHTM, 1, pos('document.write(', rawHTM) - 1);
      fillchar(variablesvalues, sizeOf(variablesvalues), 0);
      while length(trim(temp)) > 0 do
      begin
        if pos(';', temp) > 0 then
        begin
          for m := 1 to 50 do
          begin
            if variables[m] = Copy(temp, 1, pos('=', temp) - 1) then
            begin
              variablesvalues[m] := Copy(temp, pos('=', temp) + 2, 1);
              Break;
            end;
          end;
        end;
        Delete(temp, 1, pos(';', temp));
      end;
      while (pos('document.write(', rawHTM) < pos('</script', rawHTM)) do
      begin
        Delete(rawHTM, 1, pos('document.write(', rawHTM) - 1);
        temp := Copy(rawHTM, pos('document.write(', rawHTM) + 15, pos(';', rawHTM) - pos('document.write(', rawHTM) - 16);
        fillchar(variablesorder, sizeOf(variablesorder), 0);
        vardascount := 1;
        while length(temp) > 0 do
        begin
          if pos('+', temp) > 0 then
            variablesorder[vardascount] := Copy(temp, 1, pos('+', temp) - 1)
          else
          begin
            variablesorder[vardascount] := temp;
            Break;
          end;
          Delete(temp, 1, pos('+', temp));
          inc(vardascount);
        end;
        for n := 1 to 50 do
        begin
          if variablesorder[n] <> '' then
          begin
            for o := 1 to 50 do
            begin
              if variables[o] = variablesorder[n] then
              begin
                masina.telefonas := masina.telefonas + variablesvalues[o];
                Break;
              end;
            end;
          end;
        end;
        Delete(rawHTM, 1, pos(';', rawHTM));
      end;
    end;

    masina.marke := Copy(rawHTM, pos('http://auto.plius.lt/skelbimas/lengvieji-automobiliai/', rawHTM) +
      length('http://auto.plius.lt/skelbimas/lengvieji-automobiliai/'),
      pos('id-', rawHTM) - (pos('http://auto.plius.lt/skelbimas/lengvieji-automobiliai/', rawHTM) +
      length('http://auto.plius.lt/skelbimas/lengvieji-automobiliai/') + 1));
    masina.modelis := Copy(masina.marke, pos('-', masina.marke) + 1, length(masina.marke));
    masina.marke := Copy(masina.marke, 1, pos('-', masina.marke) - 1);
    if pos('Miestas, Šalis:</th><td><strong>', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Miestas, Šalis:</th><td><strong>', rawHTM) - 1);
      masina.miestas := Copy(rawHTM, pos('Miestas, Šalis:</th><td><strong>', rawHTM) + length('Miestas, Šalis:</th><td><strong>'),
        pos('</strong>', rawHTM) - pos('Miestas, Šalis:</th><td><strong>', rawHTM) - length('Miestas, Šalis:</th><td><strong>'));
      masina.salis := Copy(masina.miestas, pos(',', masina.miestas) + 2, length(masina.miestas) - pos(',', masina.miestas) - 1);
      masina.miestas := Copy(masina.miestas, 1, pos(',', masina.miestas) - 1);
    end;
    if pos('Kaina Lietuvoje:</th><td><strong>', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Kaina Lietuvoje:</th><td><strong>', rawHTM) - 1);
      masina.kaina := Copy(rawHTM, pos('Kaina Lietuvoje:</th><td><strong>', rawHTM) + length('Kaina Lietuvoje:</th><td><strong>'),
        pos('Lt', rawHTM) - pos('Kaina Lietuvoje:</th><td><strong>', rawHTM) - length('Kaina Lietuvoje:</th><td><strong>') - 1);
    end;
    if pos('Pagaminimo data:</th><td><strong>', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Pagaminimo data:', rawHTM) - 1);
      masina.pagaminimo_data := Copy(rawHTM, pos('Pagaminimo data:</th><td><strong>', rawHTM) + length('Pagaminimo data:</th><td><strong>'),
        pos('</strong>', rawHTM) - pos('Pagaminimo data:</th><td><strong>', rawHTM) - length('Pagaminimo data:</th><td><strong>'));
    end;
    if pos('Rida, km:</th><td><strong>', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Rida, km:</th><td><strong>', rawHTM) + length('Rida, km:</th><td><strong>'));
      masina.rida := Copy(rawHTM, 1, pos('km', rawHTM) - 2);
    end;
    if (pos('Variklis:</th><td><strong>', rawHTM) > 0) then
    begin
      Delete(rawHTM, 1, pos('Variklis:</th><td><strong>', rawHTM) + length('Variklis:</th><td><strong>') - 1);
      if pos('cm³', rawHTM) > 0 then
        masina.turis := Copy(rawHTM, 1, pos('cm³', rawHTM) - 2);
    end;
    if (pos('AG</span> <span>(', rawHTM) > 0) then
    begin
      Delete(rawHTM, 1, pos('AG</span> <span>(', rawHTM) + length('AG</span> <span>(') - 1);
      if pos('KW', rawHTM) > 0 then
        masina.galia := Copy(rawHTM, 1, pos('KW', rawHTM) - 1);
    end;

    if pos('Kuro tipas:</th><td><strong>', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Kuro tipas:</th><td><strong>', rawHTM) - 1);
      masina.kuro_tipas := Copy(rawHTM, pos('Kuro tipas:</th><td><strong>', rawHTM) + length('Kuro tipas:</th><td><strong>'),
        pos('</strong>', rawHTM) - pos('Kuro tipas:</th><td><strong>', rawHTM) - length('Kuro tipas:</th><td><strong>'));
    end;
    if pos('Spalva:</th><td><strong>', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Spalva:</th><td><strong>', rawHTM) - 1);
      masina.spalva := Copy(rawHTM, pos('Spalva:</th><td><strong>', rawHTM) + length('Spalva:</th><td><strong>'),
        pos('</strong>', rawHTM) - pos('Spalva:</th><td><strong>', rawHTM) - length('Spalva:</th><td><strong>'));
    end;
    if pos('Kėbulo tipas:</th><td><strong>', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Kėbulo tipas:</th><td><strong>', rawHTM) - 1);
      masina.kebulo_tipas := Copy(rawHTM, pos('Kėbulo tipas:</th><td><strong>', rawHTM) + length('Kėbulo tipas:</th><td><strong>'),
        pos('</strong>', rawHTM) - pos('Kėbulo tipas:</th><td><strong>', rawHTM) - length('Kėbulo tipas:</th><td><strong>'));
    end;
    if pos('Durų skaičius:</th><td><strong>', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Durų skaičius:</th><td><strong>', rawHTM) - 1);
      masina.duru_skaicius := Copy(rawHTM, pos('Durų skaičius:</th><td><strong>', rawHTM) + length('Durų skaičius:</th><td><strong>'),
        pos('</strong>', rawHTM) - pos('Durų skaičius:</th><td><strong>', rawHTM) - length('Durų skaičius:</th><td><strong>'));
    end;
    if pos('Pavarų dėžės tipas:</th><td><strong>', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Pavarų dėžės tipas:</th><td><strong>', rawHTM) - 1);
      masina.Pavaru_dezes_tipas := Copy(rawHTM, pos('Pavarų dėžės tipas:</th><td><strong>', rawHTM) +
        length('Pavarų dėžės tipas:</th><td><strong>'), pos('</strong>', rawHTM) - pos('Pavarų dėžės tipas:</th><td><strong>', rawHTM) -
        length('Pavarų dėžės tipas:</th><td><strong>'));
    end;
    if pos('Daužta tr. priemonė:</th><td><strong>', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Daužta tr. priemonė:</th><td><strong>', rawHTM) - 1);
      masina.dauzta := Copy(rawHTM, pos('Daužta tr. priemonė:</th><td><strong>', rawHTM) + length('Daužta tr. priemonė:</th><td><strong>'),
        pos('</strong>', rawHTM) - pos('Daužta tr. priemonė:</th><td><strong>', rawHTM) - length('Daužta tr. priemonė:</th><td><strong>'));
    end;
    if pos('Vairas:</th><td><strong>', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Vairas:</th><td><strong>', rawHTM) - 1);
      masina.vairo_padetis := Copy(rawHTM, pos('Vairas:</th><td><strong>', rawHTM) + length('Vairas:</th><td><strong>'),
        pos('</strong>', rawHTM) - pos('Vairas:</th><td><strong>', rawHTM) - length('Vairas:</th><td><strong>'));
    end;
    if pos('Neeksploatuota Lietuvoje', rawHTM) > 0 then
    begin
      masina.lietuvoje_eksplotuota := true;
    end;
    result := true;
  finally
    DeleteFile(TmpFileNameMarkes);
    Screen.Cursor := crDefault;
  end;
end;

function ParseAutogidasAdvert(webpage: string; var masina: Adv_record): boolean;
var
  TmpFileNameMarkes: TFileName;
  sl: TStringList;
  rawHTM, temp: string;
  pic: TPicture;
  AEncoding: TEncoding;
  i: integer;
begin
  try
    TmpFileNameMarkes := TempFileName;
    Screen.Cursor := crHourGlass;
    if NOT Download_HTM(webpage, TmpFileNameMarkes) then
    begin
      result := false;
      Exit;
    end;
    masina.puslapis := webpage;
    sl := TStringList.Create;
    AEncoding := TEncoding.UTF8;
    sl.LoadFromFile(TmpFileNameMarkes, AEncoding);
    rawHTM := '';
    for i := 0 to sl.Count - 1 do
    begin
      rawHTM := Concat(rawHTM, sl[i]);
    end;
    sl.Free;
    if pos('return autogidas.window.navigateToParent(this.href)', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('return autogidas.window.navigateToParent(this.href)', rawHTM) +
        length('return autogidas.window.navigateToParent(this.href)'));
    end
    else
    begin
      result := false;
      Exit;
    end;
    masina.marke := Copy(rawHTM, pos('>', rawHTM) + 1, pos('<', rawHTM) - pos('>', rawHTM) - 1);
    Delete(rawHTM, 1, pos('</a>', rawHTM) + 3);
    Delete(rawHTM, 1, pos('>', rawHTM) - 1);
    masina.modelis := Copy(rawHTM, pos('>', rawHTM) + 1, pos('<', rawHTM) - pos('>', rawHTM) - 1);
    if pos('m.', rawHTM) > 0 then
    begin
      masina.pagaminimo_data := Copy(rawHTM, pos('m. ', rawHTM) - 4, 4);
      if pos('/', masina.pagaminimo_data) > 0 then
        masina.pagaminimo_data := Copy(Copy(rawHTM, pos('m. ', rawHTM) - 7, 7), 1, 4);
      if (masina.pagaminimo_data[1] <> '1') and (masina.pagaminimo_data[1] <> '2') then
      begin
        masina.pagaminimo_data := '';
      end;
    end;
    if (pos('Kaina:</span>', rawHTM) > 0) and (pos('Sutartinė', rawHTM) = 0) then
    begin
      masina.kaina := Copy(rawHTM, pos('Kaina:</span>', rawHTM) + 13, pos('Lt', rawHTM) - pos('Kaina:</span>', rawHTM) - 13);
    end;
    Delete(rawHTM, 1, pos('id="imn', rawHTM) + 7);
    masina.skelbimo_id := Copy(rawHTM, 1, pos('"', rawHTM) - 1);
    if (pos('Darbinis tūris l.:', rawHTM) > 0) then
    begin
      Delete(rawHTM, 1, pos('Darbinis tūris l.:', rawHTM) - 1);
      masina.turis := StringReplace(Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3), '.', ',',
        [rfReplaceAll]);
      if masina.turis = '-' then
        masina.turis := ''
      else
      begin
        if pos(',', masina.turis) > 0 then
          DecimalSeparator := ','
        else
          DecimalSeparator := '.';
        masina.turis := floatToStr(StrToFloat(masina.turis) * 1000)
      end;
    end;
    if pos('Kuro tipas', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Kuro tipas', rawHTM) - 1);
      masina.kuro_tipas := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
      if pos(#9, masina.kuro_tipas) > 0 then
      begin
        masina.kuro_tipas := Copy(masina.kuro_tipas, 1, pos(#9, masina.kuro_tipas) - 1);
      end;
      if pos('<td>', masina.kuro_tipas) > 0 then
        masina.kuro_tipas := Copy(masina.kuro_tipas, pos('<td>', masina.kuro_tipas) + 4, pos('</td>', masina.kuro_tipas) - pos('<td>',
          masina.kuro_tipas) - 4);
    end;
    if pos('Pavarų dėžė:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Pavarų dėžė:', rawHTM) - 1);
      masina.Pavaru_dezes_tipas := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
      if masina.Pavaru_dezes_tipas = 'pusautomatis' then
        masina.Pavaru_dezes_tipas := 'Pusiau automatinė';
    end;
    if pos('Durų skaičius:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Durų skaičius:', rawHTM) - 1);
      masina.duru_skaicius := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
    end;
    if pos('Kėbulo tipas:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Kėbulo tipas:', rawHTM) - 1);
      masina.kebulo_tipas := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
      if masina.kebulo_tipas = 'Chečbekas' then
        masina.kebulo_tipas := 'Hečbekas'
      else if masina.kebulo_tipas = 'Coupe' then
        masina.kebulo_tipas := 'Kupė';
    end;
    if pos('Vairo padėtis:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Vairo padėtis:', rawHTM) - 1);
      masina.vairo_padetis := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
    end;
    if pos('Rida, km:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Rida, km:', rawHTM) - 1);
      masina.rida := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
    end;
    if pos('Spalva: ', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Spalva: ', rawHTM) - 1);
      masina.spalva := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
    end;
    if pos('Galia kW: ', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Galia kW: ', rawHTM) - 1);
      masina.galia := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
    end;

    if pos('Daužtas', rawHTM) > 0 then
    begin
      masina.dauzta := 'Daužta';
    end
    else
    begin
      masina.dauzta := 'Nedaužta';
    end;
    if pos('Lietuvoje neeksploatuotas', rawHTM) > 0 then
    begin
      masina.lietuvoje_eksplotuota := true;
    end;
    if pos('Vardas:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Vardas:', rawHTM) - 1);
      masina.vardas := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
    end;
    if pos('Kontaktinis telefonas:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Kontaktinis telefonas:', rawHTM) - 1);
      masina.telefonas := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
      { if masina.telefonas <> '' then
        with TDownLoadURL.Create(nil) do
        try
        URL := masina.telefonas;
        FileName := 'c:\telefonas.jpg';
        ExecuteTarget(nil);
        finally
        Free;
        end;
        autogidasTelJpgToStrReadDatafile;
        pic := TPicture.Create;
        pic.LoadFromFile('c:\telefonas.jpg');
        masina.telefonas := autogidasTelJpgToStr(pic);
        pic.Free; }
    end;
    if pos('Miestas:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Miestas:', rawHTM) - 1);
      masina.miestas := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
    end;
    if pos('Šalis:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Šalis:', rawHTM) - 1);
      masina.salis := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
    end;
    if pos('Atnaujinimo data:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Atnaujinimo data:', rawHTM) + -1);
      masina.atnaujinimo_data := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
    end;
    if pos('Patalpintas:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Patalpintas:', rawHTM) + -1);
      masina.skelbimo_data := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
    end;
    result := true;
  finally
    DeleteFile(TmpFileNameMarkes);
    Screen.Cursor := crDefault;
  end;
end;

function ParseAutogidasAdvertExt(webpage: string; var masina: Adv_record): boolean;
Var
  HTTP1: TIdHTTP;
  AdvertCardParser: TDIHtmlParser;
  HTMLStream: TMemoryStream;
  AString: String;
begin
  try
    result := false;
    HTTP1 := TIdHTTP.Create();
    HTTP1.HandleRedirects := true;
    HTMLStream := TMemoryStream.Create;

    HTTP1.Get(webpage, HTMLStream);
    HTMLStream.Position := 0;

    AdvertCardParser := TDIHtmlParser.Create(nil);

    RegisterHtmlTags;
    RegisterHtmlAttribs;
    RegisterHtmlDecodingEntities;

    AdvertCardParser.SourceStream := HTMLStream;
    AdvertCardParser.ReadMethods := Read_UTF_8;

    { Show HTML tags and text }
    AdvertCardParser.FilterHtmlTags.SetStartEnd(fiShow);
    AdvertCardParser.FilterText := fiShow;

    { Show HTML tags and text }
    AdvertCardParser.FilterHtmlTags.SetStartEnd(fiShow);
    AdvertCardParser.FilterText := fiShow;

    masina.puslapis := webpage;

    while AdvertCardParser.ParseNextPiece do
      case AdvertCardParser.PieceType of
        // What type of HTML piece did the parser find?
        ptHtmlTag: // Found a tag.
          case AdvertCardParser.HtmlTag.TagID of
            TAG_DIV_ID: // Found a DIV tag.
              begin
                case AdvertCardParser.HtmlTag.TagType of
                  ttStartTag:
                    begin
                      { div id="breadcrumb" }
                      if StrSameIW(AdvertCardParser.HtmlTag.ValueOfNameCI['id'], 'breadcrumb') then
                      begin
                        AdvertCardParser.ParseNextPiece;
                        AdvertCardParser.ParseNextPiece;
                        AdvertCardParser.ParseNextPiece;
                        AdvertCardParser.ParseNextPiece;
                        AdvertCardParser.ParseNextPiece;
                        AdvertCardParser.ParseNextPiece;
                        AdvertCardParser.ParseNextPiece;
                        AdvertCardParser.ParseNextPiece;
                        if (AdvertCardParser.PieceType = ptText) and (trim(AdvertCardParser.DataAsStr) = '»') then
                        begin
                          AdvertCardParser.ParseNextPiece;
                          AdvertCardParser.ParseNextPiece;
                          masina.marke := trim(AdvertCardParser.DataAsStr);

                          AdvertCardParser.ParseNextPiece;
                          AdvertCardParser.ParseNextPiece;
                          if (AdvertCardParser.PieceType = ptText) and (trim(AdvertCardParser.DataAsStr) = '»') then
                          begin
                            AdvertCardParser.ParseNextPiece;
                            AdvertCardParser.ParseNextPiece;
                            masina.modelis := trim(AdvertCardParser.DataAsStr);
                            AdvertCardParser.ParseNextPiece;
                            AdvertCardParser.ParseNextPiece;
                            AdvertCardParser.ParseNextPiece;
                            AdvertCardParser.ParseNextPiece;
                            if AdvertCardParser.HtmlTag.TagName = 'h1' then
                            begin
                              AString := '';
                              AdvertCardParser.ParseNextPiece;
                              AString := AdvertCardParser.DataAsStr;
                              if pos('m.', AString) > 0 then
                              begin
                                masina.pagaminimo_data := Copy(AString, pos('m. ', AString) - 7, 4);
                                // if pos('/', masina.pagaminimo_data) > 0 then
                                // masina.pagaminimo_data := Copy(Copy(AString, pos('m. ', AString) - 7, 7), 1, 4);
                                if (masina.pagaminimo_data[1] <> '1') and (masina.pagaminimo_data[1] <> '2') then
                                begin
                                  masina.pagaminimo_data := '';
                                end;
                              end;
                            end;
                          end;
                        end;
                      end;
                      { class="advtools" }
                      if StrSameIW(AdvertCardParser.HtmlTag.ValueOfNameCI['class'], 'advtools') then
                      begin
                        AdvertCardParser.ParseNextPiece;
                        AdvertCardParser.ParseNextPiece;
                        AString := AdvertCardParser.DataAsStr;
                        Delete(AString, 1, 3);
                        masina.skelbimo_id := AString;
                      end;

                      { <div id="sklk"> }
                      if StrSameIW(AdvertCardParser.HtmlTag.ValueOfNameCI['id'], 'sklk') then
                      begin
                        while AdvertCardParser.ParseNextPiece do
                          case AdvertCardParser.PieceType of
                            ptHtmlTag: // Found a tag.
                              case AdvertCardParser.HtmlTag.TagID of
                                TAG_DIV_ID: // Found a DIV tag.
                                  case AdvertCardParser.HtmlTag.TagType of
                                    ttStartTag:
                                      begin
                                        { <div id="adprice"> }
                                        if StrSameIW(AdvertCardParser.HtmlTag.ValueOfNameCI['id'], 'adprice') then
                                        begin
                                          AdvertCardParser.ParseNextPiece;
                                          AdvertCardParser.ParseNextPiece;
                                          AString := '';
                                          AString := AdvertCardParser.DataAsStr;
                                          if (pos('Kaina:', AString) > 0) then
                                          begin
                                            Delete(AString, 1, 7);
                                            if (pos('Lt', AString) > 0) then
                                            begin
                                              Delete(AString, pos('Lt', AString), 2);
                                              if trim(AString) <> '-' then
                                                masina.kaina := trim(AString);
                                            end;
                                          end;
                                        end;
                                        { div class="orli" }
                                        if StrSameIW(AdvertCardParser.HtmlTag.ValueOfNameCI['class'], 'orli') then
                                        begin
                                          while AdvertCardParser.ParseNextPiece do
                                            case AdvertCardParser.PieceType of
                                              ptText:
                                                begin

                                                  { 'Darbinis tūris l.: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Darbinis tūris l.:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AString := trim(AdvertCardParser.DataAsStr);
                                                    if pos(DecimalSeparator, AString) > 0 then
                                                      masina.turis := floatToStr(StrToFloat(AString) * 1000)
                                                    else
                                                    begin
                                                      try
                                                        if pos('.', AString) > 0 then
                                                          AString := StringReplace(AString, '.', DecimalSeparator, [rfIgnoreCase])
                                                        else if pos(',', AString) > 0 then
                                                          AString := StringReplace(AString, ',', DecimalSeparator, [rfIgnoreCase])
                                                        else
                                                          AString := '';
                                                        if AString <> '' then
                                                          masina.turis := floatToStr(StrToFloat(AString) * 1000);
                                                      except
                                                        masina.turis := '';
                                                      end;
                                                    end;
                                                    // For TEST
                                                    // ShowMessage(masina.turis);
                                                  end;

                                                  { 'Kuro tipas: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Kuro tipas:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    masina.kuro_tipas := trim(AdvertCardParser.DataAsStr);
                                                    // For TEST
                                                    // ShowMessage(masina.kuro_tipas);
                                                  end;

                                                  { Pavarų dėžė: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Pavarų dėžė:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    masina.Pavaru_dezes_tipas := trim(AdvertCardParser.DataAsStr);
                                                    // For TEST
                                                    // ShowMessage(masina.Pavaru_dezes_tipas);
                                                  end;

                                                  { Durų skaičius: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Durų skaičius:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    masina.duru_skaicius := trim(AdvertCardParser.DataAsStr);
                                                    // For TEST
                                                    // ShowMessage(masina.duru_skaicius);
                                                  end;

                                                  { Kėbulo tipas: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Kėbulo tipas:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    masina.kebulo_tipas := trim(AdvertCardParser.DataAsStr);
                                                    if masina.kebulo_tipas = 'Chečbekas' then
                                                      masina.kebulo_tipas := 'Hečbekas'
                                                    else if masina.kebulo_tipas = 'Coupe' then
                                                      masina.kebulo_tipas := 'Kupė';
                                                    // For TEST
                                                    // ShowMessage(masina.kebulo_tipas);
                                                  end;

                                                  { Vairo padėtis: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Vairo padėtis:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    masina.vairo_padetis := trim(AdvertCardParser.DataAsStr);
                                                    // For TEST
                                                    // ShowMessage(masina.vairo_padetis);
                                                  end;

                                                  { Daužta tr. priemonė: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Daužta tr. priemonė:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    if trim(AdvertCardParser.DataAsStr) = 'Ne' then
                                                      masina.dauzta := 'Nedaužta';
                                                    if trim(AdvertCardParser.DataAsStr) = 'Taip' then
                                                      masina.dauzta := 'Daužta';
                                                    // For TEST
                                                    // ShowMessage(masina.dauzta);
                                                  end;

                                                  { Rida, km: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Rida, km:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    masina.rida := trim(AdvertCardParser.DataAsStr);
                                                    // For TEST
                                                    // ShowMessage(masina.rida);
                                                  end;

                                                  { Spalva: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Spalva:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    masina.spalva := trim(AdvertCardParser.DataAsStr);
                                                    // For TEST
                                                    // ShowMessage(masina.spalva);
                                                  end;

                                                  { Galia kW: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Galia kW:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    masina.galia := trim(AdvertCardParser.DataAsStr);
                                                    // For TEST
                                                    // ShowMessage(masina.galia);
                                                  end;

                                                  { Vardas: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Vardas:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    masina.vardas := trim(AdvertCardParser.DataAsStr);
                                                    // For TEST
                                                    // ShowMessage(masina.vardas);
                                                  end;

                                                  { Kontaktinis telefonas: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Kontaktinis telefonas:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    masina.telefonas := trim(AdvertCardParser.DataAsStr);
                                                    // For TEST
                                                    // ShowMessage(masina.telefonas);
                                                  end;

                                                  { Miestas: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Miestas:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    masina.miestas := trim(AdvertCardParser.DataAsStr);
                                                    // For TEST
                                                    // ShowMessage(masina.miestas);
                                                  end;

                                                  { Šalis: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Šalis:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    masina.salis := trim(AdvertCardParser.DataAsStr);
                                                    // For TEST
                                                    // ShowMessage(masina.salis);
                                                  end;

                                                  { Atnaujinimo data: }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Atnaujinimo data:' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    masina.atnaujinimo_data := trim(AdvertCardParser.DataAsStr);
                                                    // For TEST
                                                    // ShowMessage(masina.atnaujinimo_data);
                                                  end;

                                                  { Patalpintas į }
                                                  if trim(AdvertCardParser.DataAsStr) = 'Patalpintas į' then
                                                  begin
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    AdvertCardParser.ParseNextPiece;
                                                    masina.skelbimo_data := trim(AdvertCardParser.DataAsStr);
                                                    // For TEST
                                                    // ShowMessage(masina.skelbimo_data);
                                                  end;
                                                end;
                                            end;
                                        end;
                                      end;
                                  end;
                              end;
                          end;
                      end;
                    end;
                end;
              end;
          end;
      end;

    { Prevent of mandatory fields }
    if (masina.marke = '') or (masina.modelis = '') then
      Exit;

    result := true;
  finally
    HTTP1.Free;
    HTMLStream.Free;
    AdvertCardParser.Free;
  end;
end;

function ParseBRCAdvert(webpage: string; var masina: Adv_record): boolean;
var
  TmpFileNameMarkes: TFileName;
  sl: TStringList;
  rawHTM, temp: string;
  AEncoding: TEncoding;
  i: integer;
begin
  try
    TmpFileNameMarkes := TempFileName;
    Screen.Cursor := crHourGlass;
    if NOT Download_HTM(webpage, TmpFileNameMarkes) then
    begin
      result := false;
      Exit;
    end;
    masina.puslapis := webpage;
    sl := TStringList.Create;
    AEncoding := TEncoding.GetEncoding(1257);
    sl.LoadFromFile(TmpFileNameMarkes, AEncoding);
    rawHTM := '';
    for i := 0 to sl.Count - 1 do
    begin
      rawHTM := Concat(rawHTM, sl[i]);
    end;
    sl.Free;

    masina.skelbimo_id := Copy(webpage, pos('id=', webpage) + 3, length(webpage) - pos('id=', webpage) - 2);
    Delete(rawHTM, 1, pos('<title>BRC Autocentras //', rawHTM) + length('<title>BRC Autocentras //'));
    masina.marke := Copy(rawHTM, 1, pos('</title>', rawHTM) - 1);
    masina.modelis := Copy(masina.marke, pos(' ', masina.marke) + 1, length(masina.marke));
    masina.marke := Copy(masina.marke, 1, pos(' ', masina.marke) - 1);
    masina.modelis := Copy(masina.modelis, 1, pos(' ', masina.modelis) - 1);
    if (pos('Kaina:', rawHTM) > 0) then
    begin
      Delete(rawHTM, 1, pos('Kaina:', rawHTM) - 1);
      masina.kaina := Copy(rawHTM, pos('<span>', rawHTM) + 6, pos('</span>', rawHTM) - pos('<span>', rawHTM) - 6);
      if (pos('<del>', masina.kaina) > 0) then
      begin
        masina.kaina := Copy(masina.kaina, pos('<del>', masina.kaina) + 5, length(masina.kaina) - 5);
      end;
      if (pos('</del>', masina.kaina) > 0) then
      begin
        masina.kaina := Copy(masina.kaina, 1, pos('</del>', masina.kaina) - 1);
      end;
      if (pos('<font color="#0033ff"><blink>', masina.kaina) > 0) then
      begin
        masina.kaina := Copy(masina.kaina, pos('<blink>', masina.kaina) + 7, length(masina.kaina) - pos('<blink>', masina.kaina) - 7);
      end;
    end;
    if pos('Metai:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Metai:', rawHTM) - 1);
      Delete(rawHTM, 1, pos('"ar">', rawHTM) - 1);
      masina.pagaminimo_data := Copy(rawHTM, pos('"ar">', rawHTM) + 8, pos('</td>', rawHTM) - pos('"ar">', rawHTM) - 8);
    end;
    if pos('Spalva:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Spalva:', rawHTM) - 1);
      Delete(rawHTM, 1, pos('"ar">', rawHTM) - 1);
      masina.spalva := Copy(rawHTM, pos('"ar">', rawHTM) + 5, pos('</td>', rawHTM) - pos('"ar">', rawHTM) - 5);
    end;
    if pos('Kėbulo tipas:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Kėbulo tipas:', rawHTM) - 1);
      Delete(rawHTM, 1, pos('"ar">', rawHTM) - 1);
      masina.kebulo_tipas := Copy(rawHTM, pos('"ar">', rawHTM) + 5, pos('</td>', rawHTM) - pos('"ar">', rawHTM) - 5);
    end;
    if pos('Rida:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Rida:', rawHTM) - 1);
      Delete(rawHTM, 1, pos('"ar">', rawHTM) - 1);
      masina.rida := Copy(rawHTM, pos('"ar">', rawHTM) + 5, pos('</td>', rawHTM) - pos('"ar">', rawHTM) - 5);
      if pos(' ', masina.rida) > 0 then
        masina.rida := Copy(masina.rida, 1, pos(' ', masina.rida) - 1);
    end;
    if (pos('Variklio tūris:', rawHTM) > 0) then
    begin
      Delete(rawHTM, 1, pos('Variklio tūris:', rawHTM) - 1);
      Delete(rawHTM, 1, pos('"ar">', rawHTM) - 1);
      masina.turis := StringReplace(Copy(rawHTM, pos('"ar">', rawHTM) + 5, pos('l', rawHTM) - pos('"ar">', rawHTM) - 5), '.', ',',
        [rfReplaceAll]);
      if pos(' ', masina.turis) > 0 then
        masina.turis := Copy(masina.turis, 1, pos(' ', masina.turis) - 1);
      if pos(',', masina.turis) > 0 then
        DecimalSeparator := ','
      else
        DecimalSeparator := '.';
      if pos('T', masina.turis) > 0 then
        masina.turis := Copy(masina.turis, 1, pos('T', masina.turis) - 1);
      masina.turis := floatToStr(StrToFloat(masina.turis) * 1000);
      masina.kuro_tipas := Copy(rawHTM, pos('l', rawHTM) + 2, pos('</td', rawHTM) - pos('l', rawHTM) - 2);
      if masina.kuro_tipas = 'Benzinas + Dujos' then
        masina.kuro_tipas := 'Benzinas/Dujos';
      if masina.kuro_tipas = 'Benzinas + Elektra' then
        masina.kuro_tipas := 'Benzinas/Elektra';
    end;
    if pos('Galia:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Galia:', rawHTM) - 1);
      Delete(rawHTM, 1, pos('"ar">', rawHTM) - 1);
      masina.galia := Copy(rawHTM, pos('"ar">', rawHTM) + 5, pos(' kW', rawHTM) - pos('"ar">', rawHTM) - 5);
    end;
    if pos('Greičių dėžė:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Greičių dėžė:', rawHTM) - 1);
      Delete(rawHTM, 1, pos('"ar">', rawHTM) - 1);
      masina.Pavaru_dezes_tipas := Copy(rawHTM, pos('"ar">', rawHTM) + 5, pos('</td>', rawHTM) - pos('"ar">', rawHTM) - 5)
    end;
    masina.vairo_padetis := 'Kairėje';
    masina.dauzta := 'Nedaužta';

    if pos('Vardas:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Vardas:', rawHTM) - 1);
      masina.vardas := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
    end;

    if pos('Patalpintas:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Patalpintas:', rawHTM) + -1);
      masina.skelbimo_data := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
    end;
    result := true;
  finally
    DeleteFile(TmpFileNameMarkes);
    Screen.Cursor := crDefault;
  end;
end;

function ParseMobileAdvert(webpage: string; var masina: Adv_record): boolean;
var
  webpageTemp: string;
  TmpFileNameMarkes: TFileName;
  sl: TStringList;
  rawHTM, temp: string;
  AEncoding: TEncoding;
  i: integer;
begin
  try
    masina.puslapis := webpage;
    masina.skelbimo_id := Copy(webpage, pos('id=', webpage) + 3, length(webpage) - pos('id=', webpage) - 2);

    webpageTemp := PwideChar('http://suchen.mobile.de/fahrzeuge/details.html?lang=en&id=' + masina.skelbimo_id +
      '&pageNumber=1&tabNumber=3');
    // Log.Lines.Add(DateTimeToStr(Now) + ' ' + webpageTemp);
    TmpFileNameMarkes := TempFileName;
    Screen.Cursor := crHourGlass;
    if NOT Download_HTM(webpageTemp, TmpFileNameMarkes) then
    begin
      result := false;
      Exit;
    end;
    sl := TStringList.Create;
    AEncoding := TEncoding.UTF8;
    sl.LoadFromFile(TmpFileNameMarkes, AEncoding);
    rawHTM := '';
    for i := 0 to sl.Count - 1 do
    begin
      rawHTM := Concat(rawHTM, sl[i]);
    end;
    sl.Free;

    Delete(rawHTM, 1, pos('"keywords" content="', rawHTM) - 1);
    masina.marke := Copy(rawHTM, pos('"keywords" content="', rawHTM) + 20, pos('" />', rawHTM) - pos('"keywords" content="', rawHTM) - 20);
    masina.modelis := Copy(masina.marke, pos(' ', masina.marke) + 1, length(masina.marke));
    masina.modelis := Copy(masina.modelis, 1, pos(' ', masina.modelis) - 1);
    masina.marke := Copy(masina.marke, 1, pos(' ', masina.marke) - 1);
    if (pos('Price:', rawHTM) > 0) then
    begin
      Delete(rawHTM, 1, pos('Price:', rawHTM) - 1);
      masina.kaina := Copy(rawHTM, pos('<span class="priceBlackBold">', rawHTM) + 29,
        pos('EUR', rawHTM) - pos('<span class="priceBlackBold">', rawHTM) - 29);
      masina.kaina := StringReplace(masina.kaina, ',', '', [rfReplaceAll]);
    end;
    if pos('Mileage:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Mileage:', rawHTM) - 1);
      masina.rida := Copy(rawHTM, pos('<strong>', rawHTM) + 8, pos('</strong>', rawHTM) - pos('<strong>', rawHTM) - 8);
      masina.rida := Copy(masina.rida, 1, pos('&', masina.rida) - 1);
      masina.rida := StringReplace(masina.rida, ',', '', [rfReplaceAll]);
    end;
    if (pos('Cubic Capacity:', rawHTM) > 0) then
    begin
      Delete(rawHTM, 1, pos('Cubic Capacity:', rawHTM) - 1);
      masina.turis := Copy(rawHTM, pos('<strong>', rawHTM) + 8, pos('cm', rawHTM) - pos('<strong>', rawHTM) - 8);
    end;
    if pos('Power:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Power:', rawHTM) - 1);
      masina.galia := Copy(rawHTM, pos('<strong>', rawHTM) + 8, pos('</strong>', rawHTM) - pos('<strong>', rawHTM) - 8);
      masina.galia := Copy(masina.galia, 1, pos('kW', masina.galia) - 2);
    end;
    if pos('Fuel Type:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Fuel Type:', rawHTM) - 1);
      masina.kuro_tipas := Copy(rawHTM, pos('<strong>', rawHTM) + 8, pos('</strong>', rawHTM) - pos('<strong>', rawHTM) - 8);
      masina.kuro_tipas := StringReplace(masina.kuro_tipas, #9, '', [rfReplaceAll]);
      if masina.kuro_tipas = 'Petrol' then
        masina.kuro_tipas := 'Benzinas'
      else if masina.kuro_tipas = 'Petrol' then
        masina.kuro_tipas := 'Dyzelinas'
      else if masina.kuro_tipas = 'Diesel' then
        masina.kuro_tipas := 'Dyzelinas';
    end;
    if pos('Door Count:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Door Count:', rawHTM) - 1);
      masina.duru_skaicius := Copy(rawHTM, pos('<strong>', rawHTM) + 8, pos('</strong>', rawHTM) - pos('<strong>', rawHTM) - 8);
      masina.duru_skaicius := Copy(masina.duru_skaicius, 1, pos(' ', masina.duru_skaicius) - 1);
    end;
    if pos('Gearbox:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Gearbox:', rawHTM) - 1);
      masina.Pavaru_dezes_tipas := Copy(rawHTM, pos('<strong>', rawHTM) + 8, pos('</strong>', rawHTM) - pos('<strong>', rawHTM) - 8);
      if masina.Pavaru_dezes_tipas = 'Manual gearbox' then
        masina.Pavaru_dezes_tipas := 'Mechaninė'
      else if masina.Pavaru_dezes_tipas = 'Automatic transmission' then
        masina.Pavaru_dezes_tipas := 'Automatinė';
    end;
    if pos('First Registration:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('First Registration:', rawHTM) - 1);
      masina.pagaminimo_data := Copy(rawHTM, pos('<strong>', rawHTM) + 8, pos('</strong>', rawHTM) - pos('<strong>', rawHTM) - 8);
      masina.pagaminimo_data := StringReplace(masina.pagaminimo_data, #9, '', [rfReplaceAll]);
      masina.pagaminimo_data := Copy(masina.pagaminimo_data, 4, 4);
    end;
    if pos('Colour:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Colour:', rawHTM) - 1);
      masina.spalva := Copy(rawHTM, pos('<strong>', rawHTM) + 8, pos('</strong>', rawHTM) - pos('<strong>', rawHTM) - 8);
    end;
    {

      if Pos('Kėbulo tipas:', rawHTM) > 0 then
      begin
      Delete(rawHTM, 1, Pos('Kėbulo tipas:', rawHTM) - 1);
      masina.kebulo_tipas := Copy(rawHTM, Pos('<strong>', rawHTM) + 8,
      Pos('</strong>', rawHTM) - Pos('<strong>', rawHTM) - 8);
      end;
      if Pos('Vairo padėtis:', rawHTM) > 0 then
      begin
      Delete(rawHTM, 1, Pos('Vairo padėtis:', rawHTM) - 1);
      masina.vairo_padetis := Copy(rawHTM, Pos('<strong>', rawHTM) + 8,
      Pos('</strong>', rawHTM) - Pos('<strong>', rawHTM) - 8);
      end;
    }

    if NOT Download_HTM(masina.puslapis, TmpFileNameMarkes) then
    begin
      result := false;
      Exit;
    end;
    sl := TStringList.Create;
    AEncoding := TEncoding.UTF8;
    sl.LoadFromFile(TmpFileNameMarkes, AEncoding);
    rawHTM := '';
    for i := 0 to sl.Count - 1 do
    begin
      rawHTM := Concat(rawHTM, sl[i]);
    end;
    sl.Free;
    DeleteFile(TmpFileNameMarkes);

    if pos('Private Seller', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Private Seller', rawHTM) - 1);
      masina.vardas := Copy(rawHTM, pos('<br />', rawHTM) + 6, pos('<div', rawHTM) - pos('<br />', rawHTM) - 6);
      if pos('Miestas:', rawHTM) > 0 then
      begin
        Delete(rawHTM, 1, pos('Miestas:', rawHTM) - 1);
        masina.miestas := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
      end;
    end;
    if pos('<h3>Dealer</h3>', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('<h3>Dealer</h3>', rawHTM) - 1);
      masina.vardas := Copy(rawHTM, pos('<br />', rawHTM) + 6, pos('<div', rawHTM) - pos('<br />', rawHTM) - 6);
    end;
    if pos('Phone', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Phone', rawHTM) - 1);
      masina.telefonas := Copy(rawHTM, pos('Phone', rawHTM) + 7, pos('<br />', rawHTM) - pos('Phone', rawHTM) - 7);
    end;
    if pos('Atnaujinimo data:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Atnaujinimo data:', rawHTM) + -1);
      masina.atnaujinimo_data := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
    end;
    if pos('Patalpintas:', rawHTM) > 0 then
    begin
      Delete(rawHTM, 1, pos('Patalpintas:', rawHTM) + -1);
      masina.skelbimo_data := Copy(rawHTM, pos('<b>', rawHTM) + 3, pos('</b>', rawHTM) - pos('<b>', rawHTM) - 3);
    end;
    result := true;
  finally
    DeleteFile(TmpFileNameMarkes);
    Screen.Cursor := crDefault;
  end;
end;

function AdvertExists(tipas: integer; webpage: string): boolean;
var
  TmpFileNameMarkes: TFileName;
  sl: TStringList;
  rawHTM, temp, DataBuf: string;
  AEncoding: TEncoding;
  i: integer;
begin
  try
    TmpFileNameMarkes := TempFileName;
    Screen.Cursor := crHourGlass;
    result := true;
    if Download_HTM(webpage, TmpFileNameMarkes) then
    begin
      case tipas of
        2:
          // autogide pasibaigusio skelbimo puslapis egzistuoja, autopliuse, ne
          begin
            sl := TStringList.Create;
            DataBuf := '';
            rawHTM := '';
            AEncoding := TEncoding.UTF8;
            sl.LoadFromFile(TmpFileNameMarkes, AEncoding);
            for i := 0 to sl.Count - 1 do
            begin
              if (pos('"/images/inactive_lt.gif"', sl[i]) > 0) or (pos('puslapis nerastas', sl[i]) > 0) then
              begin
                result := false;
                Break;
              end;
            end;
            sl.Free;
          end;
        4:
          begin
            sl := TStringList.Create;
            DataBuf := '';
            rawHTM := '';
            AEncoding := TEncoding.GetEncoding(1257);
            sl.LoadFromFile(TmpFileNameMarkes, AEncoding);
            for i := 0 to sl.Count - 1 do
            begin
              rawHTM := Concat(rawHTM, sl[i]);
            end;
            if pos(webpage, rawHTM) = 0 then
            begin
              result := false;
            end;
            sl.Free;
          end;
      end;
    end
    else
    begin
      result := false;
    end;
  finally
    DeleteFile(TmpFileNameMarkes);
    Screen.Cursor := crDefault;
  end;
end;

procedure TLoadAdvertisementsForm.UpdateOld(tipas: integer);
begin
  try
    Screen.Cursor := crHourGlass;
    Log.Lines.Add(DateTimeToStr(Now) + ' Seni skelbimai:');
    AdvertisementsDataSet.Active := false;
    AdvertisementsDataSet.sql.text := 'select * from "ADVERTISEMENTS" where "WEBSITE_ID"=' + inttostr(tipas) +
      ' and "ENDED"=false and "DATE"<:Date order by "DATE"';
    AdvertisementsDataSet.ParamByName('Date').DataType := ftDate;
    AdvertisementsDataSet.ParamByName('Date').AsDate := today;
    AdvertisementsDataSet.Active := true;
    while not(AdvertisementsDataSet.EOF) do
    begin
      Application.ProcessMessages;
      if Finish then
        Exit;
      Sleep(500);
      Log.Lines.Add(DateTimeToStr(Now) + ' ' + AdvertisementsDataSetWEBPAGE.Value);
      if not(AdvertExists(tipas, AdvertisementsDataSetWEBPAGE.Value)) then
      begin
        AdvertisementsDataSet.edit;
        AdvertisementsDataSetENDED.Value := true;
        AdvertisementsDataSet.post;
        Log.Lines.Strings[Log.Lines.Count - 1] := Log.Lines.Strings[Log.Lines.Count - 1] + '. Pasibaigęs';
      end
      else
      begin
        AdvertisementsDataSet.edit;
        AdvertisementsDataSetDATE.AsDateTime := Now;
        AdvertisementsDataSet.post;
      end;
      AdvertisementsDataSet.Next;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TLoadAdvertisementsForm.SaveAdvert(tipas: integer; masina: Adv_record);
var
  CarMakeID: integer;
  FormatSettings: TFormatSettings;
begin
  try
    Application.ProcessMessages;
    if Finish then
      Exit;
    if (trim(masina.marke) <> '') and (masina.skelbimo_id <> '/></a>') then
    begin
      if masina.skelbimo_id <> '' then
      begin
        if pos(#34, masina.skelbimo_id) > 0 then
        begin
          Delete(masina.skelbimo_id, pos(#34, masina.skelbimo_id), 1);
        end;

        AdvertisementsDataSet.Active := false;
        AdvertisementsDataSet.sql.text := 'select * from "ADVERTISEMENTS" where "WEBSITE_ID"=' + inttostr(tipas) + ' and "ADVERTISEMENTID"='
          + masina.skelbimo_id;
        AdvertisementsDataSet.Active := true;
      end;
      AdvertisementsDataSet.FetchAll;
      if (trim(masina.marke) <> '') and (AdvertisementsDataSet.RecordCount = 0) then
        AdvertisementsDataSet.Insert
      else
        AdvertisementsDataSet.edit;
      AdvertisementsDataSetWEBSITE_ID.Value := tipas;
      if masina.skelbimo_id <> '' then
        AdvertisementsDataSetADVERTISEMENTID.Value := strtoint(trim(masina.skelbimo_id));
      CarMakesDataSet.Active := true;
      if masina.marke <> '' then
      begin
        if not(CarMakesDataSet.Locate('MAKE', masina.marke, [loCaseInsensitive])) then
        begin
          if not(CarMakeMapping.Locate('MAKE', masina.marke, [loCaseInsensitive])) then
          begin
            CarMakesDataSet.Insert;
            CarMakesDataSetMAKE.Value := masina.marke;
            CarMakesDataSet.post;
            CarMakesDataSet.Active := false;
            CarMakesDataSet.Active := true;
            CarMakesDataSet.Locate('MAKE', masina.marke, [loCaseInsensitive]);
            CarMakeID := CarMakesDataSetID.Value;
          end
          else
          begin
            CarMakeID := CarMakeMappingCARMAKE_ID.Value;
          end;
        end
        else
          CarMakeID := CarMakesDataSetID.Value;
        CarModelsDataSet.Active := true;
        if not(CarModelsDataSet.Locate('CARMAKE_ID; MODEL', VarArrayOf([CarMakeID, masina.modelis]), [loCaseInsensitive])) then
        begin
          CarModelsDataSet.Insert;
          CarModelsDataSetCARMAKE_ID.Value := CarMakeID;
          CarModelsDataSetMODEL.Value := masina.modelis;
          CarModelsDataSet.post;
          CarModelsDataSet.Active := false;
          CarModelsDataSet.Active := true;
          CarModelsDataSet.Locate('CARMAKE_ID; MODEL', VarArrayOf([CarMakeID, masina.modelis]), [loCaseInsensitive]);
        end;
        AdvertisementsDataSetCARMODEL_ID.Value := CarModelsDataSetID.Value;
      end;
      if masina.kebulo_tipas <> '' then
      begin
        BodyTypesDataSet.Active := true;
        if not(BodyTypesDataSet.Locate('TYPE', masina.kebulo_tipas, [loCaseInsensitive])) then
        begin
          BodyTypesDataSet.Insert;
          BodyTypesDataSetTYPE.Value := masina.kebulo_tipas;
          BodyTypesDataSet.post;
          BodyTypesDataSet.Active := false;
          BodyTypesDataSet.Active := true;
          BodyTypesDataSet.Locate('TYPE', masina.kebulo_tipas, [loCaseInsensitive]);
        end;
        AdvertisementsDataSetBODY_TYPE_ID.Value := BodyTypesDataSetID.Value;
      end;
      if masina.dauzta <> '' then
      begin
        DamagedDataSet.Active := true;
        if not(DamagedDataSet.Locate('DAMAGED', masina.dauzta, [loCaseInsensitive])) then
        begin
          DamagedDataSet.Insert;
          DamagedDataSetDAMAGED.Value := masina.dauzta;
          DamagedDataSet.post;
          DamagedDataSet.Active := false;
          DamagedDataSet.Active := true;
          DamagedDataSet.Locate('DAMAGED', masina.dauzta, [loCaseInsensitive]);
        end;
        AdvertisementsDataSetDAMAGED_ID.Value := DamagedDataSetID.Value;
      end;
      if masina.spalva <> '' then
      begin
        ColorsDataSet.Active := true;
        if not(ColorsDataSet.Locate('COLOR', trim(masina.spalva), [loCaseInsensitive])) then
        begin
          ColorsDataSet.Insert;
          ColorsDataSetCOLOR.Value := trim(masina.spalva);
          ColorsDataSet.post;
          ColorsDataSet.Active := false;
          ColorsDataSet.Active := true;
          ColorsDataSet.Locate('COLOR', trim(masina.spalva), [loCaseInsensitive]);
        end;
        AdvertisementsDataSetCOLOR_ID.Value := ColorsDataSetID.Value;
      end;
      if masina.kuro_tipas <> '' then
      begin
        FuelsDataSet.Active := true;
        if not(FuelsDataSet.Locate('FUEL', StringReplace(masina.kuro_tipas, ' ', '', [rfReplaceAll]), [loCaseInsensitive])) then
        begin
          FuelsDataSet.Insert;
          FuelsDataSetFUEL.Value := StringReplace(masina.kuro_tipas, ' ', '', [rfReplaceAll]);
          FuelsDataSet.post;
          FuelsDataSet.Active := false;
          FuelsDataSet.Active := true;
          FuelsDataSet.Locate('FUEL', StringReplace(masina.kuro_tipas, ' ', '', [rfReplaceAll]), [loCaseInsensitive]);
        end;
        AdvertisementsDataSetFUEL_ID.Value := FuelsDataSetID.Value;
      end;
      if masina.Pavaru_dezes_tipas <> '' then
      begin
        GearBoxDataSet.Active := true;
        if not(GearBoxDataSet.Locate('GEARBOX', masina.Pavaru_dezes_tipas, [loCaseInsensitive])) then
        begin
          GearBoxDataSet.Insert;
          GearBoxDataSetGEARBOX.Value := masina.Pavaru_dezes_tipas;
          GearBoxDataSet.post;
          GearBoxDataSet.Active := false;
          GearBoxDataSet.Active := true;
          GearBoxDataSet.Locate('GEARBOX', masina.Pavaru_dezes_tipas, [loCaseInsensitive]);
        end;
        AdvertisementsDataSetGEARBOX_ID.Value := GearBoxDataSetID.Value;
      end;
      if masina.duru_skaicius <> '' then
      begin
        DoorsDataSet.Active := true;
        if not(DoorsDataSet.Locate('DOORS', masina.duru_skaicius, [loCaseInsensitive])) then
        begin
          DoorsDataSet.Insert;
          DoorsDataSetDOORS.Value := masina.duru_skaicius;
          DoorsDataSet.post;
          DoorsDataSet.Active := false;
          DoorsDataSet.Active := true;
          DoorsDataSet.Locate('DOORS', masina.duru_skaicius, [loCaseInsensitive]);
        end;
        AdvertisementsDataSetDOORS_ID.Value := DoorsDataSetID.Value;
      end;
      if masina.vairo_padetis <> '' then
      begin
        SteeringWheelDataSet.Active := true;
        if not(SteeringWheelDataSet.Locate('WHEEL', masina.vairo_padetis, [loCaseInsensitive])) then
        begin
          SteeringWheelDataSet.Insert;
          SteeringWheelDataSetWHEEL.Value := masina.vairo_padetis;
          SteeringWheelDataSet.post;
          SteeringWheelDataSet.Active := false;
          SteeringWheelDataSet.Active := true;
          SteeringWheelDataSet.Locate('WHEEL', masina.vairo_padetis, [loCaseInsensitive]);
        end;
        AdvertisementsDataSetSTEERING_WHEEL_ID.Value := SteeringWheelDataSetID.Value;
      end;
      if masina.galia <> '' then
      begin
        PowerDataSet.Active := true;
        if not(PowerDataSet.Locate('POWER', strtoint(trim(masina.galia)), [loCaseInsensitive])) then
        begin
          PowerDataSet.Insert;
          PowerDataSetPOWER.Value := strtoint(trim(masina.galia));
          PowerDataSet.post;
          PowerDataSet.Active := false;
          PowerDataSet.Active := true;
          PowerDataSet.Locate('POWER', strtoint(trim(masina.galia)), [loCaseInsensitive]);
        end;
        AdvertisementsDataSetPOWER_KW_ID.Value := PowerDataSetID.Value;
      end;
      if masina.turis <> '' then
      begin
        EnginesDataSet.Active := true;
        if not(EnginesDataSet.Locate('ENGINE', strtoint(trim(masina.turis)), [loCaseInsensitive])) then
        begin
          EnginesDataSet.Insert;
          EnginesDataSetENGINE.Value := strtoint(trim(masina.turis));
          EnginesDataSet.post;
          EnginesDataSet.Active := false;
          EnginesDataSet.Active := true;
          EnginesDataSet.Locate('ENGINE', strtoint(trim(masina.turis)), [loCaseInsensitive]);
        end;
        AdvertisementsDataSetENGINE_ID.Value := EnginesDataSetID.Value;
      end;
      if masina.kaina <> '' then
      begin
        AdvertisementsDataSetPRICE.AsCurrency := strtoint(StringReplace(masina.kaina, ' ', '', [rfReplaceAll]));
      end;
      if masina.rida <> '' then
        if pos('km', masina.rida) > 0 then
          AdvertisementsDataSetKILOMETRAGE.Value := strtoint(Copy(masina.rida, 0, pos('km', masina.rida) - 1))
        else
          AdvertisementsDataSetKILOMETRAGE.Value := strtoint(trim(masina.rida));
      if masina.pagaminimo_data <> '' then
      begin
        masina.pagaminimo_data := trim(masina.pagaminimo_data);
        masina.pagaminimo_data := Copy(masina.pagaminimo_data, 1, 4);
        if (length(masina.pagaminimo_data) = 4) then
          AdvertisementsDataSetYEAR.Value := strtoint(masina.pagaminimo_data);
      end;
      AdvertisementsDataSetUSEDINLITHUANIA.Value := masina.lietuvoje_eksplotuota;
      // AdvertisementsDataSetmiestas.Value := masina.miestas;

      begin
        GetLocaleFormatSettings(0, FormatSettings);
        FormatSettings.DateSeparator := '-';
        FormatSettings.ShortDateFormat := 'yyyy-mm-dd';
        FormatSettings.LongDateFormat := 'yyyy-mm-dd hh:mm:ss';
        if masina.skelbimo_data <> '' then
          AdvertisementsDataSetADD_DATE.AsDateTime := StrToDate(masina.skelbimo_data, FormatSettings)
        else
          AdvertisementsDataSetADD_DATE.AsDateTime := today;
      end;

      if masina.atnaujinimo_data <> '' then
      begin
        GetLocaleFormatSettings(0, FormatSettings);
        FormatSettings.DateSeparator := '-';
        FormatSettings.ShortDateFormat := 'yyyy-mm-dd';
        FormatSettings.LongDateFormat := 'yyyy-mm-dd hh:mm:ss';
        AdvertisementsDataSetUPDATEDATE.AsDateTime := StrToDate(masina.atnaujinimo_data, FormatSettings);
      end;

      if masina.telefonas <> '' then
      begin
        if masina.telefonas[1] = '8' then
          masina.telefonas := '+370' + Copy(masina.telefonas, 2, length(masina.telefonas));
        masina.telefonas := StringReplace(masina.telefonas, ' ', '', [rfReplaceAll]);
        masina.telefonas := StringReplace(masina.telefonas, '-', '', [rfReplaceAll]);
        if masina.telefonas[1] <> '+' then
          masina.telefonas := '+' + masina.telefonas;
        SellersDataSet.Active := false;
        SellersDataSet.sql.text := 'select * from "SELLER" where "PHONE"=' + #39 + masina.telefonas + #39;
        SellersDataSet.Active := true;
        if SellersDataSet.RecordCount = 0 then
        begin
          SellersDataSet.Insert;
          SellersDataSetNAME.Value := masina.vardas;
          SellersDataSetTOWN.Value := masina.miestas;
          SellersDataSetPHONE.Value := masina.telefonas;
          SellersDataSetCOUNTRY.Value := masina.salis;
          SellersDataSet.post;
          SellersDataSet.Active := false;
          SellersDataSet.sql.text := 'select * from "SELLER" where "PHONE"=' + #39 + masina.telefonas + #39;
          SellersDataSet.Active := true;
        end
        else
        begin
          SellersDataSet.edit;
          SellersDataSetNAME.Value := masina.vardas;
          SellersDataSetTOWN.Value := masina.miestas;
          SellersDataSetPHONE.Value := masina.telefonas;
          SellersDataSetCOUNTRY.Value := masina.salis;
          SellersDataSet.post;
          AdvertisementsDataSetSELLER_ID.Value := SellersDataSetID.Value;
        end;
      end;
      AdvertisementsDataSetDATE.AsDateTime := Now;
      AdvertisementsDataSetWEBPAGE.Value := masina.puslapis;
      AdvertisementsDataSetENDED.Value := false;

      if ((AdvertisementsDataSetCARMODEL_ID.OldValue <> AdvertisementsDataSetCARMODEL_ID.Value) or
        (AdvertisementsDataSetYEAR.OldValue <> AdvertisementsDataSetYEAR.Value) or
        (AdvertisementsDataSetPRICE.OldValue <> AdvertisementsDataSetPRICE.Value) or
        (AdvertisementsDataSetFUEL_ID.OldValue <> AdvertisementsDataSetFUEL_ID.Value) or
        (AdvertisementsDataSetGEARBOX_ID.OldValue <> AdvertisementsDataSetGEARBOX_ID.Value) or
        (AdvertisementsDataSetBODY_TYPE_ID.OldValue <> AdvertisementsDataSetBODY_TYPE_ID.Value) or
        (AdvertisementsDataSetSTEERING_WHEEL_ID.OldValue <> AdvertisementsDataSetSTEERING_WHEEL_ID.Value) or
        (AdvertisementsDataSetENGINE_ID.OldValue <> AdvertisementsDataSetENGINE_ID.Value) or
        (AdvertisementsDataSetPOWER_KW_ID.OldValue <> AdvertisementsDataSetPOWER_KW_ID.Value) or
        (AdvertisementsDataSetKILOMETRAGE.OldValue <> AdvertisementsDataSetKILOMETRAGE.Value) or
        (AdvertisementsDataSetCOLOR_ID.OldValue <> AdvertisementsDataSetCOLOR_ID.Value) or
        (AdvertisementsDataSetDAMAGED_ID.OldValue <> AdvertisementsDataSetDAMAGED_ID.Value) or
        (AdvertisementsDataSetDOORS_ID.OldValue <> AdvertisementsDataSetDOORS_ID.Value) or
        (AdvertisementsDataSetSELLER_ID.OldValue <> AdvertisementsDataSetSELLER_ID.Value) or
        (AdvertisementsDataSetUSEDINLITHUANIA.OldValue <> AdvertisementsDataSetUSEDINLITHUANIA.Value)) and (masina.atnaujinimo_data = '')
      then
        AdvertisementsDataSetUPDATEDATE.AsDateTime := today;

      AdvertisementsDataSet.post;
    end;
  except
    on e: exception do
    begin

      Log.Lines.Add(DateTimeToStr(Now) + ' ' + masina.puslapis + ' ' + e.message);
    end;
  end;
end;

procedure TLoadAdvertisementsForm.Timer1Timer(Sender: TObject);
begin
  MainConnection.Connected := true;
  if MainConnection.Connected then
    Timer1.Enabled := false;
end;

function TLoadAdvertisementsForm.ParseAutopliusPage(webpage: string; var masina: array of Adv_record): boolean;
var
  TmpFileNameMarkes: TFileName;
  sl: TStringList;
  DataBuf, rawHTM, temp: string;
  iStart, iStop, Count: integer;
  martkestemp: string;
  Markes: string;
  AEncoding: TEncoding;
  i: integer;
begin
  try
    TmpFileNameMarkes := TempFileName;
    Screen.Cursor := crHourGlass;
    if NOT Download_HTM(webpage, TmpFileNameMarkes) then
    begin
      result := false;
      Exit;
    end;
    sl := TStringList.Create;
    DataBuf := '';
    rawHTM := '';
    try
      AEncoding := TEncoding.UTF8;
      sl.LoadFromFile(TmpFileNameMarkes, AEncoding);
      for i := 0 to sl.Count - 1 do
      begin
        rawHTM := Concat(rawHTM, sl[i]);
      end;
      iStart := pos('thumb reg_border fl', rawHTM) + length('paging');
      iStop := length(rawHTM);
      DataBuf := Copy(rawHTM, iStart, iStop - iStart);
      if (pos('<strong>Modelis</strong></h4><form id="makes_search_form"', rawHTM) > 0) or
        (pos('Pagal šiuos paieškos kriterijus skelbimų nerasta.', rawHTM) > 0) then
      begin
        result := false;
        Exit;
      end;
    finally
      sl.Free;
    end;
    Count := 0;
    Delete(DataBuf, 1, pos('http://auto.plius.lt/skelbimas/', DataBuf) - 1);
    while pos('http://auto.plius.lt/skelbimas/', DataBuf) > 0 do
    begin
      try
        Application.ProcessMessages;
        if Finish then
          Exit;
        Sleep(5000);
        martkestemp := Copy(DataBuf, pos('http://auto.plius.lt/skelbimas/', DataBuf),
          pos('"', DataBuf) - pos('http://auto.plius.lt/skelbimas/', DataBuf));
        Markes := PwideChar(martkestemp);
        Log.Lines.Add(DateTimeToStr(Now) + ' ' + Markes);
        if not(ParseAutopliusAdvert(Markes, masina[Count])) then
        begin
          Log.Lines.Strings[Log.Lines.Count - 1] := Log.Lines.Strings[Log.Lines.Count - 1] + '. Nerastas';
        end;
        if pos('"fr"><strong>', DataBuf) > 0 then
          masina[Count].skelbimo_data := Copy(DataBuf, pos('"fr"><strong>', DataBuf) + 13, 10);
        while pos(Markes, DataBuf) > 0 do
        begin
          Delete(DataBuf, 1, pos(Markes, DataBuf) + length(Markes));
        end;
        Delete(DataBuf, 1, pos('http://auto.plius.lt/skelbimas/', DataBuf) - 1);
        inc(Count);
      except
        on e: exception do
        begin
          Log.Lines.Add(DateTimeToStr(Now) + ' ' + e.message);
          Delete(DataBuf, 1, pos('http://auto.plius.lt/skelbimas/', DataBuf) - 1);
          inc(Count);
        end;
      end;
    end;
  finally
    DeleteFile(TmpFileNameMarkes);
    Screen.Cursor := crDefault;
  end;
  result := true;
end;

function TLoadAdvertisementsForm.ParseAutogidasPage(webpage: string; var masina: array of Adv_record): boolean;
var
  TmpFileNameMarkes: TFileName;
  sl: TStringList;
  DataBuf, rawHTM, temp: string;
  iStart, iStop, Count: integer;
  martkestemp: string;
  Markes: string;
  AEncoding: TEncoding;
  i: integer;
begin
  try
    TmpFileNameMarkes := TempFileName;
    Screen.Cursor := crHourGlass;
    if NOT Download_HTM(webpage, TmpFileNameMarkes) then
    begin
      result := false;
      Exit;
    end;
    sl := TStringList.Create;
    DataBuf := '';
    rawHTM := '';
    try
      AEncoding := TEncoding.UTF8;
      sl.LoadFromFile(TmpFileNameMarkes, AEncoding);
      for i := 0 to sl.Count - 1 do
      begin
        rawHTM := Concat(rawHTM, sl[i]);
      end;
      iStart := pos('tceil-1', rawHTM);
      iStop := pos('search-footer', rawHTM);
      DataBuf := Copy(rawHTM, iStart, iStop - iStart);
    finally
      sl.Free;
    end;
    Count := 0;
    while pos('http://www.autogidas.lt/skelbimai', DataBuf) > 0 do
    begin
      try
        Application.ProcessMessages;
        if Finish then
          Exit;
        martkestemp := Copy(DataBuf, pos('http://www.autogidas.lt/skelbimai', DataBuf),
          pos('.html', DataBuf) - pos('http://www.autogidas.lt/skelbimai', DataBuf) + 5);
        Markes := PwideChar(martkestemp);
        Log.Lines.Add(DateTimeToStr(Now) + ' ' + Markes);
        if not(ParseAutogidasAdvert(Markes, masina[Count])) then
        begin
          Log.Lines.Strings[Log.Lines.Count - 1] := Log.Lines.Strings[Log.Lines.Count - 1] + '. Nerastas';
        end;

        inc(Count);
        Delete(DataBuf, pos('http://www.autogidas.lt/skelbimai', DataBuf), pos('.html', DataBuf) - pos('http://www.autogidas.lt/skelbimai',
          DataBuf) + 5);
        Delete(DataBuf, pos('http://www.autogidas.lt/skelbimai', DataBuf), pos('.html', DataBuf) - pos('http://www.autogidas.lt/skelbimai',
          DataBuf) + 5);
      except
        on e: exception do
        begin
          Log.Lines.Add(DateTimeToStr(Now) + ' ' + e.message);
          inc(Count);
          Delete(DataBuf, pos('http://www.autogidas.lt/skelbimai', DataBuf),
            pos('.html', DataBuf) - pos('http://www.autogidas.lt/skelbimai', DataBuf) + 5);
          Delete(DataBuf, pos('http://www.autogidas.lt/skelbimai', DataBuf),
            pos('.html', DataBuf) - pos('http://www.autogidas.lt/skelbimai', DataBuf) + 5);
        end;
      end;
    end;
  finally
    DeleteFile(TmpFileNameMarkes);
    Screen.Cursor := crDefault;
  end;
  result := true;
end;

function TLoadAdvertisementsForm.ParseAutogidasPageExt(webpage: string; out NextWebpage: string; var masina: array of Adv_record): boolean;
var
  HTMLStream: TMemoryStream;
  AStreamReader: TStreamReader;
  ACount: integer;
  i, ii, found: integer;

begin
  IdHTTP1.HandleRedirects := true;
  HTMLStream := TMemoryStream.Create;
  IdHTTP1.Get(webpage, HTMLStream);
  HTMLStream.Position := 0;
  // AStreamReader := TStreamReader.Create(s, TEncoding.UTF8);

  RegisterHtmlTags;
  RegisterHtmlAttribs;
  RegisterHtmlDecodingEntities;

  MyHtmlParser.SourceStream := HTMLStream;
  MyHtmlParser.ReadMethods := Read_UTF_8;

  { Show HTML tags and text }
  MyHtmlParser.FilterHtmlTags.SetStartEnd(fiShow);
  MyHtmlParser.FilterText := fiShow;

  { Show HTML tags and text }
  MyHtmlParser.FilterHtmlTags.SetStartEnd(fiShow);
  MyHtmlParser.FilterText := fiShow;

  i := 0;
  ii := 0;

  Application.ProcessMessages;
  if Finish then
    Exit;

  while MyHtmlParser.ParseNextPiece do
    case MyHtmlParser.PieceType of
      // What type of HTML piece did the parser find?
      ptHtmlTag: // Found a tag.
        case MyHtmlParser.HtmlTag.TagID of
          TAG_DIV_ID: // Found a DIV tag.
            begin
              case MyHtmlParser.HtmlTag.TagType of
                ttStartTag:
                  begin
                    { <div class="paging"> }
                    if StrSameIW(MyHtmlParser.HtmlTag.ValueOfNameCI['class'], 'paging') then
                    begin
                      (* for i := 0 to 40 do
                        begin
                        MyHtmlParser.ParseNextPiece;
                        if (MyHtmlParser.PieceType = ptHtmlTag) and (StrSameIW(MyHtmlParser.HtmlTag.ValueOfNameCI['class'], 'next-prev') or
                        StrSameIW(MyHtmlParser.HtmlTag.ValueOfNameCI['class'], 'next-prev inactive-page')) then
                        inc(ii); // Count how much found
                        if ii = 2 then
                        begin
                        if MyHtmlParser.DataAsStr = 'next-prev inactive-page' then
                        NextWebpage := ''
                        else
                        NextWebpage := MyHtmlParser.HtmlTag.FirstValue;
                        found := 1;
                        Break; // Return
                        end;
                        end;
                      *)
                      while (MyHtmlParser.ParseNextPiece) and (found = 0) do
                        case MyHtmlParser.PieceType of
                          ptHtmlTag:
                            begin
                              if (MyHtmlParser.PieceType = ptHtmlTag) and
                                (StrSameIW(MyHtmlParser.HtmlTag.ValueOfNameCI['class'], 'next-prev') or
                                StrSameIW(MyHtmlParser.HtmlTag.ValueOfNameCI['class'], 'next-prev inactive-page')) then
                                inc(ii); // Count how much found
                              if ii = 2 then
                              begin
                                if MyHtmlParser.DataAsStr = 'next-prev inactive-page' then
                                  NextWebpage := ''
                                else
                                  NextWebpage := MyHtmlParser.HtmlTag.FirstValue;
                                found := 1;
                                Break; // Return
                              end;
                            end;
                        end;

                      (* while (MyHtmlParser.ParseNextPiece) and (found = 0) do
                        case MyHtmlParser.PieceType of
                        ptHtmlTag:
                        if StrSameIW(MyHtmlParser.HtmlTag.ValueOfNameCI['class'], 'next-prev') then
                        begin
                        inc(i);
                        if i = 2 then
                        begin
                        if MyHtmlParser.DataAsStr = 'next-prev inactive-page' then
                        NextWebpage := ''
                        else
                        NextWebpage := MyHtmlParser.HtmlTag.FirstValue;
                        found := 1;
                        Break; // Return
                        end;
                        end;

                        end; *)

                    end;

                    { class="sk-sar" }
                    if StrSameIW(MyHtmlParser.HtmlTag.ValueOfNameCI['class'], 'sk-sar') then
                    begin
                      ACount := 0;
                      while MyHtmlParser.ParseNextPiece do
                        case MyHtmlParser.PieceType of
                          ptHtmlTag:
                            if StrSameIW(MyHtmlParser.HtmlTag.ValueOfNameCI['class'], 'tceil-1') then
                            begin
                              MyHtmlParser.ParseNextPiece;
                              if (MyHtmlParser.HtmlTag.TagID = 1) and (MyHtmlParser.HtmlTag.FirstName = 'href') then
                              begin
                                Log.Lines.Add(DateTimeToStr(Now) + ' ' + MyHtmlParser.HtmlTag.ValueOfNameCI['href']);
                                if not(ParseAutogidasAdvertExt(MyHtmlParser.HtmlTag.ValueOfNameCI['href'], masina[ACount])) then
                                begin
                                  Log.Lines.Strings[Log.Lines.Count - 1] := Log.Lines.Strings[Log.Lines.Count - 1] + '. Nerastas';
                                end
                                else
                                  inc(ACount);
                                // ShowMessage(MyHtmlParser.HtmlTag.ValueOfNameCI['href']);
                              end;
                            end;
                        end;
                    end;
                  end;
              end;
            end;
        end;
    end;
  result := true;
end;

function TLoadAdvertisementsForm.ParseMobilePage(webpage: string; var masina: array of Adv_record): boolean;
var
  TmpFileNameMarkes: TFileName;
  sl: TStringList;
  DataBuf, rawHTM, temp: string;
  iStart, iStop, Count: integer;
  martkestemp: string;
  Markes: string;
  AEncoding: TEncoding;
  i: integer;
begin
  try
    TmpFileNameMarkes := TempFileName;
    Screen.Cursor := crHourGlass;
    if NOT Download_HTM(webpage, TmpFileNameMarkes) then
    begin
      result := false;
      Exit;
    end;
    sl := TStringList.Create;
    DataBuf := '';
    rawHTM := '';
    try
      AEncoding := TEncoding.UTF8;
      sl.LoadFromFile(TmpFileNameMarkes, AEncoding);
      for i := 0 to sl.Count - 1 do
      begin
        rawHTM := Concat(rawHTM, sl[i]);
      end;
      iStart := pos('<!-- /topOfPage -->', rawHTM);
      iStop := pos('*VAT reclaimable', rawHTM);
      DataBuf := Copy(rawHTM, iStart, iStop - iStart);
    finally
      sl.Free;
    end;
    Count := 0;
    while pos('http://suchen.mobile.de/fahrzeuge/showDetails.html?id=', DataBuf) > 0 do
    begin
      try
        Application.ProcessMessages;
        if Finish then
          Exit;
        martkestemp := Copy(DataBuf, pos('http://suchen.mobile.de/fahrzeuge/showDetails.html?id=', DataBuf),
          pos('" class', DataBuf) - pos('http://suchen.mobile.de/fahrzeuge/showDetails.html?id=', DataBuf)) + '&lang=en';
        Markes := PwideChar(martkestemp);
        if not(ParseMobileAdvert(Markes, masina[Count])) then
        begin
          Log.Lines.Strings[Log.Lines.Count - 1] := Log.Lines.Strings[Log.Lines.Count - 1] + '. Nerastas';
        end;

        inc(Count);
        Delete(DataBuf, 1, pos('http://suchen.mobile.de/fahrzeuge/showDetails.html?id=', DataBuf) +
          length('http://suchen.mobile.de/fahrzeuge/showDetails.html?id='));
        Delete(DataBuf, 1, pos('http://suchen.mobile.de/fahrzeuge/showDetails.html?id=', DataBuf) +
          length('http://suchen.mobile.de/fahrzeuge/showDetails.html?id='));
      except
        on e: exception do
          Log.Lines.Add(DateTimeToStr(Now) + ' ' + e.message);
      end;
    end;

  finally
    DeleteFile(TmpFileNameMarkes);
    Screen.Cursor := crDefault;
  end;
  result := true;
end;

function TLoadAdvertisementsForm.ParseBRCPage(webpage: string; var masina: array of Adv_record): boolean;
var
  TmpFileNameMarkes: TFileName;
  sl: TStringList;
  DataBuf, rawHTM, temp: string;
  iStart, iStop, Count: integer;
  martkestemp: string;
  Markes: string;
  AEncoding: TEncoding;
  i: integer;
begin
  try
    TmpFileNameMarkes := TempFileName;
    Screen.Cursor := crHourGlass;
    if NOT Download_HTM(webpage, TmpFileNameMarkes) then
    begin
      result := false;
      Exit;
    end;
    sl := TStringList.Create;
    DataBuf := '';
    rawHTM := '';
    try
      AEncoding := TEncoding.GetEncoding(1257);
      sl.LoadFromFile(TmpFileNameMarkes, AEncoding);
      for i := 0 to sl.Count - 1 do
      begin
        rawHTM := Concat(rawHTM, sl[i]);
      end;
      iStart := pos('car.brc?id=', rawHTM);
      iStop := pos('container-top-line', rawHTM);
      DataBuf := Copy(rawHTM, iStart, iStop - iStart);
      if pos('car.brc?id=', DataBuf) = 0 then
      begin
        result := false;
        Exit;
      end;
    finally
      sl.Free;
    end;
    Count := 0;
    while pos('car.brc?id=', DataBuf) > 0 do
    begin
      try
        Application.ProcessMessages;
        if Finish then
          Exit;
        Delete(DataBuf, 1, pos('car.brc?id=', DataBuf) - 1);
        martkestemp := Copy(DataBuf, pos('car.brc?id=', DataBuf), pos('"', DataBuf) - pos('car.brc?id=', DataBuf));
        Markes := PwideChar('http://www.brc.lt/lt/' + martkestemp);
        Log.Lines.Add(DateTimeToStr(Now) + ' ' + Markes);
        if not(ParseBRCAdvert(Markes, masina[Count])) then
        begin
          Log.Lines.Strings[Log.Lines.Count - 1] := Log.Lines.Strings[Log.Lines.Count - 1] + '. Nerastas';
        end;
        if pos('/>BRC', DataBuf) > 0 then
        begin
          Delete(DataBuf, 1, pos('/>BRC', DataBuf) + 5);
          masina[Count].salis := Copy(DataBuf, 1, pos(',', DataBuf) - 1);
          Delete(DataBuf, 1, pos(',', DataBuf) + 1);
          masina[Count].miestas := Copy(DataBuf, 1, pos(',', DataBuf) - 1);
          Delete(DataBuf, 1, pos(',', DataBuf) + 1);
          masina[Count].vardas := Copy(DataBuf, 1, pos(':', DataBuf) - 1);
          Delete(DataBuf, 1, pos(':', DataBuf) + 1);
          masina[Count].telefonas := Copy(DataBuf, 1, pos('<br />', DataBuf) - 1);
        end;
        if pos('car.brc?id=' + masina[Count].skelbimo_id, DataBuf) > 0 then
          Delete(DataBuf, 1, pos('car.brc?id=' + masina[Count].skelbimo_id, DataBuf) + length('car.brc?id=' + masina[Count].skelbimo_id));
        inc(Count);
      except
        on e: exception do
        begin
          Log.Lines.Add(DateTimeToStr(Now) + ' ' + e.message);
          if pos('car.brc?id=' + masina[Count].skelbimo_id, DataBuf) > 0 then
            Delete(DataBuf, 1, pos('car.brc?id=' + masina[Count].skelbimo_id, DataBuf) + length('car.brc?id=' + masina[Count].skelbimo_id));
          inc(Count);
        end;
      end;
    end;
  finally
    DeleteFile(TmpFileNameMarkes);
    Screen.Cursor := crDefault;
  end;
  result := true;
end;

function CheckAutoPliusFilterCount(webpage: string): integer;
var
  TmpFileNameMarkes: TFileName;
  sl: TStringList;
  DataBuf, rawHTM, temp: string;
  i: integer;
  AEncoding: TEncoding;
begin
  try
    result := 0;
    TmpFileNameMarkes := TempFileName;
    Screen.Cursor := crHourGlass;
    if NOT Download_HTM(webpage, TmpFileNameMarkes) then
    begin
      result := 0;
      Exit;
    end;
    DataBuf := '';
    rawHTM := '';
    sl := TStringList.Create;
    try
      AEncoding := TEncoding.UTF8;
      sl.LoadFromFile(TmpFileNameMarkes, AEncoding);

      for i := 0 to sl.Count - 1 do
      begin
        rawHTM := Concat(rawHTM, sl[i]);
      end;
      if (pos('<strong>Modelis</strong></h4><form id="makes_search_form"', rawHTM) > 0) or
        (pos('Pagal šiuos paieškos kriterijus skelbimų nerasta.', rawHTM) > 0) then
      begin
        result := 0;
        Exit;
      end;
      if (pos('<div class="filter-info">', rawHTM) > 0) then
      begin
        result := strtoint(Copy(rawHTM, pos('<div class="filter-info">', rawHTM) + length('<div class="filter-info">'),
          pos(' - Skelbimų atitiko žemiau pasirinktus kriterijus', rawHTM) - pos('<div class="filter-info">', rawHTM) -
          length('<div class="filter-info">')));
      end
      else
      begin
        result := 0;
      end;
    finally
      sl.Free;
    end;
  finally
    DeleteFile(TmpFileNameMarkes);
    Screen.Cursor := crDefault;
  end;
end;

function BinSearch(first, last, model_ID: integer): integer;
var
  Pivot: integer;
  found: boolean;
  WebSite: string;
  AutoPliusFilterCount: integer;
begin
  found := false;
  result := -1;
  while (first <= last) and (not found) do
  begin
    Pivot := (first + last) div 2;
    if Pivot = first then
    begin
      result := last;
      found := true;
      Exit;
    end;
    WebSite := 'http://auto.plius.lt/naudoti-automobiliai/?puslapis-1&make_date_from=' + inttostr(first) + '&make_date_to=' +
      inttostr(Pivot) + '&make_id=' + inttostr(model_ID);

    AutoPliusFilterCount := CheckAutoPliusFilterCount(WebSite);

    if (0 < AutoPliusFilterCount) and (AutoPliusFilterCount < 1000) then
    begin
      found := true;
      result := Pivot;
      Exit;
    end
    else if AutoPliusFilterCount > 1000 then
      last := Pivot - 1
    else
      first := Pivot + 1;
  end;
end;

procedure TLoadAdvertisementsForm.Parse(tipas: integer);
// 1 - autoplius, 2 - autogidas
var
  i, model_ID: integer;
  WebSite_temp, WebSite: string;
  masina: array [1 .. 200] of Adv_record;
  j: integer;
  FilterCount: integer;
  z: integer;
  last: integer;
  first: integer;
  Current: integer;
  HTMLStream: TMemoryStream;
  NextPage: boolean;
  ANextPage: String;
  AutogidasSite: String;
begin
  try
    if not(OnlyOld).Checked then
    begin

      case tipas of
{$REGION 'AUTOPLIUS'}
        1:
          begin
            Log.Lines.Add('Autoplius');
            if MakeComboBox.text <> '' then
            begin

              WEBSITEMAKE.Active := false;
              WEBSITEMAKE.ParamByName('WEBSITE').Value := 1;
              WEBSITEMAKE.ParamByName('CARMAKE').Value := MakeComboBox.EditValue;
              WEBSITEMAKE.Active := true;
              if WEBSITEMAKE.RecordCount = 1 then
              begin
                WebSite_temp := 'make_id=' + WEBSITEMAKE.FieldByName('VALUE').AsString;
                if ModelComboBox.text <> '' then
                begin
                  WEBSITEMODEL.Active := false;
                  WEBSITEMODEL.ParamByName('WEBSITE').Value := 1;
                  WEBSITEMODEL.ParamByName('CARMODEL').Value := ModelComboBox.EditValue;
                  WEBSITEMODEL.Active := true;
                  if WEBSITEMODEL.RecordCount = 1 then
                    WebSite_temp := WebSite_temp + '&make_id[' + WEBSITEMAKE.FieldByName('VALUE').AsString + ']=' +
                      WEBSITEMODEL.FieldByName('VALUE').AsString;
                end;
                Application.ProcessMessages;
                if Finish then
                  Exit;
                WebSite := PwideChar('http://auto.plius.lt/naudoti-automobiliai/puslapis-1?' + WebSite_temp);
                FilterCount := CheckAutoPliusFilterCount(WebSite);
                if FilterCount > 1000 then
                begin
                  first := 1900;
                  last := CurrentYear;
                  Current := 0;
                  while Current <> CurrentYear do
                  begin
                    Current := BinSearch(first, last, WEBSITEMAKE.FieldByName('VALUE').Value);
                    Application.ProcessMessages;
                    if Finish then
                      Exit;
                    Sleep(5000);
                    for i := 1 to 50 do
                    begin
                      WebSite := PwideChar('http://auto.plius.lt/naudoti-automobiliai/puslapis-' + inttostr(i) + '?make_date_from=' +
                        inttostr(first) + '&make_date_to=' + inttostr(Current) + '&' + WebSite_temp);
                      Application.ProcessMessages;
                      if Finish then
                        Exit;
                      fillchar(masina, sizeOf(masina), 0);
                      Sleep(5000);
                      Log.Lines.Add(DateTimeToStr(Now) + ' ' + WebSite);
                      if not(ParseAutopliusPage(WebSite, masina)) then
                      begin
                        Log.Lines.Strings[Log.Lines.Count - 1] := Log.Lines.Strings[Log.Lines.Count - 1] + '. Nerastas';
                        Break;
                      end;
                      for z := 1 to 200 do
                      begin
                        SaveAdvert(tipas, masina[z]);
                      end;
                    end;
                    first := Current;
                  end;
                end
                else
                begin
                  for i := 1 to 50 do
                  begin
                    Application.ProcessMessages;
                    if Finish then
                      Exit;
                    fillchar(masina, sizeOf(masina), 0);
                    Sleep(5000);
                    WebSite := PwideChar('http://auto.plius.lt/naudoti-automobiliai/puslapis-' + inttostr(i) + '&' + WebSite_temp);
                    Log.Lines.Add(DateTimeToStr(Now) + ' ' + WebSite);
                    if not(ParseAutopliusPage(WebSite, masina)) then
                    begin
                      Log.Lines.Strings[Log.Lines.Count - 1] := Log.Lines.Strings[Log.Lines.Count - 1] + '. Nerastas';
                      Break;
                    end;
                    for j := 1 to 200 do
                    begin
                      SaveAdvert(tipas, masina[j]);
                    end;
                  end;
                end;
              end;
            end
            else
            begin
              for model_ID := 40 to 126 do
              begin
                Application.ProcessMessages;
                if Finish then
                  Exit;
                WebSite_temp := 'http://auto.plius.lt/naudoti-automobiliai/puslapis-1' + '?make_id=' + inttostr(model_ID);
                WebSite := PwideChar(WebSite_temp);
                FilterCount := CheckAutoPliusFilterCount(WebSite);
                if FilterCount > 1000 then
                begin
                  first := 1900;
                  last := CurrentYear;
                  Current := 0;
                  while Current <> CurrentYear do
                  begin
                    Current := BinSearch(first, last, model_ID);
                    Application.ProcessMessages;
                    if Finish then
                      Exit;
                    Sleep(5000);
                    for i := 1 to 50 do
                    begin
                      WebSite_temp := 'http://auto.plius.lt/naudoti-automobiliai/puslapis-' + inttostr(i) + '?make_date_from=' +
                        inttostr(first) + '&make_date_to=' + inttostr(Current) + '&make_id=' + inttostr(model_ID);
                      WebSite := PwideChar(WebSite_temp);
                      Application.ProcessMessages;
                      if Finish then
                        Exit;
                      fillchar(masina, sizeOf(masina), 0);
                      Sleep(5000);
                      Log.Lines.Add(DateTimeToStr(Now) + ' ' + WebSite);
                      if not(ParseAutopliusPage(WebSite, masina)) then
                      begin
                        Log.Lines.Strings[Log.Lines.Count - 1] := Log.Lines.Strings[Log.Lines.Count - 1] + '. Nerastas';
                        Break;
                      end;
                      for z := 1 to 200 do
                      begin
                        SaveAdvert(tipas, masina[z]);
                      end;
                    end;
                    first := Current;
                  end;
                end
                else
                begin
                  for i := 1 to 50 do
                  begin
                    Application.ProcessMessages;
                    if Finish then
                      Exit;
                    fillchar(masina, sizeOf(masina), 0);
                    Sleep(5000);
                    WebSite_temp := 'http://auto.plius.lt/naudoti-automobiliai/puslapis-' + inttostr(i) + '?make_id=' + inttostr(model_ID);
                    WebSite := PwideChar(WebSite_temp);
                    Log.Lines.Add(DateTimeToStr(Now) + ' ' + WebSite);
                    if not(ParseAutopliusPage(WebSite, masina)) then
                    begin
                      Log.Lines.Strings[Log.Lines.Count - 1] := Log.Lines.Strings[Log.Lines.Count - 1] + '. Nerastas';
                      Break;
                    end;
                    for j := 1 to 200 do
                    begin
                      SaveAdvert(tipas, masina[j]);
                    end;
                  end;
                end;
              end;
            end;
          end;
{$ENDREGION}
{$REGION 'AUTOGIDAS'}
        2:
          begin
            Log.Lines.Add('Autogidas');
            Application.ProcessMessages;
            if Finish then
              Exit;

            fillchar(masina, sizeOf(masina), 0);

            // Laikina
            // Sleep(5000); // sleep po kieknvieno puslapio su daug skelbimu
            { INIT page }
            AutogidasSite := 'http://www.autogidas.lt';
            WebSite_temp := AutogidasSite + '/automobiliai/?';
            if MakeComboBox.text <> '' then
              WebSite_temp := WebSite_temp + '&f_1=' + MakeComboBox.text;
            WebSite_temp := WebSite_temp + '&search=Surasti';

            WebSite := PwideChar(WebSite_temp);

            NextPage := true;
            while NextPage do
            begin
              Log.Lines.Add(DateTimeToStr(Now) + ' ' + WebSite);
              if not(ParseAutogidasPageExt(WebSite, ANextPage, masina)) then
              begin
                Log.Lines.Strings[Log.Lines.Count - 1] := Log.Lines.Strings[Log.Lines.Count - 1] + '. Nerastas';
                NextPage := false;
              end;
              if ANextPage <> '' then
                WebSite := AutogidasSite + ANextPage
              else
                NextPage := false;

              { Save }
              for j := 1 to 200 do
              begin
                SaveAdvert(tipas, masina[j]);
              end;

            end;

            (*
              Log.Lines.Add('Autogidas');
              for i := 1 to 4000 do
              begin
              Application.ProcessMessages;
              if Finish then
              Exit;
              fillchar(masina, sizeOf(masina), 0);

              begin
              //Laikina
              //Sleep(5000); // sleep po kieknvieno puslapio su daug skelbimu
              {INIT page}
              WebSite_temp := 'http://www.autogidas.lt/automobiliai/?';
              if MakeComboBox.text <> '' then
              WebSite_temp := WebSite_temp + 'f_1=' + MakeComboBox.text;
              WebSite_temp := WebSite_temp + '&search=Surasti';

              WebSite := PwideChar(WebSite_temp);
              Log.Lines.Add(DateTimeToStr(Now) + ' ' + WebSite);


              if not(ParseAutogidasPageExt(WebSite, masina)) then
              begin
              Log.Lines.Strings[Log.Lines.Count - 1] := Log.Lines.Strings[Log.Lines.Count - 1] + '. Nerastas';
              Break;
              end;
              for j := 1 to 200 do
              begin
              SaveAdvert(tipas, masina[j]);
              end;
              end;
              end; *)
          end;
{$ENDREGION}
{$REGION 'MOBILE'}
        3:
          begin
            Log.Lines.Add('Mobile.de');
            for i := 1 to 2000 do
            begin
              Application.ProcessMessages;
              if Finish then
                Exit;
              fillchar(masina, sizeOf(masina), 0);

              begin
                WebSite_temp := 'http://suchen.mobile.de/fahrzeuge/miniSearch.html?isSearchRequest=true' +
                  '&minPrice=&maxPrice=&minFirstRegistrationDate=&maxFirstRegistrationDate=' +
                  '&minMileage=&maxMileage=&ambitCountry=&zipcode=&export=ALSO_EXPORT' +
                  '&damageUnrepaired=ALSO_DAMAGE_UNREPAIRED&__lp=59184&scopeId=C' +
                  '&sortOption.sortBy=searchNetGrossPrice&sortOption.sortOrder=ASCENDING' +
                  '&makeModelVariant1.searchInFreetext=false&makeModelVariant2.searchInFreetext=false' +
                  '&makeModelVariant3.searchInFreetext=false&vehicleCategory=Car&segment=Car' +
                  '&siteId=GERMANY&customerIdsAsString=&lang=en&pageNumber=' + inttostr(i);
                WebSite := PwideChar(WebSite_temp);
                Log.Lines.Add(DateTimeToStr(Now) + ' ' + WebSite);
                if not(ParseMobilePage(WebSite, masina)) then
                begin
                  Log.Lines.Strings[Log.Lines.Count - 1] := Log.Lines.Strings[Log.Lines.Count - 1] + '. Nerastas';
                  Break;
                end;
                for j := 1 to 200 do
                begin
                  SaveAdvert(tipas, masina[j]);
                end;
              end;
            end;
          end;
{$ENDREGION}
{$REGION 'BRC'}
        4:
          begin
            Log.Lines.Add('BRC');
            for i := 1 to 2000 do
            begin
              Application.ProcessMessages;
              if Finish then
                Exit;
              fillchar(masina, sizeOf(masina), 0);

              begin
                WebSite_temp := 'http://brc.lt/lt/mixed_list.brc?section=0&mark=';
                if MakeComboBox.text <> '' then
                begin
                  WEBSITEMAKE.Active := false;
                  WEBSITEMAKE.ParamByName('WEBSITE').Value := 4;
                  WEBSITEMAKE.ParamByName('CARMAKE').Value := MakeComboBox.EditValue;
                  WEBSITEMAKE.Active := true;
                  if WEBSITEMAKE.RecordCount = 1 then
                    WebSite_temp := WebSite_temp + WEBSITEMAKE.FieldByName('VALUE').AsString
                  else
                    WebSite_temp := WebSite_temp + '0';
                end
                else
                  WebSite_temp := WebSite_temp + '0';
                WebSite_temp := WebSite_temp + '&model=' + '&year_from=0&year_till=0&gearbox=0&fuel=0&mileage_from=0&mileage_to=0' +
                  '&price_from=&price_to=&brc_ee=1&brc_lv=3&brc_lt=2&body_type=0&wheelbase=0&color=0&' + 'mpay_from=&mpay_to=&city=0&page='
                  + inttostr(i);
                WebSite := PwideChar(WebSite_temp);
                Log.Lines.Add(DateTimeToStr(Now) + ' ' + WebSite);
                if not(ParseBRCPage(WebSite, masina)) then
                begin
                  Log.Lines.Strings[Log.Lines.Count - 1] := Log.Lines.Strings[Log.Lines.Count - 1] + '. Nerastas';
                  Break;
                end;
                for j := 1 to 200 do
                begin
                  SaveAdvert(tipas, masina[j]);
                end;
              end;
            end;
          end;
{$ENDREGION}
      end;
    end;
    UpdateOld(tipas);
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
