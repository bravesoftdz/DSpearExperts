unit FindUnit.Viewer;

interface

uses
  DSpear.ToolApi.Interf,

  FindUnit.ViewModel.Interf,

  System.Classes,
  System.SysUtils,
  System.Variants,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls,

  Winapi.Messages,
  Winapi.Windows;

type
  TFormFindUnit = class(TForm)
    edtSearch: TEdit;
    grpResult: TGroupBox;
    lstResult: TListBox;
    grpSearch: TGroupBox;
    btnAdd: TButton;
  private
    FViewModel: IFindUnitViewModel;

    procedure ConfigureViewer;
  public
    constructor Create(ViewModel: IFindUnitViewModel; AOwner: TComponent); reintroduce;
    procedure Show; reintroduce;
  end;

var
  FormFindUnit: TFormFindUnit;

implementation

{$R *.dfm}

{ TFormFindUnit }

procedure TFormFindUnit.ConfigureViewer;
begin
  FViewModel.SetTextForSearch(edtSearch);
end;

constructor TFormFindUnit.Create(ViewModel: IFindUnitViewModel; AOwner: TComponent);
begin
  inherited Create(Owner);
  FViewModel := ViewModel;
end;

procedure TFormFindUnit.Show;
begin
  inherited;
  ConfigureViewer;
end;

end.
