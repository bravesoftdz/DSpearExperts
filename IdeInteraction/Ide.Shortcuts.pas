unit Ide.Shortcuts;

interface

uses
  Spring, ToolsAPI,

  Feature.Domain,

  Ide.Shortcuts.Interf,

  Spring.Collections,
  Spring.Logging,

  System.Classes,
  System.Generics.Collections,
  System.SysUtils,

  Vcl.Dialogs,
  Vcl.Menus;

type
  TToolShortcut = class(TNotifierObject, IOTAKeyboardBinding)
  strict private
    FShortcutIndex: Integer;
    FToolInformation: TToolInformation;
    FMethod: TActionShortcut;
    FLogger: ILogger;

    procedure InternalMethod(const Context: IOTAKeyContext; KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
  public
    //IOTAKeyboardBinding
    function GetBindingType: TBindingType;
    function GetDisplayName: string;
    function GetName: string;
    procedure BindKeyboard(const BindingServices: IOTAKeyBindingServices);

    constructor Create(ToolInformation: TToolInformation; Method: TActionShortcut; Logger: ILogger);

    property ShortcutIndex: Integer read FShortcutIndex write FShortcutIndex;
  end;

  TIdeShortcuts = class(TInterfacedObject, IIdeShortCuts)
  private
    FShotcutList: IDictionary<string, TToolShortcut>;
    FLogger: ILogger;

    procedure RemoveToolShortcut(ToolTitle: string);
  public
    constructor Create(Logger: ILogger);
    destructor Destroy; override;

    procedure RegisterShortcut(ToolInformation: TToolInformation);
  end;

implementation

{ TToolShortcut }

procedure TToolShortcut.BindKeyboard(
  const BindingServices: IOTAKeyBindingServices);
var
  ShiftState: TShiftState;
begin
  ShiftState := [];

  if FToolInformation.ShortCut.Ctrl then
    Include(ShiftState, ssCtrl);

  if FToolInformation.ShortCut.Shift then
    Include(ShiftState, ssShift);

  if FToolInformation.ShortCut.Alt then
    Include(ShiftState, ssAlt);

  BindingServices.AddKeyBinding([ShortCut(Ord(FToolInformation.ShortCut.CharKey), ShiftState)], InternalMethod, nil);
end;

constructor TToolShortcut.Create(ToolInformation: TToolInformation; Method: TActionShortcut; Logger: ILogger);
begin
  FLogger := Logger;
  FLogger.Debug('rodrigo create');
  ShowMessage('aqui chegou');
  FMethod := Method;
  FToolInformation := ToolInformation;
end;

function TToolShortcut.GetBindingType: TBindingType;
begin
  Result := btPartial;
end;

function TToolShortcut.GetDisplayName: string;
begin
  Result := FToolInformation.Title;
end;

function TToolShortcut.GetName: string;
begin
  Result := FToolInformation.Title;
end;

procedure TToolShortcut.InternalMethod(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  BindingResult := krHandled;
  FMethod;
end;

{ TIdeShortcuts }

constructor TIdeShortcuts.Create(Logger: ILogger);
begin
  FLogger := Logger;
  FShotcutList := TCollections.CreateDictionary<string, TToolShortcut>;
end;

destructor TIdeShortcuts.Destroy;
begin
  FShotcutList.ForEach(
    procedure (const Action: TPair<string, TToolShortcut>)
    begin
      RemoveToolShortcut(Action.Key);
    end);
  inherited;
end;

procedure TIdeShortcuts.RegisterShortcut(ToolInformation: TToolInformation);
var
  ToolShortcut: TToolShortcut;
  ToolShortcutBinding: IOTAKeyboardBinding;
  ShortcutIndex: Integer;
begin
  RemoveToolShortcut(ToolInformation.Title);

  ToolShortcut := TToolShortcut.Create(ToolInformation, ToolInformation.Action, FLogger);
  FShotcutList.AddOrSetValue(ToolInformation.Title, ToolShortcut);

  if not ToolInformation.Enabled then
    Exit;

  ToolShortcutBinding := ToolShortcut as IOTAKeyboardBinding;
  with (BorlandIDEServices as IOTAKeyboardServices) do
  begin
    ShortcutIndex := AddKeyboardBinding(ToolShortcutBinding);
    ShowMessage(IntToStr(ShortcutIndex));
    ToolShortcut.ShortcutIndex := ShortcutIndex;
  end;
end;

procedure TIdeShortcuts.RemoveToolShortcut(ToolTitle: string);
var
  ToolShortcut: TToolShortcut;
begin
  if FShotcutList.TryGetValue(ToolTitle, ToolShortcut) then
  begin
    with (BorlandIDEServices as IOTAKeyboardServices) do
      RemoveKeyboardBinding(ToolShortcut.ShortcutIndex);
  end;
end;

end.
