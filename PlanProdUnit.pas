unit PlanProdUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, ActnList, StdActns, Menus;

type
  TPlanProdForm = class(TForm)
    PPWarningPn: TPanel;
    PPWarningLB: TLabel;
    SG: TStringGrid;
    ActionLst: TActionList;
    EditCopy: TEditCopy;
    EditPaste: TEditPaste;
    EditCut: TEditCut;
    PopMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    MoveLeft: TAction;
    N5: TMenuItem;
    LoadPlane: TAction;
    OpenDlg: TOpenDialog;
    LoadPlane1: TMenuItem;
    CountPN: TPanel;
    procedure SGDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure FormResize(Sender: TObject);
    procedure SGMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SGMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SGMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LoadPlaneExecute(Sender: TObject);
    procedure MoveLeftExecute(Sender: TObject);
    procedure PopMenuPopup(Sender: TObject);
    procedure EditCutExecute(Sender: TObject);
    procedure EditPasteExecute(Sender: TObject);
    procedure EditCopyExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SGSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure SGSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SGKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure PPWarningLBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ItemChange(warning:boolean);
    function  PlanProdValue(ItemCode:string;Prd:integer):integer;
    procedure SetPlanProdValue(ItemCode:string;Prd:integer;value:integer);
    function  MinOst(code: string; prd : integer):integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PlanProdForm: TPlanProdForm;

implementation

{$R *.dfm}

uses Clipbrd, GlobalData, DateUtils,ItemEditUnit;

var
  SelRect : TGridRect;


function TPlanProdForm.MinOst(code: string; prd : integer):integer;
var
  i,ind,cnt : integer;
begin
  //ищем всю готовую продукцию в которую входит текущая деталь
  cnt:=0;
  for I := 0 to ProdStartCount.Count-1 do
    begin
      ind:=ItemList.IndFromCode(ProdStartCount.Items[i].code);
      if (ind>-1)and(ItemList.Items[ind].SubItems.CountFromCode(code)>0) then cnt:=cnt+
        self.PlanProdValue(ProdStartCount.Items[i].code,prd);
    end;
  result:=round(cnt*ProdMinOst/100);
end;

procedure TPlanProdForm.MoveLeftExecute(Sender: TObject);
var
  c,r : integer;
begin
  if MessageDLG('Данные в таблице будут сдвинуты на один период влево.'+chr(13)+
    'Отменить изменения будет невозможно!',mtWarning,[mbOk,mbCancel],0)=mrOK then
    begin
      for c := 1 to SG.ColCount - 2 do
        for r := 1 to SG.RowCount - 1 do
          SG.Cells[c,r]:=SG.Cells[c+1,r];
      for r := 1 to SG.RowCount - 1 do SG.Cells[SG.ColCount-1,r]:='';
      //скрывваем информационную панель
      if PPWarningPN.Visible then PPWarningPN.Visible:=false;
      //Обновление остатков и поставок
      PlanForm.UpdateOstSG;
      PlanForm.UpdateDelivSG;
    end;
end;

procedure TPlanProdForm.EditCopyExecute(Sender: TObject);
var
  S: string;
  GRect: TGridRect;
  C, R: Integer;
begin
  GRect := self.SG.Selection;
  S  := '';
  for R := GRect.Top to GRect.Bottom do
  begin
    for C := GRect.Left to GRect.Right do
    begin
      if C = GRect.Right then S := S + (SG.Cells[C, R])
      else
        S := S + SG.Cells[C, R] + #9;
    end;
    S := S + #13#10;
  end;
  ClipBoard.AsText := S;
end;

procedure TPlanProdForm.EditCutExecute(Sender: TObject);
var
  S: string;
  GRect: TGridRect;
  C, R: Integer;
begin
  GRect := self.SG.Selection;
  S  := '';
  for R := GRect.Top to GRect.Bottom do
  begin
    for C := GRect.Left to GRect.Right do
    begin
      if C = GRect.Right then S := S + (SG.Cells[C, R])
        else S := S + SG.Cells[C, R] + #9;
      SG.Cells[C, R]:='';
    end;
    S := S + #13#10;
  end;
  ClipBoard.AsText := S;
  //скрывваем информационную панель
  if PPWarningPN.Visible then PPWarningPN.Visible:=false;
  //Обновление остатков и поставок
  PlanForm.UpdateOstSG;
  PlanForm.UpdateDelivSG;
end;

procedure TPlanProdForm.EditPasteExecute(Sender: TObject);
var
  S, CS, F: string;
  L, R, C: Byte;
begin
  L := sg.Selection.Left;
  R := sg.Selection.Top;
  S := ClipBoard.AsText;
  R :=R-1;
  while (Pos(#13, S)>0)and(R<SG.RowCount) do
  begin
    R  := R + 1;
    C  := L - 1;
    CS := Copy(S, 1,Pos(#13, S));
    while (Pos(#9,CS)>0)and(C<SG.ColCount) do
    begin
      C := C + 1;
      SG.Cells[C,R]:=Copy(CS,1,Pos(#9,CS) - 1);
      F := Copy(CS, 1,Pos(#9, CS) - 1);
      Delete(CS, 1,Pos(#9, CS));
    end;
    SG.Cells[C + 1,R] := Copy(CS, 1,Pos(#13, CS) - 1);
    Delete(S, 1,Pos(#13, S));
    if Copy(S, 1,1) = #10 then Delete(S, 1,1);
    //скрывваем информационную панель
    if PPWarningPN.Visible then PPWarningPN.Visible:=false;
    //Обновление остатков и поставок
    PlanForm.UpdateOstSG;
    PlanForm.UpdateDelivSG;
  end;
end;

procedure TPlanProdForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if self.WindowState=wsMaximized then begin
    self.WindowState:=wsNormal;
    Action:=caNone;
  end else
    //сообщаем главному окну о закрыитии формы
    SendMessage(FindWindow('TPlanMainForm',nil),WM_USER+101,0,2);
end;

procedure TPlanProdForm.FormCreate(Sender: TObject);
begin
  //позиционирование формы
  self.Left:=OstFormRight+round(screen.WorkAreaWidth*0.005);
  self.Top:=MainPanelButtom+round(screen.WorkAreaHeight*0.01);
  self.Width:=screen.WorkAreaWidth-self.Left;
  PlanProdFormBottom :=self.Top+self.Height;
end;

procedure TPlanProdForm.FormResize(Sender: TObject);
begin
  CountPn.Left:=SG.Left+SG.ClientWidth-CountPn.Width-5;
  CountPn.Top:=SG.Top+SG.Height-CountPn.Height-5;
end;

function  TPlanProdForm.PlanProdValue(ItemCode:string;Prd:integer):integer;
var
  rowind : integer;
  str    : string;
begin
  rowind:=ProdStartCount.IndFromCode(ItemCode)+1;
  str:=SG.Cells[Prd+1,rowind];
  if length(str)>0 then result:=StrToInt(str) else result:=0;
end;

procedure TPlanProdForm.PopMenuPopup(Sender: TObject);
begin
  self.EditCopy.Enabled  :=(SG.Selection.top>-1);
  self.EditCut.Enabled   :=(SG.Selection.Top>-1);
  self.EditPaste.Enabled :=(Length(Clipboard.AsText)>0);
end;

procedure TPlanProdForm.SetPlanProdValue(ItemCode:string;Prd:integer;value:integer);
var
  rowind : integer;
begin
  rowind:=ProdStartCount.IndFromCode(ItemCode)+1;
  SG.Cells[Prd+1,rowind]:=IntToStr(value);
end;

procedure TPlanProdForm.FormShow(Sender: TObject);
begin
  SelRect.Left:=-1;
  SelRect.Top:=-1;
  self.ItemChange(false);
  CountPN.Caption:='Сумма: 0';
end;

procedure TPlanProdForm.ItemChange(warning:boolean);
var
  PrdCnt,i,ind : integer;

begin
  PrdCnt:=PlanForm.GetPrdCount;
  SG.ColCount:=PrdCnt+1;
  if ProdStartCount.Count=0 then
    begin
      SG.RowCount:=2;
      SG.Rows[1].Clear;
      SG.Enabled:=false;
    end else begin
      SG.Enabled:=true;
      SG.RowCount:=ProdStartCount.Count+1;
    end;
  //Заголовки столбцов
  SG.Cells[0,0]:=' Изделие';
  //заголовки столбцов
  for I := 0 to PrdCnt - 1 do
    if DatePrd=prdDay then SG.Cells[i+1,0]:=FormatDateTime('dd.mm',PlanForm.GetPrdStartDate(i))
      else SG.Cells[i+1,0]:=' '+FormatDateTime('dd',PlanForm.GetPrdStartDate(i))+'-'
        +FormatDateTime('dd.mm',IncDay(PlanForm.GetPrdStartDate(i+1),-1));
  //Списокизделий
  for i := 0 to ProdStartCount.Count-1 do begin
    ind:=ItemList.IndFromCode(ProdStartCount.Items[i].code);
    SG.Cells[0,i+1]:=ItemList.Items[ind].name;
  end;
  //панель информирования об изменении данных
  if warning then
    begin
      if not self.Showing then self.Show;
      PPWarningPN.Visible:=true;
    end;
end;

procedure TPlanProdForm.LoadPlaneExecute(Sender: TObject);
var
  Strs            : TStringList;
  str,code,substr : string;
  i,j,ACol,ARow   : integer;
  cnt             : real;
  dt              : Tdate;
  Dates           : array of TDateTime;
  Count           : array of integer;

function DeleteFrom(s:string;ch:char;ps:integer):string;
var
  ind : integer;
begin
  ind:=1;
  while(pos(ch,s)<>0)and(ind<=ps)do begin
    s:=copy(s,pos(ch,s)+1,MaxInt);
    inc(ind);
  end;
  result:=s;
end;

begin
  if (MessageDLG('Отмена сделанных изменений будет невозможна.'+chr(13)+
    'Продолжить?',mtWarning,[mbYes,mbNo],0)=mrYes)and(OpenDlg.Execute) then
    begin
      //Очищаем таблицу
      for ARow := 1 to SG.RowCount-1 do
        for ACol :=1 to SG.ColCount-1 do SG.Cells[ACol,Arow]:='0';
      //
      Strs:=TStringList.Create;
      Strs.LoadFromFile(OpenDlg.FileName);
      //Записываем даты
      str:=Strs[0];
      str:=DeleteFrom(str,chr(9),8);
      delete(str,1,pos(chr(9),str));
      str:=DeleteFrom(str,chr(9),1);
      j:=0;
      while (pos(chr(9),str)<>0) do begin
        substr:=copy(str,1,pos(chr(9),str)-1);
        if length(substr)>0 then begin
          inc(j);
          SetLength(Dates,j);
          Dates[j-1]:=StrToDate(substr);
          if DayOfTheMonth(Dates[j-1])=15 then Dates[j-1]:=Dates[j-1]+1;
          end;
        delete(str,1,pos(chr(9),str));
        str:=DeleteFrom(str,chr(9),1);
        end;
      SetLength(Dates,j+1);
      Dates[j]:=StartOfTheYear(IncYear(now));
      SetLength(Count,j);
      //Записываем количества нужных деталей
      for I := 1 to Strs.Count - 1 do
        begin
          str:=strs[i];
          //Выделяем код 1С
          code:=copy(str,1,pos(chr(9),str)-1);
          delete(str,1,pos(chr(9),str));
          //Ищем совпадение кода 1С с кодами в списке номеклатуры
          ARow:=ProdStartCount.IndFromCode(code);
          //если совпадений нет - ищем совпадения в описании номеклатуры
          if (ARow=-1)and(Length(code)>0) then begin
            j:=0;
            while(j<ProdStartCount.Count)and(ItemList.Items[ItemList.IndFromCode(ProdStartCount.Items[j].code)].note<>code)do inc(j);
            if(j<ProdStartCount.Count)and(ItemList.Items[ItemList.IndFromCode(ProdStartCount.Items[j].code)].note=code)then ARow:=j;
            end;
          //Записываем данные в нужную строку таблицы
          if ARow>-1 then begin
            ARow:=ARow+1;
            //выписываем цифры из строки в массив
            str:=DeleteFrom(str,chr(9),9);
            j:=1;
            while (pos(chr(9),str)<>0)and(j<25) do begin
              substr:=copy(str,1,pos(chr(9),str)-1);
              //удаляем лишние пробелы
              while(pos(' ',substr)<>0)do delete(substr,pos(' ',substr),1);
              //записываем цифру
              if Length(substr)>0 then Count[j-1]:=StrToInt(substr) else Count[j-1]:=0;
              //переходим к следующей позиции строки, где должно быть след занчение
              delete(str,1,pos(chr(9),str));
              str:=DeleteFrom(str,chr(9),1);
              inc(j);
              end;
            //распределеям цифры по периодам
            ACol:=1;
            while(ACol<SG.ColCount)do
              begin
                j:=0;
                //если начало изи конец периода входят в диапазон какой либо записанной даты
                while(j<=high(Dates))and(not((PlanForm.GetPrdStartDate(ACol-1)>=Dates[j])and
                  ((PlanForm.GetPrdStartDate(ACol-1)<Dates[j+1])or(j=high(Dates)))))and
                  (not((PlanForm.GetPrdLastDate(ACol-1)>=Dates[j])and
                  ((PlanForm.GetPrdLastDate(ACol-1)<Dates[j+1])or(j=high(Dates)))))do inc(j);
                if(j<=high(Dates))and(((PlanForm.GetPrdStartDate(ACol-1)>=Dates[j])and
                  ((PlanForm.GetPrdStartDate(ACol-1)<Dates[j+1])or(j=high(Dates))))or
                  ((PlanForm.GetPrdLastDate(ACol-1)>=Dates[j])and
                  ((PlanForm.GetPrdLastDate(ACol-1)<Dates[j+1])or(j=high(Dates)))))then
                  case DatePrd of
                    prdDay       : if j<=high(Count)then SG.Cells[ACol,ARow]:=IntToStr(round(Count[j]/(DaysBetween(Dates[j],Dates[j+1]))))
                                    else SG.Cells[ACol,ARow]:='0';
                    prdWeek      : begin
                                    dt:=PlanForm.GetPrdStartDate(ACol-1);
                                    if dt<Dates[j] then dt:=Dates[j];
                                    cnt:=0;
                                    while(dt<=PlanForm.GetPrdLastDate(ACol-1))do
                                      begin
                                        if dt>=Dates[j+1] then inc(j);
                                        if (j+1)<=high(Dates) then
                                          if j<high(Dates) then cnt:=cnt+Count[j]/(DaysBetween(Dates[j],Dates[j+1]))
                                            else cnt:=cnt+Count[j]/15;
                                        dt:=IncDay(dt,1);
                                      end;
                                    SG.Cells[ACol,ARow]:=IntToStr(round(cnt));
                                   end;
                    prdHalfMonth : if j<=high(Count)then SG.Cells[ACol,ARow]:=IntToStr(Count[j]) else SG.Cells[ACol,ARow]:='0';
                    prdMonth     : if j<=high(Count)then begin
                                      if j=high(Dates)then SG.Cells[ACol,ARow]:=IntToStr(Count[j])
                                        else SG.Cells[ACol,ARow]:=IntToStr(Count[j]+Count[j+1]);
                                    end else SG.Cells[ACol,ARow]:='0';
                  end;
                inc(ACol);
              end;
            end;
        end;
      //скрывваем информационную панель
      if PPWarningPN.Visible then PPWarningPN.Visible:=false;
      //Обновление остатков и поставок
      PlanForm.UpdateOstSG;
      PlanForm.UpdateDelivSG;
    end;
end;

procedure TPlanProdForm.PPWarningLBClick(Sender: TObject);
begin
  PPWarningPN.Visible:=false;
end;

procedure TPlanProdForm.SGDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  c,r,cnt : integer;
begin
  //подсчет суммы в выбранных ячейках
  if (SG.Selection.Left>0)and(SG.Selection.Top>0) then
    begin
      cnt:=0;
      for c := SG.Selection.Left to SG.Selection.Right do
        for r := SG.Selection.Top to SG.Selection.Bottom do
          if Length(SG.Cells[c,r])>0 then cnt:=cnt+StrToInt(SG.Cells[c,r]);
      CountPN.Caption:='Сумма: '+IntTOStr(cnt);
    end;
end;

procedure TPlanProdForm.SGKeyPress(Sender: TObject; var Key: Char);
begin
  if not ((Key in ['0'..'9'])or(ord(key)=8)or(ord(key)=13)) then Key:=chr(0);
end;

procedure TPlanProdForm.SGMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SelRect.Left:=SG.MouseCoord(X,Y).X;
  SelRect.Top:=SG.MouseCoord(X,Y).Y;
end;

procedure TPlanProdForm.SGMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  c,r : integer;
begin
  SG.MouseToCell(x,y,c,r);
  if (SelRect.Left>0)and(SelRect.Top>0)and
    (c>0)and(r>0)
    then begin
        SelRect.Right:=c;
        SelRect.Bottom:=r;
        SG.Selection:=SelRect;
      end;
end;

procedure TPlanProdForm.SGMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SelRect.Left:=-1;
  SelRect.Top:=-1;
end;

procedure TPlanProdForm.SGSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if (Arow>0)and(ACol>0) then SG.Options:=SG.Options+[goEditing]
    else SG.Options:=SG.Options-[goEditing];
end;

procedure TPlanProdForm.SGSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  //скрывваем информационную панель
  if PPWarningPN.Visible then PPWarningPN.Visible:=false;
  //Обновление остатков и поставок
  PlanForm.UpdateOstSG;
  PlanForm.UpdateDelivSG;
end;

end.
