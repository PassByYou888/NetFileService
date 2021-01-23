program NetFileClient;

uses
  Vcl.Forms,
  NetFileClientFrm in 'NetFileClientFrm.pas' {NetFileClientForm},
  Vcl.Themes,
  Vcl.Styles,
  ProgressBarFrm in 'ProgressBarFrm.pas' {ProgressBarForm};

{$R *.res}


begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10 Dark');
  Application.CreateForm(TNetFileClientForm, NetFileClientForm);
  Application.CreateForm(TProgressBarForm, ProgressBarForm);
  Application.Run;

end.
