unit RegisterTool.Viewer.Interf;

interface

uses
  Feature.Domain,

  RegisterToolItem.Viewer.Interf,

  Spring.Collections;

type
  TOnFinishConfiguration = procedure (ListOfConfigurations: IList<TToolInformation>) of object;

  IRegisterToolViewer = interface
    ['{55905AD8-0F33-4AD1-A5E9-1B55A59B5BA4}']
    procedure AddTool(ToolItem: IRegisterToolItemViewer);
    procedure Show(OnFinishConfiguration: TOnFinishConfiguration);
  end;

implementation

end.
