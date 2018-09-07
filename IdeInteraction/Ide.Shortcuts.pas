unit Ide.Shortcuts;

interface

uses
  ToolsAPI,

  Feature.Domain,

  Ide.Shortcuts.Interf;

type
  TToolShortcut = class(TNotifierObject, IOTAKeyboardBinding)
  public
    //IOTAKeyboardBinding
    function GetBindingType: TBindingType;
    function GetDisplayName: string;
    function GetName: string;
    procedure BindKeyboard(const BindingServices: IOTAKeyBindingServices);
  end;

  TIdeShortcuts = class(TInterfacedObject, IIdeShortCuts)
  public
    procedure RegisterShortcut(ToolInformation: TToolInformation);
  end;

implementation

{ TToolShortcut }

procedure TToolShortcut.BindKeyboard(
  const BindingServices: IOTAKeyBindingServices);
begin

end;

function TToolShortcut.GetBindingType: TBindingType;
begin

end;

function TToolShortcut.GetDisplayName: string;
begin

end;

function TToolShortcut.GetName: string;
begin

end;

{ TIdeShortcuts }

procedure TIdeShortcuts.RegisterShortcut(ToolInformation: TToolInformation);
begin

end;

end.
