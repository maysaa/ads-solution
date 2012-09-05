unit MainFRM;

interface

uses
  FastMM4, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw_EWB, EwbCore, EmbeddedWB, Vcl.ComCtrls,
  MSHTML_EWB, Winapi.ActiveX;

Type
  TAnimal = record
    Number: String; // Gyvulio numeris:
    Species: String; // Rûðis:
    Gender: String; // Lytis:
    Breed: String; // Veislë:
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
    lblAnimalNo: TLabel;
    txtAnimalNo: TEdit;
    btnSubmit: TButton;
    pnlMain: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    WB1: TEmbeddedWB;
    txtUser: TEdit;
    lblUser: TLabel;
    lblPassword: TLabel;
    txtpassword: TEdit;
    Bevel1: TBevel;
    CheckBox1: TCheckBox;
    lblCompany: TLabel;
    txtCompany: TEdit;
    StatusBar1: TStatusBar;
    memResult: TMemo;
    procedure btnSubmitClick(Sender: TObject);
    function Get1(ANumber: String): Boolean;
    function Get2(ANumber: String): Boolean;
    procedure CheckBox1Click(Sender: TObject);
    procedure WB1Authenticate(Sender: TCustomEmbeddedWB; var hwnd: hwnd; var szUserName, szPassWord: WideString; var Rezult: HRESULT);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure WB1DocumentComplete(ASender: TObject; const pDisp: IDispatch; var URL: OleVariant);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function GetData(AUser, APassword, ACompany, ASearchNumber: PChar): Boolean; Export;
Procedure Debug(); Export;
Function Test(a: PChar): Boolean; Export;
Function ParseHeader(AHTML: String): Boolean;
Function ParseValue(AName, AString: String): String;
function StripHTML(S: string): string;

var
  frmMain: TfrmMain;
  gloUser: String = 'VG0344';
  gloPsw: String = 'DMANT_3K';
  gloLivestock: TAnimal;
  gloHTML: String = '';
  gloCount: Integer;

implementation

Function Test(a: PChar): Boolean;
begin
  Result := True;
  //ShowMessage('Test');
end;

Function GetData(AUser, APassword, ACompany, ASearchNumber: PChar): Boolean;
begin
  gloCount := 0;
  AUser := StrAlloc(MAX_PATH);
  APassword := StrAlloc(MAX_PATH);

  //ShowMessage('GetData start ' + IntToStr(Length(AUser)));
  Result := False;

  if Trim(AUser) <> '' then
    gloUser := AUser;

  if Trim(APassword) <> '' then
    gloPsw := APassword;

  if not assigned(frmMain) then
    Exit;

  frmMain.Get1('LT000005816831');

  //ShowMessage('GetData end');
  StrDispose(AUser);
  StrDispose(APassword);
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

procedure TfrmMain.btnSubmitClick(Sender: TObject);
var
  doc: IHTMLDocument2;
  ElementCollection: IHTMLElementCollection;
  iall: IHTMLElement;

  i: Integer;
begin
  Get2('LT000006042643');

  // ShowMessage('before parse');

//  doc := WB1.Document as IHTMLDocument2;
//
//  iall := doc.body;
//
//  while iall.parentElement <> nil do
//  begin
//    iall := iall.parentElement;
//  end;

  //ParseHeader(iall.outerHTML);

  // memResult.Lines.Add(iall.outerHTML);

  // // Memo1.Text := iall.outerHTML;
  // //
  // // ParseHeader(Memo1.Lines);
  //
  // memResult.Lines.Add(gloLivestock.Number);
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
  //ShowMessage('Close');
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
  Result := False;
  WB1.Stop;
  WB1.GoAboutBlank;
  while WB1.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  { Open page and wait }
  WB1.Navigate('https://www.vic.lt:8102/pls/gris/ataskaitos.gyvulio_judejimo_forma');
  while WB1.ReadyState < READYSTATE_COMPLETE do
    Application.ProcessMessages;

  { Fill edit with value }
  WB1.OleObject.Document.Forms.item(0).elements.item(0).value := ANumber;

  { Execute Java Script to submit data }
  WB1.ExecScript('document.forma.submit()', 'JavaScript');
  while WB1.ReadyState < READYSTATE_COMPLETE do
    Application.ProcessMessages;

end;

function ParseHeader(AHTML: String): Boolean;
var
  S: String;
  i, APosition, AStart, AEnd: Integer;
  html: TStrings;
begin
  Result := False;

  if Trim(AHTML) = '' then
    Exit;

  gloLivestock.Number := ParseValue('Gyvulio numeris:', AHTML);
  gloLivestock.Species := ParseValue('Rûðis:', AHTML);
  gloLivestock.Gender := ParseValue('Lytis:', AHTML);
  gloLivestock.Breed := ParseValue('Veislë:', AHTML);
  gloLivestock.DateOfBirth := ParseValue('Gimimo data:', AHTML);
  gloLivestock.MotherNumber := ParseValue('Motinos  Nr.:', AHTML);
  gloLivestock.Passport := ParseValue('Pasas:', AHTML);
  // gloLivestock.OwnerCode:=ParseValue('Laikytojo kodas:', AHTML);
  // gloLivestock.:=ParseValue('', AHTML);

end;

Function ParseValue(AName, AString: String): String;
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

  APosition := POS(AName, AString);
  if APosition = 0 then
    Exit;
  Delete(AString, 1, APosition - 1); // Truncate begining until current string

  { Find first <b> }
  APosition := POS(b1, AString);
  if APosition = 0 then
    Exit;
  Delete(AString, 1, APosition + Length(b1) - 1);

  { Find last </b> }
  APosition := POS(b2, AString);
  if APosition = 0 then
    Exit;

  Delete(AString, APosition, Length(AString) - APosition + 1);
  Result := Trim(AString);
  Exit;

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
  Inc(gloCount);
  if gloCount = 3 then
  begin
    LStream := TStringStream.Create('');
    try
      LPersistStreamInit := WB1.Document as IPersistStreamInit;
      Stream := TStreamAdapter.Create(LStream, soReference);
      LPersistStreamInit.Save(Stream, True);
      memResult.Lines.Text := LStream.DataString;
      ParseHeader(LStream.DataString);
      memResult.Lines.Add(gloLivestock.Number);
    finally
      LStream.Free();
    end;

  end;

end;

function StripHTML(S: string): string;
var
  TagBegin, TagEnd, TagLength: Integer;
begin
  TagBegin := POS('<', S); // search position of first <

  while (TagBegin > 0) do
  begin // while there is a < in S
    TagEnd := POS('>', S); // find the matching >
    TagLength := TagEnd - TagBegin + 1;
    Delete(S, TagBegin, TagLength); // delete the tag
    TagBegin := POS('<', S); // search for next <
  end;

  Result := S; // give the result
end;

end.
