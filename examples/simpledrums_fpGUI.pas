program simpledrums_fpGUI;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  uos_flat,
  fpg_style_chrome_silver_flatmenu,
  fpg_stylemanager,
  SysUtils, Classes, fpg_base, fpg_main,
  {%units 'Auto-generated GUI code'}
  fpg_form, fpg_label, fpg_button, fpg_edit
  {%endunits}
  ;

type

  Tsimpledrum = class(TfpgForm)
  private
    {@VFD_HEAD_BEGIN: simpledrum}
    Label1: TfpgLabel;
    Button1: TfpgButton;
    Button2: TfpgButton;
    EditInteger1: TfpgEdit;
    {@VFD_HEAD_END: simpledrum}
    public
    Timertick: Tfpgtimer;
    sound: array[0..3] of string;
    posi: integer;
    drum_beats: array[0..2] of string; 
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure ontimertick(Sender: TObject);
    procedure initall;
    procedure AfterCreate; override;
  end;

{@VFD_NEWFORM_DECL}

{@VFD_NEWFORM_IMPL}

var
   stopit :boolean = false;
   ms0, ms1, ms2 : Tmemorystream; 
  
  
procedure Tsimpledrum.initall;
var ordir: string;
    lib1, lib2: string;
    i : integer;
         
begin
 Timertick := Tfpgtimer.Create(100);
 Timertick.enabled := false;
 Timertick.OnTimer := @ontimertick;
 
  ordir := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

    {$IFDEF Windows}
         {$if defined(cpu64)}
        lib1 := ordir + 'lib\Windows\64bit\LibPortaudio-64.dll';
        lib2 := ordir + 'lib\Windows\64bit\LibSndFile-64.dll';
         {$else}
        lib1 := ordir + 'lib\Windows\32bit\LibPortaudio-32.dll';
        lib2 := ordir + 'lib\Windows\32bit\LibSndFile-32.dll';
         {$endif}
     {$ENDIF}

     {$IFDEF linux}
        {$if defined(cpu64)}
       lib1 :=  ordir + 'lib/Linux/64bit/LibPortaudio-64.so'    ;
       lib2 := ordir + 'lib/Linux/64bit/LibSndFile-64.so'   ;
        {$else}
        lib1 := ordir + 'lib/Linux/32bit/LibPortaudio-32.so';
         lib2 := ordir + 'lib/Linux/32bit/LibSndFile-32.so'   ;
        {$endif}
      {$ENDIF}

     {$IFDEF freebsd}
        {$if defined(cpu64)}
         lib1 :=  ordir + 'lib/FreeBSD/64bit/libportaudio-64.so'    ;
         lib2 := ordir + 'lib/FreeBSD/64bit/libportaudio-64.so'   ;
        {$else}
        lib1 := ordir + 'lib/FreeBSD/32bit/libportaudio-32.so';
        lib2 := ordir + 'lib/FreeBSD/32bit/libportaudio-32.so'   ;
        {$endif}
      {$ENDIF}

     {$IFDEF Darwin}
        ordir := copy(ordir, 1, Pos('/UOS', ordir) - 1);
       lib1 :=  ordir + '/lib/Mac/32bit/LibPortaudio-32.dylib';
       lib2 :=  ordir + '/lib/Mac/32bit/LibSndFile-32.dylib';
     {$ENDIF}

uos_LoadLib(Pchar(lib1),  Pchar(lib2), nil, nil, nil,nil);

// uos_SetGlobalEvent(true) ;

sound[0] := ordir + 'sound' + directoryseparator +  'drums' + directoryseparator + 'HH.wav';
sound[1] := ordir + 'sound' + directoryseparator +  'drums' + directoryseparator + 'SD.wav';
sound[2] := ordir + 'sound' + directoryseparator +  'drums' + directoryseparator + 'BD.wav';

 drum_beats[0] := 'x0x0x0x0x0x0x0x0'; // hat
 drum_beats[1] := '0000x0000000x000'; // snare
 drum_beats[2] := 'x0000000x0x00000'; // kick

 posi := 1;
 {
 ms0:= TMemoryStream.Create; 
 ms0.LoadFromFile(pchar(sound[0])); 
 ms0.Position:= 0;
 
 ms1:= TMemoryStream.Create; 
 ms1.LoadFromFile(pchar(sound[1])); 
 ms1.Position:= 0;
 
 ms2:= TMemoryStream.Create; 
 ms2.LoadFromFile(pchar(sound[2])); 
 ms2.Position:= 0; 
 }

   for i := 0 to 2 do   // free player (not done with playnofree)
 begin
   uos_CreatePlayer(i);
  case i of
  {
  0: uos_AddFromMemoryStream(i,ms0,0,-1,0,512);
  1: uos_AddFromMemoryStream(i,ms1,0,-1,0,512);
  2: uos_AddFromMemoryStream(i,ms2,0,-1,0,512);
  }
  0: uos_AddFromfile(i,pchar(sound[0]),-1,0,512);
  1: uos_AddFromfile(i,pchar(sound[1]),-1,0,512);
  2: uos_AddFromfile(i,pchar(sound[2]),-1,0,512);
  end;
   uos_AddIntoDevOut(i, -1, 0.03, -1, 1, 0, 512);
    uos_PlayNoFree(i) ;
    sleep(150);
 end;
 
 
end;                                                                                                                            

procedure Tsimpledrum.AfterCreate;
begin
  {%region 'Auto-generated GUI code' -fold}
  {@VFD_BODY_BEGIN: simpledrum}
  Name := 'simpledrum';
  SetPosition(526, 229, 228, 163);
  WindowTitle := 'Simple Drums';
  IconName := '';
  BackGroundColor := $80000001;
  Hint := '';
  WindowPosition := wpScreenCenter;

  Label1 := TfpgLabel.Create(self);
  with Label1 do
  begin
    Name := 'Label1';
    SetPosition(68, 20, 80, 15);
    FontDesc := '#Label1';
    ParentShowHint := False;
    Text := 'Interval in ms';
  end;

  Button1 := TfpgButton.Create(self);
  with Button1 do
  begin
    Name := 'Button1';
    SetPosition(32, 72, 164, 39);
    Text := 'Start';
    FontDesc := '#Label1';
    ImageName := '';
    ParentShowHint := False;
    TabOrder := 3;
    onclick := @btnStartClick;
  end;

  Button2 := TfpgButton.Create(self);
  with Button2 do
  begin
    Name := 'Button2';
    SetPosition(32, 120, 164, 31);
    Text := 'Stop';
    FontDesc := '#Label1';
    ImageName := '';
    ParentShowHint := False;
    TabOrder := 4;
    onclick := @btnStopClick;
  end;

  EditInteger1 := TfpgEdit.Create(self);
  with EditInteger1 do
  begin
    Name := 'EditInteger1';
    SetPosition(80, 40, 68, 23);
    ExtraHint := '';
    FontDesc := '#Edit1';
    ParentShowHint := False;
    TabOrder := 5;
    Text := '100';
  end;

  {@VFD_BODY_END: simpledrum}
  {%endregion}
  initall;
end;

procedure Tsimpledrum.btnStartClick(Sender: TObject);
  begin
  TimerTick.Interval := strtoint(EditInteger1.text);
  stopit := false;
  posi := 1;
  TimerTick.Enabled := true; 
  end;
  
procedure Tsimpledrum.btnStopClick(Sender: TObject);
  begin
    stopit := true;      
  end;
  
procedure Tsimpledrum.ontimertick(Sender: TObject);
  var i: integer;
begin

if stopit = false then
 begin

   for i := 0 to 2 do
    if(Copy(drum_beats[i], posi, 1) = 'x') then
    begin
   //  fpgapplication.processmessages;
     uos_PlayPausednofree(i) ;
     end;
   
    for i := 0 to 2 do
    if(Copy(drum_beats[i], posi, 1) = 'x') then
    uos_RePlay(i) ;
     
 inc(posi);
 if(posi > 16) then posi := 1;

 end else Timertick.Enabled := false;
  
end;   

procedure MainProc;
var
  frm: Tsimpledrum;
begin
  fpgApplication.Initialize;
  try
     if fpgStyleManager.SetStyle('Chrome silver flat menu') then
          fpgStyle := fpgStyleManager.Style;
    fpgApplication.CreateForm(Tsimpledrum, frm);
    fpgApplication.MainForm := frm;
    frm.Show;
    fpgApplication.Run;
  finally
  uos_free();
  frm.Free;
  end;
end;

begin
  MainProc;
end.
