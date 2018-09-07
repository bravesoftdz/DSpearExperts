unit uViewerTests;

interface

uses
  FindUnit.Model,
  FindUnit.ViewModel,
  FindUnit.ViewModel.Interf,
  FindUnit.Viewer,

  System.Classes,
  System.SysUtils,
  System.Variants,

  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls,

  Winapi.Messages,
  Winapi.Windows;

type
  TFormMain = class(TForm)
    btnCreateSampleForm: TButton;
    procedure btnCreateSampleFormClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.btnCreateSampleFormClick(Sender: TObject);
var
  FindUnitForm: TFormFindUnit;
  FindUnitModel: TFindUnitModel;
  ViewModel: TFindUnitViewModel;
begin
  FindUnitModel := TFindUnitModel.Create;
  ViewModel := TFindUnitViewModel.Create(FindUnitModel);
  FindUnitForm := TFormFindUnit.Create(ViewModel, Self);
  FindUnitForm.Show;
end;

end.
