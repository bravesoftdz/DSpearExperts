unit FindUnit.ViewModel.Interf;

interface

uses
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls;

type
  IFindUnitViewModel = interface
    ['{D618F979-2AB9-4374-8E3D-AC4897320532}']
    procedure SetTextForSearch(Edit: TEdit);
  end;

implementation

end.
