unit DSpear.Settings;

interface

uses
  Feature.Domain,

  System.IniFiles,
  System.SysUtils;

type
  TSettings = class
  private
    FSettingsFilePath: string;
    function GetSettingsFile: TIniFile;
  public
    constructor Create;
    destructor Destroy; override;

    function GetShortcutForTool(ToolName: string; out ShortcutInformation: TShortcutInformation): Boolean;
    procedure SetShortcutForTool(ToolInformation: TToolInformation);
  end;

implementation

{ TSettings }

constructor TSettings.Create;
var
  UserDir: string;
begin
  UserDir := GetEnvironmentVariable('USERPROFILE') + 'DSpear\';
  FSettingsFilePath := UserDir + 'settings.ini';
  ForceDirectories(UserDir);
end;

destructor TSettings.Destroy;
begin

  inherited;
end;

function TSettings.GetSettingsFile: TIniFile;
begin
  Result := TIniFile.Create(FSettingsFilePath);
end;

function TSettings.GetShortcutForTool(ToolName: string; out ShortcutInformation: TShortcutInformation): Boolean;
var
  IniFile: TIniFile;
begin
  IniFile := GetSettingsFile;
  try
    Result := IniFile.SectionExists(ToolName);

    ShortcutInformation.Ctrl := IniFile.ReadBool(ToolName,'Shortcut-Ctrl', True);
    ShortcutInformation.Alt := IniFile.ReadBool(ToolName,'Shortcut-Alt', True);
    ShortcutInformation.Shift := IniFile.ReadBool(ToolName,'Shortcut-Shift', True);
    ShortcutInformation.CharKey := IniFile.ReadString(ToolName, 'Shortcut-Char', 'A')[1];
  finally
    IniFile.Free;
  end;
end;

procedure TSettings.SetShortcutForTool(ToolInformation: TToolInformation);
var
  IniFile: TIniFile;
begin
  IniFile := GetSettingsFile;
  try
    IniFile.WriteBool(ToolInformation.Title,'Shortcut-Ctrl', ToolInformation.ShortCut.Ctrl);
    IniFile.WriteBool(ToolInformation.Title,'Shortcut-Alt', ToolInformation.ShortCut.Alt);
    IniFile.WriteBool(ToolInformation.Title,'Shortcut-Shift', ToolInformation.ShortCut.Shift);
    IniFile.WriteString(ToolInformation.Title, 'Shortcut-Char', ToolInformation.ShortCut.CharKey);
  finally
    IniFile.Free;
  end;
end;

end.
