unit uWM;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Sparkle.HttpServer.Module,
  Sparkle.HttpServer.Context, Sparkle.Comp.Server,
  XData.Comp.Server, Aurelius.Drivers.Interfaces, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.Client,
  Sparkle.WebBroker.Server,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  TWM = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
    procedure WMDefaultHandlerAction(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }

    procedure CreateDatabase(DBName, UserName, Password: string);
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWM;

implementation

uses
  Sparkle.WebBroker.Adapter,
  XData.Server.Module,
  ConnectionModule,
  Aurelius.Engine.DatabaseManager,
  XData.Aurelius.ConnectionPool,
  Sparkle.Middleware.Cors;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

var
  Server: TWebBrokerServer;
  Module : TXDataServerModule;

procedure TWM.CreateDatabase(DBName, UserName, Password: string);
begin
//  FDConn.ExecSQL('CREATE DATABASE IF NOT EXISTS ' + DBname);
//
//  FDConn.Params.Values['Driver ID']     := 'MySQL';
//  FDConn.Params.Database                := DBName;
//  FDConn.Params.Values['LockingMode']   := 'Normal';
//  FDConn.Params.Values['StringFormat']  := 'Unicode';
//
//  FDConn.Open(rootUserName, rootPwd);
end;

procedure TWM.WebModuleCreate(Sender: TObject);
begin
//  CreateDatabase('TestVenecuela', 'root', 'Tajeta2001!');



//  TDatabaseManager.Update(TFireDacMySqlConnection.CreateConnection);
//  Server.Dispatcher.AddModule(TXDataServerModule.Create(
//    'http://localhost/bg', TFireDacMySqlConnection.CreateConnection

//  ));
end;

procedure TWM.WMDefaultHandlerAction(Sender: TObject; Request: TWebRequest;
  Response: TWebResponse; var Handled: Boolean);
var
  Adapter: IWebBrokerAdapter;
begin
  Adapter := TWebBrokerAdapter.Create(Request, Response);
  Server.DispatchRequest(Adapter);
end;

initialization
  FireDacMySqlConnection  := TFireDacMySqlConnection.Create(nil);

  Server := TWebBrokerServer.Create;

  Module  := TXDataServerModule.Create(
     'http://192.168.0.29:8080/bg',
     TDBConnectionPool.Create(20, TFireDacMySqlConnection.CreateFactory));
  Module.AccessControlAllowOrigin := '*';

  Server.Dispatcher.AddModule(Module);

finalization
  FireDacMySqlConnection.Free;
  Server.Free;

end.
