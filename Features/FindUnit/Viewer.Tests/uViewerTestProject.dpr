program uViewerTestProject;

uses
  Vcl.Forms,
  uViewerTests in 'uViewerTests.pas' {FormMain},
  FindUnit.Viewer in '..\Viewer\FindUnit.Viewer.pas' {FormFindUnit},
  FindUnit.Model.Interf in '..\Model\FindUnit.Model.Interf.pas',
  FindUnit.ViewModel.Interf in '..\ViewModel\FindUnit.ViewModel.Interf.pas',
  FindUnit.ViewModel in '..\ViewModel\FindUnit.ViewModel.pas',
  FindUnit.Model in '..\Model\FindUnit.Model.pas',
  FindUnit.Model.TestImplementation in '..\Model.Tests\FindUnit.Model.TestImplementation.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormFindUnit, FormFindUnit);
  Application.Run;
end.
