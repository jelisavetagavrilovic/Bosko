unit uCountries;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.Controls, WEBLib.ExtCtrls, Vcl.StdCtrls,
  WEBLib.StdCtrls;

type
  TfrmCountries = class(TWebForm)
    wp: TWebPanel;
    WebLabel1: TWebLabel;
    edCountryShortName: TWebEdit;
    edtCountryName: TWebEdit;
    WebLabel2: TWebLabel;
    btnSave: TWebButton;
    btnCancel: TWebButton;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Save  : Boolean;
  end;

var
  frmCountries: TfrmCountries;

implementation

{$R *.dfm}

procedure TfrmCountries.btnCancelClick(Sender: TObject);
begin
  Save    := False;
  Close;
end;

procedure TfrmCountries.btnSaveClick(Sender: TObject);
begin
  Save    := True;
  Close;
end;

end.
