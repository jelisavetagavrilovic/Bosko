unit ConnectionModule;

interface

uses
  Aurelius.Drivers.Interfaces,
  Aurelius.Drivers.FireDac,  
  FireDAC.Dapt,
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  Aurelius.Sql.MySQL, Aurelius.Schema.MySQL, Aurelius.Comp.Connection, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  TFireDacMySqlConnection = class(TDataModule)
    AureliusConn: TAureliusConnection;
    Connection: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
  private
  public
    class function CreateConnection: IDBConnection;
    class function CreateFactory: IDBConnectionFactory;
    
  end;

var
  FireDacMySqlConnection: TFireDacMySqlConnection;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses 
  Aurelius.Drivers.Base;

{$R *.dfm}

{ TMyConnectionModule }

class function TFireDacMySqlConnection.CreateConnection: IDBConnection;
begin

  Result := FireDacMySqlConnection.AureliusConn.CreateConnection;
end;

class function TFireDacMySqlConnection.CreateFactory: IDBConnectionFactory;
begin
  Result := TDBConnectionFactory.Create(
    function: IDBConnection
    begin
      Result := CreateConnection;
    end
  );
end;



end.
