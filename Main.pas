unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DxJoystick,
  Vcl.ComCtrls, Vcl.ExtCtrls, Math, StrUtils, Utility, Vcl.Imaging.pngimage, System.UITypes,
  Vcl.Imaging.GIFImg, shellapi, ShlObj, System.IniFiles, Vcl.Menus, HTTPApp, System.NetEncoding,
  Vcl.XPMan, IOUtils, About, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, cxProgressBar,
  cxGridCustomTableView, cxGridTableView, cxGridCustomView, cxClasses,
  cxGridLevel, cxGrid, cxButtonEdit, cxEditRepositoryItems, cxDropDownEdit, cxDataUtils,
  cxCheckBox;

type
  positionR = record
    min_value: integer;
    min_position: TPoint;
    max_value: integer;
    max_position: TPoint;
    iote: boolean;
    row_num : integer;
    progressBar: TcxProgressBar;
  end;

  Tposition = array of positionR;
  
  TFrm_Main = class(TForm)
    XPManifest: TXPManifest;
    DxJoystick: TDxJoystick;
    CB_Hardware: TComboBox;
    MemoStatus: TMemo;
    TimerAxis: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    CB_GameWindows: TComboBox;
    Image1: TImage;
    Img_PayPalLink: TImage;
    Img_DiscordLink: TImage;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    N1: TMenuItem;
    MI_Exit: TMenuItem;
    MI_Profiles: TMenuItem;
    MI_Profiles_New: TMenuItem;
    N2: TMenuItem;
    Label5: TLabel;
    L_ProfileName: TLabel;
    GB_Hotkeys: TGroupBox;
    L_Btn_6: TLabel;
    Label1: TLabel;
    Shape_Btn_6: TShape;
    L_Btn_7: TLabel;
    Label10: TLabel;
    Shape_Btn_7: TShape;
    Shape_Btn_8: TShape;
    Label11: TLabel;
    L_Btn_8: TLabel;
    Shape_Btn_9: TShape;
    Label13: TLabel;
    L_Btn_9: TLabel;
    Shape_Btn_10: TShape;
    Label15: TLabel;
    L_Btn_10: TLabel;
    L_Btn_1: TLabel;
    Label18: TLabel;
    Shape_Btn_1: TShape;
    L_Btn_2: TLabel;
    Label20: TLabel;
    Shape_Btn_2: TShape;
    Shape_Btn_3: TShape;
    Label21: TLabel;
    L_Btn_3: TLabel;
    Shape_Btn_4: TShape;
    Label23: TLabel;
    L_Btn_4: TLabel;
    Shape_Btn_5: TShape;
    Label25: TLabel;
    L_Btn_5: TLabel;
    L_Btn_11: TLabel;
    Label28: TLabel;
    Shape_Btn_11: TShape;
    L_Btn_12: TLabel;
    Label30: TLabel;
    Shape_Btn_12: TShape;
    Shape_Btn_13: TShape;
    Label31: TLabel;
    L_Btn_13: TLabel;
    Shape_Btn_14: TShape;
    Label33: TLabel;
    L_Btn_14: TLabel;
    Shape_Btn_15: TShape;
    Label35: TLabel;
    L_Btn_15: TLabel;
    MI_Profiles_Import: TMenuItem;
    B_Profile_Save: TButton;
    B_Profile_Rename: TButton;
    B_Profile_Delete: TButton;
    E_Hotkey_Btn_1: TEdit;
    E_Hotkey_Btn_2: TEdit;
    E_Hotkey_Btn_3: TEdit;
    E_Hotkey_Btn_4: TEdit;
    E_Hotkey_Btn_5: TEdit;
    E_Hotkey_Btn_6: TEdit;
    E_Hotkey_Btn_7: TEdit;
    E_Hotkey_Btn_8: TEdit;
    E_Hotkey_Btn_9: TEdit;
    E_Hotkey_Btn_10: TEdit;
    E_Hotkey_Btn_11: TEdit;
    E_Hotkey_Btn_12: TEdit;
    E_Hotkey_Btn_13: TEdit;
    E_Hotkey_Btn_14: TEdit;
    E_Hotkey_Btn_15: TEdit;
    Label6: TLabel;
    MI_About: TMenuItem;
    GroupBox1: TGroupBox;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGrid;
    GT_View: TcxGridTableView;
    Col_Axis: TcxGridColumn;
    Col_MinValue: TcxGridColumn;
    Col_MaxValue: TcxGridColumn;
    Col_AxisValue: TcxGridColumn;
    Col_Calibration: TcxGridColumn;
    cxEditRepository1: TcxEditRepository;
    cxEditRepository1ButtonItem1: TcxEditRepositoryButtonItem;
    Col_MinPos: TcxGridColumn;
    Col_MaxPos: TcxGridColumn;
    Col_IOTE: TcxGridColumn;
    procedure FormCreate(Sender: TObject);
    procedure CB_HardwareChange(Sender: TObject);
    procedure TimerAxisTimer(Sender: TObject);
    procedure B_ResetPositionClick(Sender: TObject);
    procedure CB_GameWindowsChange(Sender: TObject);
    procedure CB_GameWindowsEnter(Sender: TObject);
    procedure B_AxisCalibrationClick(Sender: TObject);
    procedure Img_DiscordLinkClick(Sender: TObject);
    procedure Img_PayPalLinkClick(Sender: TObject);
    procedure MI_ExitClick(Sender: TObject);
    procedure MI_Profiles_NewClick(Sender: TObject);
    procedure L_Btn_Click(Sender: TObject);
    procedure B_Profile_SaveClick(Sender: TObject);
    procedure MI_ProfilesClick(Sender: TObject);
    procedure MI_ProfileOnLoad(Sender: TObject);
    procedure B_Profile_RenameClick(Sender: TObject);
    procedure B_Profile_DeleteClick(Sender: TObject);
    procedure ClearScreen(Name: String);
    function SaveINI:boolean;
    procedure MI_Profiles_ImportClick(Sender: TObject);
    procedure DxJoystickStateChange(Sender: TObject);
    procedure E_Hotkey_Btn_OnKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure E_Hotkey_Btn_OnContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure MI_AboutClick(Sender: TObject);
    procedure FillWatchList;
    procedure FormShow(Sender: TObject);
    procedure GT_ViewDataControllerAfterPost(
      ADataController: TcxCustomDataController);
    procedure GT_ViewDataControllerAfterInsert(
      ADataController: TcxCustomDataController);
    procedure cxEditRepository1ButtonItem1PropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure GT_ViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    lastPosition: array[0..7] of integer;
    GameHWND: HWND;
    inCalibrationMode: boolean;
    calibrationStep: integer;
    calibrationRow: integer;
    userDir, profileDir: String;
    Ini: TIniFile;
    buttonState,buttonStateX : Array[1..15] of Boolean;
    watchList : array[0..7] of Tposition;
    AxisCont : TStringList;
    GridInsertMode: boolean;
  public
    { Public declarations }
  end;

var
  Frm_Main: TFrm_Main;

implementation

{$R *.dfm}

procedure TFrm_Main.FillWatchList;
var i,p:integer;
    axis,s,s1,s2: String;
begin
  for i := 0 to Length(watchlist)-1 do
    SetLength(watchlist[i],0);
  for i := 0 to GT_View.DataController.DataRowCount-1 do
  begin
    axis := GT_View.DataController.Values[i,0];

    p := AxisCont.IndexOf(axis);

    SetLength(watchList[p],Length(watchList[p])+1);
    watchList[p][Length(watchList[p])-1].min_value := GT_View.DataController.Values[i,1];

    s := Trim(GT_View.DataController.Values[i,2]);
    s1 := copy(s,1,ansipos (',',s)-1);
    s2 := copy(s,ansipos(',',s)+1,100);
    watchList[p][Length(watchList[p])-1].min_position := TPoint.Create(StrToIntDef(s1,0),StrToIntDef(s2,0));
    watchList[p][Length(watchList[p])-1].max_value := GT_View.DataController.Values[i,3];
    s := Trim(GT_View.DataController.Values[i,4]);
    s1 := copy(s,1,ansipos (',',s)-1);
    s2 := copy(s,ansipos(',',s)+1,100);
    watchList[p][Length(watchList[p])-1].max_position := TPoint.Create(StrToIntDef(s1,0),StrToIntDef(s2,0));

    watchList[p][Length(watchList[p])-1].iote := GT_View.DataController.Values[i,5];
    watchList[p][Length(watchList[p])-1].row_num := i;
  end;
end;

procedure TFrm_Main.FormCreate(Sender: TObject);
var i: Integer;
begin
  userDir := GetSpecialFolderPath(CSIDL_LOCAL_APPDATA)+'\RROHOTASSupport';
  profileDir := userDir+'\Profiles';
  {$IOChecks off}
  MkDir(userDir);
  MkDir(profileDir);
  {$IOChecks on}
  if not DirectoryExists(userDir) then
    MessageDlg('Not enough permission to make Data folder!',mtWarning,[mbOk],0);

  AxisCont := TStringList.Create();
  AxisCont.AddStrings(['X','Y','Z','RX','RY','RZ','Slider1','Slider2']);
  
  //DoubleBuffered := True;
  GridInsertMode := false;

  FillHotkeyList;

  inCalibrationMode := false;

  CB_Hardware.Items.Clear;

  for i := 0 to length(lastPosition)-1 do
    lastPosition[i] := 9999999;
  for i := 1 to length(buttonState) do
    buttonState[i] := false;
  for i := 1 to length(buttonStateX) do
    buttonStateX[i] := false;

  for i := 1 to DxJoystick.DeviceCount do
    try
      DxJoystick.Device := I;
      DxJoystick.Active := True;
      CB_Hardware.Items.Add(DxJoystick.InstanceName);
    finally
      DxJoystick.Active := False;
    end;

  CB_Hardware.ItemIndex := 0;
  CB_HardwareChange(CB_Hardware);

  listWindowTitles(CB_GameWindows);

  ClearScreen('');
end;

procedure TFrm_Main.FormShow(Sender: TObject);
begin
  FillWatchList;
end;

procedure TFrm_Main.GT_ViewCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
//AViewInfo.GridView.DataController.Values[]
  if (inCalibrationMode) and (calibrationStep = 0) and ((AViewInfo.Item.Index = 1) or (AViewInfo.Item.Index = 2)) and (calibrationRow = AViewInfo.RecordViewInfo.Index) then
    ACanvas.Brush.Color := clWebBurlywood;
  if (inCalibrationMode) and (calibrationStep = 1) and ((AViewInfo.Item.Index = 3) or (AViewInfo.Item.Index = 4)) and (calibrationRow = AViewInfo.RecordViewInfo.Index) then
    ACanvas.Brush.Color := clWebBurlywood;
end;

procedure TFrm_Main.GT_ViewDataControllerAfterInsert(
  ADataController: TcxCustomDataController);
begin
  ADataController.Values[ADataController.FocusedRecordIndex,0] := 'X';
  ADataController.Values[ADataController.FocusedRecordIndex,1] := '0';
  ADataController.Values[ADataController.FocusedRecordIndex,2] := '0,0';
  ADataController.Values[ADataController.FocusedRecordIndex,3] := '0';
  ADataController.Values[ADataController.FocusedRecordIndex,4] := '0,0';
  ADataController.Values[ADataController.FocusedRecordIndex,5] := 0;
end;

procedure TFrm_Main.GT_ViewDataControllerAfterPost(
  ADataController: TcxCustomDataController);
begin
  FillWatchList;
end;

procedure TFrm_Main.B_AxisCalibrationClick(Sender: TObject);
//var position: integer;
begin
  //ysdf
end;

procedure TFrm_Main.B_Profile_DeleteClick(Sender: TObject);
var s: String;
begin
  If trim(L_ProfileName.Caption) <> '' then
  begin
    if MessageDlg('Delete profile. Are you sure?',
      mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    begin
      s := TNetEncoding.URL.Encode(RemoveSpecialChars(L_ProfileName.Caption));
      DeleteFile(profileDir+'/'+s+'.');
      ClearScreen('');
      MemoStatus.Lines.Add('Profile renamed');
    end;
  end;
end;

procedure TFrm_Main.B_Profile_RenameClick(Sender: TObject);
var name, s: String;
begin
  If trim(L_ProfileName.Caption) <> '' then
  begin
    name := InputBox('Rename Profile', 'Profile name', L_ProfileName.Caption);
    if trim(name) <> '' then
    begin
      s := TNetEncoding.URL.Encode(RemoveSpecialChars(L_ProfileName.Caption));
      DeleteFile(profileDir+'/'+s+'.hop');
      L_ProfileName.Caption := name;
      SaveIni;
      MemoStatus.Lines.Add('Profile renamed');
    end;
  end;
end;

procedure TFrm_Main.B_Profile_SaveClick(Sender: TObject);
begin
  if SaveIni then
    MemoStatus.Lines.Add('Profile saved');
end;

procedure TFrm_Main.B_ResetPositionClick(Sender: TObject);
begin
  MemoStatus.Lines.Add('HOTAS position reset to 0');
end;

procedure TFrm_Main.CB_GameWindowsChange(Sender: TObject);
begin
  GameHWND := FindWindowByTitle(CB_GameWindows.Text);
  MemoStatus.Lines.Add('Game window changed to: '+CB_GameWindows.Text);
end;

procedure TFrm_Main.CB_GameWindowsEnter(Sender: TObject);
begin
  listWindowTitles(CB_GameWindows);
end;

procedure TFrm_Main.CB_HardwareChange(Sender: TObject);
begin
  DxJoystick.Active := False;
  DxJoystick.Device := CB_Hardware.ItemIndex + 1;
  DxJoystick.Active := True;
  MemoStatus.Lines.Add('Hardwer changed to: '+CB_Hardware.Text);
end;

procedure TFrm_Main.MI_AboutClick(Sender: TObject);
begin
  Frm_About.show;
end;

procedure TFrm_Main.MI_ExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrm_Main.MI_ProfileOnLoad(Sender: TObject);
  var i,c:integer;
      windowName, hardwareName: string;
begin
  TimerAxis.Enabled := false;
  Ini := TIniFile.Create((Sender as TMenuItem).Hint);
  L_ProfileName.Caption := Ini.ReadString('Game','Name','Undefined');

  windowName := Ini.ReadString( 'Game', 'Window', 'Undefined');
  for i := 0 to CB_GameWindows.Items.Count-1 do
  begin
    if Pos(windowName, CB_GameWindows.Items[i]) <> 0 then
      begin
      CB_GameWindows.ItemIndex := i;
      CB_GameWindowsChange(CB_GameWindows);
      end;
  end;

  hardwareName := Ini.ReadString('Hardware', 'Name', 'Undefined');
  for i := 0 to CB_Hardware.Items.Count-1 do
  begin
    if Pos(hardwareName, CB_Hardware.Items[i]) <> 0 then
      CB_Hardware.ItemIndex := i;
  end;

  GT_View.DataController.SetRecordCount(0);

  c := Ini.ReadInteger('Axis', 'Length', 0);
  for i := 0 to c-1 do
    begin
      GT_View.DataController.Append;
      GT_View.DataController.Values[GT_View.DataController.FocusedRecordIndex,0] := Ini.ReadString( 'Axis', IntToStr(i)+'_Axis', '');
      GT_View.DataController.Values[GT_View.DataController.FocusedRecordIndex,1] := Ini.ReadString( 'Axis', IntToStr(i)+'_MinValue', '');
      GT_View.DataController.Values[GT_View.DataController.FocusedRecordIndex,2] := Ini.ReadString( 'Axis', IntToStr(i)+'_MinMousePosition', '');
      GT_View.DataController.Values[GT_View.DataController.FocusedRecordIndex,3] := Ini.ReadString( 'Axis', IntToStr(i)+'_MaxValue', '');
      GT_View.DataController.Values[GT_View.DataController.FocusedRecordIndex,4] := Ini.ReadString( 'Axis', IntToStr(i)+'_MaxMousePosition', '');
      GT_View.DataController.Values[GT_View.DataController.FocusedRecordIndex,5] := Ini.ReadInteger( 'Axis', IntToStr(i)+'_IOTE', 0);
      GT_View.DataController.Post(True);
    end;

  for i := 1 to 15 do
  begin
    (Frm_Main.FindComponent('L_Btn_'+inttostr(i)) as TLabel).Caption := Ini.ReadString( 'Hotkey', inttostr(i)+'_Label', '');
    (Frm_Main.FindComponent('E_Hotkey_Btn_'+inttostr(i)) as TEdit).Text := Ini.ReadString( 'Hotkey', inttostr(i)+'_Key', '');
    ChangeHotkeyLabel(Frm_Main.FindComponent('L_Btn_'+inttostr(i)) as TLabel);
  end;

  TimerAxis.Enabled := true;
end;

procedure TFrm_Main.MI_ProfilesClick(Sender: TObject);
var MItem: TMenuItem;
    path, name: string;
    i: integer;
begin
  for i := MI_Profiles.Count downto 4 do
  begin
    MI_Profiles.Items[i-1].Destroy;
  end;
  for Path in TDirectory.GetFiles(profileDir)  do
  begin
    Ini := TIniFile.Create(Path);
    name := Ini.ReadString('Game','Name','Undefined');
    MItem := TMenuItem.Create(MI_Profiles);
    MItem.Caption := name;
    MItem.Hint := Path;
    MItem.OnClick := MI_ProfileOnLoad;
    MI_Profiles.Add(MItem);
  end;
end;

procedure TFrm_Main.MI_Profiles_ImportClick(Sender: TObject);
var
  selectedFile: string;
  dlg: TOpenDialog;
begin
  selectedFile := '';
  dlg := TOpenDialog.Create(nil);
  try
    dlg.InitialDir := 'C:\';
    dlg.Filter := 'Profile files (*.hop)|*.hop';
    if dlg.Execute(Handle) then
      selectedFile := dlg.FileName;
  finally
    dlg.Free;
  end;

  if selectedFile <> '' then
    begin
    TFile.Copy(selectedFile,profileDir+'/'+extractFilename(selectedFile),true);
    MemoStatus.Lines.Add('Profile import success');
    end;
end;

procedure TFrm_Main.MI_Profiles_NewClick(Sender: TObject);
var name: String;
begin
  name := InputBox('New Profile', 'Profile name', '');
  if trim(name) <> '' then
    ClearScreen(name);
end;

function TFrm_Main.SaveINI:boolean;
var s: string;
    i: integer;
begin
  Result := false;

  if trim(L_ProfileName.Caption)='' then
  begin
    name := InputBox('New Profile', 'Profile name', '');
    L_ProfileName.Caption := name;
  end;

  if trim(L_ProfileName.Caption)<>'' then
  begin
    TimerAxis.Enabled := false;
    s := TNetEncoding.URL.Encode(RemoveSpecialChars(L_ProfileName.Caption));
    Ini := TIniFile.Create( profileDir+'\'+s+'.hop' );
    Ini.WriteString( 'Game', 'Name', L_ProfileName.Caption);
    Ini.WriteString( 'Game', 'Window', CB_GameWindows.Text);
    Ini.WriteString( 'Hardware', 'Name', CB_Hardware.Text);

    Ini.WriteString( 'Axis', 'Length', inttostr(GT_View.DataController.DataRowCount));
    for i := 0 to GT_View.DataController.DataRowCount-1 do
    begin
      Ini.WriteString( 'Axis', inttostr(i)+'_Axis', GT_View.DataController.Values[i,0]);
      Ini.WriteString( 'Axis', inttostr(i)+'_MinValue', GT_View.DataController.Values[i,1]);
      Ini.WriteString( 'Axis', inttostr(i)+'_MinMousePosition', GT_View.DataController.Values[i,2]);
      Ini.WriteString( 'Axis', inttostr(i)+'_MaxValue', GT_View.DataController.Values[i,3]);
      Ini.WriteString( 'Axis', inttostr(i)+'_MaxMousePosition', GT_View.DataController.Values[i,4]);
      Ini.WriteString( 'Axis', inttostr(i)+'_IOTE', GT_View.DataController.Values[i,5]);
    end;

    for i := 1 to 15 do
    begin
      Ini.WriteString( 'Hotkey', inttostr(i)+'_Label', (Frm_Main.FindComponent('L_Btn_'+inttostr(i)) as TLabel).Caption);
      Ini.WriteString( 'Hotkey', inttostr(i)+'_Key', (Frm_Main.FindComponent('E_Hotkey_Btn_'+inttostr(i)) as TEdit).Text);
    end;
    Ini.Free;

    TimerAxis.Enabled := true;
    Result := true;
   end;
end;

procedure TFrm_Main.TimerAxisTimer(Sender: TObject);
var i, j, position, percent: integer;
    max_value,min_value: integer;
    max_position,min_position: TPoint;
    positionChanged: boolean;
    WRect: TRect;
    cPos: TPoint;
begin
  //position 65000:full fék, 0: full gáz
  position := 0;

  for i := 0 to Length(watchList)-1 do
  begin
    if Length(watchList[i])>0 then
    begin
      positionChanged := false;
      case i of
        0: position := DxJoystick.PositionX;
        1:position := DxJoystick.PositionY;
        2:position := DxJoystick.PositionZ;
        3:position := DxJoystick.PositionRX;
        4:position := DxJoystick.PositionRY;
        5:position := DxJoystick.PositionRZ;
        6:position := DxJoystick.PositionSlider1;
        7:position := DxJoystick.PositionSlider2;
      end;

      if lastPosition[i]<>position then
          positionChanged := true;

      if positionChanged then
      begin
        for j := 0 to Length(watchList[i])-1 do
        begin
          GT_View.DataController.Values[watchList[i][j].row_num,6] := Round(position/65535*100);
          if GameHWND = GetForegroundWindow then
          begin
            if watchList[i][j].max_value > watchList[i][j].min_value then
            begin
              min_value := watchList[i][j].min_value;
              max_value := watchList[i][j].max_value;
              min_position := watchList[i][j].min_position;
              max_position := watchList[i][j].max_position;
            end
            else
            begin
              min_value := watchList[i][j].max_value;
              max_value := watchList[i][j].min_value;
              min_position := watchList[i][j].max_position;
              max_position := watchList[i][j].min_position;
            end;

            if not watchList[i][j].iote then
            begin
              if (position>=min_value) and (position<=max_value) then
              begin
                percent := 100;
                if max_value<>min_value then
                  percent := round((position-min_value)/(max_value-min_value)*100);

                GetWindowRect(GameHWND, WRect);
                cPos := TPoint.Create(
                  round(min_position.X+((max_position.X-min_position.X)*(percent/100))),
                  round(min_position.Y+((max_position.Y-min_position.Y)*(percent/100)))
                );

                SetCursorPos(WRect.Left+cPos.X,WRect.Top+cPos.Y);
                Sleep(10);
                mouse_event(MOUSEEVENTF_LEFTDOWN,0, 0, 0, 0);
                Sleep(10);
                mouse_event(MOUSEEVENTF_LEFTUP,0, 0, 0, 0);

                //MemoStatus.Lines.Add('Cursor: '+inttostr(cPos.X)+','+inttostr(cPos.Y));
              end;
            end
            else
            begin
              if (position=min_value) or (position=max_value) then
              begin
                if position=max_value then
                  cPos := TPoint.Create(min_position.X,min_position.Y)
                else
                  cPos := TPoint.Create(max_position.X,max_position.Y);
                GetWindowRect(GameHWND, WRect);
                SetCursorPos(WRect.Left+cPos.X,WRect.Top+cPos.Y);
                Sleep(10);
                mouse_event(MOUSEEVENTF_LEFTDOWN,0, 0, 0, 0);
                Sleep(10);
                mouse_event(MOUSEEVENTF_LEFTUP,0, 0, 0, 0);
              end;
            end;
          end;
        end;
      end;

      lastPosition[i] := position;
    end;
  end;

end;

procedure TFrm_Main.L_Btn_Click(Sender: TObject);
begin
  (Sender as TLabel).Caption := trim(InputBox('Change Label', 'Text', (Sender as TLabel).Caption));
  ChangeHotkeyLabel(Sender as TLabel);
end;

procedure TFrm_Main.Img_PayPalLinkClick(Sender: TObject);
begin
  ShellExecute( 0, 'open', PChar('https://www.paypal.com/donate?business=KQBCBMERRWP7N&no_recurring=0&item_name=Donation+for+HOTAS+Support+&currency_code=EUR'), '', '', SW_SHOWNORMAL );
end;

procedure TFrm_Main.Img_DiscordLinkClick(Sender: TObject);
begin
  ShellExecute( 0, 'open', PChar('https://discord.gg/VvsMfJWjyp'), '', '', SW_SHOWNORMAL );
end;

procedure TFrm_Main.ClearScreen(Name: String);
var i:integer;
begin
  L_ProfileName.Caption := name;
  for i := 1 to 15 do
    begin
      (Frm_Main.FindComponent('L_Btn_'+inttostr(i)) as TLabel).Caption := '';
      ChangeHotkeyLabel(Frm_Main.FindComponent('L_Btn_'+inttostr(i)) as TLabel);
      (Frm_Main.FindComponent('E_Hotkey_Btn_'+inttostr(i)) as TEdit).Text := '';
    end;
end;

procedure TFrm_Main.cxEditRepository1ButtonItem1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
    inCalibrationMode := not inCalibrationMode;
    calibrationRow := GT_View.DataController.FocusedRecordIndex;
    calibrationStep := 0;
    cxGrid.SetFocus;
end;

procedure TFrm_Main.DxJoystickStateChange(Sender: TObject);
var i, HotKey, position: integer;
    s: String;
   Edit: TEdit;
   WRect: TRect;
begin
  buttonStateX[1] := joButton1 in DxJoystick.Buttons;
  buttonStateX[2] := joButton2 in DxJoystick.Buttons;
  buttonStateX[3] := joButton3 in DxJoystick.Buttons;
  buttonStateX[4] := joButton4 in DxJoystick.Buttons;
  buttonStateX[5] := joButton5 in DxJoystick.Buttons;
  buttonStateX[6] := joButton6 in DxJoystick.Buttons;
  buttonStateX[7] := joButton7 in DxJoystick.Buttons;
  buttonStateX[8] := joButton8 in DxJoystick.Buttons;
  buttonStateX[9] := joButton9 in DxJoystick.Buttons;
  buttonStateX[10] := joButton10 in DxJoystick.Buttons;
  buttonStateX[11] := joButton11 in DxJoystick.Buttons;
  buttonStateX[12] := joButton12 in DxJoystick.Buttons;
  buttonStateX[13] := joButton13 in DxJoystick.Buttons;
  buttonStateX[14] := joButton14 in DxJoystick.Buttons;
  buttonStateX[15] := joButton15 in DxJoystick.Buttons;

  if not inCalibrationMode then
  begin
    for i := 1 to 15 do
    begin
      if buttonStateX[i] then
      begin
        (Frm_Main.FindComponent('Shape_Btn_'+inttostr(i)) as TShape).Brush.Color := clLime;
        if not(buttonState[i]) then
        begin
          HotKey := FindHotKeyByName((Frm_Main.FindComponent('E_Hotkey_Btn_'+inttostr(i)) as TEdit).Text);
          if HotKey = 0 then
          begin
            Edit := (Frm_Main.FindComponent('E_Hotkey_Btn_'+inttostr(i)) as TEdit);
            if (Edit<>nil) and (trim(Edit.Text)<>'') then
              HotKey := Ord(Edit.Text[1]);
          end;
          if HotKey<>0 then
            PostKeyExHWND(GameHWND, HotKey, [], false, true, false);
        end;
      end
      else
      begin
        (Frm_Main.FindComponent('Shape_Btn_'+inttostr(i)) as TShape).Brush.Color := clMoneyGreen;
        if buttonState[i] then
        begin
          HotKey := FindHotKeyByName((Frm_Main.FindComponent('E_Hotkey_Btn_'+inttostr(i)) as TEdit).Text);
          if HotKey = 0 then
          begin
            Edit := (Frm_Main.FindComponent('E_Hotkey_Btn_'+inttostr(i)) as TEdit);
            if (Edit<>nil) and (trim(Edit.Text)<>'') then
              HotKey := Ord(Edit.Text[1]);
          end;
          if HotKey<>0 then
            PostKeyExHWND(GameHWND, HotKey, [], false, false, true);
        end;
      end;
    end;
  end
  else
  begin
    if buttonStateX[1] then
    begin
      GetWindowRect(GameHWND, WRect);
      position := 0;

      s := GT_View.DataController.Values[GT_View.DataController.FocusedRecordIndex,0];
      if s='X' then
        position := DxJoystick.PositionX
      else if s='Y' then
        position := DxJoystick.PositionY
      else if s='Z' then
        position := DxJoystick.PositionZ
      else if s='RX' then
        position := DxJoystick.PositionRX
      else if s='RY' then
        position := DxJoystick.PositionRY
      else if s='RZ' then
        position := DxJoystick.PositionRZ
      else if s='Slider1' then
        position := DxJoystick.PositionSlider1
      else if s='Slider2' then
        position := DxJoystick.PositionSlider2;

      if calibrationStep = 1 then
      begin                       
        GT_View.DataController.Values[calibrationRow,3] := inttostr(position);
        GT_View.DataController.Values[calibrationRow,4] := inttostr(GetMouseCursorPos.X-WRect.Left)+','+inttostr(GetMouseCursorPos.Y-WRect.Top);        
        calibrationStep := 0;
        inCalibrationMode := false;
        cxGrid.SetFocus;
      end;
      if (calibrationStep = 0) and inCalibrationMode then
      begin
        GT_View.DataController.Values[calibrationRow,1] := inttostr(position);
        GT_View.DataController.Values[calibrationRow,2] := inttostr(GetMouseCursorPos.X-WRect.Left)+','+inttostr(GetMouseCursorPos.Y-WRect.Top);
        Inc(calibrationStep);
        cxGrid.SetFocus;
      end;
      
    end;
  end;

  buttonState[1] := joButton1 in DxJoystick.Buttons;
  buttonState[2] := joButton2 in DxJoystick.Buttons;
  buttonState[3] := joButton3 in DxJoystick.Buttons;
  buttonState[4] := joButton4 in DxJoystick.Buttons;
  buttonState[5] := joButton5 in DxJoystick.Buttons;
  buttonState[6] := joButton6 in DxJoystick.Buttons;
  buttonState[7] := joButton7 in DxJoystick.Buttons;
  buttonState[8] := joButton8 in DxJoystick.Buttons;
  buttonState[9] := joButton9 in DxJoystick.Buttons;
  buttonState[10] := joButton10 in DxJoystick.Buttons;
  buttonState[11] := joButton11 in DxJoystick.Buttons;
  buttonState[12] := joButton12 in DxJoystick.Buttons;
  buttonState[13] := joButton13 in DxJoystick.Buttons;
  buttonState[14] := joButton14 in DxJoystick.Buttons;
  buttonState[15] := joButton15 in DxJoystick.Buttons;
end;

procedure TFrm_Main.E_Hotkey_Btn_OnContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  (Sender as TEdit).Text := '';
  Handled := true;
end;

procedure TFrm_Main.E_Hotkey_Btn_OnKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var kname: String;
begin
  kname := FindHotKeyByKey(key);
  if kname<>'' then
    (Sender as TEdit).Text := kname
  else
    (Sender as TEdit).Text := Chr(Key);
end;

end.
