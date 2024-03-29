﻿unit MainUNT;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw_EWB,
  EwbCore, EmbeddedWB, MSHTML_EWB;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    WB1: TEmbeddedWB;
    Button2: TButton;
    Button3: TButton;
    txtCode: TEdit;
    Label1: TLabel;
    memResult: TMemo;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure WB1DocumentComplete(ASender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure WB1NavigateComplete2(ASender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
  private
    { Private declarations }
    function Proceed1(ACode: String): Boolean;
    function Proceed2(ACode: String): Boolean;
    function Parse1(ASource: String; ASourceText: String): Boolean;
    function Parse2(ASource: String; ASourceText: String): Boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  gloURL1: String = 'http://www.vmi.lt/lt/?itemId=1003741';
  gloURL2: String = 'http://www.vmi.lt/lt/?itemId=1003740';
  gloCount: Integer;

implementation

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
Var
  aElement: IhtmlElement;
  ATimeout: Integer;
  ARepeatCount: Integer;
begin
  memResult.Lines.Clear;
  gloCount := 0;
  ATimeout := 0;
  ARepeatCount := 0;
  WB1.Stop;
  WB1.Navigate('about:blank');
  WB1.Navigate(gloURL1);

  //Padaryti timeout ir su state ir gal kartojima
  while WB1.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;

  while (gloCount < 1) and (ATimeout < 199999999) do
  begin
    Application.ProcessMessages;
    Inc(ATimeout);
  end;

  if ATimeout >= 199999999 then
  begin
    WB1.Stop;
    // WB1.Quit;
    WB1.Navigate('about:blank');
    WB1.Navigate(gloURL1);
    ShowMessage('TimeOut');
    // Exit;
  end;

  // Check emty string
  if trim(txtCode.Text) = '' then
    Exit;

  // If Recognize person code or company code try proceed
  if (length(trim(txtCode.Text)) = 11) or (length(trim(txtCode.Text)) = 13) then
    Proceed1(txtCode.Text)
  else
    Proceed2(txtCode.Text);

end;

procedure TfrmMain.Button2Click(Sender: TObject);
var
  aElement: IhtmlElement;
begin
  WB1.FillForm('InputByPerson_code', '36205301333');
  // WB1.FillFormAndExcecute;

  aElement := WB1.ElementByID['LNGSubmit'];
  if aElement <> nil then
  begin
    aElement.click;
  end;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
var
  aElement: IhtmlElement;
begin
  aElement := WB1.ElementByID['inpPerson_code'];
  if aElement <> nil then
  begin
    aElement.click;
  end;
end;

function TfrmMain.Parse1(ASource, ASourceText: String): Boolean;
var
  AStart: Integer;
  AEnd: Integer;
  AResult: String;
begin
  Result := False;

  // Result parse
  if Pos('Įrašų nerasta', WB1.DocumentSource) > 0 then
  begin
    memResult.Lines.Add('Įrašų nerasta');
    // try parse 2
    Proceed2(txtCode.Text);
    Exit;
  end;

  AStart := Pos('Paieškos rezultatai', ASourceText);

  AResult := ASourceText;
  Delete(AResult, 1, AStart - 1);

  AEnd := Pos('Konsultacijos mokesčių klausimais telefonu 1882', AResult);
  Delete(AResult, AEnd, length(AResult) - AEnd);

  memResult.Lines.Text := trim(AResult);

end;

function TfrmMain.Parse2(ASource, ASourceText: String): Boolean;
var
  AStart: Integer;
  AEnd: Integer;
  AResult: String;
begin
  Result := False;

  // Result parse
  if Pos('Įrašų nerasta', WB1.DocumentSource) > 0 then
  begin
    memResult.Lines.Add('Įrašų nerasta');
    Exit;
  end;

  AStart := Pos('Paieškos rezultatai', ASourceText);

  AResult := ASourceText;
  Delete(AResult, 1, AStart - 1);

  AEnd := Pos('Konsultacijos mokesčių klausimais telefonu 1882', AResult);
  Delete(AResult, AEnd, length(AResult) - AEnd);

  memResult.Lines.Text := trim(AResult);
end;

function TfrmMain.Proceed1(ACode: String): Boolean;
var
  aElement: IhtmlElement;
  ATimeout: Integer;
begin
  Result := False;
  ATimeout := 0;

  // Recognize person code and select person code radio button
  if length(trim(txtCode.Text)) = 11 then
  begin
    // Person code 11 symbols
    aElement := WB1.ElementByID['inpPerson_code'];
    if aElement <> nil then
    begin
      aElement.click;
      WB1.FillForm('InputByPerson_code', ACode);
      WB1.FillFormAndExcecute;
    end;
  end;

  // Recognize company code and select company code radio button
  if length(trim(txtCode.Text)) = 13 then
  begin
    // Company code 13 symbols
    aElement := WB1.ElementByID['inpCode'];
    if aElement <> nil then
    begin
      aElement.click;
      WB1.FillForm('InputByCode', ACode);
      WB1.FillFormAndExcecute;
    end;
  end;

  aElement := nil;

  aElement := WB1.ElementByID['LNGSubmit'];
  if aElement <> nil then
  begin
    aElement.click;
  end
  else
    Exit;

  while (gloCount < 2) and (ATimeout < 199999999) do
  begin
    Application.ProcessMessages;
    Inc(ATimeout);
  end;

  if ATimeout >= 199999999 then
  begin
    WB1.Stop;
    WB1.Navigate('about:blank');
    WB1.Navigate(gloURL1);
    ShowMessage('TimeOut');
    Exit;
  end;

  Parse1(WB1.DocumentSource, WB1.DocumentSourceText);
end;

function TfrmMain.Proceed2(ACode: String): Boolean;
var
  ATimeout: Integer;
  aElement: IhtmlElement;
begin
  Result := False;

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
    ShowMessage ('Timeout');
    Exit;
  end;

  aElement := WB1.ElementByID['inpCode'];
  if aElement <> nil then
  begin
    aElement.click;
    WB1.FillForm('InputByCode', ACode);
    WB1.FillFormAndExcecute;
  end;

  aElement := nil;

  aElement := WB1.ElementByID['LNGSubmit'];
  if aElement <> nil then
  begin
    aElement.click;
  end
  else
    Exit;

  ATimeout := 0;
  while (gloCount < 2) and (ATimeout < 199999999) do
  begin
    Application.ProcessMessages;
    Inc(ATimeout);
  end;

  if ATimeout >= 199999999 then
  begin
    ShowMessage ('Timeout');
    Exit;
  end;

  Parse2(WB1.DocumentSource, WB1.DocumentSourceText);

end;

procedure TfrmMain.WB1DocumentComplete(ASender: TObject; const pDisp: IDispatch;
  var URL: OleVariant);
var
  aElement: IhtmlElement;
begin
  Inc(gloCount);
  Application.ProcessMessages;
  // if gloCount = 1 then
  // begin
  // aElement := WB1.ElementByID['inpPerson_code'];
  // if aElement <> nil then
  // begin
  // aElement.click;
  // end;
  // end;
  //
  // if gloCount = 2 then
  // begin
  // aElement := WB1.ElementByID['inpPerson_code'];
  // if aElement <> nil then
  // begin
  // aElement.click;
  // end;
  // end;
end;

procedure TfrmMain.WB1NavigateComplete2(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  aElement: IhtmlElement;
begin
  // aElement := WB1.ElementByID['inpPerson_code'];
  // if aElement <> nil then
  // begin
  // aElement.click;
  // end;
end;

end.
