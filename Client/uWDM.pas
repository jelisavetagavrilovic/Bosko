unit uWDM;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Modules, XData.Web.Connection,
  WEBLib.REST, XData.Web.Client, uTypes;

type
  TWDM = class(TWebDataModule)
    XDataWebConnection: TXDataWebConnection;
    XDataWebClient: TXDataWebClient;
  private
    { Private declarations }
    FCountries  : TCountryArray;
    FZipCodes   : TZipCodesArray;
    FCity       : TZipCode;
    FSelectedCountry: string;
  public
    { Public declarations }
    [async]
    procedure GetCountries();
    [async]
    procedure GetZipCodes(Country: string);
    [async]
    procedure AddCountry(CountryID, CountryName: String);
    [async]
    procedure AddZipCode(Country, ZipCode, CityName: string);
    [async]
    procedure AddContact(Country, FirstName, LastName, Address,
                Email, aCity: string);

    property Countries  : TCountryArray   read FCountries   write FCountries;
    property ZipCodes   : TZipCodesArray  read FZipCodes    write FZipCodes;
    property City       : TZipCode        read FCity        write FCity;
    property SelectedCountry: string      read FSelectedCountry;
  end;

var
  WDM: TWDM;

implementation

uses
  Vcl.Dialogs, ufrmMain;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TWDM }

procedure TWDM.AddContact(Country, FirstName, LastName, Address, Email,
  aCity: string);

  procedure OnResponse(Response: TXDataClientResponse);
  var
    jTemp : JSValue;
  begin
    jTemp := Response.Result;
    FCity := TZipCode(jTemp);
  end;

  procedure OnResponse1(Response: TXDataClientResponse);
  begin
//  Function returns Boolean
  end;

var
  CountryID   : string;
  idx         : Integer;

begin
  FSelectedCountry  := EmptyStr;
  CountryID         := EmptyStr;
  if Country <> EmptyStr then
    for idx := Low(FCountries) to High(FCountries) do
      if FCountries[idx].country = Country then
      begin
        CountryID         := FCountries[idx].id;
        FSelectedCountry  := CountryID;
        Break;
      end;

  Try
    aWait(WDM.XDataWebConnection.OpenAsync);
  Except
    ShowMessage('Exception ');
  End;

  WDM.XDataWebClient.RawInvoke('IVenecuelaService.GetZipCode', [CountryID, aCity], @OnResponse);

  WDM.XDataWebClient.RawInvoke('IVenecuelaService.SetContacts', [CountryID, FirstName, LastName, Address, Email, City.idzipcode], @OnResponse1);

end;

procedure TWDM.AddCountry(Country, CountryName: String);

  procedure OnResponse(Response: TXDataClientResponse);
  begin
//  Function returns Boolean
  end;

begin

  Try
    aWait(WDM.XDataWebConnection.OpenAsync);
  Except
    ShowMessage('Exception ');
  End;

  WDM.XDataWebClient.RawInvoke('IVenecuelaService.SetCountry', [CountryID, CountryName], @OnResponse);
end;

procedure TWDM.AddZipCode(Country, ZipCode, CityName: string);

  procedure OnResponse(Response: TXDataClientResponse);
  begin
//  Function returns Boolean
  end;

var
  CountryID   : string;
  idx         : Integer;
begin
  FSelectedCountry  := EmptyStr;
  CountryID         := EmptyStr;
  if Country <> EmptyStr then
    for idx := Low(FCountries) to High(FCountries) do
      if FCountries[idx].country = Country then
      begin
        CountryID         := FCountries[idx].id;
        FSelectedCountry  := CountryID;
        Break;
      end;

  Try
    aWait(WDM.XDataWebConnection.OpenAsync);
  Except
    ShowMessage('Exception ');
  End;

  WDM.XDataWebClient.RawInvoke('IVenecuelaService.SetZipCode', [CountryID, FZipCodes, CityName], @OnResponse);

end;

procedure TWDM.GetCountries;

  procedure OnResponse(Response: TXDataClientResponse);
  var
    idx   : integer;
    jTemp : JSValue;
  begin
    jTemp   := Response.Result;
    FCountries   := TCountryArray(jTemp);
    frmMain.wcbCountries.Clear;
    for idx := Low(FCountries) to High(FCountries) do
      frmMain.wcbCountries.Items.Add(FCountries[idx].country);
  end;

begin

  Try
    aWait(WDM.XDataWebConnection.OpenAsync);
  Except
    ShowMessage('Exception ');
  End;

  WDM.XDataWebClient.RawInvoke('IVenecuelaService.GetCountries', [], @OnResponse);
end;

procedure TWDM.GetZipCodes(Country: string);

  procedure OnResponse(Response: TXDataClientResponse);
  var
    idx   : integer;
    jTemp : JSValue;
  begin
    jTemp     := Response.Result;
    FZipCodes := TZipCodesArray(jTemp);
    frmMain.wcbZipCode.Clear;
    for idx := Low(FZipCodes) to High(FZipCodes) do
      frmMain.wcbZipCode.Items.Add(FZipCodes[idx].cityname);
  end;

var
  CountryID   : string;
  idx         : Integer;
begin
  FSelectedCountry  := EmptyStr;
  CountryID         := EmptyStr;
  if Country <> EmptyStr then
    for idx := Low(FCountries) to High(FCountries) do
      if FCountries[idx].country = Country then
      begin
        CountryID         := FCountries[idx].id;
        FSelectedCountry  := CountryID;
        Break;
      end;

  Try
    aWait(WDM.XDataWebConnection.OpenAsync);
  Except
    ShowMessage('Exception ');
  End;

  WDM.XDataWebClient.RawInvoke('IVenecuelaService.GetZipCodes', [CountryID], @OnResponse);
end;

end.
