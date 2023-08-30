unit ufrmMain;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TfrmMain = class(TWebForm)
    wcbCountries: TWebComboBox;
    lblCountry: TWebLabel;
    wlServerAddress: TWebLabel;
    weServerAddress: TWebEdit;
    btnConnect: TWebButton;
    btnAddCountry: TWebButton;
    lblName: TWebLabel;
    edtName: TWebEdit;
    lblLastName: TWebLabel;
    edtLastName: TWebEdit;
    lblEmail: TWebLabel;
    edtEmail: TWebEdit;
    lblZIPCode: TWebLabel;
    wcbZipCode: TWebComboBox;
    btnAddZipCode: TWebButton;
    btnAddNewContact: TWebButton;
    procedure btnConnectClick(Sender: TObject);
    procedure wcbCountriesExit(Sender: TObject);
    [async]
    procedure btnAddCountryClick(Sender: TObject);
    [async]
    procedure btnAddZipCodeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ConnectServer;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses uWDM, uCountries, ufrmZip;

procedure TfrmMain.btnAddCountryClick(Sender: TObject);
var
  newform: TfrmCountries;

  short   : string;
  name    : string;
  Save    : Boolean;
begin
  newform   := TfrmCountries.Create(Self);
  newForm.Caption := 'New country';
  newform.Popup   := True;

  newform.Border  := fbDialog;

  window.location.hash  := 'subform';

  await(TfrmCountries, newform.Load());

  newform.Save    := False;
  newform.edCountryShortName.Text   := '';
  newform.edtCountryName.Text       := '';
  try
    await(TModalResult, newForm.Execute);
    short   := newform.edCountryShortName.Text;
    name    := newform.edtCountryName.Text;
    Save    := newform.Save;

    if Save then
    begin
      Wdm.AddCountry(short, name);
      WDM.GetCountries;
      wcbCountries.ItemIndex := wcbCountries.Items.IndexOf(name);
    end;
  finally
    newform.Free;
  end;
end;

procedure TfrmMain.btnAddZipCodeClick(Sender: TObject);
var
  newform: TfrmZipCode;

  zip   : string;
  name    : string;
  Save    : Boolean;
begin
  newform   := TfrmZipCode.Create(Self);
  newForm.Caption := 'New zip code';
  newform.Popup   := True;

  newform.Border  := fbDialog;

  window.location.hash  := 'subform';

  await(TfrmCountries, newform.Load());

  newform.Save    := False;
  newform.WebLabel1.Caption   := 'Country ' + wcbCountries.Text;
  newform.edtZipCode.Text     := '';
  newform.edtCity.Text        := '';
  try
    await(TModalResult, newForm.Execute);
    zip     := newform.edtZipCode.Text;
    name    := newform.edtCity.Text;
    Save    := newform.Save;

    if Save then
    begin
      Wdm.AddZipCode(wcbCountries.Items[wcbCountries.ItemIndex], zip, name);
      WDM.GetZipCodes(wcbCountries.Items[wcbCountries.ItemIndex]);
      wcbZipCode.ItemIndex := wcbZipCode.Items.IndexOf(name);
    end;
  finally
    newform.Free;
  end;
end;

procedure TfrmMain.btnConnectClick(Sender: TObject);
begin
  ConnectServer;

  WDM.GetCountries;
end;

procedure TfrmMain.ConnectServer;
begin
  WDM.XDataWebConnection.Connected  := False;
  WDM.XDataWebConnection.URL        := frmMain.weServerAddress.Text;

end;

procedure TfrmMain.wcbCountriesExit(Sender: TObject);
var
  country : string;
begin
  if (not btnAddCountry.Focused) or (wcbCountries.ItemIndex >= 0) then
    country   := wcbCountries.Items[wcbCountries.ItemIndex]
  else
  begin
    if wcbCountries.ItemIndex < 0 then
    begin
      ShowMessage('Country has to have a value. Please select !!!');
    end;
  end;
  WDM.GetZipCodes(country);
end;

end.