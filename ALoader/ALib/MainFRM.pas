unit MainFRM;

interface

uses
  FastMM4, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw_EWB, EwbCore, EmbeddedWB, Vcl.ComCtrls,
  MSHTML_EWB, Winapi.ActiveX, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL;

Type
  TAnimal = record
    Number: String; // Gyvulio numeris:
    Species: String; // R��is:
    Gender: String; // Lytis:
    Breed: String; // Veisl�:
    DateOfBirth: String; // Gimimo data:
    MotherNumber: String; // Motinos  Nr.:
    Passport: String; // Pasas:
    OwnerCode: String; // Laikytojo kodas:
    OwnerName: String; // Laikytojo vardas:
    HerdCode: String; // Bandos kodas:
    HerdAddress: String; // Bandos adresas:
  end;

type
  TfrmMain = class(TForm)
    pnlTop: TPanel;
    pnlMain: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    WB1: TEmbeddedWB;
    SB1: TStatusBar;
    memResult: TMemo;
    PB1: TProgressBar;
    lblCompany: TLabel;
    txtCompany: TEdit;
    lblUser: TLabel;
    txtUser: TEdit;
    lblPassword: TLabel;
    txtpassword: TEdit;
    CheckBox1: TCheckBox;
    Bevel1: TBevel;
    lblAnimalNo: TLabel;
    txtAnimalNo: TEdit;
    btnSubmit: TButton;
    btnCancel: TButton;
    procedure btnSubmitClick(Sender: TObject);
    function Get1(ANumber: String): Boolean;
    function Get2(ANumber: String): Boolean;
    procedure CheckBox1Click(Sender: TObject);
    procedure WB1Authenticate(Sender: TCustomEmbeddedWB; var hwnd: hwnd; var szUserName, szPassWord: WideString; var Rezult: HRESULT);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure WB1DocumentComplete(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    function NavigateDetail2(AHTML: String): Boolean;
    procedure FormCreate(Sender: TObject);
    procedure WB1NavigateComplete2(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
    procedure btnCancelClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function GetData(AUser, APassword, ACompany, ASearchNumber: WideString; out ANumber, ASpecies, AGender, ABreed, ADateOfBirth, AMotherNumber, APassport, AOwnerCode, AOwnerName, AHerdCode, AHerdAddress: WideString): Boolean; Export;
Procedure Debug(); Export;
Function Test(out a: WideString): Boolean; Export;
Function ParseHeader2(AHTML: String): Boolean;
Function ParseValue2(AName, AString: String): String;
function StripHTML(S: string): string;

Const

  URL1 = 'https://www.vic.lt:8102/pls/gris/kl_main.pirmas#';
  URL2 = 'https://www.vic.lt:8102/pls/gris/ataskaitos.gyvulio_judejimo_forma';

  URLCompare1 = 'https://www.vic.lt:8102/pls/gris/kl_main.pirmas';
  URLCompare2 = 'https://www.vic.lt:8102/pls/gris/ataskaitos';

  URLMain = 'https://www.vic.lt:8102/pls/gris/';

var
  frmMain: TfrmMain;
  gloUser: String = 'VG0344';
  gloPsw: String = 'DMANT_3K';
  gloLivestock: TAnimal;
  gloHTML: String = '';
  gloCount, gloCount1: Integer;
  gloCompany: String;
  gloSearchNumber: String;
  gloExecuting: Boolean;
  gloAbort: Boolean;

implementation

Function Test(out a: WideString): Boolean;
begin
  // StrPCopy(a, 'Veikia 1');
  a := 'Veikia3';

  Result := True;
  // ShowMessage('Test');
end;

Function GetData(AUser, APassword, ACompany, ASearchNumber: WideString; out ANumber, ASpecies, AGender, ABreed, ADateOfBirth, AMotherNumber, APassport, AOwnerCode, AOwnerName, AHerdCode, AHerdAddress: WideString): Boolean;
begin
  // Laikina, perkelti i pradzia kazkur
  if assigned(frmMain) then
  begin
     //frmMain.WindowState := wsMaximized;
    frmMain.Show;
  end;

  frmMain.PB1.Position := 0;

  gloExecuting := True;
  gloAbort := False;
  try

    gloCount := 0;
    gloCount1 := 0;
    // AUser := StrAlloc(MAX_PATH);
    // APassword := StrAlloc(MAX_PATH);
    // ACompany := StrAlloc(MAX_PATH);
    // ASearchNumber := StrAlloc(MAX_PATH);

    Result := False;

    if Trim(AUser) <> '' then
      gloUser := AUser;

    if Trim(APassword) <> '' then
      gloPsw := APassword;

    if Trim(ACompany) <> '' then
      gloCompany := ACompany;

    if Trim(ASearchNumber) <> '' then
      gloSearchNumber := ASearchNumber;

    if not assigned(frmMain) then
      Exit;

    // frmMain.Get1('LT000005816831');
    Result := frmMain.Get2(gloSearchNumber);

    // StrDispose(AUser);
    // StrDispose(APassword);
    // StrDispose(ACompany);
    // StrDispose(ASearchNumber);

    while gloExecuting <> False do
    begin
      Application.ProcessMessages;
    end;

    if gloAbort = True then
      ANumber := ''
    else
    begin
      frmMain.PB1.Position := 100;
      ANumber := WideString(gloLivestock.Number);
      ASpecies:= WideString(gloLivestock.Species);
      AGender:= WideString(gloLivestock.Gender);
      ABreed:= WideString(gloLivestock.Breed);
      ADateOfBirth:= WideString(gloLivestock.DateOfBirth);
      AMotherNumber:= WideString(gloLivestock.MotherNumber);
      APassport:= WideString(gloLivestock.Passport);
      AOwnerCode:= WideString(gloLivestock.OwnerCode);
      AOwnerName:= WideString(gloLivestock.OwnerName);
      AHerdCode:= WideString(gloLivestock.HerdCode);
      AHerdAddress:= WideString(gloLivestock.HerdAddress);
    end;
    // Laikina
    // frmMain.Close;

  except
    gloExecuting := False;
    //Abort;
  end;
end;

Procedure Debug();
begin
  if assigned(frmMain) then
  begin
    frmMain.WindowState := wsMaximized;
    frmMain.ShowModal;
  end;
end;

{$R *.dfm}

procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
  WB1.Stop;
  gloExecuting:= False;
  gloAbort:= True;
  raise Exception.Create('Error Message');
  Abort;
end;

procedure TfrmMain.btnSubmitClick(Sender: TObject);
var
  AResult: WideString;
begin
  //Laikina, uzkomentavau, kad nereiktu aprasyti visu parametru
//  if not GetData(txtUser.Text, txtpassword.Text, txtCompany.Text, txtAnimalNo.Text, AResult) then
//    MessageDlg('An error occurs ...', mtError, [mbOK], 0);
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  doc: IHTMLDocument2;
  doc5: IHTMLDocument5;
  HTMLWindow: IHTMLWindow2;
  ElementCollection: IHTMLElementCollection;
  ChildElementCollection: IHTMLElementCollection;
  HtmlElement: IHTMLElement;
  InputElement: IHTMLInputElement;
  i: Integer;
begin
  doc := WB1.Document as IHTMLDocument2;
  // IDoc3 := WB1.Document as IHTMLDocument3;

  ElementCollection := doc.all;


  // ShowMessage(IntToStr(ElementCollection.length));

  for i := 0 to ElementCollection.Length - 1 do
  begin
    try
      HtmlElement := ElementCollection.item(i, '') as IHTMLElement;
    except
      continue;
    end;
    if UpperCase(HtmlElement.tagName) = 'INPUT' then
    begin
      if HtmlElement.id = 'p_nr' then
      begin
        InputElement := HtmlElement as IHTMLInputElement;
        InputElement.value := 'LT000005816834';
      end;

      // ShowMessage(HtmlElement.id);
      // InputElement := HtmlElement as IHTMLInputElement;
      // ShowMessage(InputElement.type_);
    end;
  end;

end;

procedure TfrmMain.CheckBox1Click(Sender: TObject);
begin
  if txtpassword.PasswordChar = #0 then
    txtpassword.PasswordChar := '*'
  else
    txtpassword.PasswordChar := #0;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  // ShowMessage('Close');
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // TOleControl(WB1).Visible := False

end;

function TfrmMain.Get1(ANumber: String): Boolean;
Var
  AScript: String;
  doc: IHTMLDocument2;
  HTMLWindow: IHTMLWindow2;
  ElementCollection: IHTMLElementCollection;
  HtmlElement: IHTMLElement;
  InputElement: IHTMLInputElement;
  i: Integer;
begin
  Result := False;
  WB1.Stop;
  WB1.GoAboutBlank;
  while WB1.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  { Open page and wait }
  WB1.Navigate('https://www.vic.lt:8102/pls/gris/kl_main.pirmas#');

  while WB1.ReadyState < READYSTATE_COMPLETE do
    Application.ProcessMessages;

  { Execute java script for menu expand }
  WB1.ExecScript('slept_IE(''d_5'')', 'JavaScript');

  while WB1.ReadyState < READYSTATE_COMPLETE do
    Application.ProcessMessages;

  { Execute java script for menu navigation }
  AScript := 'ajax_siust2(''kl_main_system.kviesti?x='' + ''5'', ''d_veik'');';
  WB1.ExecScript(AScript, 'JavaScript');

  while WB1.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  doc := WB1.Document as IHTMLDocument2;
  // IDoc3 := WB1.Document as IHTMLDocument3;

  ElementCollection := doc.all;

  if WB1.Focused then
    txtUser.Text := '1'
  else
    txtUser.Text := '0';

  txtAnimalNo.Text := IntToStr(ElementCollection.Length);
  // ShowMessage(IntToStr(ElementCollection.Length));
  if WB1.Focused then
    txtUser.Text := '1'
  else
    txtUser.Text := '0';

  txtAnimalNo.Text := IntToStr(ElementCollection.Length);

  for i := 0 to ElementCollection.Length - 1 do
  begin
    try
      HtmlElement := ElementCollection.item(i, '') as IHTMLElement;
    except
      continue;
    end;
    if UpperCase(HtmlElement.tagName) = 'INPUT' then
    begin
      if HtmlElement.id = 'p_nr' then
      begin
        InputElement := HtmlElement as IHTMLInputElement;
        InputElement.value := 'LT000005816834';
      end;

      // ShowMessage(HtmlElement.id);
      // InputElement := HtmlElement as IHTMLInputElement;
      // ShowMessage(InputElement.type_);
    end;
  end;
end;

function TfrmMain.Get2(ANumber: String): Boolean;
begin
  if gloExecuting = False then
    Exit;

  Result := False;
  try

    WB1.Stop;
    WB1.GoAboutBlank;
    while WB1.ReadyState < READYSTATE_INTERACTIVE do
      Application.ProcessMessages;

    if gloExecuting = False then
      Exit;
    frmMain.PB1.Position := 5;

    { Open page and wait }
    SB1.Panels[0].Text:='Navigate';

    WB1.Navigate(URL2);
    while WB1.ReadyState < READYSTATE_COMPLETE do
      Application.ProcessMessages;
    if gloExecuting = False then
      Exit;

    frmMain.PB1.Position := 10;

    { Fill edit with value }
    WB1.OleObject.Document.Forms.item(0).elements.item(0).value := ANumber;

    SB1.Panels[0].Text:='Fill number';

    frmMain.PB1.Position := 15;
    Application.ProcessMessages;

    { Execute Java Script to submit data }
    SB1.Panels[0].Text:='Execute submit number';
    WB1.ExecScript('document.forma.submit()', 'JavaScript');
    while WB1.ReadyState < READYSTATE_COMPLETE do
      Application.ProcessMessages;

    if gloExecuting = False then
      Exit;
    frmMain.PB1.Position := 25;
    Result := True;
  except

  end;
end;

function TfrmMain.NavigateDetail2(AHTML: String): Boolean;
var
  ATableStart, ATableEnd, ATR1, ATR2, AString: String;
  APosition, APosition2: Integer;
  ATable: TStringList;
  i: Integer;
  IdHTTP: TIdHTTP;
  lIOHandler: TIdSSLIOHandlerSocketOpenSSL;
  AHTMLStream: TStringStream;
begin
  Result := False;

  try

    if gloExecuting = False then
      Exit;
    PB1.Position := 65;
    ATable := TStringList.Create;

    if Trim(AHTML) = '' then
      Exit;

    ATableStart := '<table';
    ATableEnd := '</table';
    ATR1 := '<tr';
    ATR2 := '</tr>';

    { First table found }
    APosition := Pos(ATableStart, AHTML);
    if APosition = 0 then
      Exit;
    Delete(AHTML, 1, APosition + Length(ATableStart)); // Truncate begining until current string

    { Second table found }
    APosition := Pos(ATableStart, AHTML);
    if APosition = 0 then
      Exit;
    Delete(AHTML, 1, APosition + Length(ATableStart)); // Truncate begining until current string

    { Third table found }
    APosition := Pos(ATableStart, AHTML);
    if APosition = 0 then
      Exit;
    Delete(AHTML, 1, APosition - 1); // Truncate begining until current string

    { Find third table end }
    APosition := Pos(ATableEnd, AHTML);
    if APosition = 0 then
      Exit;
    Delete(AHTML, APosition, Length(AHTML) - APosition + 1);

    { Find tables, first, second skip }
    APosition := Pos(ATR1, AHTML);
    if APosition = 0 then
      Exit;
    Delete(AHTML, 1, APosition + Length(ATR1));

    APosition := Pos(ATR1, AHTML);
    if APosition = 0 then
      Exit;
    Delete(AHTML, 1, APosition + Length(ATR1));

    APosition := Pos(ATR1, AHTML);
    if APosition = 0 then
      Exit;
    Delete(AHTML, 1, APosition + Length(ATR1));

    APosition := Pos(ATR1, AHTML);
    if APosition = 0 then
      Exit;

    if gloExecuting = False then
      Exit;
    PB1.Position := 70;

    while APosition <> 0 do
    begin
      APosition2 := Pos(ATR2, AHTML); // Search </TR
      AString := AHTML;
      APosition := Pos(ATR2, AString);

      Delete(AString, APosition, Length(AString) - APosition);
      ATable.Add(Trim(AString));
      Delete(AHTML, 1, APosition2 + Length(ATR1) + Length(ATR2) + 1);
      APosition := Pos(ATR2, AHTML);
    end;

    if gloExecuting = False then
      Exit;
    PB1.Position := 75;

    AString := '';

    for i := ATable.Count - 1 downto 0 do
    begin
      APosition := Pos(gloCompany, ATable[i]);
      if APosition = 0 then
      begin
        AString := ATable[i];
        APosition := Pos('href="', AString);
        Delete(AString, 1, APosition + 5);
        APosition := Pos('"><', AString);
        Delete(AString, APosition, Length(AString) - APosition + 3);
        Break;
      end;
    end;

    if gloExecuting = False then
      Exit;
    PB1.Position := 80;

    if Trim(AString) = '' then
      Exit;

    { Open page and wait }
    try
      IdHTTP := TIdHTTP.Create(nil);
      AHTMLStream := TStringStream.Create;
      lIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

      IdHTTP.IOHandler := lIOHandler;
      IdHTTP.HandleRedirects := True;

      IdHTTP.ConnectTimeout := 10000;
      IdHTTP.Request.Clear;

      IdHTTP.Request.BasicAuthentication := True;
      IdHTTP.Request.Username := gloUser;
      IdHTTP.Request.Password := gloPsw;

      try
      SB1.Panels[0].Text:='Get ...';
        IdHTTP.Get(URLMain + AString, AHTMLStream);
      SB1.Panels[0].Text:='After get ...';
        if gloExecuting = False then
          Exit;
        PB1.Position := 90;
        gloLivestock.OwnerCode := ParseValue2('Laikytojo kodas:', AHTMLStream.DataString);
        gloLivestock.OwnerName := ParseValue2('Laikytojo vardas:', AHTMLStream.DataString);
        gloLivestock.HerdCode := ParseValue2('Bandos kodas:', AHTMLStream.DataString);
        gloLivestock.HerdAddress := ParseValue2('Bandos adresas:', AHTMLStream.DataString);
        memResult.Lines.Add(gloLivestock.OwnerCode);
        memResult.Lines.Add(gloLivestock.OwnerName);
        memResult.Lines.Add(gloLivestock.HerdCode);
        memResult.Lines.Add(gloLivestock.HerdAddress);
        gloExecuting := False;
        // memResult.Lines.Text:= AHTMLStream.DataString;
      except

      end;

      if gloExecuting = False then
        Exit;
      PB1.Position := 95;

    finally
      IdHTTP.free;
      lIOHandler.free;
      AHTMLStream.free;
    end;


    // gloLivestock.OwnerCode := ParseValue2('Laikytojo kodas:', WB2.DocumentSource);
    // gloLivestock.OwnerName := ParseValue2('Laikytojo vardas:', WB2.DocumentSource);
    // gloLivestock.HerdCode := ParseValue2('Bandos kodas:', WB2.DocumentSource);
    // gloLivestock.HerdAddress := ParseValue2('Bandos adresas:', WB2.DocumentSource);

    Result := True;
  finally
    ATable.free;
  end;
end;

function ParseHeader2(AHTML: String): Boolean;
var
  S: String;
  i, APosition, AStart, AEnd: Integer;
  html: TStrings;
begin
  Result := False;

  if Trim(AHTML) = '' then
    Exit;

  frmMain.SB1.Panels[0].Text:='Parsing in details ...';

  gloLivestock.Number := ParseValue2('Gyvulio numeris:', AHTML);
  gloLivestock.Species := ParseValue2('R��is:', AHTML);
  gloLivestock.Gender := ParseValue2('Lytis:', AHTML);
  gloLivestock.Breed := ParseValue2('Veisl�:', AHTML);
  gloLivestock.DateOfBirth := ParseValue2('Gimimo data:', AHTML);
  gloLivestock.MotherNumber := ParseValue2('Motinos  Nr.:', AHTML);
  gloLivestock.Passport := ParseValue2('Pasas:', AHTML);
  // gloLivestock.OwnerCode:=ParseValue('Laikytojo kodas:', AHTML);
  // gloLivestock.:=ParseValue('', AHTML);

end;

Function ParseValue2(AName, AString: String): String;
var
  APosition: Integer;
  b1, b2: String;
begin
  b1 := '<b>';
  b2 := '</b>';
  Result := '';

  if Trim(AName) = '' then
    Exit;

  if Trim(AString) = '' then
    Exit;

  APosition := Pos(AName, AString);
  if APosition = 0 then
    Exit;
  Delete(AString, 1, APosition - 1); // Truncate begining until current string

  { Find first <b> }
  APosition := Pos(UpperCase(b1), UpperCase(AString));
  if APosition = 0 then
    Exit;
  Delete(AString, 1, APosition + Length(b1) - 1);

  { Find last </b> }
  APosition := Pos(UpperCase(b2), UpperCase(AString));
  if APosition = 0 then
    Exit;

  Delete(AString, APosition, Length(AString) - APosition + 1);
  Result := Trim(AString);

  // TODO: for best performace can be implemented function with result as left string for next searh
end;

procedure TfrmMain.WB1Authenticate(Sender: TCustomEmbeddedWB; var hwnd: hwnd; var szUserName, szPassWord: WideString; var Rezult: HRESULT);
begin
  szUserName := gloUser;
  szPassWord := gloPsw;
end;

procedure TfrmMain.WB1DocumentComplete(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
var
  LStream: TStringStream;
  Stream: IStream;
  LPersistStreamInit: IPersistStreamInit;
begin
  Application.ProcessMessages;
  Inc(gloCount);
  if gloExecuting = False then
    Exit;

  if gloCount = 1 then
    frmMain.PB1.Position := 30;

  if gloExecuting = False then
    Exit;

  if gloCount = 2 then
    frmMain.PB1.Position := 45;

  try
    LStream := TStringStream.Create('');
    if gloCount = 3 then
    begin
      if gloExecuting = False then
        Exit;

      SB1.Panels[0].Text:='Parsing ...';

      frmMain.PB1.Position := 50;
      { WAY 1 }
      if Pos(URLCompare1, ShortString(WB1.LocationURL)) > 0 then
      begin
        // Not implemented
      end;

      { WAY 2 }
      if Pos(URLCompare2, ShortString(WB1.LocationURL)) > 0 then
      begin

        LPersistStreamInit := WB1.Document as IPersistStreamInit;
        Stream := TStreamAdapter.Create(LStream, soReference);
        LPersistStreamInit.Save(Stream, True);
        // memResult.Lines.Text := LStream.DataString;//Laikina
        ParseHeader2(LStream.DataString);

        memResult.Lines.Add(gloLivestock.Number);
        memResult.Lines.Add(gloLivestock.Species);
        memResult.Lines.Add(gloLivestock.Gender);
        memResult.Lines.Add(gloLivestock.Breed);
        memResult.Lines.Add(gloLivestock.DateOfBirth);
        memResult.Lines.Add(gloLivestock.MotherNumber);
        memResult.Lines.Add(gloLivestock.Passport);

        Application.ProcessMessages;
        NavigateDetail2(LStream.DataString);
        Application.ProcessMessages;

        // MOVED to WB2
        // memResult.Lines.Add(gloLivestock.OwnerCode);
        // memResult.Lines.Add(gloLivestock.OwnerName);
        // memResult.Lines.Add(gloLivestock.HerdCode);
        // memResult.Lines.Add(gloLivestock.HerdAddress);
      end;
    end;
    if gloCount = 5 then
    begin
      // { WAY 1 }
      // if Pos(URLCompare1, ShortString(WB1.LocationURL)) > 0 then
      // begin
      // // Not implemented
      // end;
      //
      // { WAY 2 }
      // if Pos(URLCompare2, ShortString(WB1.LocationURL)) > 0 then
      // begin
      // LPersistStreamInit := WB1.Document as IPersistStreamInit;
      // Stream := TStreamAdapter.Create(LStream, soReference);
      // LPersistStreamInit.Save(Stream, True);
      // //memResult.Lines.Text := LStream.DataString;
      //
      // gloLivestock.OwnerCode := ParseValue2('Laikytojo kodas:', LStream.DataString);
      // memResult.Lines.Add(gloLivestock.OwnerCode);
      // end;
    end;
  finally
    LStream.free();
  end;
end;

procedure TfrmMain.WB1NavigateComplete2(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);
var
  a: String;
begin
  a := 'a';
end;

function StripHTML(S: string): string;
var
  TagBegin, TagEnd, TagLength: Integer;
begin
  TagBegin := Pos('<', S); // search position of first <

  while (TagBegin > 0) do
  begin // while there is a < in S
    TagEnd := Pos('>', S); // find the matching >
    TagLength := TagEnd - TagBegin + 1;
    Delete(S, TagBegin, TagLength); // delete the tag
    TagBegin := Pos('<', S); // search for next <
  end;

  Result := S; // give the result
end;

initialization

finalization

CoUninitialize;
if gloAbort <> True then
  frmMain.free;

end.
