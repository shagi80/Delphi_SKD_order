unit DateUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DateUtils, Buttons, ComCtrls;

type
  TDateForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    PrdCB: TComboBox;
    RightDtBtn: TSpeedButton;
    LeftDtBtn: TSpeedButton;
    StartDateST: TStaticText;
    Label2: TLabel;
    Label3: TLabel;
    DateSizeCB: TComboBox;
    BitBtn1: TBitBtn;
    procedure LeftDtBtnClick(Sender: TObject);
    procedure PrdCBChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function DateSetting:boolean;

implementation

{$R *.dfm}

uses GlobalData;

var
  Prd    : word;  //период
  StDate : TDateTime; //стартовая дата

function DateSetting:boolean;
var
  i    : integer;
  Form : TDateForm;
begin
  result:=false;
  Form:=TDateForm.Create(application);
  with Form do begin
    //устанавливаем локальные переменные
    Prd:=DatePrd;
    StDate:=StartDate;
    //настараиваем визальные компоненты
    PrdCB.Clear;
    for I := 1 to high(DatePrdCaption) do PrdCB.Items.Add(DatePrdCaption[i]);
    PrdCB.ItemIndex:=Prd-1;
    DateSizeCB.Clear;
    for I := 1 to high(DateSizeCaption) do DateSizeCB.Items.Add(DateSizeCaption[i]);
    DateSizeCB.ItemIndex:=DateSize-1;
    StartDateST.Caption:=FormatDateTime('dd mmmm yyyy',StDate);
    if ShowModal=mrOK then
      begin
        DatePrd:=Prd;
        StartDate:=StDate;
        DateSize:=DateSizeCB.ItemIndex+1;
        result:=true;
      end;
  end;
  Form.Free;
end;

procedure TDateForm.LeftDtBtnClick(Sender: TObject);
var
  arrow : integer;
begin
  //увеличение/уменьшение стартовой даты в зависимости от периода
  arrow:=0;
  if (Sender as TSpeedButton).name='LeftDtBtn' then arrow:=-1;
  if (Sender as TSpeedButton).name='RightDtBtn' then arrow:=1;
  case Prd of
    prdDay        : StDate:=IncDay(StDate,arrow);
    prdWeek       : StDate:=StDate+arrow*7;
    prdHalfMonth  : begin
                    if arrow>0 then StDate:=IncDay(StDate,16) else StDate:=IncDay(StDate,-15);
                    if DayOfTheMonth(StDate)<13 then StDate:=StartOfTheMonth(StDate)
                      else StDate:=StartOfTheMonth(StDate)+15;
                    end;
    prdMonth      : StDate:=IncMonth(StDate,arrow);
  end;
  StartDateST.Caption:=FormatDateTime('dd mmmm yyyy',StDate);
end;

procedure TDateForm.PrdCBChange(Sender: TObject);
begin
  //побор стартовой даты для нового значения периода
  Prd:=PrdCB.ItemIndex+1;
  StDate:=PlanForm.GetStartDate (prd);
  StartDateST.Caption:=FormatDateTime('dd mmmm yyyy',StDate);
end;

end.
