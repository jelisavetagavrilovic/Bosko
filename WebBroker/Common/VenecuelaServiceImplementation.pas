unit VenecuelaServiceImplementation;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  VenecuelaService,
  System.JSON;

type
  [ServiceImplementation]
  TVenecuelaService = class(TInterfacedObject, IVenecuelaService)
    [HttpGet]
    function GetCountries: TJSONArray;
    [HttpPost]
    function SetCountry(CountryID, CountryName: String): Boolean;

    [HttpGet]
    function GetZipCodes(CountryID: string): TJSONArray;
    [HttpGet]
    function GetZipCode(CountryID, ZipCode: string): TJSONObject;
    [HttpPost]
    function SetZipCode(CountryID, ZipCode, CityName: string): Boolean;

    [HttpGet]
    function GetContacts(): TJSONArray;
    [HttpPost]
    function SetContacts(CountryID, FirstName, LastName, Address,
                Email, ZipCode: string): Boolean;
  end;

implementation


{ TVenecuelaService }

uses ConnectionModule, DataSet.Serialize, DB, FireDAC.Stan.Param;

function TVenecuelaService.GetContacts: TJSONArray;
var
  DS    : TDataSet;
  SQL   : string;
begin
  sql   := 'SELECT `contacts`.`idCountry`, ' +
            'contacts.idPerson, ' +
            'contacts.Name, ' +
            'contacts.LastName, ' +
            'contacts.Address, ' +
            'contacts.Email, ' +
            'contacts.zipcode, ' +
            'testvenecuela.zipcodes.CityName, ' +
            'testvenecuela.countries.country ' +
            'FROM testvenecuela.contacts ' +
            'inner join testvenecuela.zipcodes ON ' +
            'testvenecuela.zipcodes.idCountry = contacts.idCountry and ' +
            'testvenecuela.zipcodes.idZipCode = contacts.zipcode ' +
            'inner join testvenecuela.countries ON testvenecuela.countries.id = contacts.idCountry';
  try
    FireDacMySqlConnection.Connection.ExecSQL(SQL, DS);
    Result    := DS.ToJSONArray();
  finally
    DS.Free;
  end;
end;

function TVenecuelaService.GetCountries: TJSONArray;
var
  DS    : TDataSet;
  SQL   : string;
begin
  sql   := 'select * from Countries';
  try
    FireDacMySqlConnection.Connection.ExecSQL(SQL, DS);
    Result    := DS.ToJSONArray();
  finally
    DS.Free;
  end;
end;

function TVenecuelaService.GetZipCode(CountryID, ZipCode: string): TJSONObject;
var
  DS    : TDataSet;
  SQL   : string;
  FP    : TFDParams;
begin
  SQL   := 'SELECT zipcodes.idCountry, ' +
            'zipcodes.idZipCode, ' +
            'zipcodes.CityName ' +
            'FROM testvenecuela.zipcodes ' +
            'where zipcodes.idCountry = :CountryID and zipcodes.CityName = :ZipCode';

  FP    := TFDParams.Create;
  try
    with FP.Add do
    begin
      DataType    := TFieldType.ftWideString;
      Value       := CountryID;
    end;
    with FP.Add do
    begin
      DataType    := TFieldType.ftWideString;
      Value       := ZipCode;
    end;
    FireDacMySqlConnection.Connection.ExecSQL(SQL, FP, DS);
    Result    := DS.ToJSONObject();
  finally
    FP.Free;
    DS.Free;
  end;
end;

function TVenecuelaService.GetZipCodes(CountryID: string): TJSONArray;
var
  DS    : TDataSet;
  SQL   : string;
  FP    : TFDParams;
begin
  SQL   := 'SELECT zipcodes.idCountry, ' +
            'zipcodes.idZipCode, ' +
            'zipcodes.CityName ' +
            'FROM testvenecuela.zipcodes ' +
            'where zipcodes.idCountry = :CountryID';

  FP    := TFDParams.Create;
  try
    with FP.Add do
    begin
      DataType    := TFieldType.ftWideString;
      Value       := CountryID;
    end;
    FireDacMySqlConnection.Connection.ExecSQL(SQL, FP, DS);
    Result    := DS.ToJSONArray();
  finally
    FP.Free;
    DS.Free;
  end;
end;

function TVenecuelaService.SetContacts(CountryID, FirstName, LastName, Address,
  Email, ZipCode: string): Boolean;
var
  SQL       : string;
  idPerson  : Integer;
begin
  SQL   := 'select max(idPerson) from testvenecuela.contacts where idCountry = :idCountry';
  try
    idPerson := FireDacMySqlConnection.Connection.ExecSQLScalar(SQL, [CountryID], [ftWideString]);
  except
    idPerson  := 0;
  end;

  idPerson    := idPerson + 1;

  SQL   := 'INSERT INTO testvenecuela.contacts ' +
            '(idCountry, idPerson, Name, LastName, Address, Email, ' +
            'zipcode) VALUES ' +
            '(:idCountry, :idPerson, :Name, :LastName, :Address, :Email, ' +
            ':zipcode);';

  Result    := False;
  if not FireDacMySqlConnection.Connection.InTransaction then
    FireDacMySqlConnection.Connection.StartTransaction;
  try
    FireDacMySqlConnection.Connection.ExecSQL(SQL,
                      [CountryID, idPerson, FirstName, LastName, Address, Email, zipcode],
                      [ftWideString, ftInteger, ftWideString, ftWideString, ftWideString,
                      ftWideString, ftWideString]);
    FireDacMySqlConnection.Connection.Commit;
    Result    := True;
  except
    FireDacMySqlConnection.Connection.Rollback;
  end;
end;

function TVenecuelaService.SetCountry(CountryID, CountryName: String): Boolean;
var
  SQL   : string;
begin
  Result    := False;
  if not FireDacMySqlConnection.Connection.InTransaction then
    FireDacMySqlConnection.Connection.StartTransaction;
  try
    SQL   := 'INSERT INTO testvenecuela.countries ' +
             '(id, country) VALUES (:id, :country);';
    FireDacMySqlConnection.Connection.ExecSQL(SQL, [CountryID, CountryName]);
    FireDacMySqlConnection.Connection.Commit;
    Result    := True;
  except
    FireDacMySqlConnection.Connection.Rollback;
  end;
end;

function TVenecuelaService.SetZipCode(CountryID, ZipCode,
  CityName: string): Boolean;
var
  SQL   : string;
begin
  Result    := False;
  if not FireDacMySqlConnection.Connection.InTransaction then
    FireDacMySqlConnection.Connection.StartTransaction;
  try
    SQL   := 'INSERT INTO testvenecuela.zipcodes ' +
            '(idCountry, idZipCode, CityName) VALUES ' +
             '(:idCountry, :idZipCode, :CityName);';
    FireDacMySqlConnection.Connection.ExecSQL(SQL, [CountryID, ZipCode, CityName]);
    FireDacMySqlConnection.Connection.Commit;
    Result    := True;
  except
    FireDacMySqlConnection.Connection.Rollback;
  end;
end;

initialization
  RegisterServiceType(TVenecuelaService);

end.
