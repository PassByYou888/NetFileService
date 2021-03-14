program NetFileService;

{$mode objfpc}{$H+}

uses
  //{$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  //{$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, NetFileServiceFrm
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TNetFileServiceForm, NetFileServiceForm);
  Application.Run;
end.

