unit MainFRM;

interface

uses
  FastMM4, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw_EWB, EwbCore, EmbeddedWB, Vcl.ComCtrls,
  MSHTML_EWB;

Type
  TAnimal = record
    Number: String; // Gyvulio numeris:
    Species: String; // Rûðis:
    Gender: String; // Lytis
    Breed: String; // Veislë:
    DateOfBirth: String; // Gimimo  data:
    MotherNumber: String; // Motinos  Nr.:
    Passport: String; // Pasas
    OwnerCode: String; // Laikytojo kodas
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
    Memo1: TMemo;
    procedure btnSubmitClick(Sender: TObject);
    function Get1(ANumber: String): Boolean;
    function Get2(ANumber: String): Boolean;
    procedure CheckBox1Click(Sender: TObject);
    procedure WB1Authenticate(Sender: TCustomEmbeddedWB; var hwnd: hwnd; var szUserName, szPassWord: WideString; var Rezult: HRESULT);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function GetData(AUser, APassword: PChar): Boolean; Export;
Procedure Debug(); Export;
Function Test(a: PChar): Boolean; Export;
Function ParseHeader(AHTML: TStrings): Boolean;
function StripHTML(S: string): string;

var
  frmMain: TfrmMain;
  gloUser: String = 'VG0344';
  gloPsw: String = 'DMANT_3K';
  gloLivestock: TAnimal;

implementation

Function Test(a: PChar): Boolean;
begin
  Result := True;
  ShowMessage('Test');
end;

Function GetData(AUser, APassword: PChar): Boolean;
begin
  AUser := StrAlloc(MAX_PATH);
  APassword := StrAlloc(MAX_PATH);

  ShowMessage('GetData start ' + IntToStr(Length(AUser)));
  Result := False;

  if Trim(AUser) <> '' then
    gloUser := AUser;

  if Trim(APassword) <> '' then
    gloPsw := APassword;

  if not assigned(frmMain) then
    Exit;

  frmMain.Get1('LT000005816831');

  ShowMessage('GetData end');
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
  ShowMessage('before parse');

  doc := WB1.Document as IHTMLDocument2;

  iall := doc.body;

  while iall.parentElement <> nil do
  begin
    iall := iall.parentElement;
  end;

  Memo1.Text := iall.outerHTML;

  ParseHeader(Memo1.Lines);

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
  ShowMessage('Close');
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

function ParseHeader(AHTML: TStrings): Boolean;
var
  S: String;
  i, APosition: Integer;
  html: TStrings;
begin
  Result := False;

  if AHTML.Count = 0 then
    Exit;

  try

    html := TStrings.Create;
    html:= AHTML;

    // Main loop
    for i := 0 to html.Count - 1 do
    begin
      S := html[i];

      // Gyvulio numeris:
      APosition := POS('Gyvulio numeris:', S);
      if APosition > 0 then
      begin
        S := StripHTML(S);
        Delete(S, APosition, 16);
        gloLivestock.Number := Trim(S);
        ShowMessage(gloLivestock.Number);
      end
      else
        gloLivestock.Number := '';

    end;
  finally
    html.Free;
  end;
end;

procedure TfrmMain.WB1Authenticate(Sender: TCustomEmbeddedWB; var hwnd: hwnd; var szUserName, szPassWord: WideString; var Rezult: HRESULT);
begin
  szUserName := gloUser;
  szPassWord := gloPsw;
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
