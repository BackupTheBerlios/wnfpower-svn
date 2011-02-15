unit p_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, ActnList, Menus, Inifiles;

type
  TwnfPowerObj = object
    Caption:string;
    Hint:string;
    Kommando:string;
    Parameter:string;
    Konsole:boolean;
  end;

type

  { TForm1 }

  TForm1 = class(TForm)
    ax_5: TAction;
    ax_4: TAction;
    ax_3: TAction;
    ax_2: TAction;
    ax_1: TAction;
    ax: TActionList;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    mm: TMainMenu;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure ax_Execute(Sender: TObject);
    procedure Button5MouseEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
  private
    { private declarations }
    fInifilename:string;
    fSL:TStringList;
    procedure _Init;
    procedure _Nop(Sender: TObject);
    procedure _LadenAction(x:TAction);
    procedure _Beep;
    procedure _Speichern;
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

uses p_const, p_eingabe, wnf_linux;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := cProgName +' '+ cProgVersion + IntToStr(cProgBuild);
  _Init;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  _Speichern;
end;

procedure TForm1.ax_Execute(Sender: TObject);
begin
  _Nop(Sender);
end;

procedure TForm1.Button5MouseEnter(Sender: TObject);
begin
  Panel3.Caption:=ax_5.Hint;
end;

procedure TForm1._Init;
var s:string;
  i:integer;
  x:TAction;
  p : TwnfPowerObj;
begin
  fInifilename:=wnfIniFileName(ApplicationName);
  fSL:=TStringList.Create;
  for i:=0 to ax.ActionCount-1 do begin
    x:=TAction(ax.Actions[i]);
    if assigned(x) then begin
    x.Caption:='';
    x.Tag:=i;
    end;
  end;
  for i:=0 to ax.ActionCount-1 do begin
    x:=TAction(ax.Actions[i]);
    _LadenAction(x);
  end;
end;

procedure TForm1._LadenAction(x: TAction);
var i:integer;  s:string; ini:TINIFile;
begin
  if not assigned(x) then exit;
  ini:=TIniFile.Create(fInifilename);
  try
  i:=x.Tag;
  s:=cIniButton+IntToStr(i+1);
  x.Caption:=ini.ReadString(s,cIniCaption,x.Caption);
  x.Hint:=ini.ReadString(s,cIniHint,x.Hint);
  finally
    FreeAndNil(ini);
  end;
end;

procedure TForm1._Nop(Sender: TObject);
var s:string;
  x:TAction;
begin
  if not (Sender is TAction) then exit;
  x:=TAction(Sender);
  if (x.Caption='') or (_Kommando(x)='') then begin
    s:=cIniButton+IntToStr(x.Tag+1);
    if am_Eingabe.Execute(fInifilename,s) then begin
       _LadenAction(x);
    end;
  end;
end;

procedure TForm1._Beep;
begin
  wnf_playsound_beep;
end;

procedure TForm1._Speichern;
var s:string;
  i:integer;
  x:TAction;
  ini:TINIFile;
begin
  ini:=TIniFile.Create(fInifilename);
  try
  for i:=0 to ax.ActionCount-1 do begin
    x:=TAction(ax.Actions[i]);
    if assigned(x) then begin
      s:=cIniButton+IntToStr(i+1);
      ini.WriteString(s,cIniCaption,x.Caption);
      ini.WriteString(s,cIniHint,x.Hint);
    end;
  end;
  finally
    FreeAndNil(ini);
  end;
end;

initialization
  {$I p_main.lrs}

end.

