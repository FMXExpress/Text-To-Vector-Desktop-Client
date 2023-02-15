program IllustrokeClient;

uses
  System.StartUpCopy,
  FMX.Forms,
  Skia.FMX,
  uMainForm in 'uMainForm.pas' {MainForm};

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
