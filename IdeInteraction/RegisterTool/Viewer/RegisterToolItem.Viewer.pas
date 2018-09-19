unit RegisterToolItem.Viewer;

interface

uses
  Feature.Domain,

  RegisterToolItem.Viewer.Interf,

  System.Classes,
  System.SysUtils,
  System.Variants,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Mask,
  Vcl.StdCtrls,

  Winapi.Messages,
  Winapi.Windows;

type
  TfraRegisterToolItem = class(TFrame, IRegisterToolItemViewer)
    gbGeneral: TGroupBox;
    chbEnabled: TCheckBox;
    cbCtrl: TCheckBox;
    cbAlt: TCheckBox;
    cbShift: TCheckBox;
    Label1: TLabel;
    meChar: TMaskEdit;
    procedure meCharClick(Sender: TObject);
  public
    procedure SetParentControl(Control: TWinControl);
    procedure SetItemInformation(ToolTitle: TToolInformation);
    function GetItemInformation: TToolInformation;
  end;

implementation

{$R *.dfm}

function TfraRegisterToolItem.GetItemInformation: TToolInformation;
begin
  Result.Title := gbGeneral.Caption;
  Result.Enabled := chbEnabled.Checked;
  Result.ShortCut.Ctrl := cbCtrl.Checked;
  Result.ShortCut.Alt := cbAlt.Checked;
  Result.ShortCut.Shift := cbShift.Checked;
  Result.ShortCut.CharKey := meChar.Text[1];
end;

procedure TfraRegisterToolItem.meCharClick(Sender: TObject);
begin
  TMaskEdit(Sender).SelectAll;
end;

procedure TfraRegisterToolItem.SetItemInformation(ToolTitle: TToolInformation);
begin
  gbGeneral.Caption := ToolTitle.Title + ' - ' + ToolTitle.Description;
  chbEnabled.Checked := ToolTitle.Enabled;
  cbCtrl.Checked := ToolTitle.ShortCut.Ctrl;
  cbAlt.Checked := ToolTitle.ShortCut.Alt;
  cbShift.Checked := ToolTitle.ShortCut.Shift;
  meChar.Text := ToolTitle.ShortCut.CharKey;
end;

procedure TfraRegisterToolItem.SetParentControl(Control: TWinControl);
begin
  Self.Parent := Control;
end;

end.
