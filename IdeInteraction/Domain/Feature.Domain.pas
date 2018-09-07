unit Feature.Domain;

interface

type
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
  end;

implementation

end.
