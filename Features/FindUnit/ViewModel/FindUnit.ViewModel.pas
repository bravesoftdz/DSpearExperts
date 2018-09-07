unit FindUnit.ViewModel;

interface

uses
  FindUnit.Model.Interf,
  FindUnit.ViewModel.Interf,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls;

type
  TFindUnitViewModel = class(TInterfacedObject, IFindUnitViewModel)
  private
    FFindUnitModel: IFindUnitModel;
  public
    constructor Create(FindUnitModel: IFindUnitModel);

    procedure SetTextForSearch(Edit: TEdit);
  end;

implementation

{ TFindUnitViewModel }

constructor TFindUnitViewModel.Create(FindUnitModel: IFindUnitModel);
begin
  FFindUnitModel := FindUnitModel;
end;

procedure TFindUnitViewModel.SetTextForSearch(Edit: TEdit);
begin
  Edit.Text := FFindUnitModel.GetSelectedText;
end;

end.
