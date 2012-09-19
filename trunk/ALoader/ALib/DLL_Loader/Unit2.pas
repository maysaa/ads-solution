unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type

  TGetInfo = function(AUser, APassword, ACompany, ASearchNumber: WideString; out ANumber: WideString): Boolean;
//  GetData(AUser, APassword, ACompany, ASearchNumber: WideString; out ANumber: WideString): Boolean; Export;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  dllHandle: cardinal;
  GetInfo: TGetInfo;
  aResult: PWideChar;
  a: WideString;
begin
  // aResult:= AllocMem(10);
  dllHandle := LoadLibrary('d:\DEV\ADS\trunk\ALoader\ALib\Win32\Debug\ALib.dll');
  if dllHandle <> 0 then
  begin
    @GetInfo := GetProcAddress(dllHandle, 'GetData');
    if Assigned(GetInfo) then
    begin
      GetInfo('VG0344','DMANT_3K','UAB" BARTYNCO "','LT000005816835', a);
      ShowMessage(a);
    end
    else
      ShowMessage('"GetData" function not found');
    FreeLibrary(dllHandle);
  end
  else
  begin
    ShowMessage('ALib.dll not found / not loaded');
  end;
//   FreeMem(aResult, 10);
end;

end.
