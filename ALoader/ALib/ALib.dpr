library ALib;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  FastMM4,
  System.SysUtils,
  System.Classes,
  Dialogs,
  ActiveX,
  MainFRM in 'MainFRM.pas' {frmMain};

{$R *.res}

Exports GetData, Debug, Test;



begin
  try
    CoInitialize(nil);

    frmMain := TfrmMain.Create(nil);
    //frmMain.ShowModal;
  finally
end;
end.
