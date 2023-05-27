unit StartOstUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, ComCtrls, ToolWin, ExtCtrls, ImgList, Mask;

type
  TStartOstForm = class(TForm)
    GPPn: TPanel;
    StaticText1: TStaticText;
    Splitter1: TSplitter;
    ItemPn: TPanel;
    StaticText2: TStaticText;
    GPTB: TToolBar;
    GPEditBtn: TToolButton;
    GPWarnPn: TPanel;
    GPWarningLB: TLabel;
    ItemWarnPn: TPanel;
    ItemWarningLb: TLabel;
    GPVLE: TValueListEditor;
    ItemVLE: TValueListEditor;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    itemLstEditBtn: TToolButton;
    GPAddBtn: TToolButton;
    GPDelBtn: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ItemVLESetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure GPVLESetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure GPDelBtnClick(Sender: TObject);
    procedure GPAddBtnClick(Sender: TObject);
    procedure itemLstEditBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GPEditBtnClick(Sender: TObject);
    procedure GPVLEKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure ItemVLEStringsChange(Sender: TObject);
    procedure GPVLEStringsChange(Sender: TObject);
    procedure UpdateGPVLE;
    procedure UpdateItemVLE;
    procedure ItemChange(GPWarning,ItemWarning:boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StartOstForm: TStartOstForm;

implementation

uses ItemEditUnit, ItemListUnit, GlobalData, CheckListUnit, PlanProdUnit;

{$R *.dfm}

var
  ProdLstCode : array of string; //коды элементов, записанных в таблицу остатков ГП
  ItemLstCode : array of string; //коды элементов, записанных в таблицу остатков элемент


procedure TStartOstForm.ItemChange(GPWarning,ItemWarning:boolean);
begin
  if (GPWarning or ItemWarning)and(not self.Showing) then self.Show;
  if GPWarning then GPWarnPn.Visible:=true;
  if ItemWarning then ItemWarnPn.Visible:=true;
end;

procedure TStartOstForm.UpdateGPVLE;
var
  i,ind     : integer;

begin
  GPVLE.Enabled:=false;
  GPVLE.Strings.BeginUpdate;
  GPVLE.Strings.Clear;
  SetLength(ProdLstCode,ProdStartCount.Count);
  for i := 0 to ProdStartCount.Count-1 do begin
    ind:=ItemList.IndFromCode(ProdStartCount.Items[i].code);
    GPVLE.Strings.Add(ItemList.Items[ind].name+
          '='+inttostr(ProdStartCount.Items[i].count));
        ProdLstCode[GPVLE.Strings.Count-1]:=ProdStartCount.Items[i].code;
  end;
  //Удаляем лишнее
  for Ind := 0 to ProdStartCount.Count-1 do
    begin
      i:=0;
      while(i<=high(ProdLstCode))and(ProdLstCode[i]<>ProdStartCount.items[ind].code)do inc(i);
      if(i>high(ProdLstCode))then ProdStartCount.Delete(ProdStartCount.items[ind].code);
    end;
  GPVLE.Strings.EndUpdate;
  GPVLE.Enabled:=(GPVLE.Strings.Count>0);
end;

procedure TStartOstForm.UpdateItemVLE;
var
  i : integer;
begin
  ItemVLE.Enabled:=false;
  ItemVLE.Strings.BeginUpdate;
  ItemVLE.Strings.Clear;
  SetLength(ItemLstCode,ItemsStartCount.Count);
  for I := 0 to ItemsStartCount.Count-1 do
    begin
      ItemVLE.Strings.Add(ItemList.Items[ItemList.IndFromCode(ItemsStartCount.Items[i].code)].name+
        '='+inttostr(ItemsStartCount.Items[i].count));
      ItemLstCode[ItemVLE.Strings.Count-1]:=ItemsStartCount.Items[i].code;
    end;
  ItemVLE.Strings.EndUpdate;
  ItemVLE.Enabled:=(ItemVLE.Strings.Count>0);
end;

procedure TStartOstForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //сообщаем главному окну о закрыитии формы
  SendMessage(FindWindow('TPlanMainForm',nil),WM_USER+101,0,1);
end;

procedure TStartOstForm.FormCreate(Sender: TObject);
begin
  //позиционирование формы
  self.Left:=0;
  self.Top:=MainPanelButtom+round(screen.WorkAreaHeight*0.01);
  self.Height:=screen.WorkAreaHeight-self.Top-round(screen.WorkAreaHeight*0.01);
  OstFormRight:=self.Left+self.Width;
end;

procedure TStartOstForm.FormShow(Sender: TObject);
begin
  //обновление таблиц
  self.UpdateGPVLE;
  self.UpdateItemVLE;
end;

procedure TStartOstForm.GPAddBtnClick(Sender: TObject);
var
  code : string;
begin
  code:=GetSelectItems('');
  if (Length(code)>0)and(ProdStartCount.Add(code,1)) then
    begin
      self.UpdateGPVLE;
      PlanProdForm.ItemChange(true);
      //Обновление остатков и поставок
      PlanForm.UpdateDelivSG;
      PlanForm.UpdateOstSG;
      //Сообщение о необходимости проверить остатки комплектующих
      self.ItemChange(false,true);
    end;
end;

procedure TStartOstForm.GPDelBtnClick(Sender: TObject);
begin
  if GPVLE.Selection.Top>0 then
    begin
      ProdStartCount.Delete(ProdlstCode[GPVLE.Selection.Top-1]);
      self.UpdateGPVLE;
      //Обновление остатков и поставок
      PlanProdForm.ItemChange(true);
      PlanForm.UpdateDelivSG;
      PlanForm.UpdateOstSG;
      //Сообщение о необходимости проверить остатки комплектующих
      self.ItemChange(false,true);
    end;
end;

procedure TStartOstForm.GPEditBtnClick(Sender: TObject);
var
  ind  : integer;
  code : string;
begin
  if GPVLE.Selection.Top>0 then
    begin
      //определяем папку текущего элемента
      code:=ProdlstCode[GPVLE.Selection.Top-1];
      code:=ItemList.Items[ItemList.IndFromCode(code)].owner;
      ind:=ProdStartCount.IndFromCode(ProdlstCode[GPVLE.Selection.Top-1]);
      code:=GetSelectItems(code);
      if Length(code)>0 then
        begin
          ProdlstCode[GPVLE.Selection.Top-1]:=code;
          ProdStartCount.Items[ind].code:=code;
          self.UpdateGPVLE;
          PlanProdForm.ItemChange(true);
          //Обновление остатков и поставок
          PlanForm.UpdateDelivSG;
          PlanForm.UpdateOstSG;
          //Сообщение о необходимости проверить остатки комплектующих
          self.ItemChange(false,true);
       end;
    end;
end;

procedure TStartOstForm.GPVLEKeyPress(Sender: TObject; var Key: Char);
begin
  if not ((Key in ['0'..'9'])or(ord(key)=8)or(ord(key)=13)) then Key:=chr(0);
end;

procedure TStartOstForm.GPVLESetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
var
  code:string;
  ind : integer;
begin
  if GPVLE.Enabled then begin
    if ((ARow-1)<=high(ProdLstCode)) then code:=ProdLstCode[ARow-1] else code:='';
    if Length(code)>0 then
      begin
        ind:=ProdStartCount.IndFromCode(code);
        if(ind>=0)then if(Length(value)=0)then ProdStartCount.Items[ind].count:=0 else ProdStartCount.Items[ind].count:=StrToInt(value);
      end;
    //Обновление остатков и поставок
    PlanForm.UpdateOstSG;
    PlanForm.UpdateDelivSG;
  end;
end;

procedure TStartOstForm.GPVLEStringsChange(Sender: TObject);
begin
  //скрывваем информационную панель
  if GPWarnPN.Visible then GPWarnPN.Visible:=false;
end;

procedure TStartOstForm.itemLstEditBtnClick(Sender: TObject);
var
  list,check : TstringList;
  pi,i,j,k : integer;
begin
  //составляем список всех комплектующих входящих в состав всей
  //отобранной в остатки готовой продукции
  list:=TStringList.Create;
  //идем по списку остатков готовой продукции
  for I := 0 to ProdStartCount.Count - 1 do
    begin
      pi:=ItemList.IndFromCode(ProdStartCount.Items[i].code);
      //идем по комплекту каждого элемента
      for j := 0 to ItemList.Items[pi].SubItems.Count - 1 do
        begin
          //проверяем, не записана ли уже деталь в список
          k:=0;
          while(k<list.Count)and(list.ValueFromIndex[k]<>ItemList.Items[pi].SubItems.Items[j].code)do inc(k);
          //если не записанна - добавляем в список
          if (k=list.Count) then
            list.Add(ItemList.Items[itemlist.IndFromCode(ItemList.Items[pi].SubItems.Items[j].code)].name
              +'='+ItemList.Items[pi].SubItems.Items[j].code);
        end;
    end;
  //составляем список уже выбранных позиций
  check:=TstringList.Create;
  for I := 0 to ItemsStartCount.Count - 1 do check.Add(ItemsStartCount.Items[i].code);

  if CheckList('для таблицы остатков:',list,check) then
    begin
      //добавляем новые
      for I := 0 to check.Count - 1 do
        begin
          j:=0;
          while(j<ItemsStartCount.Count)and(ItemsStartCount.Items[j].code<>check[i])do inc(j);
          if (j=ItemsStartCount.Count) then ItemsStartCount.Add(check[i],1);
        end;
      //удаляем отсутствующие
      I := 0;
      while(i<ItemsStartCount.Count) do
        begin
          j:=0;
          while(j<check.Count)and(ItemsStartCount.Items[i].code<>check[j])do inc(j);
          if(j=check.Count)then ItemsStartCount.Delete(ItemsStartCount.Items[i].code);
          inc(i);
        end;
      //обновляем визуальные элементы
      self.UpdateItemVLE;
      //Обновление остатков и поставок
      PlanForm.UpdateDelivSG;
      PlanForm.UpdateOstSG;
    end;
  list.Free;
  check.Free;
  self.ItemWarnPn.Visible:=false;
end;

procedure TStartOstForm.ItemVLESetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
var
  code:string;
  ind : integer;
begin
  if ItemVLE.Enabled then begin
    if ((ARow-1)<=high(ItemLstCode)) then code:=ItemLstCode[ARow-1] else code:='';
    if Length(code)>0 then
      begin
        ind:=ItemsStartCount.IndFromCode(code);
        if ind>=0 then if Length(value)=0 then ItemsStartCount.Items[ind].count:=0 else ItemsStartCount.Items[ind].count:=StrToInt(value);
      end;
    //Обновление остатков и поставок
    PlanForm.UpdateDelivSG;
    PlanForm.UpdateOstSG;
  end;
end;

procedure TStartOstForm.ItemVLEStringsChange(Sender: TObject);
begin
  //скрывваем информационную панель
  if ItemWarnPN.Visible then ItemWarnPN.Visible:=false;
end;

end.
