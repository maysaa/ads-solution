unit ALoaderUNT;

interface

uses
  System.SysUtils,
  System.Classes,
  SHDocVw,
  Vcl.Dialogs,
  Winapi.ActiveX;

procedure Test(window, hInstance: integer; cmdLine: pchar; showCmd: integer); Export;
function InitLib(): Boolean; export;
Procedure CloseLib(); export;

implementation

uses MainFRM;

//procedure Test(window, hInstance: integer; cmdLine: pchar; showCmd: integer); stdcall;


procedure Test(window, hInstance: integer; cmdLine: pchar; showCmd: integer); Export;
begin
  ShowMessage('Test');
    frmMain := TfrmMain.Create(nil);
    frmMain.Show;
end;

function InitLib(): Boolean; export;
begin
Exit;
  Result := false;
  frmMain.Show;
  GetData();
  frmMain.Close;
  CloseLib();
end;

Procedure CloseLib(); export;
begin
  CoUninitialize;
end;

end.
