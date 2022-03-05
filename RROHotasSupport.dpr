program RROHotasSupport;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Frm_Main},
  Utility in 'Utility.pas',
  About in 'About.pas' {Frm_About};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrm_Main, Frm_Main);
  Application.CreateForm(TFrm_About, Frm_About);
  Application.Run;
end.
