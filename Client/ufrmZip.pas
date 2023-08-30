unit ufrmZip;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TfrmZipCode = class(TWebForm)
    WebLabel1: TWebLabel;
    WebLabel2: TWebLabel;
    edtZipCode: TWebEdit;
    WebLabel3: TWebLabel;
    edtCity: TWebEdit;
    btnSave: TWebButton;
    btnClose: TWebButton;
    procedure WebFormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Save    : Boolean;
  end;

var
  frmZipCode: TfrmZipCode;

implementation

{$R *.dfm}

procedure TfrmZipCode.btnCloseClick(Sender: TObject);
begin
  Save    := False;
  Close;
end;

procedure TfrmZipCode.btnSaveClick(Sender: TObject);
begin
  Save    := True;
  Close;
end;

procedure TfrmZipCode.WebFormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose  := (edtZipCode.Text <> EmptyStr) and (edtCity.Text <> EmptyStr);
end;

end.