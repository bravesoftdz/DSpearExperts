unit Viewer.Tests;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Spring.Collections, RegisterToolItem.Viewer.Interf,
  Feature.Domain;

type
  TfrmTestViewer = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    procedure OnFinishConfiguration(ListOfConfigurations: IList<TToolInformation>);
  public
    { Public declarations }
  end;

var
  frmTestViewer: TfrmTestViewer;

implementation

uses
  RegisterTool.Viewer, RegisterToolItem.Viewer, RegisterTool.Viewer.Interf;

{$R *.dfm}

procedure TfrmTestViewer.btn1Click(Sender: TObject);
var
  RegisterViewer: IRegisterToolViewer;
  RegisterItemViewer: IRegisterToolItemViewer;
  ToolTitle: TToolInformation;
begin
  ToolTitle.Title := 'FindUnit';
  ToolTitle.Description := 'Search for items inside of units';
  ToolTitle.Enabled := True;
  ToolTitle.ShortCut.Ctrl := True;
  ToolTitle.ShortCut.Shift := True;
  ToolTitle.ShortCut.Alt := True;
  ToolTitle.ShortCut.CharKey := 'F';
  
  RegisterItemViewer := TfraRegisterToolItem.Create;
  RegisterItemViewer.SetItemInformation(ToolTitle);

  RegisterViewer := TfrmRegisterTool.Create(Self);
  RegisterViewer.AddTool(RegisterItemViewer);
  RegisterViewer.Show(OnFinishConfiguration);
end;

procedure TfrmTestViewer.OnFinishConfiguration(
  ListOfConfigurations: IList<TToolInformation>);
begin
  Caption := 'Item configured' + IntToStr(ListOfConfigurations.Count);
end;

end.
