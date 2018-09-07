unit RegisterTool.Viewer;

interface

uses
  Feature.Domain,

  RegisterTool.Viewer.Interf,

  RegisterToolItem.Viewer.Interf,

  Spring.Collections,

  System.Classes,
  System.SysUtils,
  System.Variants,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,

  Winapi.Messages,
  Winapi.Windows;

type
  TfrmRegisterTool = class(TForm, IRegisterToolViewer)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FOnFinishConfiguration: TOnFinishConfiguration;
    FListOfTools: IList<IRegisterToolItemViewer>;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AddTool(ToolItem: IRegisterToolItemViewer);
    procedure Show(OnFinishConfiguration: TOnFinishConfiguration);
  end;

implementation

{$R *.dfm}

{ TfrmRegisterTool }

procedure TfrmRegisterTool.AddTool(ToolItem: IRegisterToolItemViewer);
begin
  ToolItem.SetParent(Self);
  FListOfTools.Add(ToolItem);
end;

constructor TfrmRegisterTool.Create(AOwner: TComponent);
begin
  inherited;
  FListOfTools := TCollections.CreateList<IRegisterToolItemViewer>;
end;

destructor TfrmRegisterTool.Destroy;
begin

  inherited;
end;

procedure TfrmRegisterTool.FormClose(Sender: TObject; var Action: TCloseAction);
var
  Tool: IRegisterToolItemViewer;
  ListOfConfigurations: IList<TToolInformation>;
begin
  ListOfConfigurations := TCollections.CreateList<TToolInformation>;

  for Tool in FListOfTools do
    ListOfConfigurations.Add(Tool.GetItemInformation);

  if Assigned(FOnFinishConfiguration) then
    FOnFinishConfiguration(ListOfConfigurations);
end;

procedure TfrmRegisterTool.Show(OnFinishConfiguration: TOnFinishConfiguration);
begin
  FOnFinishConfiguration := OnFinishConfiguration;
  inherited Show;
end;

end.
