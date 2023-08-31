unit ufrmCountries;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit;

type
  TfrmCountry = class(TForm)
    Label1: TLabel;
    edtShortName: TEdit;
    lblCountryName: TLabel;
    edtCountry: TEdit;
    btnSave: TButton;
    btnClose: TButton;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Save    : Boolean;
  end;

var
  frmCountry: TfrmCountry;

implementation

{$R *.fmx}

procedure TfrmCountry.btnCloseClick(Sender: TObject);
begin
  Save    := False;
  Close;
end;

procedure TfrmCountry.btnSaveClick(Sender: TObject);
begin
  Save    := True;
  Close;
end;

procedure TfrmCountry.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose  := (edtShortName.Text <> EmptyStr) and (edtCountry.Text <> EmptyStr) and Save;
end;

end.
