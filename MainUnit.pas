unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DateUtils, ActnList, Menus, ComCtrls,
  ToolWin, AppEvnts, frxClass, frxExportODF, frxCross;

const
  WM_MYCLOSE  = WM_USER+101;
  WM_MYCHANGE = WM_USER+102;

type
  TPlanMainForm = class(TForm)
    Panel1: TPanel;
    DateCaption: TLabel;
    MainMenu1: TMainMenu;
    MainActionList: TActionList;
    ShowStartOst: TAction;
    ShowPlanProd: TAction;
    ShowGlobalForm: TAction;
    ViewMI: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    MainTB: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ShowStartOstBtn: TToolButton;
    ShowItemListForm: TAction;
    N1: TMenuItem;
    SaveAs: TAction;
    SaveFile: TAction;
    NewFile: TAction;
    OpenFile: TAction;
    Exit: TAction;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    SaveDlg: TSaveDialog;
    OpenDlg: TOpenDialog;
    Rep: TfrxReport;
    CrossView: TfrxCrossObject;
    ExportODS: TAction;
    ToolButton7: TToolButton;
    PrintPlan: TAction;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    N14: TMenuItem;
    N15: TMenuItem;
    PrintPlanPriview: TAction;
    N16: TMenuItem;
    ShowPlanSetting: TAction;
    N17: TMenuItem;
    DelivOutload: TAction;
    ToolButton10: TToolButton;
    N18: TMenuItem;
    ODS1: TMenuItem;
    N19: TMenuItem;
    frxODSExp: TfrxODSExport;
    N13: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    procedure DelivOutloadExecute(Sender: TObject);
    procedure ShowPlanSettingExecute(Sender: TObject);
    procedure PrintPlanPriviewExecute(Sender: TObject);
    procedure PrintPlanExecute(Sender: TObject);
    procedure RepGetValue(const VarName: string; var Value: Variant);
    procedure RepBeforePrint(Sender: TfrxReportComponent);
    procedure ExportODSExecute(Sender: TObject);
    procedure ExitExecute(Sender: TObject);
    procedure OpenFileExecute(Sender: TObject);
    procedure NewFileExecute(Sender: TObject);
    procedure SaveFileExecute(Sender: TObject);
    procedure SaveAsExecute(Sender: TObject);
    procedure ShowItemListFormExecute(Sender: TObject);
    procedure ViewMIClick(Sender: TObject);
    procedure ShowGlobalFormExecute(Sender: TObject);
    procedure ShowPlanProdExecute(Sender: TObject);
    procedure ShowStartOstExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DateCaptionClick(Sender: TObject);
    procedure DateCaptionMouseLeave(Sender: TObject);
    procedure DateCaptionMouseEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpdateDateCaption;
    procedure MsgFormClose(var msg: TMessage); message WM_MYCLOSE;
    procedure MsgChange(var msg: TMessage); message WM_MYCHANGE;
    function  ShowSaveChangeDlg:TModalResult;
    procedure ClearPlan;
    procedure RepBeforeOutload(Sender: TfrxReportComponent);
    procedure N13Click(Sender: TObject);
    procedure ApplicationEvents1ShowHint(var HintStr: string;
      var CanShow: Boolean; var HintInfo: THintInfo);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PlanMainForm: TPlanMainForm;

implementation

{$R *.dfm}


uses ItemEditUnit, ItemListUnit, CountList, GlobalData, DateUnit, StartOstUnit,
  PlanProdUnit, DelivUnit, SetUnit, StartUnit, OrderUnit;

const
  MainCaption='Планировщик заказов V1.6.';
  
//--------- Создание, открытие, сохранение _------------------------------------

procedure TPlanMainForm.MsgChange(var msg: TMessage);
begin
  self.SaveFile.Enabled:=true;
  msg.Result := 1;
end;

procedure TPlanMainForm.ClearPlan;
begin
  if ProdStartCount<>nil then ProdStartCount.Destroy;
  if ItemsStartCount<>nil then ItemsStartCount.Destroy;
  if DelivList<>nil then DelivList.Destroy;
  ProdStartCount := TCountList.Create;
  ItemsStartCount:= TCountList.Create;
  DelivList      := TDelivList.Create;
  DatePrd        := prdHalfMonth;
  StartDate      := PlanForm.GetStartDate(DatePrd);
  DateSize       := 1;
  ProdMinOst     := 50;
  DocFileName    :='';
  self.Caption   :=MainCaption+' - новый план';
end;

procedure TPlanMainForm.N13Click(Sender: TObject);
begin
  OrderForm.Show;
end;

procedure TPlanMainForm.NewFileExecute(Sender: TObject);
var
  mr : TModalResult;
begin
  mr:=mrNo;
  if self.SaveFile.Enabled then
    begin
      mr:=self.ShowSaveChangeDlg;
      if mr=mrYes then self.SaveFile.Execute;
    end;
  if (mr<>mrCancel)then
    begin
      self.ClearPlan;
      //Обновление параметров периода
      self.UpdateDateCaption;
      //Обновление данных в других формах
      StartOstForm.UpdateGPVLE;
      StartOstForm.UpdateItemVLE;
      PlanProdForm.ItemChange(false);
      PlanForm.UpdateOstSG;
      PlanForm.UpdateDelivSG;
      //Сбрасываем флаги наличия изменений
      self.SaveFile.Enabled:=false;
    end;
end;

procedure TPlanMainForm.OpenFileExecute(Sender: TObject);
var
  mr : TModalResult;
begin
  mr:=mrNo;
  if self.SaveFile.Enabled then
    begin
      mr:=self.ShowSaveChangeDlg;
      if mr=mrYes then self.SaveFile.Execute;
    end;
  OpenDlg.InitialDir:=InitFolder;
  if (mr<>mrCancel)and(OpenDlg.Execute) then
    begin
      DocFilename:=OpenDLG.FileName;
      self.Caption:=MainCaption+' - '+ExtractFilename(DocFileName);
      PlanForm.LoadDocFromFile(DocFileName);
      //сохраниянем текущую дирреторию работы с файлами
      InitFolder:=ExtractFilePath(OpenDLG.FileName);
      SetPlanForm.SaveInitFolder;
      //Обновление параметров периода
      self.UpdateDateCaption;
      //Обновление данных в других формах
      StartOstForm.UpdateGPVLE;
      StartOstForm.UpdateItemVLE;
      PlanProdForm.ItemChange(false);
      PlanForm.UpdateOstSG;
      PlanForm.UpdateDelivSG;
      //Сбрасываем флаги наличия изменений
      self.SaveFile.Enabled:=false;
    end;
end;

procedure TPlanMainForm.SaveAsExecute(Sender: TObject);
begin
  SaveDlg.Title:='Сохраниение плана продаж';
  SaveDlg.Filter:='Планы продаж (*.ppr)|*.ppr';
  SaveDlg.DefaultExt:='ppr';
  SaveDlg.InitialDir:=InitFolder;
  if SaveDlg.Execute then
    begin
      DocFilename:=SaveDLG.FileName;
      self.Caption:=MainCaption+' - '+ExtractFilename(DocFileName);
      InitFolder:=ExtractFilePath(SaveDLG.FileName);
      SetPlanForm.SaveInitFolder;
      self.SaveFileExecute(self);
    end;
end;

procedure TPlanMainForm.SaveFileExecute(Sender: TObject);
begin
  if Length(DocFilename)>0 then
    begin
      PlanForm.SaveDocToFile(DocFileName);
      self.SaveFile.Enabled:=false;
    end else self.SaveAs.Execute;
end;

procedure TPlanMainForm.ExitExecute(Sender: TObject);
begin
  Self.Close;
end;

//-------- Печать и экспорт ----------------------------------------------------

procedure TPlanMainForm.DelivOutloadExecute(Sender: TObject);
begin
  SaveDlg.Title:='Выгрузка графика поставок';
  SaveDlg.Filter:='Файлы ODS (*.ods)|*.ods';
  SaveDlg.DefaultExt:='ods';
  SaveDlg.InitialDir:=InitFolder;
  if SaveDlg.Execute then
    begin
      Rep.LoadFromFile(ExePath+'delivoutload.fr3');
      (Rep.FindObject('Page1')as TFrxReportPage).EndlessHeight:=true;
      (Rep.FindObject('Page1')as TFrxReportPage).EndlessWidth:=true;
      Rep.OnBeforePrint:=self.RepBeforeOutload;
      Rep.PrepareReport(true);
      self.frxODSExp.FileName:=SaveDLG.FileName;
      Rep.Export(self.frxODSExp);
      //сохраниянем текущую дирреторию работы с файлами
      InitFolder:=ExtractFilePath(SaveDLG.FileName);
      SetPlanForm.SaveInitFolder;
    end;
end;

procedure TPlanMainForm.PrintPlanExecute(Sender: TObject);
begin
  Rep.LoadFromFile(ExePath+'mainprint.fr3');
  (Rep.FindObject('Page1')as TFrxReportPage).EndlessHeight:=false;
  (Rep.FindObject('Page1')as TFrxReportPage).EndlessWidth:=false;
  Rep.OnBeforePrint:=self.RepBeforePrint;
  Rep.PrepareReport(true);
  Rep.Print;
end;

procedure TPlanMainForm.PrintPlanPriviewExecute(Sender: TObject);
begin
  Rep.LoadFromFile(ExePath+'mainprint.fr3');
  (Rep.FindObject('Page1')as TFrxReportPage).EndlessHeight:=false;
  (Rep.FindObject('Page1')as TFrxReportPage).EndlessWidth:=false;
  Rep.OnBeforePrint:=self.RepBeforePrint;
  Rep.ShowReport(true);
end;

procedure TPlanMainForm.RepBeforeOutload(Sender: TfrxReportComponent);
var
  i,j,cnt,qty    : integer;
  ARow,ACol      : integer;
  dt             : TDateTime;
  index          : TIntArray;
  Cross          : TfrxCrossView;
  prdstr,datestr : string;
begin
  if sender.Name='DelivCross'then
    begin
      Cross:=(sender as TfrxCrossView);
      for ACol := 0 to PlanForm.GetPrdCount-1 do
        for ARow := 0 to ItemsStartCount.Count - 1 do
          begin
            //определяем общее количество поставок за период
            cnt:=DelivList.IndexFromPrd(PlanForm.GetPrdStartDate(ACol),PlanForm.GetPrdStartDate(ACol+1),'',index);
            if cnt>0 then
              begin
                //сортировка поставок по дате
                for j:=0 to cnt-2 do
                  for i:=0 to cnt-j-2 do
                    if CompareDate(DelivList.items[index[i]].Date,DelivList.items[index[i+1]].Date )=1 then
                      begin
                        dt:=DelivList.items[index[i]].Date;
                        DelivList.items[index[i]].Date:=DelivList.items[index[i+1]].Date;
                        DelivList.items[index[i+1]].Date:=dt;
                      end;
                //индентификатор колонки 1-го уровня - период
                prdstr:=DateToStr(PlanForm.GetPrdStartDate(ACol))+'-'+
                  DateToStr(IncDay(PlanForm.GetPrdStartDate(ACol+1),-1));
                for j:=0 to cnt - 1 do
                  begin
                    //индентификатор колонки 2-го уровня - имя и дата поставки
                    datestr:=DelivList.items[index[j]].name+chr(13)+DateToStr(DelivList.items[index[j]].Date);
                    //количество соотв деталей в поставке
                    qty:=DelivList.items[index[j]].Items.CountFromCode(ItemsStartCount.Items[ARow].code);
                    if qty<0 then qty:=0;
                    Cross.AddValue([ItemList.Items[ItemList.IndFromCode(ItemsStartCount.Items[ARow].code)].name],
                        [prdstr,DateStr],[qty]);
                  end;
              end;
          end;
    end;
end;

procedure TPlanMainForm.RepBeforePrint(Sender: TfrxReportComponent);
var
  i,j,k,cnt,qty : integer;
  index : TIntArray;
  strs  : TstringList;
begin
  if sender.Name='StartOstCross'then
    begin
      k:=1;
      (sender as TfrxCrossView).AddValue([0],[0],[' Наименование']);
      (sender as TfrxCrossView).AddValue([0],[1],[' Количество']);
      for I := 0 to ProdStartCount.Count - 1 do
        begin
          (sender as TfrxCrossView).AddValue([k],[0],[ItemList.Items[ItemList.IndFromCode(ProdStartCount.Items[i].code)].name]);
          (sender as TfrxCrossView).AddValue([k],[1],[ProdStartCount.Items[i].count]);
          inc(k);
        end;
      for I := 0 to ItemsStartCount.Count - 1 do
        begin
          (sender as TfrxCrossView).AddValue([k],[0],[ItemList.Items[ItemList.IndFromCode(ItemsStartCount.Items[i].code)].name]);
          (sender as TfrxCrossView).AddValue([k],[1],[ItemsStartCount.Items[i].count]);
          inc(k);
        end;
    end;
  if sender.Name='OstCross'then
    begin
      //основые ячеки таблицы
      for i := 0 to PlanForm.OstSG.ColCount - 1 do
        for j := 0 to PlanForm.OstSG.RowCount - 2 do
          (sender as TfrxCrossView).AddValue([j],[i],[PlanForm.OstSG.Cells[i,j]]);
      //последняя строка "Поставки"
      k:=PlanForm.OstSG.RowCount-1;
      (sender as TfrxCrossView).AddValue([k],[0],['Поставки:']);
      for j := 1 to PlanForm.OstSG.ColCount - 1 do
        begin
          DelivList.SendFromPrd(PlanForm.GetPrdStartDate(j),PlanForm.GetPrdStartDate(j+1),'',index);
          strs:=TStringList.Create;
          for i := 0 to high(index) do strs.Add(DelivList.Items[index[i]].name);
          (sender as TfrxCrossView).AddValue([k],[j],[strs.Text]);
        end;
    end;
  if sender.Name='PlanCross'then
    begin
      for i := 0 to PlanProdForm.SG.ColCount - 1 do
        for j := 0 to PlanProdForm.SG.RowCount - 1 do
          (sender as TfrxCrossView).AddValue([j],[i],[PlanProdForm.SG.Cells[i,j]]);
    end;
  if sender.Name='DelivCross'then
    begin
      for I := 0 to PlanForm.DelivSG.ColCount - 1 do
          (sender as TfrxCrossView).AddValue([0],[i],[PlanForm.DelivSG.Cells[i,0]]);
      for I := 0 to PlanForm.DelivSG.RowCount - 1 do
          (sender as TfrxCrossView).AddValue([i],[0],[PlanForm.DelivSG.Cells[0,i]]);
      //отриосвываем ячейки
      strs:=TstringList.Create;
      for I := 0 to PlanForm.DelivSG.ColCount-1 do
        for j := 0 to PlanForm.DelivSG.RowCount - 1 do
          if (j>0)and(i>0)then
          begin
            strs.Clear;
            DelivList.IndexFromPrd(PlanForm.GetPrdStartDate(i-1),PlanForm.GetPrdStartDate(i),'',index);
            if (j=(PlanForm.DelivSG.RowCount - 1))then
              begin
                for k := 0 to high(index) do strs.Add(DelivList.Items[index[k]].name);
              end else begin
                cnt:=0;
                for k := 0 to high(index) do
                  begin
                    qty:=DelivList.Items[index[k]].Items.CountFromCode(ItemsStartCount.Items[j-1].code);
                    if qty<0 then qty:=0;
                    cnt:=cnt+qty;
                  end;
                if cnt>0 then strs.Add(IntToStr(cnt)) else strs.Add('');
              end;
            (sender as TfrxCrossView).AddValue([j],[i],[strs.Text])
         end;
    end;
end;

procedure TPlanMainForm.RepGetValue(const VarName: string; var Value: Variant);
begin
  value:='error '+varname;
  if CompareText(VarName,'plancaption')=0 then value:=self.DateCaption.Caption;
end;

procedure TPlanMainForm.ExportODSExecute(Sender: TObject);
begin
  SaveDlg.Title:='Экспорт плана продаж';
  SaveDlg.Filter:='Файлы ODS (*.ods)|*.ods';
  SaveDlg.DefaultExt:='ods';
  SaveDlg.InitialDir:=InitFolder;
  if SaveDlg.Execute then
    begin
      Rep.LoadFromFile(ExePath+'mainprint.fr3');
      (Rep.FindObject('Page1')as TFrxReportPage).EndlessHeight:=true;
      (Rep.FindObject('Page1')as TFrxReportPage).EndlessWidth:=true;
      Rep.OnBeforePrint:=self.RepBeforePrint;
      Rep.PrepareReport(true);
      self.frxODSExp.FileName:=SaveDLG.FileName;
      Rep.Export(self.frxODSExp);
      //сохраниянем текущую дирреторию работы с файлами
      InitFolder:=ExtractFilePath(SaveDLG.FileName);
      SetPlanForm.SaveInitFolder;
    end;
end;

function  TPlanMainForm.ShowSaveChangeDlg:TModalResult;
begin
  result:=MessageDLG('Сохранить изменения в плане?',mtWarning,[mbYes,mbNo,mbCancel],0);
end;

//--------- Редактирование параметров даты -------------------------------------

procedure TPlanMainForm.UpdateDateCaption;
var
  LastDate : TDateTime;
begin
  LastDate:=PlanForm.GetLastDate;
  DateCaption.Caption:='ПЛАН ПОСТАВОК'+chr(13)+'на период с '+
    FormatDateTime('dd mmmm yyyy',StartDate)+' по '+
    FormatDateTime('dd mmmm yyyy',LastDate)+
    ' (скважность '+DatePrdCaption[DatePrd]+')';
end;

procedure TPlanMainForm.DateCaptionClick(Sender: TObject);
begin
  if DateSetting then
    begin
      self.UpdateDateCaption;
      //Показ сообщений в окне остатков о необходимости проверки
      StartOstForm.ItemChange(true,true);
      PlanProdForm.ItemChange(true);
      //Обновление остатков и поставок
      PlanForm.UpdateOstSG;
      PlanForm.UpdateDelivSG;
    end;
end;

procedure TPlanMainForm.DateCaptionMouseEnter(Sender: TObject);
begin
  (Sender as TLabel).Font.Color:=clBlue;
  Screen.Cursor:=crHandPoint;
end;

procedure TPlanMainForm.DateCaptionMouseLeave(Sender: TObject);
begin
  (Sender as TLabel).Font.Color:=clBlack;
  Screen.Cursor:=crDefault;
end;

//--------- Создание, показ, закрытие формы ------------------------------------

procedure TPlanMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  mr : TModalResult;
begin
  if (Self.SaveFile.Enabled) then
    begin
      mr:=self.ShowSaveChangeDlg;
      case mr of
        mrYes    : self.SaveFile.Execute;
        mrCancel : Action:=caNone;
      end;
    end;
end;

procedure TPlanMainForm.FormCreate(Sender: TObject);
begin
  //Позиционирование формы, установка переменных позиционирования
  self.Width:=screen.WorkAreaWidth;
  self.Top:=0;
  self.Left:=0;
  MainPanelButtom:=self.Top+self.Height;
  //Создание списков, инициализация переменных
  ExePath:=ExtractFilePath(application.ExeName);
  SetPlanForm.InitDef;
  //Начальные установки переменных
  ItemList := TItemList.Create;
  if FileExists(ExePath+ItmListFileName)then ItemList.LoadFromFile(ExePath+ItmListFileName);
  self.ClearPlan;
  DocFileName:='';
  //Получение имени файла переданного в коммандной строке
  if ParamCount <> 0 then DocFileName:=ParamStr(1);
end;

procedure TPlanMainForm.FormShow(Sender: TObject);
var
  Form : TStartForm;
begin
  //Сбрасываем флаги наличия изменений
  self.SaveFile.Enabled:=false;
  //Если из коммандной строки было получено имя файла пытаемся его загрузить
  //если нет - показываем стартовое окно выбора действия
  if (Length(docfilename)>0)and(FileExists(docfilename)) then
    begin
      PlanForm.LoadDocFromFile(DocFileName);
      self.Caption:=MainCaption+' - '+ExtractFilename(DocFileName);
    end else
      begin
        Form:=TStartForm.Create(application);
        Form.CaptionLB.Caption:=MainCaption;
        Form.Show;
        repeat
          while Form.Tag=0 do application.ProcessMessages ;
          case Form.Tag of
              3 : Halt(0);
              1 : self.NewFileExecute(self);
              2 : begin
                    self.OpenFileExecute(self);
                    if Length(docfilename)=0 then Form.Tag:=0;
                  end;
          end;
        until (Length(docfilename)>0)or(Form.Tag=1);
        Form.Free;
      end;
  //Обновление визуальных компонентов
  StartOstForm.Show;
  PlanProdForm.Show;
  PlanForm.Show;
  self.UpdateDateCaption;
end;

procedure TPlanMainForm.ApplicationEvents1ShowHint(var HintStr: string;
  var CanShow: Boolean; var HintInfo: THintInfo);
var
  pid : ^integer;
  pt  : TPoint;
begin
{  pt.X:=PlanForm.OstSG.MouseCoord(HintInfo.CursorPos.X,HintInfo.CursorPos.Y).X;
  pt.Y:=PlanForm.OstSG.MouseCoord(HintInfo.CursorPos.X,HintInfo.CursorPos.Y).Y;
  if (pt.X>0)and(pt.Y>0) then begin
    HintStr:=PlanForm.OstSG.Cells[pt.x,pt.y];
  end;}
end;

//--------- Скрытие и отображение окон -----------------------------------------

procedure TPlanMainForm.MsgFormClose(var msg: TMessage);
var
  winID : word;
begin
  winID:=msg.LParam;
  case winID of
    1: ShowStartOst.Checked:=false;
    2: self.ShowPlanProd.Checked:=false;
    3: self.ShowGlobalForm.Checked:=false;
  end;
  msg.Result := 1;
end;

procedure TPlanMainForm.ViewMIClick(Sender: TObject);
begin
  //устанавливаем галочки в подменю в зависимости от состояния окон
  ShowStartOst.Checked:=StartOstForm.Showing;
  ShowPlanProd.Checked:=PlanProdForm.Showing;
  ShowGlobalForm.Checked:=PlanForm.Showing;
end;

procedure TPlanMainForm.ShowGlobalFormExecute(Sender: TObject);
begin
  if PlanForm.Showing then PlanForm.Close else PlanForm.Show;
  ShowGlobalForm.Checked:=PlanForm.Showing;
end;

procedure TPlanMainForm.ShowPlanProdExecute(Sender: TObject);
begin
  if PlanProdForm.Showing then PlanProdForm.Close else PlanProdForm.Show;
  ShowPlanProd.Checked:=PlanProdForm.Showing;
end;

procedure TPlanMainForm.ShowStartOstExecute(Sender: TObject);
begin
  if StartOstForm.Showing then StartOstForm.Close else StartOstForm.Show;
  ShowStartOst.Checked:=StartOstForm.Showing;
end;

//--------- Окна насроек ------------------------------------------------------

procedure TPlanMainForm.ShowPlanSettingExecute(Sender: TObject);
begin
  SetPlanForm.ShowSetting;
  PlanForm.UpdateOstSG;
  PlanForm.UpdateDelivSG;
end;

procedure TPlanMainForm.ShowItemListFormExecute(Sender: TObject);
begin
  ShowItemList('');
  //Обновление остатков и поставок
  StartOstForm.UpdateGPVLE;
  StartOstForm.UpdateItemVLE;
  PlanProdForm.ItemChange(true);
  PlanForm.UpdateOstSG;
  PlanForm.UpdateDelivSG;
  //Показ сообщений в окне остатков о необходимости проверки
  StartOstForm.ItemChange(true,true);
end;


end.
