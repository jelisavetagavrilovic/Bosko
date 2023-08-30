program VenecuelaTestClient;

uses
  Vcl.Forms,
  WEBLib.Forms,
  ufrmMain in 'ufrmMain.pas' {frmMain: TWebForm} {*.html},
  uWDM in 'uWDM.pas' {WDM: TWebDataModule},
  uTypes in 'uTypes.pas',
  ufrmZip in 'ufrmZip.pas' {frmZipCode: TWebForm} {*.html},
  uCountries in 'uCountries.pas' {frmCountries: TWebForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TWDM, WDM);
  Application.CreateForm(TfrmZipCode, frmZipCode);
  Application.CreateForm(TfrmCountries, frmCountries);
  Application.Run;
end.
