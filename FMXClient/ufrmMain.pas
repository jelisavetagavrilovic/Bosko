unit ufrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  FMX.Layouts, FMX.ListBox, System.JSON, XData.Client, VenecuelaService;

type
  TfrmMain = class(TForm)
    tcMain: TTabControl;
    tabData: TTabItem;
    tabSettingConnection: TTabItem;
    Label1: TLabel;
    edtServer: TEdit;
    ListBox1: TListBox;
    lbiCountry: TListBoxItem;
    btnAddCountry: TButton;
    cbCountry: TComboBox;
    lbName: TListBoxItem;
    lbiLastName: TListBoxItem;
    lbiEmail: TListBoxItem;
    lbiZipCode: TListBoxItem;
    edtName: TEdit;
    edtLastName: TEdit;
    edtEmail: TEdit;
    cbZipCode: TComboBox;
    btnAddZip: TButton;
    btnSaveContact: TButton;
    btnSaveConnection: TButton;
    lbiAddress: TListBoxItem;
    edtAddress: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure btnSaveConnectionClick(Sender: TObject);
    procedure cbCountryExit(Sender: TObject);
    procedure btnAddCountryEnter(Sender: TObject);
    procedure btnAddCountryExit(Sender: TObject);
    procedure btnAddCountryClick(Sender: TObject);
    procedure btnAddZipClick(Sender: TObject);
    procedure btnSaveContactClick(Sender: TObject);
  private
    btnAddCountryEntered  :   Boolean;
    FSelectedCountry      : string;
    function GetServerPath: string;
    procedure SetServerPath(const Value: string);
    { Private declarations }
    procedure LoadCountries;
    procedure GetZipCodes(Country: string);
  public
    { Public declarations }
    property ServerPath: string read GetServerPath write SetServerPath;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  IniFiles, System.IOUtils,
  System.Generics.Collections, ufrmCountries, ufrmZipCode;

{$R *.fmx}

procedure TfrmMain.btnAddCountryClick(Sender: TObject);
var
  CountryName       : string;
  ShortCountryName  : string;

  LXDClient   : TXDataClient;
  LService    : IVenecuelaService;
begin
  frmCountry  := TfrmCountry.Create(self);
  try
    frmCountry.edtShortName.Text    := '';
    frmCountry.edtCountry.Text      := '';
    frmCountry.ShowModal;

    CountryName       := frmCountry.edtCountry.Text;
    ShortCountryName  := frmCountry.edtShortName.Text;

    if frmCountry.Save then
    begin
      LXDClient   := TXDataClient.Create;
      LXDClient.Uri := edtServer.Text;
      try
        try
          LService    :=  LXDClient.Service<IVenecuelaService>;
          LService.SetCountry(ShortCountryName, CountryName);

          LoadCountries;
        except
          ShowMessage('The server is not found!!!');
        end;
      finally
        LXDClient.Free;
      end;
    end;
  finally
    frmCountry.Free;
  end;
end;

procedure TfrmMain.btnAddCountryEnter(Sender: TObject);
begin
  btnAddCountryEntered    := True;
end;

procedure TfrmMain.btnAddCountryExit(Sender: TObject);
begin
  btnAddCountryEntered  := False;
end;

procedure TfrmMain.btnAddZipClick(Sender: TObject);
var
  LXDClient   : TXDataClient;
  LService    : IVenecuelaService;
begin
  frmZipCode  := TfrmZipCode.Create(self);
  try
    frmZipCode.lblCountry.Text  := 'Country ' + cbCountry.Items[cbCountry.ItemIndex];
    frmZipCode.edtZipCode.Text  := '';
    frmZipCode.edtCityName.Text := '';

    frmZipCode.ShowModal;

    if frmZipCode.Save then
    begin
      LXDClient   := TXDataClient.Create;
      LXDClient.Uri := edtServer.Text;
      try
        try
          LService    :=  LXDClient.Service<IVenecuelaService>;

          LService.SetZipCode(FSelectedCountry, frmZipCode.edtZipCode.Text, frmZipCode.edtCityName.Text);

          GetZipCodes(cbCountry.Items[cbCountry.ItemIndex]);
        except
          ShowMessage('The server is not found!!!');
        end;
      finally
        LXDClient.Free;
      end;
    end;
  finally
    frmZipCode.Free;
  end;
end;

procedure TfrmMain.btnSaveConnectionClick(Sender: TObject);
var
  IniFile   : TIniFile;
  FilePath  : string;
begin
  FilePath  := TPath.Combine(ParamStr(0), 'Server.ini');
  IniFile   := TIniFile.Create(FilePath);
  try
    ServerPath  := edtServer.Text;
    IniFile.WriteString('Server', 'Path', ServerPath);
  finally
    IniFile.Free;
  end;
end;

procedure TfrmMain.btnSaveContactClick(Sender: TObject);
var
  LXDClient   : TXDataClient;
  LService    : IVenecuelaService;
  idx         : Integer;
  FCountries  : TJSONArray;
  ZipCode     : TJSONObject;
  ZIP         : string;
begin
  if (cbCountry.ItemIndex >= 0) and
      (cbZipCode.ItemIndex >= 0) and
      (edtName.Text <> EmptyStr) and
      (edtLastName.Text <> EmptyStr) and
      (edtEmail.Text <> EmptyStr) and
      (edtAddress.Text <> EmptyStr) then
  begin
    LXDClient   := TXDataClient.Create;
    LXDClient.Uri := edtServer.Text;
    try
      try
        LService    :=  LXDClient.Service<IVenecuelaService>;

        ZipCode   := LService.GetZipCode(FSelectedCountry, cbZipCode.Items[cbZipCode.ItemIndex]);
        Zip       := ZipCode.GetValue<string>('idzipcode', EmptyStr);
        LService.SetContacts(FSelectedCountry, edtName.Text, edtLastName.Text, edtAddress.Text,
            edtEmail.Text, Zip);
      except
        ShowMessage('The server is not found!!!');
      end;
    finally
      LXDClient.Free;
    end;

    cbCountry.ItemIndex := -1;
    cbZipCode.ItemIndex := -1;
    edtName.Text        := EmptyStr;
    edtLastName.Text    := EmptyStr;
    edtEmail.Text       := EmptyStr;
    edtAddress.Text     := EmptyStr;
  end else
    ShowMessage('All fields are required');
end;

procedure TfrmMain.cbCountryExit(Sender: TObject);
var
  country : string;
begin
  if (not btnAddCountryEntered) or (cbCountry.ItemIndex >= 0) then
    country   := cbCountry.Items[cbCountry.ItemIndex]
  else
  begin
    if cbCountry.ItemIndex < 0 then
    begin
      ShowMessage('Country has to have a value. Please select !!!');
    end;
  end;
  GetZipCodes(country);
end;

procedure TfrmMain.FormActivate(Sender: TObject);
var
  IniFile   : TIniFile;
  FilePath  : string;
begin
  btnAddCountryEntered    := False;
  FilePath  := TPath.Combine(ParamStr(0), 'Server.ini');
  IniFile   := TIniFile.Create(FilePath);
  try
    ServerPath  := IniFile.ReadString('Server', 'Path', 'http://192.168.0.29:8080/bg');
  finally
    IniFile.Free;
  end;
end;

function TfrmMain.GetServerPath: string;
begin
  Result    := edtServer.Text;
end;

procedure TfrmMain.GetZipCodes(Country: string);
var
  LXDClient   : TXDataClient;
  LService    : IVenecuelaService;
  idx         : Integer;
  FCountries  : TJSONArray;
  FZipCodes   : TJSONArray;
  CountryID   : String;
begin
  FSelectedCountry  := EmptyStr;
  CountryID         := EmptyStr;
  LXDClient   := TXDataClient.Create;
  LXDClient.Uri := edtServer.Text;
  try
    try
      LService    :=  LXDClient.Service<IVenecuelaService>;
      FCountries  :=  LService.GetCountries;
      if Country <> EmptyStr then
        for idx := 0 to FCountries.Count - 1 do
          if FCountries.items[idx].GetValue<string>('country', EmptyStr) = Country then
          begin
            CountryID         := FCountries.Items[idx].GetValue<string>('id', EmptyStr);
            FSelectedCountry  := CountryID;
            Break;
          end;

      FZipCodes   :=  LService.GetZipCodes(CountryID);
      cbZipCode.Clear;
      for idx := 0 to FZipCodes.Count - 1 do
        cbZipCode.Items.add(FZipCodes.items[idx].GetValue<string>('cityname', EmptyStr));
    except
      ShowMessage('The server is not found!!!');
    end;
  finally
    LXDClient.Free;
  end;
end;

procedure TfrmMain.LoadCountries;
var
  LXDClient   : TXDataClient;
  LService    : IVenecuelaService;
  idx         : Integer;
  FCountries  : TJSONArray;
begin
  LXDClient   := TXDataClient.Create;
  LXDClient.Uri := edtServer.Text;
  try
    try
      LService    :=  LXDClient.Service<IVenecuelaService>;
      FCountries  :=  LService.GetCountries;
      cbCountry.Clear;
      for idx := 0 to FCountries.Count - 1 do
        cbCountry.Items.add(FCountries.items[idx].GetValue<string>('country', EmptyStr));
    except
      ShowMessage('The server is not found!!!');
    end;
  finally
    LXDClient.Free;
  end;
end;

procedure TfrmMain.SetServerPath(const Value: string);
begin
  edtServer.Text    := Value;
  LoadCountries;
end;

end.
