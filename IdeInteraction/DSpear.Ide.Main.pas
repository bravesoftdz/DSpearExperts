unit DSpear.Ide.Main;

interface

uses
  ToolsAPI,

  DSpear.Settings,

  Feature.Domain,

  Ide.Main.Interf,
  Ide.Shortcuts.Interf,

  ImageGalery.Interf,

  RegisterTool.Viewer,
  RegisterTool.Viewer.Interf,

  RegisterToolItem.Viewer,

  Spring.Collections,

  System.Classes,
  System.SysUtils,
  System.Win.VCLCom,

  Vcl.Menus,

  Winapi.Windows;

type
  TDSpearIdeMain = class(TInterfacedObject, IIdeMain)
  private
    FMenusCreated: Boolean;
    FIdeShortCuts: IIdeShortCuts;
    FImageGalery: IImageGalery;
    FSettings: ISettings;
    FToolsInformation: IList<TToolInformation>;

    procedure OpenConfiguration(Sender: TObject);
    procedure OnFinishConfiguration(ListOfConfigurations: IList<TToolInformation>);

    procedure RegisterTool(RegisterToolViewer: IRegisterToolViewer; AOwner: TComponent; ToolInformation: TToolInformation);
    procedure RegisterTools(RegisterToolViewer: IRegisterToolViewer; AOwner: TComponent);
  public
    constructor Create(ImageGalery: IImageGalery; IdeShortCuts: IIdeShortCuts; Settings: ISettings);

    procedure CreateMainMenu;
    procedure GenerateToolsShortCuts;

    procedure RegisterToolInformation(ToolInformation: TToolInformation);
  end;

implementation

{ TDSpearIdeMain }

constructor TDSpearIdeMain.Create(ImageGalery: IImageGalery; IdeShortCuts: IIdeShortCuts; Settings: ISettings);
begin
  FToolsInformation := TCollections.CreateList<TToolInformation>;
  FIdeShortCuts := IdeShortCuts;
  FImageGalery := ImageGalery;
  FSettings := Settings;
end;

procedure TDSpearIdeMain.CreateMainMenu;
var
  MainMenu: TMainMenu;
  NewItem: TMenuItem;
  DSpearItemMenu: TMenuItem;
  ToolItem: TMenuItem;
  FirstBreak: TMenuItem;
  IndexFirstBreak: Integer;
  CurrentSettings: TMenuItem;
begin
  if not (Supports(BorlandIDEServices, INTAServices)) then
    Exit;

  if FMenusCreated then
    Exit;

  FMenusCreated := True;

  MainMenu := (BorlandIDEServices as INTAServices).MainMenu;
  ToolItem := MainMenu.Items.Find('Tools');

  FirstBreak := ToolItem.Find('-');
  if Assigned(FirstBreak) then
    IndexFirstBreak := ToolItem.IndexOf(FirstBreak) + 1
  else
    IndexFirstBreak := ToolItem.Count - 1;

  DSpearItemMenu := ToolItem.Find('DSpear');
  if DSpearItemMenu = nil then
  begin
    DSpearItemMenu := TMenuItem.Create(nil);
    DSpearItemMenu.Caption := 'DSpear';
    ToolItem.Insert(IndexFirstBreak, DSpearItemMenu);
  end;

  CurrentSettings := DSpearItemMenu.Find('Settings');
  if Assigned(CurrentSettings) then
    DSpearItemMenu.Delete(DSpearItemMenu.IndexOf(CurrentSettings));

  NewItem := TMenuItem.Create(nil);
  NewItem.Caption := 'Settings';
  NewItem.OnClick := OpenConfiguration;
  DSpearItemMenu.Add(NewItem);
end;

procedure TDSpearIdeMain.GenerateToolsShortCuts;
begin
end;

procedure TDSpearIdeMain.OnFinishConfiguration(ListOfConfigurations: IList<TToolInformation>);
begin

end;

procedure TDSpearIdeMain.RegisterTool(RegisterToolViewer: IRegisterToolViewer; AOwner: TComponent;
  ToolInformation: TToolInformation);
var
  toolFrame: TfraRegisterToolItem;
begin
  toolFrame := TfraRegisterToolItem.Create(AOwner);
  toolFrame.SetItemInformation(ToolInformation);
  RegisterToolViewer.AddTool(toolFrame);
end;

procedure TDSpearIdeMain.RegisterToolInformation(ToolInformation: TToolInformation);
begin
  FToolsInformation.Add(ToolInformation);

end;

procedure TDSpearIdeMain.RegisterTools(RegisterToolViewer: IRegisterToolViewer; AOwner: TComponent);
var
  I: Integer;
  ShortCutInfo: TShortcutInformation;
  Item: TToolInformation;
begin
  for I := 0 to FToolsInformation.Count -1 do
  begin
    Item := FToolsInformation[I];
    if FSettings.GetShortcutForTool(Item.Title, ShortCutInfo) then
      Item.ShortCut := ShortCutInfo;
    FToolsInformation[I] := Item;
    RegisterTool(RegisterToolViewer, AOwner, FToolsInformation[I]);
  end;
end;

procedure TDSpearIdeMain.OpenConfiguration(Sender: TObject);
var
  RegisterToolViewer: TfrmRegisterTool;
begin
  RegisterToolViewer := TfrmRegisterTool.Create(nil);
  RegisterTools(RegisterToolViewer, RegisterToolViewer);
  RegisterToolViewer.ShowItems(OnFinishConfiguration);
end;

end.
