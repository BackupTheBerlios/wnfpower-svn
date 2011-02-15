unit p_eingabe;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, ActnList, IniFiles;

type

  { Tam_Eingabe }

  Tam_Eingabe = class(TForm)
    ax_Cancel: TAction;
    ax_OK: TAction;
    ActionList1: TActionList;
    Button1: TButton;
    Button2: TButton;
    ed_Caption: TEdit;
    ed_Kommando: TEdit;
    ed_Parameter: TEdit;
    ed_Hint: TEdit;
    gb_Caption: TGroupBox;
    gb_Hint: TGroupBox;
    gb_Kommando: TGroupBox;
    gb_Parameter: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure ax_CancelExecute(Sender: TObject);
    procedure ax_OKExecute(Sender: TObject);
  private
    { private declarations }
    procedure _Laden(aIniDateiName,aSectionName:string);
    procedure _Speichern(aIniDateiName,aSectionName:string);
  public
    { public declarations }
    function Execute(aIniDateiName,aSectionName:string):boolean;
  end; 

var
  am_Eingabe: Tam_Eingabe;

implementation

  uses p_const;

{ Tam_Eingabe }

procedure Tam_Eingabe.ax_CancelExecute(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure Tam_Eingabe.ax_OKExecute(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

function Tam_Eingabe.Execute(aIniDateiName, aSectionName: string): boolean;
begin
  _Laden(aIniDateiName, aSectionName);
  ShowModal;
  Result := ModalResult=mrOK;
  if Result then
    _Speichern(aIniDateiName, aSectionName);
end;

procedure Tam_Eingabe._Laden(aIniDateiName, aSectionName: string);
var
  ini:TIniFile;
begin
  ini:=TIniFile.Create(aIniDateiName);
  try
    ed_Caption.Text:=ini.ReadString(aSectionName,cIniCaption,'');
    ed_Hint.Text:=ini.ReadString(aSectionName,cIniHint,'');
    ed_Kommando.Text:=ini.ReadString(aSectionName,cIniKommando,'');
    ed_Parameter.Text:=ini.ReadString(aSectionName,cIniParameter,'');
  finally
    FreeAndNil(ini);
  end;
end;

procedure Tam_Eingabe._Speichern(aIniDateiName, aSectionName: string);
var
  ini:TIniFile;
begin
  ini:=TIniFile.Create(aIniDateiName);
  try
    ini.WriteString(aSectionName,cIniCaption,ed_Caption.Text);
    ini.WriteString(aSectionName,cIniHint,ed_Hint.Text);
    ini.WriteString(aSectionName,cIniKommando,ed_Kommando.Text);
    ini.WriteString(aSectionName,cIniParameter,ed_Parameter.Text);
  finally
    FreeAndNil(ini);
  end;
end;

initialization
  {$I p_eingabe.lrs}

end.

