unit DelivUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, ComCtrls, StdCtrls, ExtCtrls, Mask, ToolWin,
  CountList, Buttons, ImgList;

type
  TIntArray = array of integer;

  TDelivForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel3: TPanel;
    Label6: TLabel;
    Label8: TLabel;
    ColorCB: TColorBox;
    StateCB: TComboBox;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Tm2ED: TEdit;
    Tm3ED: TEdit;
    Tm4ED: TEdit;
    Tm2UD: TUpDown;
    Tm3UD: TUpDown;
    Tm4UD: TUpDown;
    DateED: TMaskEdit;
    Panel2: TPanel;
    DelivVLE: TValueListEditor;
    Label2: TLabel;
    NameED: TEdit;
    Label1: TLabel;
    NoteED: TEdit;
    FNameED: TEdit;
    Label9: TLabel;
    LinkAddBtn: TSpeedButton;
    SubItemBtn: TSpeedButton;
    LinkDelBtn: TSpeedButton;
    LinkEditBtn: TSpeedButton;
    OpenDlg: TOpenDialog;
    PortLB: TLabel;
    SpeedButton1: TSpeedButton;
    SaveDlg: TSaveDialog;
    procedure DateEDChange(Sender: TObject);
    procedure Tm2EDChange(Sender: TObject);
    procedure LinkAddBtnClick(Sender: TObject);
    procedure LinkEditBtnClick(Sender: TObject);
    procedure LinkDelBtnClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DelivVLEKeyPress(Sender: TObject; var Key: Char);
    procedure SubItemEditBtnClick(Sender: TObject);
    procedure UpdateVLE;
    function  GetError:string;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    SubItems : TCountList;
    period   : word;
  public
    { Public declarations }
  end;

  TDelivery = record
    name  : string[20];
    note  : string[255];
    Fname : string;
    color : TColor;
    Tm1   : word;
    Tm2   : word;
    Tm3   : word;
    Tm4   : word;
    Date  : TDate;
    state : word;
    Items : TCountList;
  end;

  TDelivList = class
    count : integer;
    items : array of TDelivery;
    constructor Create;
    destructor  Destroy; override;
    function    AddItem(item: TDelivery):boolean;
    procedure   Delete(name: string);
    function    IndFromName(name:string):integer;
    //список индексов поставок за период (по дате отгрузки)
    function    IndexFromPrd(dt1,dt2:TDateTime;code : string;var ind:TIntArray):integer;
    //список индексов поставок за период (по дате попадания на сток)
    function    SendFromPrd(dt1,dt2:TDateTime;code : string;var ind:TIntArray):integer;
    //сумма элементов из всех поставок поступающих на сток за период
    function    SumSendFromPrd(dt1,dt2:TDateTime;code : string):integer;
  end;


var
  DelivList : TDelivList;

function ShowDelivery(ind:integer;prd:word=0; selcode:string=''):boolean;


implementation

uses ShellApi,GlobalData, DateUtils, ItemEditUnit, ItemListUnit, CheckListUnit,
  IniFiles, TDataLst, Math;


{$R *.dfm}

constructor TDelivList.Create;
begin
  inherited;
  count:=0;
  SetLength(self.Items,self.Count);
end;

destructor TDelivList.Destroy;
var
  i : integer;
begin
  for I := 0 to self.count - 1 do self.items[i].Items.Destroy;
  SetLength(self.items,0);
  inherited;
end;

function TDelivList.AddItem(item: TDelivery):boolean;
const
  defcodeformat='00000';
var
  newcode    : integer;
  codeformat : string;

function CodeExists(code:string):boolean;
//процедура определения наличия кода в списке
var
  i : integer;
begin
  i:=0;
  while(i<self.Count)and(self.Items[i].name<>code)do inc(i);
  result:=not (i>=self.Count);
end;

begin
  result:=false;
  //если код не задан подбираем автоматически начаная с 1
  if length(item.name)=0 then
    begin
      newcode:=1;
      codeformat:=defcodeformat;
      while CodeExists(FormatFloat(codeformat,newcode))do inc(newcode);
      item.name:=FormatFloat(codeformat,newcode);
      result:=true;
  //есил код задан проверяем его уникальность
    end else result:=not CodeExists(item.name);
  //если код уникален - добавляем элемент в список
  if result then
    begin
      inc(self.Count);
      SetLength(self.Items,self.Count);
      self.Items[self.Count-1]:=item;
    end;
end;

procedure TDelivList.Delete(name: string);
var
  i,j,k : integer;
begin
  i:=0;
  while(i<self.Count)and(self.Items[i].name<>name)do inc(i);
  if(i<self.Count)and(self.Items[i].name=name)then
    begin
      for j := i to self.Count - 2 do
        begin
          self.items[j].name:=self.Items[j+1].name;
          self.items[j].note:=self.Items[j+1].note;
          self.items[j].fname:=self.Items[j+1].fname;
          self.items[j].color:=self.Items[j+1].color;
          self.items[j].Tm1:=self.Items[j+1].Tm1;
          self.items[j].Tm2:=self.Items[j+1].Tm2;
          self.items[j].Tm3:=self.Items[j+1].Tm3;
          self.items[j].Tm4:=self.Items[j+1].Tm4;
          self.items[j].Date:=self.Items[j+1].Date;
          self.items[j].state:=self.Items[j+1].state;
          //удалям старый список поставки
          if self.items[j].Items=nil then self.items[j].Items:=TCountList.Create
            else while self.items[j].Items.Count>0 do self.items[j].Items.Delete(self.items[j].Items.Items[0].code);
          //копируем список поставки
          for k := 0 to self.items[j+1].Items.Count - 1 do
            self.items[j].Items.Add(self.items[j+1].Items.Items[k].code,self.items[j+1].Items.Items[k].count)
        end;
      dec(self.count);
      SetLength(self.items,self.count);
    end;
end;

function TDelivList.IndFromName(name: string):integer;
var
  i : integer;
begin
  i:=0;
  while(i<self.Count)and(self.Items[i].name<>name)do inc(i);
  if(i<self.Count)and(self.Items[i].name=name)then result:=i else result:=-1;
end;

function TDelivList.IndexFromPrd(dt1,dt2:TDateTime;code : string;var ind:   TIntArray):integer;
var
  i,cnt : integer;
begin
  cnt:=0;
  SetLength(ind,0);
  for I := 0 to self.Count - 1 do
    if(self.items[i].Date>=dt1)and(self.items[i].Date<dt2)and
      ((Length(code)=0)or((Length(code)>0)and(self.items[i].Items.IndFromCode(code)>=0)))then
      begin
        inc(cnt);
        SetLength(ind,cnt);
        ind[cnt-1]:=i;
      end;
  result:=cnt;
end;

function TDelivList.SendFromPrd(dt1,dt2:TDateTime;code : string;var ind:   TIntArray):integer;
var
  i,cnt : integer;
  dcnt  : integer;
  senddt: TDateTime;
begin
  cnt:=0;
  SetLength(ind,0);
  for I := 0 to self.Count - 1 do
    begin
      dcnt:=self.items[i].Tm2+self.items[i].Tm3+self.items[i].Tm4;
      senddt:=IncDay(self.items[i].Date,dcnt);
      if(senddt>=dt1)and(senddt<dt2)and
        ((Length(code)=0)or((Length(code)>0)and(self.items[i].Items.IndFromCode(code)>=0)))then
          begin
            inc(cnt);
            SetLength(ind,cnt);
            ind[cnt-1]:=i;
          end;
    end;
  result:=cnt;
end;

function TDelivList.SumSendFromPrd(dt1,dt2:TDateTime;code : string):integer;
var
  i,cnt : integer;
  dcnt  : integer;
  senddt: TDateTime;
begin
  cnt:=0;
  for I := 0 to self.Count - 1 do
    begin
      dcnt:=self.items[i].Tm2+self.items[i].Tm3+self.items[i].Tm4;
      senddt:=IncDay(self.items[i].Date,dcnt);
      if(senddt>=dt1)and(senddt<dt2)and
        ((Length(code)>0)and(self.items[i].Items.IndFromCode(code)>=0))then
            cnt:=cnt+self.Items[i].Items.Items[self.items[i].Items.IndFromCode(code)].count;
    end;
  result:=cnt;
end;

//------------------------------------------------------------------------------

function TDelivForm.GetError:string;
var
  res:string;
  i,sum : integer;
begin
  res:='';
  //проверяем заполнение списка комплектующих
  if (Length(res)=0)then
    begin
      sum:=0;
      for I := 0 to self.DelivVLE.Strings.Count-1 do
        if (Length(self.DelivVLE.Strings.ValueFromIndex[i])>0)then
          sum:=sum+StrToInt(self.DelivVLE.Strings.ValueFromIndex[i]);
      if sum=0 then res:='Поставка не содержит деталей!';
    end;
  //проверяем соответствие периоду планирования
  if (Length(res)=0)and((PlanForm.GetPrdStartDate(0)>StrtoDate(self.DateED.Text))
    or((PlanForm.GetPrdStartDate(PlanForm.GetPrdCount)<=StrtoDate(self.DateED.Text))))then
      if MessageDLG('ВНИМАИНЕ! Дата поставки за пределами периода планирования!'+
        chr(13)+'Сохранить запись о поставке несмотря на это?',
        mtWarning,[mbYes,mbNo],0)=mrNo then res:='Измените дату поставки!';
  result:=res;
end;

procedure TDelivForm.LinkAddBtnClick(Sender: TObject);
begin
  if OpenDlg.Execute then FNameED.Text:=OpenDlg.FileName;
end;

procedure TDelivForm.LinkDelBtnClick(Sender: TObject);
begin
  if MessageDLG('Вы действительно хотите удвлить связь с файлом?',
    mtWarning,[mbYes,mbNo],0)=mrYes then FNameED.Text:='';
end;

procedure TDelivForm.LinkEditBtnClick(Sender: TObject);
var
  cmdLine, fName : string;
begin
  cmdLine := OrderEditProg; //полный путь до программы, которой хотим открыть файл
  fName   := FNameED.Text;    //полный путь до файла
  if(Length(FName)>0)and(FileExists(FName))and
    (Length(cmdLine)>0)and(FileExists(cmdLine))then
      ShellExecute(Handle, 'open',pchar(cmdLine),pchar(FName),nil,SW_SHOWNORMAL)
   else if (Length(FName)>0)and(FileExists(FName)) then
      ShellExecute(Handle, 'open',pchar(FName),nil,nil,SW_SHOWNORMAL)
   else if (Length(cmdLine)>0)and(FileExists(cmdLine)) then
      ShellExecute(Handle, 'open',pchar(cmdLine),nil,nil,SW_SHOWNORMAL)
   else MessageDlg('Ошибка открытия файла!',mtError,[mbOk],0);
end;

function ShowDelivery(ind:integer;prd:word=0; selcode:string=''):boolean;
var
  form : TDelivForm;
  item : TDelivery;
  i    : integer;
begin
  form:=TDelivForm.Create(application);
  form.SubItems:=TCountList.Create;
  with form do begin
    if(ind>=0)then begin
        //существующая поставка
        NameED.Text:=DelivList.Items[ind].name;
        NoteED.Text:=DelivList.Items[ind].note;
        FNameED.Text:=DelivList.Items[ind].fname;
        Tm2UD.Position:=DelivList.Items[ind].Tm2;
        Tm3UD.Position:=DelivList.Items[ind].Tm3;
        Tm4UD.Position:=DelivList.Items[ind].Tm4;
        DateED.Text:=DateToStr(DelivList.Items[ind].Date);
        PortLB.Caption:='(в порту '+DateToStr(IncDay(DelivList.Items[ind].Date,DelivList.Items[ind].Tm2))+')';
        StateCB.ItemIndex:=DelivList.Items[ind].state;
        for I := 0 to DelivList.Items[ind].Items.Count - 1 do
          SubItems.Add(DelivList.Items[ind].Items.Items[i].code,DelivList.Items[ind].Items.Items[i].count);
        ColorCB.Selected:=DelivList.Items[ind].color;
        UpdateVLE;
      end else begin
        //создание поставки
        NameED.Text:='';
        NoteED.Text:='';
        FNameED.Text:='';
        Tm2UD.Position:=DefTm2;
        Tm3UD.Position:=DefTm3;
        Tm4UD.Position:=DefTm4;
        StateCB.ItemIndex:=0;
        DateED.Text:=DateToStr(PlanForm.GetPrdStartDate(prd));
        if Length(selcode)>0 then SubItems.Add(selcode,1);
        ColorCB.ItemIndex:=10;
        UpdateVLE;
      end;
    period:=prd;
    result:=false;
    if (ShowModal=mrOk) then
        //если это новая поставка
        if ind=-1 then begin
          item.Items:=TCountList.Create;
          item.name:=NameED.Text;
          item.note:=NoteED.Text;
          item.fname:=FNameED.Text;
          if Length(TM2ED.Text)=0 then item.Tm2:=0 else item.Tm2:=StrToInt(Tm2ED.Text);
          if Length(TM3ED.Text)=0 then item.Tm3:=0 else item.Tm3:=StrToInt(Tm3ED.Text);
          if Length(TM4ED.Text)=0 then item.Tm4:=0 else item.Tm4:=StrToInt(Tm4ED.Text);
          item.Date:=StrToDate(DateED.Text);
          item.color:=ColorCB.Colors[ColorCB.ItemIndex];
          item.state:=StateCB.ItemIndex;
          for I:= 0 to SubItems.Count-1 do
            if Length(DelivVLE.Strings.ValueFromIndex[i])=0 then item.Items.Add(SubItems.Items[i].code,0)
              else item.Items.Add(SubItems.Items[i].code,StrToInt(DelivVLE.Strings.ValueFromIndex[i]));
          if DelivList.AddItem(item) then result:=true else
            MessageDLG('Ошибка при добавлении поставки!',mtError,[mbOk],0);
        end else begin
        //если изменяется имеющаяся поставка
          DelivList.items[ind].name:=NameED.Text;
          DelivList.items[ind].note:=NoteED.Text;
          DelivList.items[ind].fname:=FnameED.Text;
          if Length(TM2ED.Text)=0 then DelivList.items[ind].Tm2:=0 else DelivList.items[ind].Tm2:=StrToInt(Tm2ED.Text);
          if Length(TM3ED.Text)=0 then DelivList.items[ind].Tm3:=0 else DelivList.items[ind].Tm3:=StrToInt(Tm3ED.Text);
          if Length(TM4ED.Text)=0 then DelivList.items[ind].Tm4:=0 else DelivList.items[ind].Tm4:=StrToInt(Tm4ED.Text);
          DelivList.items[ind].Date:=StrToDate(DateED.Text);
          DelivList.items[ind].color:=ColorCB.Colors[ColorCB.ItemIndex];
          DelivList.items[ind].state:=StateCB.ItemIndex;
          //очистка и обновление списка поставки
          while DelivList.items[ind].Items.Count>0 do
            DelivList.items[ind].Items.Delete(DelivList.items[ind].Items.Items[0].code);
          for I := 0 to SubItems.Count-1 do
            if Length(DelivVLE.Strings.ValueFromIndex[i])=0 then DelivList.items[ind].Items.Add(SubItems.Items[i].code,0)
              else DelivList.items[ind].Items.Add(SubItems.Items[i].code,StrToInt(DelivVLE.Strings.ValueFromIndex[i]));
          result:=true;
        end;
  end;
  form.Free;
end;

procedure TDelivForm.BitBtn1Click(Sender: TObject);
var
  str:string;
begin
  str:=self.GetError;
  if Length(str)=0 then self.ModalResult:=mrOk else
    MessageDlg(str,mtError,[mbOk],0);  
end;

procedure TDelivForm.DateEDChange(Sender: TObject);
begin
  try
    if (Length(DateED.Text)>0)and(Length(Tm2ED.text)>0) then
      PortLB.Caption:='(в порту '+DateToStr(IncDay(StrToDate(DateED.Text),StrToInt(Tm2ED.text)))+')';
  except
     //
  end;
end;

procedure TDelivForm.DelivVLEKeyPress(Sender: TObject; var Key: Char);
begin
  if not ((Key in ['0'..'9'])or(ord(key)=8)or(ord(key)=13)) then Key:=chr(0);
end;

procedure TDelivForm.SpeedButton1Click(Sender: TObject);
var
  FileTable   : TFileTable;
  i,j,rnd,cnt : integer;
  fname, ord_name: string;
  OneSet      : TDataList;
  Order       : TModList;
  stop        : boolean;
  RoundTable: TStringList;
begin
  FileTable :=TFiletable.Create;
  Order     := TModList.Create;
  RoundTable:= TStringList.Create;
  RoundTable.LoadFromFile(ExtractFilePath(application.ExeName)+'RoundTable.txt');
  i:=0;
  stop:=false;
  while(i<Self.SubItems.Count)and(not stop)do begin
    fname:=FileTable.Values[self.SubItems.Items[i].code];
    ord_name:=ItemList.Items[ItemList.IndFromCode(self.SubItems.Items[i].code)].name;;
    cnt:=self.SubItems.Items[i].count;
    if (Length(fname)>0)and(FileExists(fname))and(cnt>0) then begin
      OneSet:=TDataList.Create;
      OneSet.LoadFrom1CTXT(fname);
      //настройка комплекта - умножение, округление
      OneSet.EngName:=OneSet.EngName+' '+IntToStr(cnt);
      for j := 0 to OneSet.Count - 1 do begin
        OneSet.Item[j].TotCount:=OneSet.Item[j].TotCount*cnt;
        // округление необходимых позиций
        if Length(RoundTable.Values[OneSet.Item[j].Code])>0 then begin
          rnd:=StrToIntDef(RoundTable.Values[OneSet.Item[j].Code],1);
          OneSet.Item[j].TotCount:=Ceil(OneSet.Item[j].TotCount/rnd)*rnd;
        end;
      end;
      //------------------------------------------
      Order.Add(OneSet);
    end else stop:=(MessageDlg('Файл комплекта для модели "'+ord_name+
      '" не найден. Продолжить формирование заказа ?',mtError,[mbYes,mbNo],0)=mrNo);
    inc(i);
  end;
  if (not stop)and(SaveDlg.Execute) then begin
    Order.SaveAll(SaveDlg.FileName);
    FNameED.Text:=SaveDlg.FileName;
  end;
  Order.Free;
  FileTable.Free;
  RoundTable.Free;
end;

procedure TDelivForm.SubItemEditBtnClick(Sender: TObject);
var
  list,check : TstringList;
  i,j        : integer;
  str        : string;
begin
  //составляем список всех комплектующих входящих в состав всей
  //отобранной в остатки готовой продукции
  list:=TStringList.Create;
  //идем по списку остатков готовой продукции
  for I := 0 to ItemsStartCount.Count - 1 do
    list.Add(ItemList.Items[itemlist.IndFromCode(ItemsStartCount.Items[i].code)].name
      +'='+ItemsStartCount.Items[i].code);
  //составляем список уже выбранных позиций
  check:=TstringList.Create;
  for I := 0 to self.SubItems.Count - 1 do check.Add(self.SubItems.Items[i].code);

  if Length(NameED.Text)>0 then str:=' ('+NameED.Text+')' else str:='';
  if CheckList('поставка от '+DateED.Text+str,list,check) then
    begin
      //добавляем новые
      for I := 0 to check.Count - 1 do
        begin
          j:=0;
          while(j<self.SubItems.Count)and(self.SubItems.Items[j].code<>check[i])do inc(j);
          if (j=self.SubItems.Count) then self.SubItems.Add(check[i],1);
        end;
      //удаляем отсутствующие
      I := 0;
      while(i<self.SubItems.Count) do
        begin
          j:=0;
          while(j<check.Count)and(self.SubItems.Items[i].code<>check[j])do inc(j);
          if(j=check.Count)then self.SubItems.Delete(self.SubItems.Items[i].code);
          inc(i);
        end;
      //обновляем визуальные элементы
      self.UpdateVLE;
    end;
  list.Free;
  check.Free;
end;

procedure TDelivForm.Tm2EDChange(Sender: TObject);
begin
  if (Length(DateED.Text)>0)and(Length(Tm2ED.text)>0) then
    PortLB.Caption:='(в порту '+DateToStr(IncDay(StrToDate(DateED.Text),StrToInt(Tm2ED.text)))+')';
end;

procedure TDelivForm.UpdateVLE;
var
  i : integer;
  name : string;
begin
  DelivVLE.Strings.Clear;
  for I := 0 to Self.SubItems.Count-1 do
    begin
      name:=ItemList.Items[ItemList.IndFromCode(self.SubItems.Items[i].code)].name;
      self.DelivVLE.Strings.Add(name+'='+IntToStr(self.SubItems.Items[i].count));
    end;
  DelivVLE.Enabled:=(DelivVLE.Strings.Count>0);
end;


end.
