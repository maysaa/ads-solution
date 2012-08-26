unit MainFRM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, dxSkinscxPCPainter,
  dxLayoutContainer, dxLayoutControl, cxContainer, cxEdit, dxLayoutcxEditAdapters, cxTextEdit, dxLayoutControlAdapters, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, SHDocVw_EWB, EwbCore, EmbeddedWB, Winapi.ActiveX;

type
  TfrmMain = class(TForm)
    dxLayoutControl1Group_Root: TdxLayoutGroup;
    dxLayoutControl1: TdxLayoutControl;
    cxTextEdit1: TcxTextEdit;
    dxLayoutControl1Item1: TdxLayoutItem;
    btnGet: TcxButton;
    dxLayoutControl1Item2: TdxLayoutItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function Get(): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

Function GetData(): Boolean; export;

implementation

{$R *.dfm}

uses ALoaderUNT;

Function GetData(): Boolean; export;
begin
  Result := False;
  if not Assigned(frmMain) then
  begin
    Exit;
  end;
  frmMain.Get();
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ShowMessage ('before close');
  Action := caFree;
  //CoUninitialize;
end;

function TfrmMain.Get(): Boolean;
begin
  Result := False;
  ShowMessage('iskvietineju');
  exit;

//  WB1.Stop;
//  WB1.GoAboutBlank;
//  while WB1.ReadyState < READYSTATE_INTERACTIVE do
//    Application.ProcessMessages;
//
//  WB1.Navigate('https://www.vic.lt:8102/pls/gris/ataskaitos.gyvulio_judejimo_forma');
//  while (WB1.ReadyState <> READYSTATE_COMPLETE) do
//    Application.ProcessMessages;

  // WebBrowser1.Navigate('http://www.delfi.lt');
  ShowMessage('iskvieciau');

end;

end.
