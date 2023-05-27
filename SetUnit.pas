unit SetUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons;

type
  TSetPlanForm = class(TForm)
    PC: TPageControl;
    DelivTime: TTabSheet;
    Label3: TLabel;
    Tm2ED: TEdit;
    Tm2UD: TUpDown;
    Tm3UD: TUpDown;
    Tm3ED: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Tm4ED: TEdit;
    Tm4UD: TUpDown;
    DelivCalck: TTabSheet;
    Label1: TLabel;
    MinOstED: TEdit;
    MinOstUD: TUpDown;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    FilesAndFolder: TTabSheet;
    Label2: TLabel;
    OrderEditProgED: TEdit;
    OrderEdtProgBtn: TSpeedButton;
    OpenDlg: TOpenDialog;
    DelOrderEditProgBtn: TSpeedButton;
    NegativeCB: TCheckBox;
    procedure DelOrderEditProgBtnClick(Sender: TObject);
    procedure OrderEdtProgBtnClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    function ShowSetting:boolean;
    procedure InitDef;
    procedure SaveInitFolder;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetPlanForm: TSetPlanForm;

implementation

{$R *.dfm}

uses GlobalData, IniFiles, ShellApi;

const
  DefFileName='\ShipSchedule\mainset.ini';


function GetWin(Comand: string): string;
var
  buff: array [0 .. $FF] of char;
begin
  ExpandEnvironmentStrings(PChar(Comand), buff, SizeOf(buff));
  Result := buff;
end;

procedure TSetPlanForm.BitBtn1Click(Sender: TObject);
begin
  self.ModalResult:=mrOK;
end;

procedure TSetPlanForm.DelOrderEditProgBtnClick(Sender: TObject);
begin
  OrderEditProgED.Text:='';
end;

procedure TSetPlanForm.InitDef;
var
  DefFile : TiniFile;
begin
  DefFile:=TIniFile.Create(getwin('%AppData%')+DefFileName);
  DefTm2:=DefFile.ReadInteger('TIME','DEFTM2',30);
  DefTm3:=DefFile.ReadInteger('TIME','DEFTM3',7);
  DefTm4:=DefFile.ReadInteger('TIME','DEFTM4',7);
  ProdMinOst:=DefFile.ReadInteger('CALK','MINOST',50);
  OrderEditProg:=DefFile.ReadString ('FOLDER','ORDEREDITPORG','');
  InitFolder:=DefFile.ReadString ('FOLDER','INITFOLDER','');
  NegativePossible:=DefFile.ReadBool('CALK','NEGATIVEPOSSIBLE',false);
  DefFile.Free;
end;

procedure TSetPlanForm.OrderEdtProgBtnClick(Sender: TObject);
begin
  if OpenDlg.Execute then OrderEditProgED.Text:=OpenDlg.FileName;
end;

procedure TSetPlanForm.SaveInitFolder;
var
  DefFile : TiniFile;
begin
  if not(DirectoryExists(ExtractFilePath(getwin('%AppData%')+DefFileName))) then
    CreateDir(ExtractFilePath(getwin('%AppData%')+DefFileName));
  DefFile:=TIniFile.Create(getwin('%AppData%')+DefFileName);
  DefFile.WriteString ('FOLDER','INITFOLDER',InitFolder);
  DefFile.Free;
end;


function TSetPlanForm.ShowSetting:boolean;
var
  DefFile : TiniFile;
begin
  Tm2UD.Position:=DefTm2;
  Tm3UD.Position:=DefTm3;
  Tm4UD.Position:=DefTm4;
  MinOstUD.Position:=ProdMinOst;
  OrderEditProgED.Text:=OrderEditProg;
  NegativeCB.Checked:=NegativePossible;

  result:=(self.ShowModal=mrOK);
  if result then
    begin
      if Length(TM2ED.Text)=0 then DefTm2:=0 else DefTm2:=StrToInt(Tm2ED.Text);
      if Length(TM3ED.Text)=0 then DefTm3:=0 else DefTm3:=StrToInt(Tm3ED.Text);
      if Length(TM4ED.Text)=0 then DefTm4:=0 else DefTm4:=StrToInt(Tm4ED.Text);
      if Length(MinOstED.Text)=0 then ProdMinOst:=0 else ProdMinOst:=StrToInt(MinOstED.Text);
      OrderEditProg:=OrderEditProgED.Text;
      NegativePossible:=NegativeCB.Checked;
      //Запись в файл
      if not(DirectoryExists(ExtractFilePath(getwin('%AppData%')+DefFileName))) then
          CreateDir(ExtractFilePath(getwin('%AppData%')+DefFileName));
      DefFile:=TIniFile.Create(getwin('%AppData%')+DefFileName);
      DefFile.WriteInteger('TIME','DEFTM2',DefTm2);
      DefFile.WriteInteger('TIME','DEFTM3',DefTm3);
      DefFile.WriteInteger('TIME','DEFTM4',DefTm4);
      DefFile.WriteInteger('CALK','MINOST',ProdMinOst);
      DefFile.WriteString ('FOLDER','ORDEREDITPORG',OrderEditProg);
      DefFile.WriteBool('CALK','NEGATIVEPOSSIBLE',NegativePossible);
      DefFile.Free;
    end;
end;

end.
