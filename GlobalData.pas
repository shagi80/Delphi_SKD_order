unit GlobalData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CountList, Grids, StdCtrls, ExtCtrls, Menus, ImgList, AppEvnts,
  ToolWin, ComCtrls, Buttons;

const
  // периоды планирования
  prdDay        = 1;
  prdWeek       = 2;
  prdHalfMonth  = 3;
  prdMonth      = 4;
  //файл со списком сортировки
  orderfile='orders.txt';

type
  TPlanForm = class(TForm)
    DelivSGMenu: TPopupMenu;
    DelivSGDelMI: TMenuItem;
    DelivSGCutMI: TMenuItem;
    DelivSGCopyMI: TMenuItem;
    DelivSGAddMI: TMenuItem;
    N1: TMenuItem;
    DelivSGPasteMI: TMenuItem;
    ImgLst: TImageList;
    AppEvents: TApplicationEvents;
    MainPN: TPanel;
    OstPn: TPanel;
    StaticText1: TStaticText;
    OstSG: TStringGrid;
    Splitter1: TSplitter;
    DelivPn: TPanel;
    StaticText2: TStaticText;
    DelivSG: TStringGrid;
    Panel1: TPanel;
    Splitter2: TSplitter;
    StaticText3: TStaticText;
    DelivLV: TListView;
    BtnPn: TPanel;
    EditDelivBtn: TSpeedButton;
    DelDelivBtn: TSpeedButton;
    CountPN: TPanel;
    procedure OstSGDblClick(Sender: TObject);
    procedure DelivPnResize(Sender: TObject);
    procedure MainPNClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OstSGMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure OstSGMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DelDelivBtnClick(Sender: TObject);
    procedure DelivLVDblClick(Sender: TObject);
    procedure AppEventsShowHint(var HintStr: string; var CanShow: Boolean;
      var HintInfo: THintInfo);
    procedure DelivSGPasteMIClick(Sender: TObject);
    procedure DelivSGDelMIClick(Sender: TObject);
    procedure DelivSGCutMIClick(Sender: TObject);
    procedure DelivSGAddMIClick(Sender: TObject);
    procedure DelivSGCopyMIClick(Sender: TObject);
    procedure DelivSGMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DelivSGMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DelivSGDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure DelivSGKeyPress(Sender: TObject; var Key: Char);
    procedure OstSGDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function GetStartDate(prd:word):TDateTime;
    function GetLastDate:TDateTime;
    function GetPrdCount:integer;
    function GetPrdStartDate(prd:word):TDateTime;
    function GetPrdLastDate(prd:word):TDateTime;
    procedure SaveDocToFile(fname:string);
    function LoadDocFromFile(fname:string):boolean;
    procedure UpdateOstSG;
    procedure UpdateDelivSG;
    procedure FormResize(Sender: TObject);
    procedure OstSGMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure WMGetMinMaxInfo(var M:TWMGetMinMaxInfo);message WM_GetMinMaxInfo;
  end;

var
  PlanForm: TPlanForm;

  DocFilename   : string;            //имя файла
  ExePath       : string;            //путь к исполняему файлу
  OrderEditProg : string='';         //путь к программе редактирования файлов заказа
  InitFolder    : string;            //текущая дирретория рабоы с файлами

  //период планирования
  DatePrd     : word = prdWeek;      //период планирования
  DateSize    : word = 1;            //длительность планирвоания (месяцев)
  StartDate   : TDateTime;           //стартовая дата
  DatePrdCaption  : array [1..4] of string = ('день','неделя','1/2 месяца','месяц');
  DateSizeCaption : array [1..8] of string = ('1 месяц','2 месяца','3 месяца',
                    '4 месяца','5 месяцев','6 месяцев','7 месяцев','8 месяцев');
  NegativePossible: boolean=false;
  //начальные остатки
  ProdStartCount  : TCountList;  //готовая продукция
  ItemsStartCount : TCountList;  //комплектующие
  ProdMinOst      : integer=0;   //минимальный остаток готовой продуции

  //настройки поставки
  DefTm1 : integer =15;
  DefTm2 : integer =30;
  DefTm3 : integer =7;
  DefTm4 : integer =7;

  //настройки внешнего вида
  MainPanelButtom    : integer;
  OstFormRight       : integer;
  PlanProdFormBottom : integer;


implementation

{$R *.dfm}

uses PlanProdUnit, DelivUnit, DateUtils, ItemEditUnit;

const
  //состояние "буфера обмена"
  cmNone = 0;
  cmCopy = 1;
  cmCut  = 2;

  StateImgInd = 2; //с этого индекса в ImgLst начинаютс рисунки состояния поставки
  ErrorImgInd = 5; //индекс рисунка "поставка вне периода"

var
  MyClipBoard    : ^TDelivery; //буфер обмена
  SelDelivSGCell : TPoint;     //выбранная ячейка таблицы поставок
  ClipMode       : word;       //состояние "буфера обмена"
  SelRect        : TGridRect;  //диапазон выбранных ячеек в какой либо таблице
  DblClk         : boolean = false;

//---- Процедуры работы с датой м периодом -------------------------------------

function TPlanForm.GetLastDate:TDateTime;
begin
  result:=IncMonth(StartDate,DateSize);
  if DatePrd=prdWeek then result:=StartOfTheWeek(result);
  result:=IncDay(result,-1);
end;

function TPlanForm.GetPrdCount:integer;
begin
  result:=0;
  case DatePrd of
    prdDay       : result:=trunc(DaySpan(StartDate,self.GetLastDate));
    prdWeek      : result:=trunc(DaySpan(StartDate,self.GetLastDate)/7);
    prdHalfMonth : result:=DateSize*2;
    prdMonth     : result:=DateSize;
  end;
end;

function TPlanForm.GetStartDate(prd:word):TDateTime;
begin
  result:=Now;
  case Prd of
    prdDay       : result:=StartOfTheDay(Now);
    prdWeek      : result:=StartOfTheWeek(Now);
    prdHalfMonth : if DayOfTheMonth(Now)<15 then result:=StartOfTheMonth(Now)
      else result:=StartOfTheMonth(Now)+15;
    prdMonth     : result:=StartOfTheMonth(Now);
  end;
end;

function TPlanForm.GetPrdStartDate(prd:word):TDateTime;
var
  dt : TDateTime;
begin
  result:=now;
  case DatePrd of
    prdDay  : result:=IncDay(StartDate,prd);
    prdWeek : result:=IncDay(StartDate,prd*7);
    prdHalfMonth : begin
                    dt:=IncDay(StartDate,16*prd);
                    if DayOfTheMonth(dt)<15 then dt:=StartOfTheMonth(dt)else dt:=StartOfTheMonth(dt)+15;
                    result:=dt;
                  end;
    prdMonth     : result:=StartOfTheMonth(IncMonth(StartDate,prd));
  end;
end;

function TPlanForm.GetPrdLastDate(prd:word):TDateTime;
var
  dt : TDateTime;
begin
  result:=now;
  case DatePrd of
    prdDay  : result:=IncDay(StartDate,prd);
    prdWeek : result:=IncDay(StartDate,((prd+1)*7-1));
    prdHalfMonth : begin
                    dt:=IncDay(StartDate,16*(prd+1));
                    if DayOfTheMonth(dt)<15 then dt:=StartOfTheMonth(dt)else dt:=StartOfTheMonth(dt)+15;
                    result:=IncDay(dt,-1);
                  end;
    prdMonth     : result:=IncDay(StartOfTheMonth(IncMonth(StartDate,(prd+1))),-1);
  end;
end;


//----- Обновление таблиц ------------------------------------------------------

procedure TPlanForm.UpdateOstSG;
var
  prd,itm,i,ind : integer;
  ost,negative,prodcnt  : integer;
  deliv         : TIntArray;
  pid           : ^integer;
begin
  OstSG.ColCount:=PlanProdForm.SG.ColCount;
  OstSG.RowCount:=ItemsStartCount.Count+2;
  //Заголовки столбцов
  for i := 0 to PlanProdForm.SG.ColCount-1 do OstSG.Cells[i,0]:=PlanProdForm.SG.Cells[i,0];
  //Заголовки строк
  for i := 0 to ItemsStartCount.Count-1 do OstSG.Cells[0,i+1]:=ItemList.Items[ItemList.IndFromCode(ItemsStartCount.Items[i].code)].name;
  OstSG.Cells[0,OstSG.RowCount-1]:='Поставки:';
  //ячейки
  for prd := 0 to self.GetPrdCount-1 do
    for itm := 0 to ItemsStartCount.Count-1 do
      begin
        if prd=0 then
          begin
            //начальный остаток деталей
            ost:=ItemsStartCount.Items[itm].count;
            //ищем всю готовую продукцию в которую входит текущая деталь
            for I := 0 to ProdStartCount.Count-1 do
              begin
                ind:=ItemList.IndFromCode(ProdStartCount.Items[i].code);
                if ind>-1 then begin
                  ind:=ItemList.Items[ind].SubItems.CountFromCode(ItemsStartCount.Items[itm].code);
                  //определяем начальный остаток с учетом готовой продуции
                  if ind>0 then ost:=ost+ProdStartCount.Items[i].count
                  //вычитаем продажи за 0 период (ind-количество детали в 1 ед гот продукции)
                    -ind*PlanProdForm.PlanProdValue(ProdStartCount.Items[i].code,prd);
                  end;
              end;
          end else begin
            //ищем всю готовую продукцию в которую входит текущая деталь
            prodcnt:=0;
            for I := 0 to ProdStartCount.Count-1 do
              begin
                ind:=ItemList.IndFromCode(ProdStartCount.Items[i].code);
                if ind>-1 then begin
                  ind:=ItemList.Items[ind].SubItems.CountFromCode(ItemsStartCount.Items[itm].code);
                  //вычитаем продажи за текущий период (ind-количество детали в 1 ед гот продукции)
                  if ind>0 then prodcnt:=prodcnt+ind*PlanProdForm.PlanProdValue(ProdStartCount.Items[i].code,prd);
                  end;
              end;
            //остаток за предыдующий период
            ost:=StrToIntDef(OstSG.Cells[prd,itm+1],0);
            //если остатки за предыдущий период записаны как 0/-12345 то считаем долг
            negative:=0;
            if (ost=0)and(OstSG.Objects[prd,itm+1]<>nil) then begin
              pid:=pointer(OstSG.Objects[prd,itm+1]);
              negative:=pid^-prodcnt;
            end else ost:=ost-prodcnt;
          end;
        //добавляем поставки
        ost:=ost+DelivList.SumSendFromPrd(self.GetPrdStartDate(prd),self.GetPrdStartDate(prd+1),
            ItemsStartCount.Items[itm].code);
        OstSG.Cells[prd+1,itm+1]:=IntToStr(ost);
        // Если отрицательные остатки запрещены заменяем на 0/-12345
        if (not NegativePossible)and(ost<=0) then begin
          new(pid);
          if negative=0 then negative:=ost;
          pid^:=negative+DelivList.SumSendFromPrd(self.GetPrdStartDate(prd),self.GetPrdStartDate(prd+1),
            ItemsStartCount.Items[itm].code);
          OstSG.Objects[prd+1,itm+1]:=tobject(pid);
          OstSG.Cells[prd+1,itm+1]:='0/'+IntToStr(pid^);
        end;
      end;
  //установк высоты строк таблицы (кроме последней)
  for I := 1 to OstSG.RowCount - 2 do
    if OstSG.RowHeights[i]<>OstSG.DefaultRowHeight then OstSG.RowHeights[i]:=OstSG.DefaultRowHeight;
  //установка высоты строки "поставки"
  //определяем макс кол-во поставок за каждый период и запоминаем большее
  ind:=0;
  for prd := 0 to self.GetPrdCount - 1 do
    for Itm := 0 to ItemsStartCount.Count - 1 do
      begin
        i:=DelivList.SendFromPrd(self.GetPrdStartDate(prd),self.GetPrdStartDate(prd+1),'',Deliv);
        if ind<i then ind:=i;
      end;
  OstSG.RowHeights[OstSG.RowCount-1]:=ind*OstSG.DefaultRowHeight;
  //сообщаем главному окну об изменениях
  SendMessage(FindWindow('TPlanMainForm',0),WM_USER+102,0,3);
  OstSG.Repaint;
end;

procedure TPlanForm.UpdateDelivSG;
var
  i,j,prd,itm,imgind : integer;
  ind         : TintArray;
  LVItm       : TListItem;
  pind        : ^integer;
  cap         : string;
begin
  DelivSG.ColCount:=OstSG.ColCount;
  DelivSG.RowCount:=ItemsStartCount.Count+2;
  //Заголовки столбцов
  for i := 0 to OstSG.ColCount-1 do DelivSG.Cells[i,0]:=OstSG.Cells[i,0];
  //Заголовки строк
  for i := 0 to ItemsStartCount.Count-1 do DelivSG.Cells[0,i+1]:=ItemList.Items[ItemList.IndFromCode(ItemsStartCount.Items[i].code)].name;
  DelivSG.Cells[0,DelivSG.RowCount-1]:='Поставки:';
  //установка высоты строк
  //определяем максимальное кол-во поставок для соотв элемента за все периоды
  for itm := 0 to ItemsStartCount.Count - 1 do
    begin
      j:=0;
      for prd := 0 to self.GetPrdCount - 1 do
        begin
          i:=DelivList.IndexFromPrd(self.GetPrdStartDate(prd),self.GetPrdStartDate(prd+1),ItemsStartCount.Items[itm].code,ind);
          if j<i then
            begin
              j:=i;
              DelivSG.RowHeights[itm+1]:=j*DelivSG.DefaultRowHeight;
            end;
        end;
      if j=0 then DelivSG.RowHeights[itm+1]:=DelivSG.DefaultRowHeight;
    end;
  //установка высоты строки "поставки"
  //определяем макс кол-во поставок за каждый период и запоминаем большее
  j:=0;
  for prd := 0 to self.GetPrdCount - 1 do
    for Itm := 0 to ItemsStartCount.Count - 1 do
      begin
        i:=DelivList.IndexFromPrd(self.GetPrdStartDate(prd),self.GetPrdStartDate(prd+1),'',ind);
        if j<i then j:=i;
      end;
  DelivSG.RowHeights[DelivSG.RowCount-1]:=j*DelivSG.DefaultRowHeight;
  //список всех поставок
  DelivLV.Items.Clear;
  for I := 0 to DelivList.Count - 1 do
    begin
      LVItm:=DelivLV.Items.Add;
      LVItm.Caption:=DelivList.Items[i].name+' (отгруз '+DateToStr(DelivList.Items[i].Date)+')';
      new(pind);
      pind^:=i;
      LVItm.Data:=pind;
      if(DelivList.Items[i].state>0)then LVItm.ImageIndex:=StateImgInd+DelivList.Items[i].state-1
        else LVItm.ImageIndex:=-1;
      if (DelivList.Items[i].Date<self.GetPrdStartDate(0))or
        (DelivList.Items[i].Date>self.GetPrdStartDate(self.GetPrdCount)) then LVItm.ImageIndex:=ErrorImgInd;
    end;
    //сортировка поставок в DelivLV по дате
    for j:=0 to DelivLV.Items.Count-2 do
      for i:=0 to DelivLV.Items.Count-j-2 do
        if CompareDate(DelivList.items[integer(DelivLV.Items[i].Data^)].Date,DelivList.items[integer(DelivLV.Items[i+1].Data^)].Date )=1 then
          begin
            cap  :=DelivLV.Items[i].Caption;
            pind:=DelivLV.Items[i].Data;
            imgind:=DelivLV.Items[i].ImageIndex;
            DelivLV.Items[i]:=DelivLV.Items[i+1];
            DelivLV.Items[i+1].Caption:=cap;
            DelivLV.Items[i+1].Data:=pind;
            DelivLV.Items[i+1].ImageIndex:=imgind;
          end;
  //перерисовка
  DelivSG.Repaint;
end;

//---- Всплывающее меню --------------------------------------------------------

procedure TPlanForm.DelivSGAddMIClick(Sender: TObject);
var
  code      : string;
begin
  if(SelDelivSGCell.Y<(DelivSG.RowCount-1))then code:=ItemsStartCount.Items[SelDelivSGCell.Y-1].code else code:='';
  if ShowDelivery(-1,SelDelivSGCell.X-1,code) then
    begin
      self.UpdateDelivSG;
      self.UpdateOstSG;
    end;
end;

procedure TPlanForm.DelivSGCopyMIClick(Sender: TObject);
begin
  ClipMode:=cmCopy;
  DelivSG.Repaint;
end;

procedure TPlanForm.DelivSGCutMIClick(Sender: TObject);
begin
  ClipMode:=cmCut;
  DelivSG.Repaint;
end;

procedure TPlanForm.DelivSGDelMIClick(Sender: TObject);
begin
  if (MyClipBoard<>nil)and(MessageDLG('Вы действительно хотите удалить поставку "'
    +MyClipBoard^.name+'" ?',mtWarning,[mbOK,mbCancel],0)=mrOk) then
    begin
      DelivList.Delete(MyClipBoard^.name);
      self.UpdateDelivSG;
      self.UpdateOstSG;
    end;
end;

//---- Кнопки панели "Все поставки" --------------------------------------------

procedure TPlanForm.DelDelivBtnClick(Sender: TObject);
var
  pind : ^integer;
begin
  if DelivLV.Selected<>nil then
    begin
      pind:=DelivLV.Selected.Data;
      if MessageDLG('Вы действительно хотите удалить поставку "'
        +DelivList.Items[pind^].name+'" ?',mtWarning,[mbOK,mbCancel],0)=mrOk then
          begin
            DelivList.Delete(DelivList.Items[pind^].name);
            self.UpdateDelivSG;
            self.UpdateOstSG;
          end;
    end;
end;

procedure TPlanForm.DelivLVDblClick(Sender: TObject);
var
  pind : ^integer;
begin
  if DelivLV.Selected<>nil then
    begin
      pind:=DelivLV.Selected.Data;
      if ShowDelivery(pind^) then
        begin
          self.UpdateDelivSG;
          self.UpdateOstSG;
        end;
    end;
end;

procedure TPlanForm.DelivPnResize(Sender: TObject);
begin
  DelivSG.Repaint;
end;

//---- Таблица поставок --------------------------------------------------------

procedure TPlanForm.DelivSGDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  index: TIntArray;
  Flag : Cardinal;
  str  : widestring;
  Rct  : TRect;
  i,cnt: integer;
  bmp  : TBitMap;
begin
  with (Sender as TStringGrid) do
    begin
    //отделяем толстой линией последнюю строку
    canvas.Pen.Width:=2;
    canvas.Pen.Color:=clBlack;
    rct:=CellRect(0,RowCount-1);
    canvas.MoveTo(0,rct.Top-1);
    canvas.LineTo(ClientWidth,rct.Top-1);
    canvas.Pen.Width:=1;
    //отриосвываем ячейки
    if (ARow>0)and(Acol>0)then
      begin
        Canvas.Brush.Color:=clWhite;
        Canvas.FillRect(Rect);
        Flag := DT_LEFT;
        //определяем кол-во подстрок в ячейке
        //для последний строки это общее кол-во поставок за период
        //для строк элементов - количество поставок для ссотв позиции
        if ((RowCount-1)=ARow)then DelivList.IndexFromPrd(self.GetPrdStartDate(ACol-1),self.GetPrdStartDate(ACol),'',index)
          else DelivList.IndexFromPrd(self.GetPrdStartDate(ACol-1),self.GetPrdStartDate(ACol),itemsStartCount.Items[ARow-1].code,index);
        for I := 0 to high(index) do
          begin
            //определяем выводимую инфорамацию
            //в последней строке это имя поставки
            if ((RowCount-1)=ARow)then str:=DelivList.Items[index[i]].name
              else begin
            //в других строках - кол-во в данной поставке
                cnt:=DelivList.Items[index[i]].Items.CountFromCode(ItemsStartCount.Items[ARow-1].code);
                if cnt>0 then str:=IntToStr(cnt) else str:='';
              end;
            if Length(str)>0 then
              begin
                //определяем прямоугольник вывода
                Rct:=Rect;
                Inc(Rct.Left,1);
                Inc(Rct.Right,1);
                //Высота прямоугольника это высота строке / кол-во поставок в стрке
                cnt:=round(DelivSG.RowHeights[ARow]/(high(index)+1));
                Rct.Top:=rect.Top+cnt*i+1;
                Rct.Bottom:=RCt.Top+cnt-1;
                Canvas.Brush.Color:=DelivList.Items[index[i]].color;
                Canvas.Rectangle(rct);
                Inc(Rct.Left,2);
                Inc(Rct.Top,2);
                Canvas.Pen.Color:=clBlack;
                DrawTextW((Sender as TStringGrid).Canvas.Handle,PWideChar(str),length(str),Rct,Flag);
                //Значек состояния заказа
                bmp:=TbitMap.Create;
                if (clipmode<>cmNone)and(DelivList.items[index[i]].name=MyClipBoard^.name) then
                  begin
                    if clipmode=cmCopy then ImgLst.GetBitmap(0,bmp);
                    if clipmode=cmCut  then ImgLst.GetBitmap(1,bmp);
                  end else
                    if(DelivList.items[index[i]].state>0) then
                      ImgLst.GetBitmap(DelivList.items[index[i]].state+StateImgInd-1,bmp);
                if bmp<>nil then
                  begin
                    Canvas.Draw(rct.Right-bmp.Width-2,rct.Top-1,bmp);
                    Canvas.Brush.Style:=bsClear;
                    Canvas.Rectangle(rct.Right-bmp.Width-2,rct.Top-1,rct.Right-2,rct.Top+bmp.Height-1);
                  end;
              end;
          end;
      end;
    end;
end;

procedure TPlanForm.DelivSGKeyPress(Sender: TObject; var Key: Char);
begin
  if not ((Key in ['0'..'9'])or(ord(key)=8)or(ord(key)=13)) then Key:=chr(0);
end;

procedure TPlanForm.DelivSGMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ACol,ARow,i,ind : integer;
  code        : string;
  DelivInd    : TIntArray;
  DelivCnt,h,t: integer;
  pnt         : TPoint;
begin
  DelivSG.MouseToCell(X,Y,ACol,ARow);
  if (Acol>0)and(ARow>0) then
  begin
    SelDelivSGCell.X:=ACol;
    SelDelivSGCell.Y:=ARow;
    //определение выбранной поставки
    if ((DelivSG.RowCount-1)=ARow)then DelivCnt:=DelivList.IndexFromPrd(self.GetPrdStartDate(ACol-1),self.GetPrdStartDate(ACol),'',DelivInd)
      else DelivCnt:=DelivList.IndexFromPrd(self.GetPrdStartDate(ACol-1),self.GetPrdStartDate(ACol),itemsStartCount.Items[ARow-1].code,DelivInd);
    ind:=-1;
    if DelivCnt>0 then begin
      i:=0;
      h:=round(DelivSG.RowHeights[ARow]/DelivCnt);
      t:=Y-DelivSG.CellRect(ACol,ARow).Top;
      while(i<DelivCnt)and(not((t>h*i)and(t<((i+1)*h))))do inc(i);
      if(i<DelivCnt)and((t>h*i)and(t<((i+1)*h)))then ind:=DelivInd[i];
      MyClipBoard:=@DelivList.Items[ind];
    end;
    //левая кнопка - добавление или редактирование поставки
    if (Button=mbLeft) then
    begin
    if ind>=0 then
      begin
        if ShowDelivery(ind) then
          begin
            self.UpdateDelivSG;
            self.UpdateOstSG;
          end;
      end else begin
        if(ARow<(DelivSG.RowCount-1))then code:=ItemsStartCount.Items[ARow-1].code else code:='';
        if ShowDelivery(-1,ACol-1,code) then
          begin
            self.UpdateDelivSG;
            self.UpdateOstSG;
          end;
      end;
    end;
    //правая кнопка - всплывающее меню
    if (Button=mbRight) then
    begin
      //настройка пунктов меню
      DelivSGDelMI.Enabled:=(MyClipBoard<>nil);
      DelivSGCopyMI.Enabled:=(MyClipBoard<>nil);
      DelivSGCutMI.Enabled:=(MyClipBoard<>nil);
      DelivSGPasteMI.Enabled:=(ClipMode>cmNone);
      pnt.X:=x;
      pnt.Y:=y;
      pnt:=DelivSG.ClientToScreen(pnt);
      DelivSGMenu.Popup(pnt.x,pnt.y);
    end;
  end;
end;

procedure TPlanForm.DelivSGMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  c,r : integer;
begin
  DelivSG.MouseToCell(x,y,c,r);
  if (c>0)and(r>0) then DelivSG.Cursor:=crHandPoint else DelivSG.Cursor:=crDefault;
end;

procedure TPlanForm.DelivSGPasteMIClick(Sender: TObject);
var
  itm : TDelivery;
  i   : integer;
begin
  if clipmode<>cmNone then
    begin
      if clipmode=cmCut then MyClipBoard^.Date:=PlanForm.GetPrdStartDate(SelDelivSGCell.X-1);
      if clipmode=cmCopy then
        begin
          itm.name:='';
          itm.color:=MyClipBoard^.color;
          itm.Date:=PlanForm.GetPrdStartDate(SelDelivSGCell.X-1);;
          itm.Tm1:=MyClipBoard^.Tm1;
          itm.Tm2:=MyClipBoard^.Tm2;
          itm.Tm3:=MyClipBoard^.Tm3;
          itm.Tm4:=MyClipBoard^.Tm4;
          itm.state:=0;
          itm.Items:=TCountList.Create;
          for I := 0 to MyClipBoard^.Items.Count - 1 do
            itm.Items.Add(MyClipBoard^.Items.Items[i].code,MyClipBoard^.Items.Items[i].count);
          DelivList.AddItem(itm);
        end;
      MyClipBoard:=nil;
      clipmode:=cmNone;
      self.UpdateDelivSG;
      self.UpdateOstSG;
    end;
end;

//----- Процедуры формы --------------------------------------------------------

Procedure TPlanForm.WMGetMinMaxInfo(var M: TWMGetMinMaxInfo);
Begin
  //M.MinMaxInfo^.PTMaxPosition.Y := MainPanelButtom;
end;

procedure TPlanForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if self.WindowState=wsMaximized then begin
    self.WindowState:=wsNormal;
    Action:=caNone;
  end else  //сообщаем главному окну о закрыитии формы
    SendMessage(FindWindow('TPlanMainForm',0),WM_USER+101,0,3);
end;

procedure TPlanForm.FormCreate(Sender: TObject);
begin
  //позиционирование формы
  self.Left:=OstFormRight+round(screen.WorkAreaWidth*0.005);
  self.Top:=PlanProdFormBottom+round(screen.WorkAreaHeight*0.01);
  self.Width:=screen.WorkAreaWidth-self.Left;
  self.Height:=screen.WorkAreaHeight-self.Top-round(screen.WorkAreaHeight*0.01);
end;

procedure TPlanForm.FormResize(Sender: TObject);
begin
//  CountPn.Left:=OstSG.Left+OstSG.ClientWidth-CountPn.Width-5;
//  CountPn.Top:=OstSG.Top+OstSG.Height-CountPn.Height-5;
end;

procedure TPlanForm.FormShow(Sender: TObject);
begin
  //очистка буфера обмена
  MyClipBoard:=nil;
  ClipMode:=cmNone;
  //обновление таблиц
  self.UpdateOstSG;
  self.UpdateDelivSG;
  SelRect.Left:=-1;
  SelRect.top:=-1;
  CountPN.Caption:='Сумма: 0';
end;

procedure TPlanForm.AppEventsShowHint(var HintStr: string; var CanShow: Boolean;
  var HintInfo: THintInfo);
var
  ACol,ARow,i,ind : integer;
  str             : string;
  DelivInd        : TIntArray;
  DelivCnt,h,t    : integer;
begin
  if HintInfo.HintControl.Name='OstSG' then
    begin
      OstSG.MouseToCell(HintInfo.CursorPos.X,HintInfo.CursorPos.Y,ACol,ARow);
      str:='Таблица остатков.'+chr(13);
      str:=str+'Выбор ячейки позволит добавить поставку'+chr(13);
      str:=str+'с отгрузкой в соответствующем периоде';
      if (Acol>0)and(ARow=(OstSG.RowCount-1)) then
        begin
          //определение выбранной поставки
          DelivCnt:=DelivList.SendFromPrd(self.GetPrdStartDate(ACol-1),self.GetPrdStartDate(ACol),'',DelivInd);
          ind:=-1;
          if DelivCnt>0 then begin
            i:=0;
            h:=round(OstSG.RowHeights[ARow]/DelivCnt);
            t:=HintInfo.CursorPos.Y-OstSG.CellRect(ACol,ARow).Top;
            while(i<DelivCnt)and(not((t>h*i)and(t<((i+1)*h))))do inc(i);
            if(i<DelivCnt)and((t>h*i)and(t<((i+1)*h)))then ind:=DelivInd[i];
          end;
          if ind>=0 then
            begin
              Str:='';
              if Length(DelivList.Items[ind].note)>0 then Str:=DelivList.Items[ind].note+chr(13);
              Str:=Str+'Дата отгрузки: '+DateToStr(DelivList.Items[ind].Date)+chr(13)+
                'Прибытие в порт: '+DateToStr(IncDay(DelivList.Items[ind].Date,DelivList.Items[ind].Tm2));
              for I := 0 to DelivList.Items[ind].Items.Count - 1 do
                str:=str+chr(13)+ItemList.Items[ItemList.IndFromCode(DelivList.Items[ind].Items.Items[i].code)].name
                  +' = '+IntToStr(DelivList.Items[ind].Items.Items[i].count);
            end;
        end;
      HintStr:=str;
      HintInfo.ReshowTimeout:=0;
      HintInfo.HideTimeout:=5000;
    end;
  if HintInfo.HintControl.Name='DelivSG' then
    begin
      OstSG.MouseToCell(HintInfo.CursorPos.X,HintInfo.CursorPos.Y,ACol,ARow);
      str:='План поставок.'+chr(13);
      str:=str+'Щелчек левой кнопкой мыши позволит добавить поставку,'+chr(13);
      str:=str+'правой - редактировать, копировать или удалить выбранную.';
      HintStr:=str;
      HintInfo.ReshowTimeout:=0;
      HintInfo.HideTimeout:=5000;
    end;
end;

//---- Сохрание/открытие файла -------------------------------------------------

procedure TPlanForm.SaveDocToFile(fname:string);
var
  f           : TFileStream;
  i,j,cnt,val : integer;
  str         : shortstring;
begin
  //
  f:=TFileStream.Create(fname,fmCreate or fmShareDenyRead);
  try
    //период
    f.Write(DatePrd,sizeof(word));
    f.Write(DateSize,sizeof(word));
    f.Write(StartDate,sizeof(TDateTime));
    f.Write(ProdStartCount.Count,sizeof(integer));
    //остатки готовой продукции
    for I := 0 to ProdStartCount.Count - 1 do
      f.Write(ProdStartCount.Items[i],sizeof(TCountRec));
    //остатки компелектующих
    f.Write(ItemsStartCount.Count,sizeof(integer));
    for I := 0 to ItemsStartCount.Count - 1 do
      f.Write(ItemsStartCount.Items[i],sizeof(TCountRec));
    //план продаж
    cnt:=self.GetPrdCount;
    for I := 0 to cnt - 1 do
      for j := 0 to ProdStartCount.Count - 1 do
        begin
          val:=PlanProdForm.PlanProdValue(ProdStartCount.Items[j].code,i);
          f.Write(val,sizeof(integer));
        end;
    //поставки
    f.Write(DelivList.count,sizeof(integer));
    for I := 0 to DelivList.Count - 1 do
      begin
        str:=DelivList.Items[i].name;
        f.Write(str,sizeof(shortstring));
        str:=DelivList.Items[i].note;
        f.Write(str,sizeof(shortstring));
        cnt:=Length(DelivList.Items[i].Fname);
        f.Write(cnt,sizeof(integer));
        for j := 1 to cnt do f.Write(DelivList.Items[i].Fname[j],sizeof(char));
        f.Write(DelivList.Items[i].color,sizeof(TColor));
        f.Write(DelivList.Items[i].Tm1,sizeof(TDateTime));
        f.Write(DelivList.Items[i].Tm2,sizeof(TDateTime));
        f.Write(DelivList.Items[i].Tm3,sizeof(TDateTime));
        f.Write(DelivList.Items[i].Tm4,sizeof(TDateTime));
        f.Write(DelivList.Items[i].Date,sizeof(TDateTime));
        f.Write(DelivList.Items[i].state,sizeof(word));
        f.Write(DelivList.Items[i].Items.Count,sizeof(integer));
        for j := 0 to DelivList.Items[i].Items.Count - 1 do
          f.Write(DelivList.Items[i].Items.Items[j],sizeof(TCountRec));
      end;
  finally
    f.Free;
  end;
end;

function TPlanForm.LoadDocFromFile(fname:string):boolean;
var
  f           : TFileStream;
  i,j,cnt,val : integer;
  prodcnt     : integer;
  CntRec      : TCountRec;
  DelivItm    : TDelivery;
  str         : shortstring;
  ch          : char;
begin
  //
  result:=false;
  f:=TFileStream.Create(fname,fmOpenRead or fmShareDenyRead);
  try
    f.read(DatePrd,sizeof(word));
    f.read(DateSize,sizeof(word));
    f.read(StartDate,sizeof(TDateTime));
    f.read(prodcnt,sizeof(integer));
    ProdStartCount.Count:=prodcnt;
    SetLength(ProdStartCount.Items,ProdStartCount.Count);
    for I := 0 to prodcnt - 1 do
      begin
        f.Read(cntrec,sizeof(TCountRec));
        ProdStartCount.Items[i]:=cntrec;
      end;
    f.read(cnt,sizeof(integer));
    ItemsStartCount.Count:=cnt;
    SetLength(ItemsStartCount.Items,ItemsStartCount.Count);
    for I := 0 to cnt - 1 do
      begin
        f.Read(cntrec,sizeof(TCountRec));
        ItemsStartCount.Items[i]:=cntrec;
      end;
    cnt:=self.GetPrdCount;
    for I := 0 to cnt - 1 do
      for j := 0 to Prodcnt - 1 do
        begin
          f.Read(val,sizeof(integer));
          PlanProdForm.SetPlanProdValue(ProdStartCount.Items[j].code,i,val);
        end;
    //поставки
    while DelivList.count>0 do DelivList.Delete(DelivList.Items[0].name);
    f.Read(cnt,sizeof(integer));
    for I := 0 to cnt - 1 do
      begin
        f.Read(str,sizeof(shortstring));
        DelivItm.name:=str;
        f.Read(str,sizeof(shortstring));
        DelivItm.note:=str;
        f.Read(cnt,sizeof(integer));
        DelivItm.fname:='';
        for j := 0 to cnt - 1 do
          begin
            f.Read(ch,sizeof(char));
            DelivItm.fname:=DelivItm.fname+ch;
          end;
        f.Read(DelivItm.color,sizeof(TColor));
        f.Read(DelivItm.Tm1,sizeof(TDateTime));
        f.Read(DelivItm.Tm2,sizeof(TDateTime));
        f.Read(DelivItm.Tm3,sizeof(TDateTime));
        f.Read(DelivItm.Tm4,sizeof(TDateTime));
        f.Read(DelivItm.date,sizeof(TDateTime));
        f.Read(DelivItm.state,sizeof(word));
        f.Read(val,sizeof(integer));
        DelivItm.Items:=TCountList.Create;
        for j := 0 to val - 1 do
          begin
            f.Read(CntRec,sizeof(TCountRec));
            DelivItm.Items.Add(CntRec.code,CntRec.count);
          end;
        DelivList.AddItem(DelivItm);
      end;
    //удаляем записи о деталях. нанайденых в списке номеклатуры
    I := 0;
    while(i<ProdStartCount.Count)do
      begin
        j:=ItemList.IndFromCode(ProdStartCount.Items[i].code);
        if j=-1 then ProdStartCount.Delete(ProdStartCount.Items[i].code) else inc(i);
      end;
    I := 0;
    while(i<ItemsStartCount.Count)do
      begin
        j:=ItemList.IndFromCode(ItemsStartCount.Items[i].code);
        if j=-1 then ItemsStartCount.Delete(ItemsStartCount.Items[i].code) else inc(i);
      end;
    i:=0;
    while(i<DelivList.count)do
      begin
        j:=0;
        while(j<DelivList.Items[i].Items.Count)do
          begin
            val:=ItemList.IndFromCode(DelivList.Items[i].Items.Items[j].code);
            if val=-1 then DelivList.Items[i].Items.Delete(DelivList.Items[i].Items.Items[j].code)
              else inc(j);
          end;
        if DelivList.Items[i].Items.Count=0 then DelivList.Delete(DelivList.Items[i].name) else inc(i);
      end;
    ProdStartCount.Sort(ExePath+orderfile);
    result:=true;
  finally
    f.Free;
  end;
end;

procedure TPlanForm.MainPNClick(Sender: TObject);
begin

end;

//---- Таблица остатков --------------------------------------------------------

procedure TPlanForm.OstSGDblClick(Sender: TObject);
var
  ACol,ARow,i,dcnt : integer;
  code             : string;
  dt               : TDateTime;
begin
  ACol:=OstSG.Selection.Left;
  ARow:=OstSG.Selection.Top;
  if ((Acol>0)and(ARow>0)and(ARow<(OstSG.RowCount-1))and
    (MessageDLG('Добавить поставку для пополнения остатков в этом периоде?',mtInformation,[mbYes,mbNo],0)=mrYES)) then
    begin
      code:=ItemsStartCount.Items[ARow-1].code;
      dcnt:=DefTm2+DefTm3+DefTm4;
      //начало текущего периода в таблице остатков
      dt:=self.GetPrdStartDate(ACol-1);
      //необходимая дата отгрузки
      dt:=IncDay(dt,-dcnt);
      //подыскиваем подходящий период отправки
      i:=0;
      while(i<self.GetPrdCount)and(not((self.GetPrdStartDate(i)<=dt)and(self.GetPrdStartDate(i+1)>dt)))do inc(i);
      if(i<self.GetPrdCount)and((self.GetPrdStartDate(i)<=dt)and(self.GetPrdStartDate(i+1)>dt))then
        begin
          if ShowDelivery(-1,i,code) then
            begin
              self.UpdateDelivSG;
              self.UpdateOstSG;
            end;
        end else MessageDLG('Поставка уже невозможна!',mtError,[mbOk],0);
    end; 
  DblClk:=true;
end;

procedure TPlanForm.OstSGDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Flag : Cardinal;
  str  : widestring;
  Rct  : TRect;
  cnt,i: integer;
  bmp  : TBitMap;
  index: TintArray;
  c,r  : integer;
begin
  with (Sender as TStringGrid) do
    begin
      Canvas.Brush.Color:=clWhite;
      if (ACol>0)and(ARow>0)and(ARow<(RowCount-1))then
        begin
          str:=OstSG.Cells[ACol,Arow];
          //если остаток меньше минимального отображаем красным
          if StrToIntDef(str,0)<=PlanProdForm.MinOst(ItemsStartCount.Items[ARow-1].code,ACol-1) then Canvas.Font.Color:=clRed else Canvas.Font.Color:=clBlack;
          //есил выделенный участок - рисуем выделение
          if (ACol<=Selection.Right)and(ACol>=Selection.Left)
            and(ARow<=Selection.Bottom)and(ARow>=Selection.Top)then
              begin
                Canvas.Brush.Color:=clMenuHighLight;
                Canvas.Font.Color:=clWhite;
              end;
          Canvas.FillRect(Rect);
          Rct:=Rect;
          Flag := DT_LEFT;
          Inc(Rct.Left,2);
          Inc(Rct.Top,2);
          //showmessage(inttostr(PlanProdForm.MinOst(ItemsStartCount.Items[ACol-1].code,ARow-1)));
          //если остаток меньше 0 отображаем полужирным
          if StrToIntDef(str,0)<=0 then Canvas.Font.Style:=[fsBold] else Canvas.Font.Style:=[];
          //Canvas.Pen.Color:=clBlack;
          DrawTextW((Sender as TStringGrid).Canvas.Handle,PWideChar(str),length(str),Rct,Flag);
        end;
      if (ACol>0)and(ARow>0)and(ARow=(RowCount-1))then
        begin
          Canvas.Brush.Color:=clWhite;
          Canvas.FillRect(Rect);
          DelivList.SendFromPrd(self.GetPrdStartDate(ACol-1),self.GetPrdStartDate(ACol),'',index);
          for I := 0 to high(index) do
            begin
              //в последней строке это имя поставки
              str:=DelivList.Items[index[i]].name;
              //определяем прямоугольник вывода
              Rct:=Rect;
              Inc(Rct.Left,1);
              Inc(Rct.Right,1);
              //Высота прямоугольника это высота строке / кол-во поставок в стрке
              cnt:=round(OstSG.RowHeights[ARow]/(high(index)+1));
              Rct.Top:=rect.Top+cnt*i+1;
              Rct.Bottom:=RCt.Top+cnt-1;
              Canvas.Brush.Color:=DelivList.Items[index[i]].color;
              Canvas.Rectangle(rct);
              Inc(Rct.Left,2);
              Inc(Rct.Top,2);
              Flag := DT_LEFT;
              Canvas.Pen.Color:=clBlack;
              DrawTextW((Sender as TStringGrid).Canvas.Handle,PWideChar(str),length(str),Rct,Flag);
              //Значек состояния заказа
              bmp:=TbitMap.Create;
              if(DelivList.items[index[i]].state>0) then
                ImgLst.GetBitmap(DelivList.items[index[i]].state+StateImgInd-1,bmp);
              if bmp<>nil then
                begin
                  Canvas.Draw(rct.Right-bmp.Width-2,rct.Top-1,bmp);
                  Canvas.Brush.Style:=bsClear;
                  Canvas.Rectangle(rct.Right-bmp.Width-2,rct.Top-1,rct.Right-2,rct.Top+bmp.Height-1);
                end;
            end;
        end;
      //отделяем толстой линией последнюю строку
      canvas.Pen.Width:=2;
      canvas.Pen.Color:=clBlack;
      rct:=CellRect(0,RowCount-1);
      canvas.MoveTo(0,rct.Top-1);
      canvas.LineTo(ClientWidth,rct.Top-1);
      canvas.Pen.Width:=1;
      //подсчет суммы в выбранных ячейках
      if (Selection.Left>0)and(Selection.Top>0) then
        begin
          cnt:=0;
          for c := Selection.Left to Selection.Right do
            for r := Selection.Top to Selection.Bottom do
              if Length(Cells[c,r])>0 then cnt:=cnt+StrToIntDef(Cells[c,r],0);
          CountPN.Caption:='Сумма: '+IntTOStr(cnt);
        end;
    end;
end;

procedure TPlanForm.OstSGMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if not DblClk then begin
    SelRect.Left:=OstSG.MouseCoord(X,Y).X;
    SelRect.Top:=OstSG.MouseCoord(X,Y).Y;
    end else DblClk:=false;
end;

procedure TPlanForm.OstSGMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  c,r,cnt : integer;
begin
  OstSG.MouseToCell(x,y,c,r);
  if (c>0)and(r>0)and(r<(OstSG.RowCount-1)) then OstSG.Cursor:=crHandPoint else OstSG.Cursor:=crDefault;
  //
  if (r<(OstSG.RowCount-1)) then begin
    if (SelRect.Left>0)and(SelRect.Top>0)and
      (c>0)and(r>0)
      and((SelRect.Right<>SelRect.Left)or(SelRect.Top<>SelRect.Bottom))
      then begin
        SelRect.Right:=c;
        SelRect.Bottom:=r;
        OstSG.Selection:=SelRect;
      end;
    end;
end;

procedure TPlanForm.OstSGMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SelRect.Left:=-1;
  SelRect.Top:=-1;
end;

end.
