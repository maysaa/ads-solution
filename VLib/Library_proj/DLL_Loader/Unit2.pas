﻿unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

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

  TGetInfo = function(ANumber: WideString; out AContractor: TContractor;
    out AContractorVAT: TContractorVAT): Boolean;
  TTest = function(ANumber: WideString; out AContractor: TContractor;
    out AContractorVAT: TContractorVAT): Boolean;

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
  Test: TTest;
  resContractor: TContractor;
  resContractorVAT: TContractorVAT;
  AResult: Boolean;
begin
  dllHandle := LoadLibrary
    ('d:\DEV\ADS\trunk\VLib\Library_proj\Win32\Debug\VLib.dll');
  if dllHandle <> 0 then
  begin
    // @GetInfo := GetProcAddress(dllHandle, 'GetData');
    @GetInfo := GetProcAddress(dllHandle, 'GetData');
    // if Assigned(GetInfo) then
    // begin
    // GetInfo('46008281120',resContractor, resContractorVAT);

    // ShowMessage(resContractor.Name);
    // ShowMessage(resContractorVAT.Name);
    if Assigned(GetInfo) then
    begin
      AResult := GetInfo('45609190875', resContractor, resContractorVAT);
      if AResult then
      begin
        ShowMessage(resContractor.Code);
        ShowMessage(resContractorVAT.Name);
      end
      else
        ShowMessage('Error occurs from DLL');
    end
    else
      ShowMessage('"GetData" function not found');
    FreeLibrary(dllHandle);
  end
  else
  begin
    ShowMessage('VLib.dll not found / not loaded');
  end;
end;

end.
