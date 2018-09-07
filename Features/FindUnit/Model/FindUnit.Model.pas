unit FindUnit.Model;

interface

uses
  FindUnit.Model.Interf;

type
  TFindUnitModel = class(TInterfacedObject, IFindUnitModel)
  public
    function GetSelectedText: string;
  end;

implementation

{ TFindUnitModel }

function TFindUnitModel.GetSelectedText: string;
begin
  Result := 'Test';
end;

end.
