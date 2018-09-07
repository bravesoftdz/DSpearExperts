unit DSpear.StartUp;

interface

uses
  Spring,

  DSpear.Ide.Main,
  DSpear.ImageGalery,

  Ide.Main.Interf,

  ImageGalery.Interf,

  Spring.Container;

implementation

var
  IdeMain: IIdeMain;

procedure RegisterClasses;
begin
  GlobalContainer.RegisterType<TDSpearImageGalery>.Implements<IImageGalery>;
  GlobalContainer.RegisterType<TDSpearIdeMain>.Implements<IIdeMain>;
  GlobalContainer.Build;
end;

procedure StartInteractionWithIde;
begin
  IdeMain := GlobalContainer.Resolve<IIdeMain>;
end;

procedure StartUpDSpear;
begin
  RegisterClasses;
end;

initialization
  StartUpDSpear;

finalization

end.

