unit Ide.Main.Interf;

interface

uses
  Feature.Domain;

type
  IIdeMain = interface
  ['{60B29239-FFBF-4678-9B18-2F9E2AD7D833}']
    procedure CreateMainMenu;
    procedure RegisterToolInformation(ToolInformation: TToolInformation);
  end;

implementation

end.
