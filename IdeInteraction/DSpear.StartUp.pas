unit DSpear.StartUp;

interface

uses
  Spring,

  DSpear.Ide.Main,
  DSpear.ImageGalery,
  DSpear.Settings,

  Feature.Domain,

  FindUnit.Model,
  FindUnit.ViewModel,
  FindUnit.Viewer,

  Ide.Main.Interf,
  Ide.Shortcuts,
  Ide.Shortcuts.Interf,

  ImageGalery.Interf,

  RegisterTool.Viewer,
  RegisterTool.Viewer.Interf,

  RegisterToolItem.Viewer,
  RegisterToolItem.Viewer.Interf,

  Spring.Container,
  Spring.Logging,
  Spring.Logging.Appenders,
  Spring.Logging.Controller,
  Spring.Logging.Loggers,

  System.SysUtils,

  Vcl.Dialogs,

  Winapi.Windows;

  procedure Register;

implementation

var
  IdeMain: IIdeMain;
  DSpearContainer: TContainer;

procedure StartInteractionWithIde;
begin
  IdeMain := DSpearContainer.Resolve<IIdeMain>;
  IdeMain.CreateMainMenu;
end;

procedure RegisterTools;
var
  IdeShortCuts: IIdeShortCuts;
  procedure RegisterSearchImports;
  var
    Item: TToolInformation;
    Shotcut: TShortcutInformation;
  begin
    Item.Title := 'Find unit';
    Item.Description := 'Find unit to satisfy implementation.';
    Item.Enabled := True;
    //Standard short cut
    Item.ShortCut.Ctrl := True;
    Item.ShortCut.Shift := True;
    Item.ShortCut.Alt := False;
    Item.ShortCut.CharKey := 'B';

    Item.Action := procedure
      begin
        with TFormFindUnit.Create(TFindUnitViewModel.Create(TFindUnitModel.Create), nil) do
        begin
          Show;
          Free;
        end;
      end;

    IdeMain.RegisterToolInformation(Item);
    IdeShortCuts.RegisterShortcut(Item);
  end;

begin
  IdeShortCuts := DSpearContainer.Resolve<IIdeShortCuts>;

  RegisterSearchImports;
end;

procedure RegisterLogger;
begin
  DSpearContainer.RegisterType<ILogger>.DelegateTo(
    function: ILogger
    var
      Logger: TLogger;
      Controller: TLoggerController;
      Appender: TFileLogAppender;
      Filename: string;
    begin
      Filename := 'Log_' +  IntToStr(GetTickCount) + '.log';

      Controller := TLoggerController.Create;
      (Controller as ILoggerProperties).Levels := LOG_ALL_LEVELS;

      Logger := TLogger.Create(Controller);
      Logger.EventTypes := [TLogEventType.Text];
      Logger.Levels := LOG_ALL_LEVELS;

      Appender := TFileLogAppender.Create;
      (Appender as ILoggerProperties).Levels := LOG_ALL_LEVELS;
      (Appender as TFileLogAppender).FileName := 'c:\temp\' + Filename;

      Controller.AddAppender(Appender);

      Result := Logger;
    end).AsSingleton;
end;

procedure RegisterClasses;
begin
  DSpearContainer := TContainer.Create;
  RegisterLogger;

  DSpearContainer.RegisterType<TDSpearImageGalery>.Implements<IImageGalery>;
  DSpearContainer.RegisterType<TSettings>.Implements<ISettings>;
  DSpearContainer.RegisterType<TIdeShortcuts>.Implements<IIdeShortCuts>.AsSingleton;
  DSpearContainer.RegisterType<TDSpearIdeMain>.Implements<IIdeMain>;
  DSpearContainer.RegisterType<IRegisterToolItemViewer>.DelegateTo(
    function: IRegisterToolItemViewer
    begin
      Result := TfraRegisterToolItem.Create(nil);
    end);
  DSpearContainer.RegisterType<TfrmRegisterTool, TfrmRegisterTool>;

  {TODO: For some reason, if I install the package and uninstall, if I register this form, in few seconds
   the IDE will throw some AV. Need to check.}
//  DSpearContainer.RegisterType<IRegisterToolViewer>.DelegateTo(
//    function: IRegisterToolViewer
//    begin
//      Result := TfrmRegisterTool.Create(nil);
//    end);

  DSpearContainer.Build;
end;

procedure Register;
begin
  RegisterClasses;
  StartInteractionWithIde;
  RegisterTools;
end;

initialization

finalization
  IdeMain := nil;
  DSpearContainer.Free;

end.

