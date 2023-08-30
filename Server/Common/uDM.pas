unit uDM;

interface

uses
  Aurelius.Drivers.Interfaces,
  Aurelius.Drivers.FireDac,  
  FireDAC.Dapt,
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Aurelius.Sql.MySQL, Aurelius.Schema.MySQL, Aurelius.Comp.Connection, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL,
  FireDAC.Comp.UI;

type
  TDM = class(TDataModule)
    FDConn: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
  private
    procedure CreateTableIfNotExistsCountries;
    procedure CreateTableIfNotExistsZipCodes;
    procedure CreateTableIfNotExistsContacts;
  public
    Constructor Create(DBName, UserName, Password: string);
    procedure CreateDatabaseIfNotExists(DBName: TFileName; rootUserName, rootPwd: string);

  end;

var
  DM: TDM;

implementation

{$R *.dfm}

constructor TDM.Create(DBName, UserName, Password: string);
begin
  inherited Create(nil);
  CreateDatabaseIfNotExists(DBName, UserName, Password);
end;

procedure TDM.CreateDatabaseIfNotExists(DBName: TFileName; rootUserName, rootPwd: string);
begin
  FDConn.ExecSQL('CREATE DATABASE IF NOT EXISTS ' + DBname);

  FDConn.Params.Values['Driver ID']     := 'MySQL';
  FDConn.Params.Database                := DBName;
  FDConn.Params.Values['LockingMode']   := 'Normal';
  FDConn.Params.Values['StringFormat']  := 'Unicode';
//  FDConn.Params.Values['User_Name']     := rootUserName;
//  FDConn.Params.Values['password']      := rootPwd;

  FDConn.Open(rootUserName, rootPwd);

  CreateTableIfNotExistsCountries;
  CreateTableIfNotExistsZipCodes;
  CreateTableIfNotExistsContacts;
end;

procedure TDM.CreateTableIfNotExistsContacts;
var
  sql   : string;
begin
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

  if not FDConn.InTransaction then
    FDConn.StartTransaction;
  try
    FDConn.ExecSQL(sql);
    FDConn.Commit;
  finally
    FDConn.Rollback;
  end;
end;

procedure TDM.CreateTableIfNotExistsCountries;
var
  sql   : string;
begin
  sql   := 'CREATE TABLE IF NOT EXISTS Countries ( ' +
          'id varchar(5) NOT NULL, ' +
          'country varchar(45) DEFAULT NULL, PRIMARY KEY (id)) ' +
          'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;';

  if not FDConn.InTransaction then
    FDConn.StartTransaction;
  try
    FDConn.ExecSQL(sql);
    FDConn.Commit;
  finally
    FDConn.Rollback;
  end;
end;

procedure TDM.CreateTableIfNotExistsZipCodes;
var
  sql   : string;
begin
  sql   := 'CREATE TABLE IF NOT EXISTS ZipCodes ( ' +
          'idCountry varchar(5) NOT NULL, ' +
          'idZipCode varchar(10) NOT NULL, ' +
          'CityName varchar(45) DEFAULT NULL, PRIMARY KEY (idCountry, idZipCode)) ' +
          'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;';

  if not FDConn.InTransaction then
    FDConn.StartTransaction;
  try
    FDConn.ExecSQL(sql);
    FDConn.Commit;
  finally
    FDConn.Rollback;
  end;
end;

end.
