unit MainFRM;

interface

uses
  FastMM4, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ActiveX, Vcl.OleCtrls,
  SHDocVw_EWB, EwbCore, EmbeddedWB, MSHTML_EWB, Vcl.ExtCtrls, Vcl.ComCtrls;

ResourceString

  RSTimeOut = 'Serveris neatsako, prašome pabandyti vėliau ...';
  RSStep0 = 'Jungiamasi ...';
  RSStep1 = 'Kraunasi ...';
  RSStep2 = 'Duomenų perdavimas ...';
  RSStep3 = 'Ieškoma kompensacinio PVM tarifo duomenų ...';
  RSStep4 = 'Kompensacinio PVM tarifo duomenų atsiuntimas ...';
  RSStep5 = 'Kompensacinio PVM tarifo duomenų apdorojimas ...';

  RSStep6 = 'Kraunasi ...';
  RSStep7 = 'Duomenų perdavimas ...';
  RSStep8 = 'Ieškoma PVM mokėtojo duomenų ...';
  RSStep9 = 'PVM mokėtojo duomenų atsiuntimas ...';
  RSStep10 = 'PVM mokėtojo duomenų apdorojimas ...';

  RSStep100 = 'Pabaiga';

type
  TContractor = record // Ūkininkai, kuriems taikomas kompensacinio PVM tarifas
    Name: WideString; // vardas, pavarde
    Code: WideString; // Kodas:

    { Duomenys apie įregistravimą }
    LicenceNo: WideString; // Pažym. nr.
    StartDate: WideString; // Reg. data
    StartLicenceDate: WideString; // Data nuo kada taikomas komp. PVM tarifas

    { Duomenys apie išregistravimą }
    EndDate: WideString; // Išreg. data
    EndLicenceDate: WideString; // Pažym. negalioja nuo

    InfoNotes: WideString; // Paskelbimo negaliojančiu "VŽ" priede pranešimai
    EndCause: WideString; // Išreg. priežastis
    Notes: WideString; // Pastabos
  end;

type
  TContractorVAT = record // PVM mokėtojai
    Name: WideString; // vardas, pavarde;
    VATCode: WideString; // PVM kodas:
    StartDate: WideString; // Įregistravimo PVM mokėtojų data:
    EndDate: WideString; // Išregistravimo iš PVM mokėtojų registro data:
  end;

type
  TfrmMain = class(TForm)
    pnlBottom: TPanel;
    WB1: TEmbeddedWB;
    pnlCenter: TPanel;
    memResult: TMemo;
    pnlTop: TPanel;
    PB1: TProgressBar;
    procedure WB1DocumentComplete(ASender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
  private
    { Private declarations }
    function Proceed1(ACode: String): Boolean;
    function Proceed2(ACode: String): Boolean;
    function Parse1(ACode: String; ASource: String;
      ASourceText: String): Boolean;
    function Parse2(ASource: String; ASourceText: String): Boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  gloContractor: TContractor;
  gloContractorVAT: TContractorVAT;
  gloURL1: String =
    'http://www.vmi.lt/cms/ukininkai-kuriems-taikoma-kompensacinio-pvm-tarifo-schema1';
  gloURL2: String = 'http://www.vmi.lt/cms/informacija-apie-mokesciu-moketojus';
  gloCount: Integer;

Function GetData(ANumber: WideString; out AContractor: TContractor;
  out AContractorVAT: TContractorVAT): Boolean;
function Test(ANumber: WideString; out AContractor: TContractor;
  out AContractorVAT: TContractorVAT): Boolean;
Procedure ClearContractor();
Procedure ClearContractorVAT();
function FindSpecificElement(AText: String; out aPersonCodeID: String;
  out aCodeID: String): Boolean;

implementation

{$R *.dfm}

function TfrmMain.Proceed1(ACode: String): Boolean;
var
  aElement: IhtmlElement;
  ATimeout: Integer;
  aElementName1, aElementName2: String;
  ElementCollection: IHTMLElementCollection;
  doc: IHTMLDocument2;
  InputElement: IHTMLInputElement;
  i: Integer;
begin
  Result := False;
  ATimeout := 0;

  frmMain.Caption := RSStep2;
  frmMain.PB1.Position := 15;
  Application.ProcessMessages;

  { Find dinamic elements ID for person code sand coder radio buttons }
  FindSpecificElement(WB1.DocumentSource, aElementName1, aElementName2);
  if (aElementName1 = '') or (aElementName2 = '') then
  begin
    WB1.Stop;
    WB1.Navigate('about:blank');
    ShowMessage(RSTimeOut);
    EXIT;
  end;

  // Recognize person code and select person code radio button
  if length(trim(ACode)) = 11 then
  begin
    aElement := WB1.ElementByID[aElementName1];
    if aElement <> nil then
    begin
      aElement.click;
      WB1.FillForm
        ('_farmersvatcompensationportlet_WAR_EskisLiferayPortletsportlet_asm_kodas',
        ACode);
      WB1.FillFormAndExcecute;
    end;
  end;

  // Recognize company code and select company code radio button
  if length(trim(ACode)) = 13 then
  begin
    // Company code 13 symbols
    aElement := WB1.ElementByID[aElementName2];
    if aElement <> nil then
    begin
      aElement.click;
      WB1.FillForm
        ('_farmersvatcompensationportlet_WAR_EskisLiferayPortletsportlet_kodas',
        ACode);
      WB1.FillFormAndExcecute;
    end;
  end;

  aElement := nil;

  frmMain.Caption := RSStep3;
  frmMain.PB1.Position := 25;
  Application.ProcessMessages;

  doc := WB1.Document as IHTMLDocument2;

  ElementCollection := doc.all;
  for i := 0 to ElementCollection.length - 1 do
  begin
    try
      aElement := ElementCollection.item(i, '') as IhtmlElement;
    except
      continue;
    end;
    if UpperCase(aElement.tagName) = 'INPUT' then
    begin
      InputElement := aElement as IHTMLInputElement;
      if UpperCase(InputElement.type_) = 'SUBMIT' then
      begin
        aElement.click;
      end;
    end;
  end;

  while (gloCount < 2) and (ATimeout < 199999999) do
  begin
    Application.ProcessMessages;
    Inc(ATimeout);
  end;

  if ATimeout >= 199999999 then
  begin
    WB1.Stop;
    WB1.Navigate('about:blank');
    ShowMessage(RSTimeOut);
    EXIT;
  end;

  Parse1(ACode, WB1.DocumentSource, WB1.DocumentSourceText);
end;

function TfrmMain.Proceed2(ACode: String): Boolean;
var
  ATimeout: Integer;
  aElement: IhtmlElement;
begin
  Result := False;

  frmMain.Caption := RSStep6;
  frmMain.PB1.Position := 50;
  Application.ProcessMessages;

  gloCount := 0;
  ATimeout := 0;
  WB1.Stop;
  WB1.Navigate('about:blank');
  WB1.Navigate(gloURL2);

  while WB1.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  while (gloCount < 1) and (ATimeout < 199999999) do
  begin
    Application.ProcessMessages;
    Inc(ATimeout);
  end;

  if ATimeout >= 199999999 then
  begin
    ShowMessage(RSTimeOut);
    EXIT;
  end;

  frmMain.Caption := RSStep7;
  frmMain.PB1.Position := 55;
  Application.ProcessMessages;



  aElement := WB1.ElementByID['class="aui-field-input aui-field-input-choice" id="_farmersvatcompensationportlet_WAR_EskisLiferayPortletsportlet_'];
  if aElement <> nil then
  begin
    aElement.click;
    WB1.FillForm('_taxespayersportlet_WAR_EskisLiferayPortletsportlet_val_orgcode', ACode);
    WB1.FillFormAndExcecute;
  end;

         ShowMessage('EXIT');
  EXIT;

  aElement := nil;

  frmMain.Caption := RSStep8;
  frmMain.PB1.Position := 65;
  Application.ProcessMessages;
  aElement := WB1.ElementByID['LNGSubmit'];
  if aElement <> nil then
  begin
    aElement.click;
  end
  else
    EXIT;

  ATimeout := 0;
  while (gloCount < 2) and (ATimeout < 199999999) do
  begin
    Application.ProcessMessages;
    Inc(ATimeout);
  end;

  if ATimeout >= 199999999 then
  begin
    ShowMessage(RSTimeOut);
    EXIT;
  end;

  Parse2(WB1.DocumentSource, WB1.DocumentSourceText);

end;

function TfrmMain.Parse1(ACode: String; ASource, ASourceText: String): Boolean;
var
  AStart: Integer;
  AEnd: Integer;
  AResult: String;
  TempIndex: Integer;
  TempString: String;
  AList: TStringList;
  i: Integer;
begin
  Result := False;

  frmMain.Caption := RSStep5;
  frmMain.PB1.Position := 35;
  Application.ProcessMessages;
  // Result parse
  if Pos('Įrašų nerasta', WB1.DocumentSource) > 0 then
  begin
    memResult.Lines.Add('Įrašų nerasta');
    // try parse 2
    Proceed2(ACode);
    EXIT;
  end;

  AStart := Pos('Paieškos rezultatai', ASourceText);

  AResult := ASourceText;
  Delete(AResult, 1, AStart - 1);

  AEnd := Pos('į viršų', AResult);
  Delete(AResult, AEnd, length(AResult) - AEnd);

  try
    AList := TStringList.Create;
    AList.Text := AResult;
    for i := 0 to AList.Count - 1 do
    begin
      if Trim(AList[i]) = 'Paieškos rezultatai' then
      begin
        gloContractor.Name := Trim(AList[i + 4]);
      end;

{$REGION 'FIELDS PARSING'}
      { Kodas: }
      if Pos('Kodas:', AList[i]) > 0 then
      begin
        TempString := Trim(AList[i]);
        TempIndex := Pos('Kodas:', TempString);
        Delete(TempString, 1, 6);
        if TempString <> '' then
          gloContractor.Code := trim(TempString)
        else
          gloContractor.Code := '';
      end;

      { Pažym. nr. }
      if Pos('Pažym. nr.', AList[i]) > 0 then
      begin
        TempString := Trim(AList[i]);
        TempIndex := Pos('Pažym. nr.', TempString);
        Delete(TempString, 1, 10);
        if TempString <> '' then
          gloContractor.LicenceNo := trim(TempString)
        else
          gloContractor.LicenceNo := '';
      end;

      { Reg. data }
      if Pos('Reg. data', AList[i]) > 0 then
      begin
        TempString := Trim(AList[i]);
        TempIndex := Pos('Reg. data', TempString);
        Delete(TempString, 1, 9);
        if TempString <> '' then
          gloContractor.StartDate := trim(TempString)
        else
          gloContractor.StartDate := '';
      end;

      { Data nuo kada taikomas komp. PVM tarifas }
      if Pos('Data nuo kada taikomas komp. PVM tarifas', AList[i]) > 0 then
      begin
        TempString := Trim(AList[i]);
        TempIndex := Pos('Data nuo kada taikomas komp. PVM tarifas',
          TempString);
        Delete(TempString, 1, 40);
        if TempString <> '' then
          gloContractor.StartLicenceDate := trim(TempString)
        else
          gloContractor.StartLicenceDate := '';
      end;

      { Išreg. data }
      if Pos('Išreg. data', AList[i]) > 0 then
      begin
        TempString := Trim(AList[i]);
        TempIndex := Pos('Išreg. data', TempString);
        Delete(TempString, 1, 11);
        if TempString <> '' then
          gloContractor.EndDate := trim(TempString)
        else
          gloContractor.EndDate := '';
      end;

      { Pažym. negalioja nuo }
      if Pos('Pažym. negalioja nuo', AList[i]) > 0 then
      begin
        TempString := Trim(AList[i]);
        TempIndex := Pos('Pažym. negalioja nuo', TempString);
        Delete(TempString, 1, 20);
        if TempString <> '' then
          gloContractor.EndLicenceDate := trim(TempString)
        else
          gloContractor.EndLicenceDate := '';
      end;

      { Paskelbimo negaliojančiu "VŽ" priede "Informaciniai pranešimai" }
      if Pos('Paskelbimo negaliojančiu "VŽ" priede "Informaciniai pranešimai"',
        AList[i]) > 0 then
      begin
        TempString := Trim(AList[i]);
        TempIndex :=
          Pos('Paskelbimo negaliojančiu "VŽ" priede "Informaciniai pranešimai"',
          TempString);
        Delete(TempString, 1, 63);
        if TempString <> '' then
          gloContractor.InfoNotes := trim(TempString)
        else
          gloContractor.InfoNotes := '';
      end;

      { Išreg. priežastis }
      if Pos('Išreg. priežastis', AList[i]) > 0 then
      begin
        TempString := Trim(AList[i]);
        TempIndex := Pos('Išreg. priežastis', TempString);
        Delete(TempString, 1, 17);
        if TempString <> '' then
          gloContractor.EndCause := trim(TempString)
        else
          gloContractor.EndCause := '';
      end;

      { Pastabos }
      if Pos('Pastabos', AList[i]) > 0 then
      begin
        TempString := Trim(AList[i]);
        TempIndex := Pos('Pastabos', TempString);
        Delete(TempString, 1, 8);
        if TempString <> '' then
          gloContractor.Notes := trim(TempString)
        else
          gloContractor.Notes := '';
      end;
{$ENDREGION}
    end;


    Proceed2(ACode);
  finally
    AList.Free;
  end;
end;

function TfrmMain.Parse2(ASource, ASourceText: String): Boolean;
var
  AStart: Integer;
  AEnd: Integer;
  AResult: String;
  TempIndex: Integer;
  TempString: String;
  AList: TStringList;
  i: Integer;
begin
  Result := False;

  frmMain.Caption := RSStep9;
  frmMain.PB1.Position := 70;
  Application.ProcessMessages;

  // Result parse
  if Pos('Įrašų nerasta', WB1.DocumentSource) > 0 then
  begin
    memResult.Lines.Add('Įrašų nerasta');
    EXIT;
  end;

  AStart := Pos('Paieškos rezultatai', ASourceText);

  AResult := ASourceText;
  Delete(AResult, 1, AStart - 1);

  AEnd := Pos('Konsultacijos mokesčių klausimais telefonu 1882', AResult);
  Delete(AResult, AEnd, length(AResult) - AEnd);

  frmMain.Caption := RSStep10;
  frmMain.PB1.Position := 85;
  Application.ProcessMessages;

  try
    AList := TStringList.Create;
    AList.Text := AResult;
    for i := 0 to AList.Count - 1 do
    begin
      if AList[i] = 'Paieškos rezultatai' then
      begin
        gloContractorVAT.Name := AList[i + 1];
      end;
{$REGION 'FIELDS PARSING'}
      { PVM kodas: }
      if Pos('PVM kodas:', AList[i]) > 0 then
      begin
        TempString := AList[i];
        TempIndex := Pos('PVM kodas:', TempString);
        Delete(TempString, 1, 10);
        if TempString <> '' then
          gloContractorVAT.VATCode := trim(TempString)
        else
          gloContractorVAT.VATCode := '';
      end;

      { Įregistravimo PVM mokėtojų data: }
      if Pos('Įregistravimo PVM mokėtojų data:', AList[i]) > 0 then
      begin
        TempString := AList[i];
        TempIndex := Pos('Įregistravimo PVM mokėtojų data:', TempString);
        Delete(TempString, 1, 32);
        if TempString <> '' then
          gloContractorVAT.StartDate := trim(TempString)
        else
          gloContractorVAT.StartDate := '';
      end;

      { Išregistravimo iš PVM mokėtojų registro data: }
      if Pos('Išregistravimo iš PVM mokėtojų registro data:', AList[i]) > 0 then
      begin
        TempString := AList[i];
        TempIndex := Pos('Išregistravimo iš PVM mokėtojų registro data:',
          TempString);
        Delete(TempString, 1, 45);
        if TempString <> '' then
          gloContractorVAT.EndDate := trim(TempString)
        else
          gloContractorVAT.EndDate := '';
      end;
{$ENDREGION}
    end;

  finally
    AList.Free;
  end;
  memResult.Lines.Append(AResult);
end;

Function GetData(ANumber: WideString; out AContractor: TContractor;
  out AContractorVAT: TContractorVAT): Boolean;
var
  ATimeout: Integer;
begin
  Result := False;

  frmMain.PB1.Position := 0;
  Application.ProcessMessages;

  if not Assigned(frmMain) then
  begin
    EXIT;
  end;

  { Reset data }
  ClearContractor();
  ClearContractorVAT();

  { Reset output variables }
  AContractor := gloContractor;
  AContractorVAT := gloContractorVAT;

  frmMain.WindowState := wsMaximized; // SET MAXIMAZE FOR TEST PURPOSE ONLY
  frmMain.Show;

  if trim(ANumber) = '' then
  begin
    EXIT;
  end;

  { Prevent of empty parameter }
  if trim(ANumber) = '' then
    EXIT;

  { Init }
  gloCount := 0;
  ATimeout := 0;
  // ARepeatCount := 0;

  frmMain.Caption := RSStep1;
  frmMain.PB1.Position := 5;
  Application.ProcessMessages;

  frmMain.WB1.Stop;
  frmMain.WB1.Navigate('about:blank');
  frmMain.WB1.Navigate(gloURL1);

  // Padaryti timeout ir su state ir gal kartojima
  while frmMain.WB1.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  while (gloCount < 1) and (ATimeout < 199999999) do
  begin
    Application.ProcessMessages;
    Inc(ATimeout);
  end;

  if ATimeout >= 199999999 then
  begin
    frmMain.WB1.Stop;
    frmMain.WB1.Navigate('about:blank');
    ShowMessage(RSTimeOut);
    EXIT;
  end;

  // If Recognize person code or company code try proceed
  if (length(trim(ANumber)) = 11) or (length(trim(ANumber)) = 13) then
    frmMain.Proceed1(ANumber)
  else
    frmMain.Proceed2(ANumber);

  AContractor := gloContractor;
  AContractorVAT := gloContractorVAT;

  frmMain.Caption := RSStep100;
  frmMain.PB1.Position := 100;
  Application.ProcessMessages;

end;

Procedure ClearContractor();
begin
  gloContractor.Name := '';
  gloContractor.Code := '';
  gloContractor.LicenceNo := '';
  gloContractor.StartDate := '';
  gloContractor.StartLicenceDate := '';
  gloContractor.EndDate := '';
  gloContractor.EndLicenceDate := '';
  gloContractor.InfoNotes := '';
  gloContractor.EndCause := '';
  gloContractor.Notes := '';
end;

Procedure ClearContractorVAT();
begin
  gloContractorVAT.Name := '';
  gloContractorVAT.VATCode := '';
  gloContractorVAT.StartDate := '';
  gloContractorVAT.EndDate := '';
end;

procedure TfrmMain.WB1DocumentComplete(ASender: TObject; const pDisp: IDispatch;
  var URL: OleVariant);
begin
  Inc(gloCount);
  Application.ProcessMessages;
end;

function Test(ANumber: WideString; out AContractor: TContractor;
  out AContractorVAT: TContractorVAT): Boolean;
begin

  Result := False;
  if not Assigned(frmMain) then
  begin
    EXIT;
  end;
  frmMain.Show;

  { Reset data }
  ClearContractor();
  ClearContractorVAT();

  { Reset output variables }
  AContractor := gloContractor;
  AContractorVAT := gloContractorVAT;

  frmMain.WB1.Stop;
  frmMain.WB1.Navigate('about:blank');
  frmMain.WB1.Navigate(gloURL1);

  // Padaryti timeout ir su state ir gal kartojima
  while frmMain.WB1.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

end;

function FindSpecificElement(AText: String; out aPersonCodeID: String;
  out aCodeID: String): Boolean;
Var
  sConst, sID, sTemp1, sTemp2: String;
  i: Integer;
begin
  Result := False;
  sConst := 'class="aui-field-input aui-field-input-choice" id="_farmersvatcompensationportlet_WAR_EskisLiferayPortletsportlet_';
  sID := '_farmersvatcompensationportlet_WAR_EskisLiferayPortletsportlet_';
  sTemp1 := AText;
  i := Pos(sConst, AText);
  if i > 0 then
  begin
    Delete(sTemp1, 1, i + length(sConst) - 1);
    sTemp2 := sTemp1;
    Delete(sTemp1, 5, length(sTemp1) - 5);
    aPersonCodeID := sID + trim(sTemp1);
  end;

  i := Pos(sConst, sTemp2);
  if i > 0 then
  begin
    Delete(sTemp2, 1, i + length(sConst) - 1);
    Delete(sTemp2, 5, length(sTemp2) - 5);
    aCodeID := sID + trim(sTemp2);
  end;
end;

initialization

finalization

CoUninitialize;
// if gloAbort <> True then
if Assigned(frmMain) then
begin
  Application.ProcessMessages;
  frmMain.Free;
end;

end.
