unit MainFRM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls, MSHTML_EWB, Vcl.ExtCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, ActiveX, SHDocVw_EWB,
  EwbCore, EmbeddedWB, UI_Less, SecurityManager, Winapi.UrlMon, EwbEventsComp;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Button3: TButton;
    RadioGroup1: TRadioGroup;
    IdHTTP1: TIdHTTP;
    Button4: TButton;
    Memo1: TMemo;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    WB1: TEmbeddedWB;
    Button5: TButton;
    WebBrowser1: TWebBrowser;
    SecurityManager1: TSecurityManager;
    Button6: TButton;
    Button7: TButton;
    HtmlListener1: THtmlListener;
    EwbC1: TEwbCore;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure WB1Authenticate(Sender: TCustomEmbeddedWB; var hwnd: hwnd; var szUserName, szPassWord: WideString; var Rezult: HResult);
    procedure WB1ShowDialog(Sender: TObject; h: NativeUInt; StyleEx: Integer; OldCaption: string; var NewCaption: WideString;
      var Cancel: Boolean);
    function WB1ShowMessage(Sender: TObject; hwnd: NativeUInt; lpstrText, lpstrCaption: PWideChar; dwType: Integer;
      lpstrHelpFile: PWideChar; dwHelpContext: Integer; var plResult: NativeInt): HResult;
    function SecurityManager1GetSecurityID(pwszUrl: PWideChar; pbSecurityId: Pointer; var cbSecurityId: Cardinal;
      dwReserved: Cardinal): HResult;
    function SecurityManager1GetZoneMappings(dwZone: Cardinal; out enumString: IEnumString; dwFlags: Cardinal): HResult;
    function SecurityManager1QueryCustomPolicy(pwszUrl: PWideChar; const guidKey: TGUID; out pPolicy: Pointer; out cbPolicy: Cardinal;
      pContext: Pointer; cbContext, dwReserved: Cardinal): HResult;
    function SecurityManager1MapUrlToZone(pwszUrl: PWideChar; out dwZone: Cardinal; dwFlags: Cardinal): HResult;
    function SecurityManager1ProcessUrlAction(pwszUrl: PWideChar; dwAction: Cardinal; pPolicy: Pointer; cbPolicy: Cardinal;
      pContext: Pointer; cbContext, dwFlags, dwReserved: Cardinal): HResult;
    function SecurityManager1SetZoneMapping(dwZone: Cardinal; lpszPattern: PWideChar; dwFlags: Cardinal): HResult;
    function SecurityManager1GetSecuritySite(out Site: IInternetSecurityMgrSite): HResult;
    function SecurityManager1SetSecuritySite(Site: IInternetSecurityMgrSite): HResult;
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure WB1PreRefresh(Sender: TObject);
    procedure EwbC1Authenticate(Sender: TCustomEmbeddedWB; var hwnd: hwnd; var szUserName, szPassWord: WideString; var Rezult: HResult);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
function ExecuteScript(doc: IHTMLDocument2; script: string; language: string): Boolean;
procedure WBLoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);

implementation

{$R *.dfm}

uses WBUtil;

procedure TForm1.Button1Click(Sender: TObject);

begin
  if RadioGroup1.ItemIndex = 0 then
  begin
    WebBrowser1.Navigate('https://www.vic.lt:8102/pls/gris/kl_main.pirmas#');
  end
  else
    WebBrowser1.Navigate('https://www.vic.lt:8102/pls/gris/ataskaitos.gyvulio_judejimo_forma')
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  doc: IHTMLDocument2;
  s: String;

begin
  if RadioGroup1.ItemIndex = 0 then
  begin
    doc := WebBrowser1.Document as IHTMLDocument2;
    ExecuteScript(doc, 'slept_IE(''d_5'')', 'JavaScript');
    s := 'ajax_siust2(''kl_main_system.kviesti?x='' + ''5'', ''d_veik'');';
    ExecuteScript(doc, s, 'JavaScript');
    ShowMessage('Demesio nepabaigta');
  end
  else
    WebBrowser1.OleObject.Document.Forms.item(0).elements.item(0).value := Edit1.Text;
end;

procedure WBLoadHTML(WebBrowser: TWebBrowser; HTMLCode: string);
var
  sl: TStringList;
  ms: TMemoryStream;
begin
  WebBrowser.Navigate('about:blank');
  while WebBrowser.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  if Assigned(WebBrowser.Document) then
  begin
    sl := TStringList.Create;
    try
      ms := TMemoryStream.Create;
      try
        sl.Text := HTMLCode;
        sl.SaveToStream(ms);
        ms.Seek(0, 0);
        (WebBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(ms));
      finally
        ms.Free;
      end;
    finally
      sl.Free;
    end;
  end;
end;

function ExecuteScript(doc: IHTMLDocument2; script: string; language: string): Boolean;
var
  win: IHTMLWindow2;
  Olelanguage: Olevariant;
begin
  if doc <> nil then
  begin
    try
      win := doc.parentWindow;
      if win <> nil then
      begin
        try
          Olelanguage := language;
          win.ExecScript(script, Olelanguage);
        finally
          win := nil;
        end;
      end;
    finally
      doc := nil;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  doc: IHTMLDocument2;
  ElementCollection: IHTMLElementCollection;
  HtmlElement: IHTMLElement;
  InputElement: IHTMLInputElement;
  I: Integer;
begin

  if RadioGroup1.ItemIndex = 0 then
  else
  begin

    doc := WebBrowser1.Document as IHTMLDocument2;

    // IDoc: IHTMLDocument2;
    // Webbrowser1.Document.QueryInterface(IHTMLDocument2, iDoc);
    // ExecuteScript(doc, 'document.login.submit()', 'JavaScript');

    ExecuteScript(doc, 'document.forma.submit()', 'JavaScript');

    (* ElementCollection := doc.all;
      for I := 0 to ElementCollection.length - 1 do
      begin
      try
      HtmlElement := ElementCollection.item(I, '') as IHTMLElement;
      except
      continue;
      end;
      if UpperCase(HtmlElement.tagName) = 'INPUT' then
      begin
      InputElement := HtmlElement as IHTMLInputElement;
      if UpperCase(InputElement.type_) = 'SUBMIT' then
      begin
      HtmlElement.Click;
      Exit;
      end;
      end;
      end;
    *)
  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
var
  BaseURL: String;
  AStream: TMemoryStream;
begin
  BaseURL := 'https://www.vic.lt:8102/pls/gris/ataskaitos.gyvulio_judejimo_forma';
  try
    AStream := TMemoryStream.Create;

    IdHTTP1.Request.Clear;
    IdHTTP1.Request.BasicAuthentication := true;
    IdHTTP1.Request.Username := 'VG0344';
    IdHTTP1.Request.Password := 'DMANT_3K';

    IdHTTP1.Get(BaseURL, AStream);
    AStream.Position := 0;
    Memo1.Lines.LoadFromStream(AStream);

    WBLoadHTML(WebBrowser1, Memo1.Lines.Text);

  finally
    AStream.Free
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  WB1.Navigate('about:blank');
  WB1.Navigate('https://www.vic.lt:8102/pls/gris/ataskaitos.gyvulio_judejimo_forma');
  WB1.ShowImportExportFavoritesAndCookies;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  doc: IHTMLDocument2;
  IDoc3: IHTMLDocument3;
  aForm: IHTMLFormElement;
  s: String;
  ElementCollection: IHTMLElementCollection;
  HtmlElement: IHTMLElement;
  InputElement: IHTMLInputElement;
  I: Integer;

  iForms, iFormItems, iSelectItems: Word;
  FormItem: Olevariant;
begin
 WB1.Stop;
  WB1.GoAboutBlank;
  while WB1.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  // WB1.Navigate('about:blank');
  WB1.Navigate('https://www.vic.lt:8102/pls/gris/kl_main.pirmas#');
  // WB1.Navigate('https://www.vic.lt:8102/pls/gris/ataskaitos.gyvulio_judejimo_forma');

  while WB1.ReadyState < READYSTATE_COMPLETE do
    Application.ProcessMessages;

  // doc := WB1.Document as IHTMLDocument2;
  // if Assigned(WB1.Document) then

  //sleep(5000);

  WB1.ExecScript('slept_IE(''d_5'')', 'JavaScript');
  // WB1.ExecScript('document.forma.submit()', 'JavaScript');

  while WB1.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  s := 'ajax_siust2(''kl_main_system.kviesti?x='' + ''5'', ''d_veik'');';
  WB1.ExecScript(s, 'JavaScript');

    while WB1.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  doc := WB1.Document as IHTMLDocument2;
  IDoc3 := WB1.Document as IHTMLDocument3;

  ElementCollection := doc.all;
  for I := 0 to ElementCollection.length - 1 do
  begin
    try
      HtmlElement := ElementCollection.item(I, '') as IHTMLElement;
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

    // if UpperCase(HtmlElement.tagName) = 'INPUT' then
    // begin
    // InputElement := HtmlElement as IHTMLInputElement;
    // if UpperCase(InputElement.type_) = 'SUBMIT' then
    // begin
    // //HtmlElement.Click;
    // Exit;
    // end;
    // end;
  end;

end;

procedure TForm1.Button7Click(Sender: TObject);
var
  s: String;
  doc: IHTMLDocument2;
  HTMLWindow: IHTMLWindow2;
begin

  WB1.ExecScript('slept_IE(''d_5'')', 'JavaScript');
  exit;

  // s:= 'ajax_siust2(''kl_main.gyvunas?p_nr=''+ document.getElementById(''p_nr'').value &#10;    + ''&amp;p_iv='' + 5+''&amp;p_ived=&amp;p_type='', ''d_iv'');';
  // s := 'ajax_siust2(''kl_main_system.kviesti?x='' + ''5'', ''d_veik'');';


  // WB1.ExecScript(s, 'JavaScript');

  EwbC1.Navigate('about:blank');
  EwbC1.Navigate('https://www.vic.lt:8102/pls/gris/kl_main.pirmas#');
  // WB1.Navigate('https://www.vic.lt:8102/pls/gris/ataskaitos.gyvulio_judejimo_forma');

  while EwbC1.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  doc := EwbC1.Document as IHTMLDocument2;

  if not Assigned(doc) then
    Exit;
  // Get parent window of current document
  HTMLWindow := doc.parentWindow;
  if not Assigned(HTMLWindow) then
    Exit;
  // Run JavaScript
  s := 'slept_IE(''d_5'')';
  HTMLWindow.ExecScript(s, 'JavaScript'); // execute function

//  ExecuteScript(doc, 'slept_IE(''d_5'')', 'JavaScript');
//  s := 'ajax_siust2(''kl_main_system.kviesti?x='' + ''5'', ''d_veik'');';
//  ExecuteScript(doc, s, 'JavaScript');

end;

procedure TForm1.EwbC1Authenticate(Sender: TCustomEmbeddedWB; var hwnd: hwnd; var szUserName, szPassWord: WideString; var Rezult: HResult);
begin
  szUserName := 'VG0344';
  szPassWord := 'DMANT_3K';
end;

function TForm1.SecurityManager1GetSecurityID(pwszUrl: PWideChar; pbSecurityId: Pointer; var cbSecurityId: Cardinal;
  dwReserved: Cardinal): HResult;
begin
  ShowMessage('1');
end;

function TForm1.SecurityManager1GetSecuritySite(out Site: IInternetSecurityMgrSite): HResult;
begin
  ShowMessage('2');
end;

function TForm1.SecurityManager1GetZoneMappings(dwZone: Cardinal; out enumString: IEnumString; dwFlags: Cardinal): HResult;
begin
  ShowMessage('3');
end;

function TForm1.SecurityManager1MapUrlToZone(pwszUrl: PWideChar; out dwZone: Cardinal; dwFlags: Cardinal): HResult;
begin
  ShowMessage('4');
end;

function TForm1.SecurityManager1ProcessUrlAction(pwszUrl: PWideChar; dwAction: Cardinal; pPolicy: Pointer; cbPolicy: Cardinal;
  pContext: Pointer; cbContext, dwFlags, dwReserved: Cardinal): HResult;
begin
  ShowMessage('5');
end;

function TForm1.SecurityManager1QueryCustomPolicy(pwszUrl: PWideChar; const guidKey: TGUID; out pPolicy: Pointer; out cbPolicy: Cardinal;
  pContext: Pointer; cbContext, dwReserved: Cardinal): HResult;
begin
  ShowMessage('6');
end;

function TForm1.SecurityManager1SetSecuritySite(Site: IInternetSecurityMgrSite): HResult;
begin
  ShowMessage('7');
end;

function TForm1.SecurityManager1SetZoneMapping(dwZone: Cardinal; lpszPattern: PWideChar; dwFlags: Cardinal): HResult;
begin
  ShowMessage('8');
end;

procedure TForm1.WB1Authenticate(Sender: TCustomEmbeddedWB; var hwnd: hwnd; var szUserName, szPassWord: WideString; var Rezult: HResult);
begin
  szUserName := 'VG0344';
  szPassWord := 'DMANT_3K';
  // Rezult:=S_OK;
end;

procedure TForm1.WB1PreRefresh(Sender: TObject);
begin
  //ShowMessage('PREREFRESH');
end;

procedure TForm1.WB1ShowDialog(Sender: TObject; h: NativeUInt; StyleEx: Integer; OldCaption: string; var NewCaption: WideString;
  var Cancel: Boolean);
begin
  // SendMessage(h, WM_COMMAND, IDYES, 0);
  // PostMessage(h, WM_COMMAND, ID_OK, 0);
end;

function TForm1.WB1ShowMessage(Sender: TObject; hwnd: NativeUInt; lpstrText, lpstrCaption: PWideChar; dwType: Integer;
  lpstrHelpFile: PWideChar; dwHelpContext: Integer; var plResult: NativeInt): HResult;
begin
  /// SendMessage(hwnd, WM_COMMAND, IDYES, 0);
  // PostMessage(hwnd, WM_COMMAND, ID_OK, 0);
end;



end.
