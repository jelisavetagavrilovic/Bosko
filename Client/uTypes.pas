unit uTypes;

interface

type
  TCountry = record
    id      : string;
    country : string;
  end;
  TCountryArray   = array of TCountry;

  TZipCode = record
    idcountry   : string;
    idzipcode   : string;
    cityname    : string;
  end;
  TZipCodesArray  = array of TZipCode;


implementation

end.
