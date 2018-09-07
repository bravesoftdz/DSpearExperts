unit DSpear.ImageGalery;

interface

uses
  ImageGalery.Interf,

  Spring.Collections,

  System.Classes,
  System.Generics.Collections,

  Vcl.Imaging.pngimage;

type
  TDSpearImageGalery = class(TInterfacedObject, IImageGalery)
  private
    FRepository: IDictionary<TImageGalleryType, TPngImage>;

    procedure GetGraphicFromText(var Graphic: TPngImage; ImageBaseText: string);
    function GetTextForType(ImageGalleryType: TImageGalleryType): string;
    procedure GetSplashScreen(var Target: TPngImage);
  public
    constructor Create;

    function GetImage(ImageGalleryType: TImageGalleryType): TPngImage;
  end;

implementation

{ TDSpearImageGalery }

constructor TDSpearImageGalery.Create;
begin
  FRepository := TCollections.CreateDictionary<TImageGalleryType, TPngImage>([doOwnsValues]);
end;

procedure TDSpearImageGalery.GetGraphicFromText(var Graphic: TPngImage; ImageBaseText: string);
var
  ImageStream: TMemoryStream;
  ImageName: ShortString;
begin
  ImageStream := TMemoryStream.Create;
  try
    ImageStream.Size := Length(ImageBaseText) div 2;
    HexToBin(PChar(ImageBaseText), ImageStream.Memory^, ImageStream.Size);

    ImageStream.Position := 0;
    ImageName := PShortString(ImageStream.Memory)^;
    Graphic := TPngImage.Create;
    ImageStream.Position := 1 + Length(ImageName);
    Graphic.LoadFromStream(ImageStream);
  finally
    ImageStream.Free;
  end;
end;

function TDSpearImageGalery.GetImage(ImageGalleryType: TImageGalleryType): TPngImage;
begin
  if FRepository.TryGetValue(ImageGalleryType, Result) then
    Exit;

  case ImageGalleryType of
    TImageGalleryType.SplashScreen:
      GetSplashScreen(Result);
  end;

  FRepository.Add(ImageGalleryType, Result);
end;

procedure TDSpearImageGalery.GetSplashScreen(var Target: TPngImage);
begin
  GetGraphicFromText(Target,
    '0954506E67496D61676589504E470D0A1A0A0000000D49484452000000100000' +
    '00100804000000B5FA37EA0000000467414D410000B18F0BFC61050000000262' +
    '4B47440000AA8D2332000000097048597300000DD700000DD70142289B780000' +
    '000774494D4507E1051D11071FA4F230C0000000AC4944415478DA636400810B' +
    '0CFA0C98E0228301030323710AD419E631EC64D88424E9C7E0CE90C47013A680' +
    '816107C30A203B1CCA5BC9F09F2182C103C44456C0CE301DCCFFCF90C9F0135D' +
    'C106063E86640669A01206A0F45386B90C9F18029015F032B400EDEC60980064' +
    '17305400DD54C3F0195901081831CC64E001D25F18D219CEC104895640D00A82' +
    '8E24E84D90020D867228AF93E106AA0248502B30244215CC6778801AD494C426' +
    '00C11F3D11DC7AADEC0000002574455874646174653A63726561746500323031' +
    '372D30352D32395431373A30373A33312B30323A3030A83C4AA7000000257445' +
    '5874646174653A6D6F6469667900323031372D30352D32395431373A30373A33' +
    '312B30323A3030D961F21B0000001974455874536F667477617265007777772E' +
    '696E6B73636170652E6F72679BEE3C1A0000000049454E44AE426082');
end;

function TDSpearImageGalery.GetTextForType(ImageGalleryType: TImageGalleryType): string;
begin

end;

end.
