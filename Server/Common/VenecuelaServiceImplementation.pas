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
  private
    function GetCountries: TJSONArray;
    function SetCountry(CountryID, CountryName: String): Boolean;
    function GetZipCodes(CountryID: string): TJSONArray;
    function SetZipCode(CountryID, ZipCode, CityName: string): Boolean;
    function GetZipCode(CountryID, ZipCode: string): TJSONObject;
    function GetContacts(): TJSONArray;
    function SetContacts(CountryID, FirstName, LastName, Address,
                Email, ZipCode: string): Boolean;
  end;

implementation

uses
  uDM, DataSet.Serialize, DB, FireDAC.Stan.Param;

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
    DM.FDConn.ExecSQL(SQL, DS);
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
    DM.FDConn.ExecSQL(SQL, DS);
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
    DM.FDConn.ExecSQL(SQL, FP, DS);
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
    DM.FDConn.ExecSQL(SQL, FP, DS);
    Result    := DS.ToJSONArray();
  finally
    FP.Free;
    DS.Free;
  end;
end;

function TVenecuelaService.SetContacts(CountryID, FirstName, LastName, Address,
  Email, ZipCode: string): Boolean;
var
  SQL   : string;
begin
  SQL   := 'INSERT INTO testvenecuela.contacts ' +
            '(idCountry, idPerson, Name, LastName, Address, Email, ' +
            'zipcode) VALUES ' +
            '(:idCountry, :idPerson, :Name, :LastName, :Address, :Email, ' +
            ':zipcode);';

  Result    := False;
  if not DM.FDConn.InTransaction then
    DM.FDConn.StartTransaction;
  try
    DM.FDConn.ExecSQL(SQL,
                      [CountryID, FirstName, LastName, Address, Email, zipcode],
                      [ftWideString, ftWideString, ftWideString, ftWideString,
                      ftWideString, ftWideString]);
    DM.FDConn.Commit;
    Result    := True;
  except
    DM.FDConn.Rollback;
  end;
end;

function TVenecuelaService.SetCountry(CountryID, CountryName: String): Boolean;
var
  SQL   : string;
begin
  Result    := False;
  if not DM.FDConn.InTransaction then
    DM.FDConn.StartTransaction;
  try
    SQL   := 'INSERT INTO testvenecuela.countries ' +
             '(id, country) VALUES (:id, :country);';
    DM.FDConn.ExecSQL(SQL, [CountryID, CountryName]);
    DM.FDConn.Commit;
    Result    := True;
  except
    DM.FDConn.Rollback;
  end;
end;

function TVenecuelaService.SetZipCode(CountryID, ZipCode,
  CityName: string): Boolean;
var
  SQL   : string;
begin
  Result    := False;
  if not DM.FDConn.InTransaction then
    DM.FDConn.StartTransaction;
  try
    SQL   := 'INSERT INTO testvenecuela.zipcodes ' +
            '(idCountry, idZipCode, CityName) VALUES ' +
             '(:idCountry, :idZipCode, :CityName);';
    DM.FDConn.ExecSQL(SQL, [CountryID, ZipCode, CityName]);
    DM.FDConn.Commit;
    Result    := True;
  except
    DM.FDConn.Rollback;
  end;
end;

initialization
  RegisterServiceType(TVenecuelaService);

end.
