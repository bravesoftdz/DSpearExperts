unit Ide.Shortcuts.Interf;

interface

uses
  Feature.Domain;

type
  TActionShortcut = procedure of object;

  IIdeShortCuts = interface
    ['{F23E11BF-37CA-424D-8AE5-EF5E01054A62}']
    procedure RegisterShortcut(ToolInformation: TToolInformation; Action: TActionShortcut);
  end;


implementation

end.
