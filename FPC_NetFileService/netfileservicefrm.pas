unit NetFileServiceFrm;

{$mode objfpc}{$H+}

interface
{$MODESWITCH AdvancedRecords}
{$MODESWITCH NestedProcVars}
{$MODESWITCH NESTEDCOMMENTS}
{$NOTES OFF}
{$STACKFRAMES OFF}
{$COPERATORS OFF}
{$GOTO ON}
{$INLINE ON}
{$MACRO ON}
{$HINTS ON}
{$IEEEERRORS ON}
{$R-}
{$I-}
{$S-}
{$OPTIMIZATION OFF}
{$HINTS OFF}
{$C+} { Assertions }
{$M-} { Run-Time Type Information }
{$H+} { long string }
{$A+} { Word Align Data }
{$Q-} { Overflow checking }
{$B-} { Complete boolean evaluation }
{$J+} { Writeable typed constants }

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,

  PascalStrings, CoreClasses,
  ListEngine, UnicodeMixedLib, DoStatusIO,
  DataFrameEngine, MemoryStream64, CoreCipher, NotifyObjectBase, Cadencer,
  TextDataEngine,
  CommunicationFramework, PhysicsIO, CommunicationFrameworkDoubleTunnelIO_NoAuth;

type

  { TNetFileServiceForm }

  TNetFileServiceForm = class(TForm)
    BindEdit: TLabeledEdit;
    BrowseButton: TButton;
    ListenStateLabel: TLabel;
    Memo: TMemo;
    PasswdEdit: TLabeledEdit;
    PortEdit: TLabeledEdit;
    progressTimer: TTimer;
    ShareDirEdit: TLabeledEdit;
    ShowPasswdCheckBox: TCheckBox;
    StartServiceButton: TButton;
    StateTimer: TTimer;
    StopServiceButton: TButton;
    procedure BrowseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure progressTimerTimer(Sender: TObject);
    procedure ShareDirEditExit(Sender: TObject);
    procedure ShowPasswdCheckBoxChange(Sender: TObject);
    procedure StartServiceButtonClick(Sender: TObject);
    procedure StateTimerTimer(Sender: TObject);
    procedure StopServiceButtonClick(Sender: TObject);
  private
    procedure DoStatus_Backcall(Text_: SystemString; const ID: Integer);

    procedure LoadOpt;
    procedure SaveOpt;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TNetFileService = class(TPhysicsServer)
  protected
    FRecv, FSend: TCommunicationFrameworkWithP2PVM_Server;
    FDoubleTunnel: TCommunicationFramework_DoubleTunnelService_NoAuth;
    procedure Command_GetFileList(Sender: TPeerIO; InData, OutData: TDataFrameEngine);
    procedure Command_DeleteFile(Sender: TPeerIO; InData: SystemString);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Progress; override;
  end;

var
  NetFileServiceForm: TNetFileServiceForm;
  NetFileService: TNetFileService;

implementation

{$R *.lfm}

{ TNetFileServiceForm }

procedure TNetFileServiceForm.StartServiceButtonClick(Sender: TObject);
begin
  NetFileService.StopService;
  NetFileService.FDoubleTunnel.FileReceiveDirectory := ShareDirEdit.Text;
  NetFileService.AutomatedP2PVMAuthToken := PasswdEdit.Text;
  if NetFileService.StartService(BindEdit.Text, umlStrToInt(PortEdit.Text)) then
    begin
      DoStatus('listen for bind %s: %s success', [TranslateBindAddr(BindEdit.Text), PortEdit.Text]);
      ListenStateLabel.Caption := 'Listen OK.';
      umlCacheFileMD5FromDirectory(NetFileService.FDoubleTunnel.FileReceiveDirectory, '*');
    end
  else
    begin
      DoStatus('failed listen for bind %s: %s', [TranslateBindAddr(BindEdit.Text), PortEdit.Text]);
      ListenStateLabel.Caption := '..';
    end;
end;

procedure TNetFileServiceForm.StateTimerTimer(Sender: TObject);
begin
  Caption := Format('NetFile Service. P2PVM-Network(Received: %s Send: %s)',
    [umlSizeToStr(NetFileService.Statistics[stReceiveSize]).Text, umlSizeToStr(NetFileService.Statistics[stSendSize]).Text]);
end;

procedure TNetFileServiceForm.StopServiceButtonClick(Sender: TObject);
begin
  NetFileService.StopService;
  DoStatus('Stop listen for bind %s: %s', [TranslateBindAddr(BindEdit.Text), PortEdit.Text]);
  ListenStateLabel.Caption := '..';
end;

procedure TNetFileServiceForm.ShowPasswdCheckBoxChange(Sender: TObject);
begin
  if ShowPasswdCheckBox.Checked then
      PasswdEdit.PasswordChar := #0
  else
      PasswdEdit.PasswordChar := '*';
end;

procedure TNetFileServiceForm.BrowseButtonClick(Sender: TObject);
var
  dir: SystemString;
begin
  dir := ShareDirEdit.Text;
  if not SelectDirectory('download directory.', '', dir) then
      exit;
  ShareDirEdit.Text := dir;
  NetFileService.FDoubleTunnel.FileReceiveDirectory := ShareDirEdit.Text;
  umlCacheFileMD5FromDirectory(NetFileService.FDoubleTunnel.FileReceiveDirectory, '*');
end;

procedure TNetFileServiceForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := TCloseAction.caFree;
  SaveOpt;
  NetFileService.StopService;
end;

procedure TNetFileServiceForm.progressTimerTimer(Sender: TObject);
begin
  NetFileService.Progress;
  CheckThreadSynchronize;
end;

procedure TNetFileServiceForm.ShareDirEditExit(Sender: TObject);
begin
  NetFileService.FDoubleTunnel.FileReceiveDirectory := ShareDirEdit.Text;
  umlCacheFileMD5FromDirectory(NetFileService.FDoubleTunnel.FileReceiveDirectory, '*');
end;

procedure TNetFileServiceForm.DoStatus_Backcall(Text_: SystemString; const ID: Integer);
begin
  if Memo.Lines.Count > 5000 then
      Memo.Lines.Clear;
  Memo.Lines.Add(Text_);
end;

procedure TNetFileServiceForm.LoadOpt;
var
  te: THashTextEngine;
begin
  te := THashTextEngine.Create;
  te.LoadFromFile(umlCombineFileName(umlGetCurrentPath, 'NetFileService.ini'));
  BindEdit.Text := te.GetDefaultText('main', 'bind', BindEdit.Text);
  PortEdit.Text := te.GetDefaultText('main', 'port', PortEdit.Text);
  PasswdEdit.Text := te.GetDefaultText('main', 'password', PasswdEdit.Text);
  ShareDirEdit.Text := te.GetDefaultText('main', 'directory', ShareDirEdit.Text);
  disposeObject(te);
end;

procedure TNetFileServiceForm.SaveOpt;
var
  te: THashTextEngine;
begin
  te := THashTextEngine.Create;
  te.SetDefaultText('main', 'bind', BindEdit.Text);
  te.SetDefaultText('main', 'port', PortEdit.Text);
  te.SetDefaultText('main', 'password', PasswdEdit.Text);
  te.SetDefaultText('main', 'directory', ShareDirEdit.Text);
  te.SaveToFile(umlCombineFileName(umlGetCurrentPath, 'NetFileService.ini'));
  disposeObject(te);
end;

constructor TNetFileServiceForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddDoStatusHook(self, @DoStatus_Backcall);
  ShareDirEdit.Text := umlGetCurrentPath.Text;
  NetFileService := TNetFileService.Create;
  LoadOpt();
  StartServiceButtonClick(StartServiceButton);
end;

destructor TNetFileServiceForm.Destroy;
begin
  DeleteDoStatusHook(self);
  disposeObject(NetFileService);
  inherited Destroy;
end;

procedure TNetFileService.Command_GetFileList(Sender: TPeerIO; InData, OutData: TDataFrameEngine);
var
  filter: U_String;
  arry: U_StringArray;
  n: U_SystemString;
  tmp: TDataFrameEngine;
begin
  filter := InData.Reader.ReadString;
  arry := umlGetFileListWithFullPath(FDoubleTunnel.FileReceiveDirectory);

  for n in arry do
    if umlMultipleMatch(filter, umlGetFileName(n)) then
      begin
        tmp := TDataFrameEngine.Create;
        tmp.WriteString(umlGetFileName(n));
        tmp.WriteInt64(umlGetFileSize(n));
        tmp.WriteDouble(umlGetFileTime(n));
        OutData.WriteDataFrame(tmp);
        disposeObject(tmp);
      end;
end;

procedure TNetFileService.Command_DeleteFile(Sender: TPeerIO; InData: SystemString);
begin
  umlDeleteFile(umlCombineFileName(FDoubleTunnel.FileReceiveDirectory, InData));
end;

constructor TNetFileService.Create;
begin
  inherited Create;
  FRecv := TCommunicationFrameworkWithP2PVM_Server.Create;
  FRecv.StartService('::', 1);
  FSend := TCommunicationFrameworkWithP2PVM_Server.Create;
  FSend.StartService('::', 2);

  AutomatedP2PVMBindService.AddService(FRecv);
  AutomatedP2PVMBindService.AddService(FSend);
  AutomatedP2PVMService := True;

  FRecv.SwitchMaxSecurity;
  FSend.SwitchMaxSecurity;
  FRecv.QuietMode := False;
  FSend.QuietMode := False;
  QuietMode := False;

  FDoubleTunnel := TCommunicationFramework_DoubleTunnelService_NoAuth.Create(FRecv, FSend);
  FDoubleTunnel.RegisterCommand;
  FRecv.RegisterStream('GetFileList').OnExecute := @Command_GetFileList;
  FRecv.RegisterDirectConsole('DeleteFile').OnExecute := @Command_DeleteFile;
end;

destructor TNetFileService.Destroy;
begin
  StopService;
  disposeObject(FDoubleTunnel);
  disposeObject(FRecv);
  disposeObject(FSend);
  inherited Destroy;
end;

procedure TNetFileService.Progress;
begin
  FDoubleTunnel.Progress;
  inherited Progress;
end;

end.

