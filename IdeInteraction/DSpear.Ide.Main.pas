unit DSpear.Ide.Main;

interface

uses
  ToolsAPI,

  Feature.Domain,

  Ide.Main.Interf,
  Ide.Shortcuts.Interf,

  ImageGalery.Interf,

  RegisterTool.Viewer.Interf,

  Spring.Collections,

  System.SysUtils,

  Vcl.Menus;

type
  TDSpearIdeMain = class(TInterfacedObject, IIdeMain)
  private
    FMenusCreated: Boolean;
    FRegisterToolViewer: IRegisterToolViewer;
    FIdeShortCuts: IIdeShortCuts;

    procedure OpenConfiguration(Sender: TObject);
    procedure OnFinishConfiguration(ListOfConfigurations: IList<TToolInformation>);
  public
    constructor Create(ImageGalery: IImageGalery; RegisterToolViewer: IRegisterToolViewer;
      IdeShortCuts: IIdeShortCuts);

    procedure CreateMainMenu;
  end;

implementation

{ TDSpearIdeMain }

constructor TDSpearIdeMain.Create(ImageGalery: IImageGalery; RegisterToolViewer: IRegisterToolViewer;
  IdeShortCuts: IIdeShortCuts);
begin
  FRegisterToolViewer := RegisterToolViewer;
  FIdeShortCuts := IdeShortCuts;
end;

procedure TDSpearIdeMain.CreateMainMenu;
var
  MainMenu: TMainMenu;
  NewItem: TMenuItem;
  DSpearItemMenu: TMenuItem;
  ToolItem: TMenuItem;
  FirstBreak: TMenuItem;
  IndexFirstBreak: Integer;
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

  NewItem := TMenuItem.Create(nil);
  NewItem.Caption := 'Settings';
  NewItem.OnClick := OpenConfiguration;
  DSpearItemMenu.Add(NewItem);
end;

procedure TDSpearIdeMain.OnFinishConfiguration(ListOfConfigurations: IList<TToolInformation>);
begin

end;

procedure TDSpearIdeMain.OpenConfiguration(Sender: TObject);
begin
  FRegisterToolViewer.Show(OnFinishConfiguration);
end;

end.
