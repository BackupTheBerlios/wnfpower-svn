program wnfpower;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, p_main, LResources, p_const, wnf_linux, p_eingabe
  { you can add units after this };

{$IFDEF WINDOWS}{$R wnfpower.rc}{$ENDIF}

begin
  {$I wnfpower.lrs}
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tam_Eingabe, am_Eingabe);
  Application.Run;
end.

