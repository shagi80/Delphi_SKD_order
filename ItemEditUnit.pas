unit ItemEditUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ValEdit, ExtCtrls, ImgList, ComCtrls,
  ToolWin, CountList;

Const
  ItmListFileName='items.lst';


type
  TFileTable = class(TStringList)
  private
    FFileName : string;
  public
    constructor Create;
    procedure SetValie(code,fname : string);
  end;

  TMyItem = class
    owner     : string[10];
    code      : string[10];
    name      : string[255];
    note      : string[255];
    folder    : boolean;
    delete    : boolean;
    SubItems  : TCountList;
  public
    constructor Create(owner: string);
    destructor  Destroy; override;
  end;

  TItemList = class
    Count : integer;
    Items : array of TMyItem;
    constructor Create;
    destructor  Destroy; override;
    function    AddItem(item: TMyItem):boolean;
    function    IndFromCode(code:string):integer;
    function    IndFromName(name:string):integer;
    procedure   SaveToFile(fname:string);
    function    LoadFromFile(fname:string):boolean;
    procedure   GetChildGroupList(code:string;var Child:TStringList);
  end;


  TItemEditForm = class(TForm)
    MainPanel: TPanel;
    MainDataPn: TPanel;
    CodeLB: TLabel;
    CodeED: TEdit;
    Label3: TLabel;
    NameED: TEdit;
    Label4: TLabel;
    NoteED: TEdit;
    ItmDataPn: TPanel;
    Label5: TLabel;
    ItemLstVLE: TValueListEditor;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    TB: TToolBar;
    AddBtn: TToolButton;
    ImageList1: TImageList;
    DelBtn: TToolButton;
    EditBtn: TToolButton;
    OpenDlg: TOpenDialog;
    Label1: TLabel;
    FileNameED: TEdit;
    FileNameBtn: TSpeedButton;
    procedure ItemLstVLESetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure ItemLstVLEKeyPress(Sender: TObject; var Key: Char);
    procedure EditBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure UpdateLV;
    procedure FileNameBtnClick(Sender: TObject);
    procedure CodeEDChange(Sender: TObject);
  private
    { Private declarations }
    SubItems : TCountList; //переменная для работы с комплетом
  public
    { Public declarations }
  end;

var
  ItemList : TItemList;


function  ItemEditFormShow(itm : TMyItem):boolean;

implementation

{$R *.dfm}

uses ItemListUnit;

//-----------------------------------------------------------------------------

constructor TFileTable.Create;
var
  fname : string;
begin
  inherited Create;
  fname:=ExtractFilePath(application.ExeName)+'SetsFileTable.txt';
  if (not FileExists(fname)) then self.SaveToFile(fname)
    else self.LoadFromFile(fname);
  self.FFileName:=fname;
end;

procedure  TFileTable.SetValie(code: string; fname: string);
var
  i : integer;
begin
  i:=0;
  while(i<self.Count)and(code<>self.Names[i]) do inc(i);
  if (i<self.Count)and(code=self.Names[i]) then self.Values[self.Names[i]]:=fname
    else self.Add(code+'='+fname);
  self.SaveToFile(self.FFileName);
end;

//-----------------------------------------------------------------------------

constructor TMyItem.Create(owner: string);
begin
  inherited Create;
  self.owner    :=owner;
  self.folder   :=false;
  self.delete   :=false;
  self.SubItems :=TCountList.Create;
end;

destructor TMyItem.Destroy;
begin
  self.SubItems.Destroy;
  inherited;
end;

//------------------------------------------------------------------------------

constructor TItemList.Create;
begin
  inherited;
  count:=0;
  SetLength(self.Items,self.Count);
end;

destructor TItemList.Destroy;
begin
  while self.Count>0 do
    begin
      self.Items[0].Destroy;
      dec(self.Count);
      SetLength(self.Items,self.Count);
    end;
  inherited;
end;

function TItemList.AddItem(item: TMyItem):boolean;
const
  defcodeformat='000000000';
var
  newcode    : integer;
  codeformat : string;

function CodeExists(code:string):boolean;
//процедура определения наличия кода в списке
var
  i : integer;
begin
  i:=0;
  while(i<self.Count)and(self.Items[i].code<>code)do inc(i);
  result:=not (i>=self.Count);
end;

begin
  result:=false;
  if item<>nil then
    begin
      //если код не задан подбираем автоматически начаная с 1
      if length(item.code)=0 then
        begin
          newcode:=1;
          if item.folder then codeformat:='F'+defcodeformat else
            codeformat:='0'+defcodeformat;
          while CodeExists(FormatFloat(codeformat,newcode))do inc(newcode);
          item.code:=FormatFloat(codeformat,newcode);
          result:=true;
      //есил код задан проверяем его уникальность
        end else result:=not CodeExists(item.code);
      //если код уникален - добавляем элемент в список
      if result then
        begin
          inc(self.Count);
          SetLength(self.Items,self.Count);
          self.Items[self.Count-1]:=item;
        end;
    end;
end;

function TItemList.IndFromCode(code: string):integer;
var
  i : integer;
begin
  i:=0;
  while(i<self.Count)and(self.Items[i].code<>code)do inc(i);
  if(i<self.Count)and(self.Items[i].code=code)then result:=i else result:=-1;
end;

function TItemList.IndFromName(name: string):integer;
var
  i : integer;
begin
  i:=0;
  while(i<self.Count)and(self.Items[i].name<>name)do inc(i);
  if(i<self.Count)and(self.Items[i].name=name)then result:=i else result:=-1;
end;

procedure TItemList.SaveToFile(fname:string);
var
  f    : TFileStream;
  i,j  : integer;
  short : shortstring;
begin
  //
  f:=TFileStream.Create(ExtractFilePath(application.ExeName)+fname,fmCreate,fmShareDenyNone);
  try
    f.Write(self.Count,sizeof(integer));
    for I := 0 to self.Count - 1 do
      begin
        short:=self.Items[i].owner;
        f.Write(short,sizeof(shortstring));
        short:=self.Items[i].code;
        f.Write(short,sizeof(shortstring));
        short:=self.Items[i].name;
        f.Write(short,sizeof(shortstring));
        short:=self.Items[i].note;
        f.Write(short,sizeof(shortstring));
        f.Write(self.Items[i].folder,sizeof(boolean));
        f.Write(self.Items[i].delete,sizeof(boolean));
        f.Write(self.Items[i].SubItems.count,sizeof(integer));
        for j := 0 to self.Items[i].SubItems.count - 1 do
          f.Write(self.Items[i].SubItems.Items[j],sizeof(TCountRec));
      end;
  finally
    f.Free;
  end;
end;

function TItemList.LoadFromFile(fname:string):boolean;
var
  f       : TFileStream;
  i,j,c,ci: integer;
  short   : shortstring;
  item    : TMyItem;
  CntRec  : TCountRec;
begin
  //
  result:=false;
  f:=TFileStream.Create(fname,fmOpenRead,fmShareDenyNone);
  try
    f.read(c,sizeof(integer));
    for I := 0 to c - 1 do
      begin
        f.Read(short,sizeof(shortstring));
        Item:=TMyItem.Create(short);
        f.Read(short,sizeof(shortstring));
        item.code:=short;
        f.Read(short,sizeof(shortstring));
        item.name:=short;
        f.Read(short,sizeof(shortstring));
        item.note:=short;
        f.Read(Item.folder,sizeof(boolean));
        f.Read(Item.delete,sizeof(boolean));
        f.read(ci,sizeof(integer));
        for j := 0 to ci - 1 do
          begin
            f.Read(CntRec,sizeof(TCountRec));
            Item.SubItems.Add(CntRec.code,CntRec.count);
          end;
         self.AddItem(item);
      end;
    result:=true;
  finally
    f.Free;
  end;
end;

procedure  TItemList.GetChildGroupList(code:string;var Child:TStringList);
var
  i : integer;
begin
  for I := 0 to self.Count - 1 do
    if (self.Items[i].folder)and(self.Items[i].owner=code) then Child.Add(self.Items[i].code);
end;

//------------------------------------------------------------------------------

procedure TItemEditForm.AddBtnClick(Sender: TObject);
var
  code : string;
begin
  code:=GetSelectItems('');
  if Length(code)>0 then
   if code<>CodeED.Text then
    begin
      if self.SubItems.Add(code,1) then self.UpdateLV else
        MessageDLG('Такая деталь уже есть в списке!',mtError,[mbOK],0);
    end else MessageDLG('Деталь не может быть добавлена в комплект к самой к себе!',mtError,[mbOK],0);
end;

procedure TItemEditForm.CodeEDChange(Sender: TObject);
var
  FileTable : TFileTable;
begin
  FileNameBtn.Enabled:=Length(CodeED.Text)>0;
  if Length(CodeED.Text)>0 then begin
    FileTable := TFileTable.Create;
    FileNameEd.Text:=FileTable.Values[CodeED.Text];
    FileTable.Free;
  end;
end;

procedure TItemEditForm.DelBtnClick(Sender: TObject);
var
  ind  : integer;
begin
  if Length(ItemLstVLE.Cells[0,ItemLstVLE.Selection.Top])>0 then
    begin
      ind:=ItemList.IndFromName(ItemLstVLE.Cells[0,ItemLstVLE.Selection.Top]);
      self.SubItems.Delete(ItemList.Items[ind].code);
      self.UpdateLV;
    end;
end;

procedure TItemEditForm.EditBtnClick(Sender: TObject);
var
  code  : string;
begin
  if Length(ItemLstVLE.Cells[0,ItemLstVLE.Selection.Top])>0 then
    begin
      //определяем родительскую папку элемент
      code:=ItemList.Items[ItemList.IndFromName(ItemLstVLE.Cells[0,ItemLstVLE.Selection.Top])].owner;
      //получение кода нового элемента
      code:=GetSelectItems(code);
      if Length(code)>0 then
        begin
          ItemLstVLE.Cells[0,ItemLstVLE.Selection.Top]:=ItemList.Items[ItemList.IndFromCode(code)].name;
          SubItems.Items[ItemLstVLE.Selection.Top-1].code:=ItemList.Items[ItemList.IndFromCode(code)].code;
        end;
    end;
end;

procedure TItemEditForm.FileNameBtnClick(Sender: TObject);
var
  FileTable : TFileTable;
begin
  if OpenDlg.Execute then begin
    FileNameED.Text:=OpenDlg.FileName;
    FileTable := TFileTable.Create;
    FileTable.SetValie(CodeED.Text,OpenDlg.FileName);
    FileTable.Free;
  end;
end;

procedure TItemEditForm.ItemLstVLEKeyPress(Sender: TObject; var Key: Char);
begin
  if not ((Key in ['0'..'9'])or(ord(key)=8)or(ord(key)=13)) then Key:=chr(0);
end;

procedure TItemEditForm.ItemLstVLESetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  if length(value)>0 then SubItems.Items[Arow-1].count:=StrToInt(value) else   SubItems.Items[Arow-1].count:=0;
end;

procedure TItemEditForm.UpdateLV;
var
  i,ind : integer;
begin
  //настройка видимости кнопок и панелей
  ItmDataPN.Visible:=(self.SubItems.Count>0);
  if (self.SubItems.Count>0) then self.MainPanel.Height:=round(screen.Height*0.5) else
    self.MainPanel.Height:=TB.Top+TB.Height+20;
  DelBtn.Visible:=ItmDataPN.Visible;
  EditBtn.Visible:=ItmDataPN.Visible;
  if (self.SubItems.Count>0) then AddBtn.Caption:='Добавить деталь' else AddBtn.Caption:='Создать комплект';
  //вывод таблицы
  ItemLstVLE.Strings.Clear;
  for I := 0 to self.SubItems.Count - 1 do
    begin
      ind:=ItemList.IndFromCode(self.SubItems.Items[i].code);
      ItemLstVLE.Strings.Add(ItemList.Items[ind].name+'='+IntToStr(self.SubItems.Items[i].count));
    end;
end;

function  ItemEditFormShow(itm : TMyItem):boolean;
var
  Form : TItemEditForm;
  i    : integer;
  FileTable : TFileTable;
begin
  Form:=TItemEditForm.Create(Application);
  with Form do begin
    CodeED.Text:=itm.code;
    NameED.Text:=itm.name;
    NoteED.Text:=itm.note;
    //копируем список коплектующих
    SubItems:=TCountList.Create;
    for I := 0 to itm.SubItems.Count - 1 do SubItems.Add(itm.SubItems.Items[i].code,itm.SubItems.Items[i].count);
    //настройка редактора кода элемента
    if (not Itm.folder)or((Itm.folder)and(Length(Itm.code)>0)) then
      begin
        CodeLB.Caption:='Код:';
        CodeED.Visible:=true;
      end else
      begin
        CodeLB.Caption:='Код для новой группы будет подобран автоматически';
        CodeED.Visible:=false;
      end;
    CodeED.Enabled:=not Itm.folder;
    CodeED.ReadOnly:=(Length(Itm.code)>0);
    TB.Visible:=not Itm.folder;
    UpdateLV;
    FileNameBtn.Enabled:=Length(CodeED.Text)>0;
    if Length(CodeED.Text)>0 then begin
      FileTable := TFileTable.Create;
      FileNameEd.Text:=FileTable.Values[CodeED.Text];
      FileTable.Free;
    end;
    //показ окна
    result:=(ShowModal=mrOK);
    if result then begin
      itm.name:=NameED.Text;
      itm.code:=CodeED.Text;
      itm.note:=NoteED.Text;
      //копируем список коплектующих
      itm.SubItems.Count:=0;
      SetLength(itm.SubItems.Items,0);
      for I := 0 to SubItems.Count - 1 do itm.SubItems.Add(SubItems.Items[i].code,SubItems.Items[i].count);
    end;
    SubItems.Free;
  end;
  Form.Free;
end;

end.
