unit VenecuelaService;

interface

uses
  XData.Service.Common,
  System.JSON;

type
  [ServiceContract]
  IVenecuelaService = interface(IInvokable)
    ['{2BB93BCE-25F5-4112-9E64-7981655C5519}']
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

initialization
  RegisterServiceType(TypeInfo(IVenecuelaService));

end.
