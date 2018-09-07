unit ImageGalery.Interf;

interface

uses
  Vcl.Imaging.pngimage;

type
  {$SCOPEDENUMS ON}
  TImageGalleryType = (SplashScreen);
  {$SCOPEDENUMS OFF}

  IImageGalery = interface
    ['{8AD4037E-8FD4-4ABD-B7C9-5E00DD85B9DF}']
    function GetImage(ImageGalleryType: TImageGalleryType): TPngImage;
  end;


implementation

end.
