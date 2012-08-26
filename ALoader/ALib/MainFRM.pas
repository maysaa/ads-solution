unit MainFRM;

interface

uses
  FastMM4, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.OleCtrls, SHDocVw_EWB, EwbCore, EmbeddedWB, Vcl.ComCtrls;

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
    procedure btnSubmitClick(Sender: TObject);
    function Get1(ANumber: String): Boolean;
    procedure CheckBox1Click(Sender: TObject);
    procedure WB1Authenticate(Sender: TCustomEmbeddedWB; var hwnd: hwnd; var szUserName, szPassWord: WideString; var Rezult: HRESULT);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Function GetData(AUser, APassword: PChar): Boolean; Export;
Procedure Debug(); Export;
Function Test(a: PChar): Boolean; Export;

var
  frmMain: TfrmMain;
  gloUser: String = 'VG0344';
  gloPsw: String = 'DMANT_3K';

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
begin
  Get1('LT000005816831');
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

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  ShowMessage('before close');

end;

function TfrmMain.Get1(ANumber: String): Boolean;
Var
  AScript: String;
begin
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

end;

procedure TfrmMain.WB1Authenticate(Sender: TCustomEmbeddedWB; var hwnd: hwnd; var szUserName, szPassWord: WideString; var Rezult: HRESULT);
begin
  szUserName := gloUser;
  szPassWord := gloPsw;
end;

end.
