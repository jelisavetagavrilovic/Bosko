unit uServerCont;

interface

uses
  System.SysUtils, System.Classes, Sparkle.HttpServer.Module,
  Sparkle.HttpServer.Context, Sparkle.Comp.Server,
  Sparkle.Comp.HttpSysDispatcher, Aurelius.Drivers.Interfaces,
  Aurelius.Comp.Connection, XData.Comp.ConnectionPool, XData.Server.Module,
  XData.Comp.Server, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client,
  Sparkle.Comp.CorsMiddleware, Sparkle.Comp.JwtMiddleware;

type
  TServCont = class(TDataModule)
    SparkleHttpSysDispatcher: TSparkleHttpSysDispatcher;
    XDataServer: TXDataServer;
    XDataServerCORS: TSparkleCorsMiddleware;
  end;

var
  ServCont: TServCont;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
