program FMXClientProj;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  VenecuelaService in '..\Server\Common\VenecuelaService.pas',
  ufrmCountries in 'ufrmCountries.pas' {frmCountry},
  ufrmZipCode in 'ufrmZipCode.pas' {frmZipCode};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
