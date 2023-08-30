unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, uServerCont;

type
  TMainForm = class(TForm)
    mmInfo: TMemo;
    btStart: TButton;
    btStop: TButton;
    edtDBName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtUserName: TEdit;
    Label3: TLabel;
    edtPassword: TEdit;
    procedure btStartClick(ASender: TObject);
    procedure btStopClick(ASender: TObject);
    procedure FormCreate(ASender: TObject);
  strict private
    procedure UpdateGUI;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses uDM, Sparkle.Middleware.Cors;

resourcestring
  SServerStopped = 'Server stopped';
  SServerStartedAt = 'Server started at ';

{ TMainForm }

procedure TMainForm.btStartClick(ASender: TObject);
begin
  if not Assigned(DM) then
    DM    := TDM.Create(edtDBName.Text, edtUserName.Text, edtPassword.Text);
  ServCont.XDataServer.CreateModule.AddMiddleware(TCorsMiddleware.Create);
  ServCont.SparkleHttpSysDispatcher.Start;
  UpdateGUI;
end;

procedure TMainForm.btStopClick(ASender: TObject);
begin
  ServCont.SparkleHttpSysDispatcher.Stop;
  UpdateGUI;
end;

procedure TMainForm.FormCreate(ASender: TObject);
begin
//  UpdateGUI;
end;

procedure TMainForm.UpdateGUI;
const
  cHttp = 'http://+';
  cHttpLocalhost = 'http://localhost';
begin
  btStart.Enabled := not ServCont.SparkleHttpSysDispatcher.Active;
  btStop.Enabled := not btStart.Enabled;
  if ServCont.SparkleHttpSysDispatcher.Active then
    mmInfo.Lines.Add(SServerStartedAt + StringReplace(
      ServCont.XDataServer.BaseUrl,
      cHttp, cHttpLocalhost, [rfIgnoreCase]))
  else
    mmInfo.Lines.Add(SServerStopped);
end;

end.
