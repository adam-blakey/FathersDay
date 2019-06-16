program HeaderFooterApplication;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {HeaderFooterForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(THeaderFooterForm, HeaderFooterForm);
  Application.Run;
end.
