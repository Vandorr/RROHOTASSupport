unit Utility;

interface

uses  Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
      Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShlObj, Vcl.Graphics;

type
  THotkeys = record
    hotkey: integer;
    name: string[100];
  end;

var hotkeyList: array of THotkeys;

procedure PostKeyExHWND(hWindow: HWnd; key: Word; const shift: TShiftState; specialkey: Boolean; justKeyDown: Boolean = false; justKeyUp: Boolean = false);
function FindWindowByTitle(WindowTitle: string): Hwnd;
procedure listWindowTitles(combo: TCombobox);
function GetSpecialFolderPath(CSIDLFolder: Integer): string;
procedure ChangeHotkeyLabel(component: TLabel);
function RemoveSpecialChars(const str: string): string;
procedure FillHotkeyList;
function FindHotKeyByKey(key: Integer): String;
function FindHotKeyByName(name: String): Integer;

implementation

procedure PostKeyExHWND(hWindow: HWnd; key: Word; const shift: TShiftState; specialkey: Boolean; justKeyDown: Boolean = false; justKeyUp: Boolean = false);
{************************************************************
 * Procedure PostKeyEx
 *
 * Parameters:
 *  hWindow: target window to be send the keystroke
 *  key    : virtual keycode of the key to send. For printable
 *           keys this is simply the ANSI code (Ord(character)).
 *  shift  : state of the modifier keys. This is a set, so you
 *           can set several of these keys (shift, control, alt,
 *           mouse buttons) in tandem. The TShiftState type is
 *           declared in the Classes Unit.
 *  specialkey: normally this should be False. Set it to True to
 *           specify a key on the numeric keypad, for example.
 *           If this parameter is true, bit 24 of the lparam for
 *           the posted WM_KEY* messages will be set.
 * Description:
 *  This procedure sets up Windows key state array to correctly
 *  reflect the requested pattern of modifier keys and then posts
 *  a WM_KEYDOWN/WM_KEYUP message pair to the target window. Then
 *  Application.ProcessMessages is called to process the messages
 *  before the keyboard state is restored.
 * Error Conditions:
 *  May fail due to lack of memory for the two key state buffers.
 *  Will raise an exception in this case.
 * NOTE:
 *  Setting the keyboard state will not work across applications
 *  running in different memory spaces on Win32 unless AttachThreadInput
 *  is used to connect to the target thread first.
 *Created: 02/21/96 16:39:00 by P. Below
 ************************************************************}
type
  TBuffers = array [0..1] of TKeyboardState;
var
  pKeyBuffers: ^TBuffers;
  lParam: LongInt;
begin
  (* check if the target window exists *)
  if IsWindow(hWindow) then
  begin
    (* set local variables to default values *)
    pKeyBuffers := nil;
    lParam := MakeLong(0, MapVirtualKey(key, 0));

    (* modify lparam if special key requested *)
    if specialkey then
      lParam := lParam or $1000000;

    (* allocate space for the key state buffers *)
    New(pKeyBuffers);
    try
      (* Fill buffer 1 with current state so we can later restore it.
         Null out buffer 0 to get a "no key pressed" state. *)
      GetKeyboardState(pKeyBuffers^[1]);
      FillChar(pKeyBuffers^[0], SizeOf(TKeyboardState), 0);

      (* set the requested modifier keys to "down" state in the buffer*)
      if ssShift in shift then
        pKeyBuffers^[0][VK_SHIFT] := $80;
      if ssAlt in shift then
      begin
        (* Alt needs special treatment since a bit in lparam needs also be set *)
        pKeyBuffers^[0][VK_MENU] := $80;
        lParam := lParam or $20000000;
      end;
      if ssCtrl in shift then
        pKeyBuffers^[0][VK_CONTROL] := $80;
      if ssLeft in shift then
        pKeyBuffers^[0][VK_LBUTTON] := $80;
      if ssRight in shift then
        pKeyBuffers^[0][VK_RBUTTON] := $80;
      if ssMiddle in shift then
        pKeyBuffers^[0][VK_MBUTTON] := $80;

      (* make out new key state array the active key state map *)
      SetKeyboardState(pKeyBuffers^[0]);
      (* post the key messages *)
      if ssAlt in Shift then
      begin
        if justKeyDown or (not(justKeyUp) and not(justKeyDown)) then
          PostMessage(hWindow, WM_SYSKEYDOWN, key, lParam);
        if justKeyUp or (not(justKeyUp) and not(justKeyDown)) then
          PostMessage(hWindow, WM_SYSKEYUP, key, lParam or $C0000000);
      end
      else
      begin
        if justKeyDown or (not(justKeyUp) and not(justKeyDown)) then
          PostMessage(hWindow, WM_KEYDOWN, key, lParam);
        if justKeyUp or (not(justKeyUp) and not(justKeyDown)) then
          PostMessage(hWindow, WM_KEYUP, key, lParam or $C0000000);
      end;
      (* process the messages *)
      Application.ProcessMessages;

      (* restore the old key state map *)
      SetKeyboardState(pKeyBuffers^[1]);
    finally
      (* free the memory for the key state buffers *)
      if pKeyBuffers <> nil then
        Dispose(pKeyBuffers);
    end; { If }
  end;
end;{ PostKeyEx }

function FindWindowByTitle(WindowTitle: string): Hwnd;
var
  NextHandle: Hwnd;
  NextTitle: array[0..260] of char;
begin
  // Get the first window
  NextHandle := GetWindow(Application.Handle, GW_HWNDFIRST);
  while NextHandle > 0 do
  begin
    // retrieve its text
    GetWindowText(NextHandle, NextTitle, 255);
    if Pos(WindowTitle, StrPas(NextTitle)) <> 0 then
    begin
      Result := NextHandle;
      Exit;
    end
    else
      // Get the next window
      NextHandle := GetWindow(NextHandle, GW_HWNDNEXT);
  end;
  Result := 0;
end;

procedure listWindowTitles(combo: TCombobox);
var
  NextHandle: Hwnd;
  NextTitle: array[0..260] of char;
begin
  combo.Items.Clear;
  NextHandle := GetWindow(Application.Handle, GW_HWNDFIRST);
  while NextHandle > 0 do
  begin
    // retrieve its text
    GetWindowText(NextHandle, NextTitle, 255);
    if trim(NextTitle)<>'' then
      combo.Items.Add(NextTitle);
    NextHandle := GetWindow(NextHandle, GW_HWNDNEXT);
  end;
  combo.Sorted := true;
end;

function GetSpecialFolderPath(CSIDLFolder: Integer): string;
var
   FilePath: array [0..MAX_PATH] of char;
begin
  SHGetFolderPath(0, CSIDLFolder, 0, 0, FilePath);
  Result := FilePath;
end;

procedure ChangeHotkeyLabel(component: TLabel);
begin
  if trim(component.Caption) = '' then
  begin
    component.Caption := '';
    component.Color:= clSilver;
    component.Transparent := false;
    component.Width := 20;
  end
  else
  begin
    component.Color:= clBtnFace;
    component.Transparent := true;
    component.AutoSize := true;
  end;
end;

function RemoveSpecialChars(const str: string): string;
const
  InvalidChars : set of char =
    [',','.','/','!','@','#','$','%','^','&','*','''','"',';','_','(',')',':','|','[',']'];
var
  i, Count: Integer;
begin
  SetLength(Result, Length(str));
  Count := 0;
  for i := 1 to Length(str) do
    if not (str[i] in InvalidChars) then
    begin
      inc(Count);
      Result[Count] := str[i];
    end;
  SetLength(Result, Count);
end;

procedure FillHotkeyList;
begin
  SetLength(hotkeyList, 88);
  hotkeyList[0].hotkey := VK_ZOOM; hotkeyList[0].name := 'Zoom';
  hotkeyList[1].hotkey := VK_BACK; hotkeyList[1].name := 'Backspace';
  hotkeyList[2].hotkey := VK_TAB; hotkeyList[2].name := 'Tab';
  hotkeyList[3].hotkey := VK_RETURN; hotkeyList[3].name := 'Enter';
  hotkeyList[4].hotkey := VK_PAUSE; hotkeyList[4].name := 'Pause';
  hotkeyList[5].hotkey := VK_CAPITAL; hotkeyList[5].name := 'Caps Lock';
  hotkeyList[6].hotkey := VK_ESCAPE; hotkeyList[6].name := 'Esc';
  hotkeyList[7].hotkey := VK_SPACE; hotkeyList[7].name := 'Spacebar';
  hotkeyList[8].hotkey := VK_PRIOR; hotkeyList[8].name := 'Page Up';
  hotkeyList[9].hotkey := VK_NEXT; hotkeyList[9].name := 'Page Down';
  hotkeyList[10].hotkey := VK_END; hotkeyList[10].name := 'End';
  hotkeyList[11].hotkey := VK_HOME; hotkeyList[11].name := 'Home';
  hotkeyList[12].hotkey := VK_LEFT; hotkeyList[12].name := 'Left Arrow';
  hotkeyList[13].hotkey := VK_UP; hotkeyList[13].name := 'Up Arrow';
  hotkeyList[14].hotkey := VK_RIGHT; hotkeyList[14].name := 'Right Arrow';
  hotkeyList[15].hotkey := VK_DOWN; hotkeyList[15].name := 'Down Arrow';
  hotkeyList[16].hotkey := VK_SELECT; hotkeyList[16].name := 'Select';
  hotkeyList[17].hotkey := VK_PRINT; hotkeyList[17].name := 'Print';
  hotkeyList[18].hotkey := VK_EXECUTE; hotkeyList[18].name := 'Execute';
  hotkeyList[19].hotkey := VK_SNAPSHOT; hotkeyList[19].name := 'Print Screen';
  hotkeyList[20].hotkey := VK_INSERT; hotkeyList[20].name := 'Ins';
  hotkeyList[21].hotkey := VK_DELETE; hotkeyList[21].name := 'Del';
  hotkeyList[22].hotkey := VK_HELP; hotkeyList[22].name := 'Help';
  hotkeyList[23].hotkey := VK_LWIN; hotkeyList[23].name := 'Left Windows';
  hotkeyList[24].hotkey := VK_RWIN; hotkeyList[24].name := 'Right Windows';
  hotkeyList[25].hotkey := VK_APPS; hotkeyList[25].name := 'Applications';
  hotkeyList[26].hotkey := VK_SLEEP; hotkeyList[26].name := 'Computer Sleep';
  hotkeyList[27].hotkey := VK_NUMPAD0; hotkeyList[27].name := 'Num keypad 0';
  hotkeyList[28].hotkey := VK_NUMPAD1; hotkeyList[28].name := 'Num keypad 1';
  hotkeyList[29].hotkey := VK_NUMPAD2; hotkeyList[29].name := 'Num keypad 2';
  hotkeyList[30].hotkey := VK_NUMPAD3; hotkeyList[30].name := 'Num keypad 3';
  hotkeyList[31].hotkey := VK_NUMPAD4; hotkeyList[31].name := 'Num keypad 4';
  hotkeyList[32].hotkey := VK_NUMPAD5; hotkeyList[32].name := 'Num keypad 5';
  hotkeyList[33].hotkey := VK_NUMPAD6; hotkeyList[33].name := 'Num keypad 6';
  hotkeyList[34].hotkey := VK_NUMPAD7; hotkeyList[34].name := 'Num keypad 7';
  hotkeyList[35].hotkey := VK_NUMPAD8; hotkeyList[35].name := 'Num keypad 8';
  hotkeyList[36].hotkey := VK_NUMPAD9; hotkeyList[36].name := 'Num keypad 9';
  hotkeyList[37].hotkey := VK_MULTIPLY; hotkeyList[37].name := 'Multiply';
  hotkeyList[38].hotkey := VK_ADD; hotkeyList[38].name := 'Add';
  hotkeyList[39].hotkey := VK_SEPARATOR; hotkeyList[39].name := 'Separator';
  hotkeyList[40].hotkey := VK_SUBTRACT; hotkeyList[40].name := 'Subtract';
  hotkeyList[41].hotkey := VK_DECIMAL; hotkeyList[41].name := 'Decimal';
  hotkeyList[42].hotkey := VK_DIVIDE; hotkeyList[42].name := 'Divide';
  hotkeyList[43].hotkey := VK_F1; hotkeyList[43].name := 'F1';
  hotkeyList[44].hotkey := VK_F2; hotkeyList[44].name := 'F2';
  hotkeyList[45].hotkey := VK_F3; hotkeyList[45].name := 'F3';
  hotkeyList[46].hotkey := VK_F4; hotkeyList[46].name := 'F4';
  hotkeyList[47].hotkey := VK_F5; hotkeyList[47].name := 'F5';
  hotkeyList[48].hotkey := VK_F6; hotkeyList[48].name := 'F6';
  hotkeyList[49].hotkey := VK_F7; hotkeyList[49].name := 'F7';
  hotkeyList[50].hotkey := VK_F8; hotkeyList[50].name := 'F8';
  hotkeyList[51].hotkey := VK_F9; hotkeyList[51].name := 'F9';
  hotkeyList[52].hotkey := VK_F10; hotkeyList[52].name := 'F10';
  hotkeyList[53].hotkey := VK_F11; hotkeyList[53].name := 'F11';
  hotkeyList[54].hotkey := VK_F12; hotkeyList[54].name := 'F12';
  hotkeyList[55].hotkey := VK_F13; hotkeyList[55].name := 'F13';
  hotkeyList[56].hotkey := VK_F14; hotkeyList[56].name := 'F14';
  hotkeyList[57].hotkey := VK_F15; hotkeyList[57].name := 'F15';
  hotkeyList[58].hotkey := VK_F16; hotkeyList[58].name := 'F16';
  hotkeyList[59].hotkey := VK_F17; hotkeyList[59].name := 'F17';
  hotkeyList[60].hotkey := VK_F18; hotkeyList[60].name := 'F18';
  hotkeyList[61].hotkey := VK_F19; hotkeyList[61].name := 'F19';
  hotkeyList[62].hotkey := VK_F20; hotkeyList[62].name := 'F20';
  hotkeyList[63].hotkey := VK_F21; hotkeyList[63].name := 'F21';
  hotkeyList[64].hotkey := VK_F22; hotkeyList[64].name := 'F22';
  hotkeyList[65].hotkey := VK_F23; hotkeyList[65].name := 'F23';
  hotkeyList[66].hotkey := VK_F24; hotkeyList[66].name := 'F24';
  hotkeyList[67].hotkey := VK_NUMLOCK; hotkeyList[67].name := 'Num Lock';
  hotkeyList[68].hotkey := VK_SCROLL; hotkeyList[68].name := 'Scroll Lock';
  hotkeyList[69].hotkey := VK_BROWSER_BACK; hotkeyList[69].name := 'Browser Back';
  hotkeyList[70].hotkey := VK_BROWSER_FORWARD; hotkeyList[70].name := 'Browser Forward';
  hotkeyList[71].hotkey := VK_BROWSER_REFRESH; hotkeyList[71].name := 'Browser Refresh';
  hotkeyList[72].hotkey := VK_BROWSER_STOP; hotkeyList[72].name := 'Browser Stop';
  hotkeyList[73].hotkey := VK_BROWSER_SEARCH; hotkeyList[73].name := 'Browser Search';
  hotkeyList[74].hotkey := VK_BROWSER_FAVORITES; hotkeyList[74].name := 'Browser Favorites';
  hotkeyList[75].hotkey := VK_BROWSER_HOME; hotkeyList[75].name := 'Browser Start and Home';
  hotkeyList[76].hotkey := VK_VOLUME_MUTE; hotkeyList[76].name := 'Volume Mute';
  hotkeyList[77].hotkey := VK_VOLUME_DOWN; hotkeyList[77].name := 'Volume Down';
  hotkeyList[78].hotkey := VK_VOLUME_UP; hotkeyList[78].name := 'Volume Up';
  hotkeyList[79].hotkey := VK_MEDIA_NEXT_TRACK; hotkeyList[79].name := 'Next Track';
  hotkeyList[80].hotkey := VK_MEDIA_PREV_TRACK; hotkeyList[80].name := 'Previous Track';
  hotkeyList[81].hotkey := VK_MEDIA_STOP; hotkeyList[81].name := 'Stop Media';
  hotkeyList[82].hotkey := VK_MEDIA_PLAY_PAUSE; hotkeyList[82].name := 'Play/Pause Media';
  hotkeyList[83].hotkey := VK_LAUNCH_MAIL; hotkeyList[83].name := 'Start Mail';
  hotkeyList[84].hotkey := VK_LAUNCH_MEDIA_SELECT; hotkeyList[84].name := 'Select Media';
  hotkeyList[85].hotkey := VK_LAUNCH_APP1; hotkeyList[85].name := 'Start Application 1';
  hotkeyList[86].hotkey := VK_LAUNCH_APP2; hotkeyList[86].name := 'Start Application 2';
  hotkeyList[87].hotkey := VK_PLAY; hotkeyList[87].name := 'Play';
end;

function FindHotKeyByKey(key: Integer): String;
var i: integer;
begin
  Result := '';
  for i := 0 to length(hotKeyList)-1 do
  begin
    if hotKeyList[i].hotkey=key then
    begin
      Result := hotKeyList[i].name;
      exit;
    end;
  end;
end;

function FindHotKeyByName(name: String): Integer;
var i: integer;
begin
  Result := 0;
  for i := 0 to length(hotKeyList)-1 do
  begin
    if hotKeyList[i].name=name then
    begin
      Result := hotKeyList[i].hotkey;
      exit;
    end;
  end;
end;

end.
