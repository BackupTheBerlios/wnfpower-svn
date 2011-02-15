unit wnf_linux;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Process, FileUtil;

procedure wnf_playsound(filename : string; faktor_lautstaerke : real);
procedure wnf_playsound_beep;
procedure wnfkdekonsole(cmd:string);
function wnfAnwenderdaten:string;
function wnfIniFileName(aApplicationName:string):string;

implementation

procedure wnf_playsound(filename : string; faktor_lautstaerke : real);
var  AProcess: TProcess;
begin
  AProcess := TProcess.Create(nil)  ;
  AProcess.CommandLine := 'play -v ' + floattostr(faktor_lautstaerke) + ' '  + filename;
  AProcess.Execute;
end;

procedure wnf_playsound_beep;
var  AProcess: TProcess;
begin
  AProcess := TProcess.Create(nil)  ;
  AProcess.CommandLine := 'playsound /usr/share/kde4/apps/korganizer/sounds/icemag.wav';
  AProcess.Execute;
end;

procedure wnfkdekonsole(cmd:string);
const
  ckonsole = 'konsole --hold -e ';
var  AProcess: TProcess;
begin
  AProcess := TProcess.Create(nil)  ;
  AProcess.CommandLine := ckonsole+cmd;
  AProcess.Execute;
end;

function wnfAnwenderdaten:string;
begin
  Result:=GetUserDir+'.wlsoft'+PathDelim;
  ForceDirectory(Result);
end;

function wnfIniFileName(aApplicationName:string):string;
begin
  Result:=ExtractFileName(aApplicationName);
  Result:=wnfAnwenderdaten+Result+'.ini';
end;

end.

