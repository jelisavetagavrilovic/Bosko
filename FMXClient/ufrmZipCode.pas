unit ufrmZipCode;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit;

type
  TfrmZipCode = class(TForm)
    lblZipCode: TLabel;
    lblCountry: TLabel;
    edtZipCode: TEdit;
    lblCityName: TLabel;
    edtCityName: TEdit;
    btnSave: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Save    : Boolean;
  end;

var
  frmZipCode: TfrmZipCode;

implementation

{$R *.fmx}

procedure TfrmZipCode.btnCancelClick(Sender: TObject);
begin
  Save    := False;
  Close;
end;

procedure TfrmZipCode.btnSaveClick(Sender: TObject);
begin
  Save    := True;
  Close;
end;

procedure TfrmZipCode.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose  := (edtZipCode.Text <> EmptyStr) and (edtCityName.Text <> EmptyStr) and Save;
end;

end.
