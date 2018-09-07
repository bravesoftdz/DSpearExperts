program Viewer.Tests.Project;

uses
  Vcl.Forms,
  Viewer.Tests in 'Viewer.Tests.pas' {frmTestViewer},
  RegisterTool.Viewer in '..\Viewer\RegisterTool.Viewer.pas' {frmRegisterTool},
  RegisterToolItem.Viewer in '..\Viewer\RegisterToolItem.Viewer.pas' {fraRegisterToolItem: TFrame},
  ViewModel.RegisterTool in '..\ViewModel\ViewModel.RegisterTool.pas',
  ViewModel.RegisterToolItem in '..\ViewModel\ViewModel.RegisterToolItem.pas',
  RegisterTool.Viewer.Interf in '..\Viewer\RegisterTool.Viewer.Interf.pas',
  RegisterToolItem.Viewer.Interf in '..\Viewer\RegisterToolItem.Viewer.Interf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTestViewer, frmTestViewer);
  Application.Run;
end.
