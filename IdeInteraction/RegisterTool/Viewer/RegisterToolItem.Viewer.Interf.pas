unit RegisterToolItem.Viewer.Interf;

interface

uses
  Feature.Domain,

  Vcl.Controls;

type
  IRegisterToolItemViewer = interface
    ['{88C28434-174B-4088-AC22-20FFBFAC80DB}']
    procedure SetParentControl(Control: TWinControl);
    procedure SetItemInformation(ToolTitle: TToolInformation);
    function GetItemInformation: TToolInformation;
  end;

implementation

end.
