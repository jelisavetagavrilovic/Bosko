library mod_bg_test;

uses
  {$IFDEF MSWINDOWS}
  Winapi.ActiveX,
  System.Win.ComObj,
  {$ENDIF }
  Web.WebBroker,
  Web.ApacheApp,
  Web.HTTPD24Impl,
  uWM in 'uWM.pas' {WM: TWebModule},
  uDB in 'Common\uDB.pas',
  ConnectionModule in 'Common\ConnectionModule.pas' {FireDacMySqlConnection: TDataModule},
  VenecuelaService in 'Common\VenecuelaService.pas',
  VenecuelaServiceImplementation in 'Common\VenecuelaServiceImplementation.pas';

{$R *.res}

// httpd.conf entries:
//
(*
 LoadModule bg_test_module modules/mod_bg_test.dll

 <Location /xyz>
    SetHandler mod_bg_test-handler
 </Location>
*)
//
// These entries assume that the output directory for this project is the apache/modules directory.
//
// httpd.conf entries should be different if the project is changed in these ways:
//   1. The TApacheModuleData variable name is changed.
//   2. The project is renamed.
//   3. The output directory is not the apache/modules directory.
//   4. The dynamic library extension depends on a platform. Use .dll on Windows and .so on Linux.
//

// Declare exported variable so that Apache can access this module.
var
  GModuleData: TApacheModuleData;
exports
  GModuleData name 'bg_test_module';

begin
{$IFDEF MSWINDOWS}
  CoInitFlags := COINIT_MULTITHREADED;
{$ENDIF}
  Web.ApacheApp.InitApplication(@GModuleData);
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
//  Application.CreateForm(TFireDacMySqlConnection, FireDacMySqlConnection);
  Application.Run;
end.
