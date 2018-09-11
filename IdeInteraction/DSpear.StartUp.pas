unit DSpear.StartUp;

interface

uses
  Spring,

  DSpear.Ide.Main,
  DSpear.ImageGalery,
  DSpear.Settings,

  Ide.Main.Interf,
  Ide.Shortcuts,
  Ide.Shortcuts.Interf,

  ImageGalery.Interf,

  Spring.Container;

implementation

var
  IdeMain: IIdeMain;

procedure RegisterClasses;
begin
  GlobalContainer.RegisterType<TDSpearImageGalery>.Implements<IImageGalery>;
  GlobalContainer.RegisterType<TDSpearIdeMain>.Implements<IIdeMain>;
  GlobalContainer.RegisterType<TSettings>.Implements<ISettings>;
  GlobalContainer.RegisterType<TSettings>.Implements<ISettings>;
  GlobalContainer.RegisterType<TIdeShortcuts>.Implements<IIdeShortCuts>;

  GlobalContainer.Build;
end;

procedure StartInteractionWithIde;
begin
  IdeMain := GlobalContainer.Resolve<IIdeMain>;
end;

procedure RegisterInitialShortcuts;
begin

end;

procedure StartUpDSpear;
begin
  RegisterClasses;
  RegisterInitialShortcuts;
end;

initialization
  StartUpDSpear;

finalization

end.

