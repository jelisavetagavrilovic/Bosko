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
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure CreateDatabaseIfNotExists();
    procedure CreateTableIfNotExistsCountries;
    procedure CreateTableIfNotExistsZipCodes;
    procedure CreateTableIfNotExistsContacts;
  public
    class function CreateConnection: IDBConnection;
    class function CreateFactory: IDBConnectionFactory;
    
  end;

var
  FireDacMySqlConnection: TFireDacMySqlConnection;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses 
  Aurelius.Drivers.Base, IniFiles;

{$R *.dfm}

{ TMyConnectionModule }

class function TFireDacMySqlConnection.CreateConnection: IDBConnection;
begin

  Result := FireDacMySqlConnection.AureliusConn.CreateConnection;
end;

procedure TFireDacMySqlConnection.CreateDatabaseIfNotExists;
var
  DBName: TFileName;
  rootUserName, rootPwd: string;
  iniFile   : TIniFile;
begin
  iniFile       := TIniFile.Create(ParamStr(0) + 'dbconf.ini');
  DBName        := iniFile.ReadString('DB', 'DBName', 'TestVenecuela');
  rootUserName  := iniFile.ReadString('DB', 'root', 'root');
  rootPwd       := iniFile.ReadString('DB', 'pwd', 'Tajeta2001!');
  Connection.ExecSQL('CREATE DATABASE IF NOT EXISTS ' + DBname);

  Connection.Params.Values['Driver ID']     := 'MySQL';
  Connection.Params.Database                := DBName;
  Connection.Params.Values['LockingMode']   := 'Normal';
  Connection.Params.Values['StringFormat']  := 'Unicode';
//  FDConn.Params.Values['User_Name']     := rootUserName;
//  FDConn.Params.Values['password']      := rootPwd;

  Connection.Open(rootUserName, rootPwd);

  CreateTableIfNotExistsCountries;
  CreateTableIfNotExistsZipCodes;
  CreateTableIfNotExistsContacts;
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



procedure TFireDacMySqlConnection.CreateTableIfNotExistsContacts;
var
  sql   : string;
begin
//Table can be created by XData entity, too
  sql   := 'CREATE TABLE IF NOT EXISTS Contacts ( ' +
          'idCountry varchar(5) NOT NULL, ' +
          'idPerson integer NOT NULL, ' +
          'Name varchar(25), ' +
          'LastName varchar(25), ' +
          'Address Varchar(50), ' +
          'Email Varchar(50), ' +
          'zipcode varchar(10) NOT NULL, ' +
          'PRIMARY KEY (idCountry, idPerson)) ' +
          'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;';

  if not Connection.InTransaction then
    Connection.StartTransaction;
  try
    Connection.ExecSQL(sql);
    Connection.Commit;
  finally
    Connection.Rollback;
  end;
end;

procedure TFireDacMySqlConnection.CreateTableIfNotExistsCountries;
var
  sql   : string;
begin
  sql   := 'CREATE TABLE IF NOT EXISTS Countries ( ' +
          'id varchar(5) NOT NULL, ' +
          'country varchar(45) DEFAULT NULL, PRIMARY KEY (id)) ' +
          'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;';

  if not Connection.InTransaction then
    Connection.StartTransaction;
  try
    Connection.ExecSQL(sql);
    Connection.Commit;
  finally
    Connection.Rollback;
  end;
end;

procedure TFireDacMySqlConnection.CreateTableIfNotExistsZipCodes;
var
  sql   : string;
begin
  sql   := 'CREATE TABLE IF NOT EXISTS ZipCodes ( ' +
          'idCountry varchar(5) NOT NULL, ' +
          'idZipCode varchar(10) NOT NULL, ' +
          'CityName varchar(45) DEFAULT NULL, PRIMARY KEY (idCountry, idZipCode)) ' +
          'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;';

  if not Connection.InTransaction then
    Connection.StartTransaction;
  try
    Connection.ExecSQL(sql);
    Connection.Commit;
  finally
    Connection.Rollback;
  end;
end;

procedure TFireDacMySqlConnection.DataModuleCreate(Sender: TObject);
begin
//  CreateTableIfNotExistsContacts;
end;

end.
