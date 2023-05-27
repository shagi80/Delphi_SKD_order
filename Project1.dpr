program Project1;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {PlanMainForm},
  DateUnit in 'DateUnit.pas' {DateForm},
  CountList in 'CountList.pas',
  StartOstUnit in 'StartOstUnit.pas' {StartOstForm},
  CheckListUnit in 'CheckListUnit.pas' {CheckListForm},
  PlanProdUnit in 'PlanProdUnit.pas' {PlanProdForm},
  GlobalData in 'GlobalData.pas' {PlanForm},
  DelivUnit in 'DelivUnit.pas' {DelivForm},
  SetUnit in 'SetUnit.pas' {SetPlanForm},
  StartUnit in 'StartUnit.pas' {StartForm},
  ItemEditUnit in 'ItemEditUnit.pas' {ItemEditForm},
  ItemListUnit in 'ItemListUnit.pas' {ItemListForm},
  OrderUnit in 'OrderUnit.pas' {OrderForm},
  TDataLst in 'TDataLst.pas',
  LangUnit in 'LangUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TPlanMainForm, PlanMainForm);
  Application.CreateForm(TStartOstForm, StartOstForm);
  Application.CreateForm(TPlanProdForm, PlanProdForm);
  Application.CreateForm(TPlanForm, PlanForm);
  Application.CreateForm(TSetPlanForm, SetPlanForm);
  Application.CreateForm(TOrderForm, OrderForm);
  Application.Run;
end.
