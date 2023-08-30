program XDataServer;

uses
  Vcl.Forms,
  uServerCont in '..\Common\uServerCont.pas' {ServCont: TDataModule},
  uFrmMain in 'uFrmMain.pas' {MainForm},
  uDM in '..\Common\uDM.pas' {DM: TDataModule},
  VenecuelaService in '..\Common\VenecuelaService.pas',
  VenecuelaServiceImplementation in '..\Common\VenecuelaServiceImplementation.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServCont, ServCont);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
