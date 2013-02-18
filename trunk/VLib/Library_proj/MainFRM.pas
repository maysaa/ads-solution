unit MainFRM;

interface

uses
  FastMM4, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ActiveX;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  gloContractor: TContractor;
  gloContractorVAT: TContractorVAT;

Function GetData(ANumber: WideString; out AContractor: TContractor;
  out AContractorVAT: TContractorVAT): Boolean; export;
Procedure ClearContractor();
Procedure ClearContractorVAT();

implementation

{$R *.dfm}

Function GetData(ANumber: WideString; out AContractor: TContractor;
  out AContractorVAT: TContractorVAT): Boolean;
begin
  Result := False;
  if not Assigned(frmMain) then
  begin
    Exit;
  end;

  if trim(ANumber) = '' then
  begin
    Exit;
  end;

  { Reset data }
  ClearContractor();
  ClearContractorVAT();

  gloContractor.Name := 'Artūras Plytninkas';
  gloContractor.Code := '3610524083427';
  gloContractor.LicenceNo := '1020000002204';
  gloContractor.StartDate := '2002.03.29';
  gloContractor.StartLicenceDate := '2002.04.01';
  gloContractor.EndDate := '2004.09.24';
  gloContractor.EndLicenceDate := '2004.09.27';
  gloContractor.InfoNotes := '2004.10.15';
  gloContractor.EndCause :=
    'Ūkininko registruotas žemės plotas didesnis kaip 7 ha';
  gloContractor.Notes := 'registruotas žemės plotas didesnis kaip 7 ha';

  gloContractorVAT.Name := 'ARTŪRAS PLYTNINKAS';
  gloContractorVAT.VATCode := 'LT100001615913';
  gloContractorVAT.StartDate := '2005.05.10';
  gloContractorVAT.EndDate := '2012.06.14';

  AContractor := gloContractor;
  AContractorVAT := gloContractorVAT;

  { Init }

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

initialization

finalization

CoUninitialize;
// if gloAbort <> True then
frmMain.free;

end.
