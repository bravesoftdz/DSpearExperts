unit Feature.Domain;

interface

type
  TActionShortcut = reference to procedure;

  TShortcutInformation = record
    Ctrl: Boolean;
    Shift: Boolean;
    Alt: Boolean;
    CharKey: Char;
  end;

  TToolInformation = record
    Title: string;
    Description: string;
    Enabled: Boolean;
    ShortCut: TShortcutInformation;
    Action: TActionShortcut;
  end;

implementation

end.
