program LoadAdsProject;

uses
  Forms,
  LoadAds in 'LoadAds.pas' {LoadAdvertisementsForm},
  UnitPing in 'UnitPing.pas',
  Unit1 in 'autogidasJPGtoSTRv3\Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLoadAdvertisementsForm, LoadAdvertisementsForm);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
