unit OrderUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, Grids, ValEdit, ImgList;

type
  TOrderForm = class(TForm)
    ToolBar1: TToolBar;
    AddBtn: TToolButton;
    DelBtn: TToolButton;
    UpBtn: TToolButton;
    DownBtn: TToolButton;
    VLE: TValueListEditor;
    ImageList2: TImageList;
    procedure AddBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
    procedure VLEStringsChange(Sender: TObject);
    procedure VLESelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OrderForm: TOrderForm;

implementation

{$R *.dfm}

uses ItemListUnit, ItemEditUnit,GlobalData;


procedure TOrderForm.AddBtnClick(Sender: TObject);
var
  code : string;
  ind  : integer;
begin
  code:=GetSelectItems('');
  if Length(code)>0 then begin
    ind:=ItemList.IndFromCode(code);
    VLE.InsertRow(ItemList.Items[ind].code,ItemList.Items[ind].name,false);
    VLE.Strings.SaveToFile(ExePath+orderfile);
  end;
end;

procedure TOrderForm.DelBtnClick(Sender: TObject);
begin
  if VLE.Selection.Top>0 then VLE.DeleteRow(VLE.Selection.Top);
  VLE.Strings.SaveToFile(ExePath+orderfile);
end;

procedure TOrderForm.DownBtnClick(Sender: TObject);
var
  tp,btm : string;
  i   : integer;
begin
  i:=VLE.Selection.Top;
  if i<VLE.RowCount-1 then begin
    tp:=VLE.Strings[i-1];
    btm:=VLE.Strings[i];
    VLE.Strings[i-1]:='';
    VLE.Strings[i]:=tp;
    VLE.Strings[i-1]:=btm;
    VLE.Selection:=TGridRect(rect(0,i+1,1,i+1));
    VLE.Strings.SaveToFile(ExePath+orderfile);
  end;
end;

procedure TOrderForm.FormShow(Sender: TObject);
begin
  VLE.Strings.Clear;
  if FileExists(ExePath+orderfile) then VLE.Strings.LoadFromFile(ExePath+orderfile);
end;

procedure TOrderForm.UpBtnClick(Sender: TObject);
var
  tp,btm : string;
  i   : integer;
begin
  i:=VLE.Selection.Top;
  if i>1 then begin
    tp:=VLE.Strings[i-2];
    btm:=VLE.Strings[i-1];
    VLE.Strings[i-1]:='';
    VLE.Strings[i-2]:=btm;
    VLE.Strings[i-1]:=tp;
    VLE.Selection:=TGridRect(rect(0,i-1,1,i-1));
    VLE.Strings.SaveToFile(ExePath+orderfile);
  end;
end;

procedure TOrderForm.VLESelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  UpBtn.Enabled:=(ARow>1);
  DownBtn.Enabled:=(ARow<VLE.RowCount-1);
end;

procedure TOrderForm.VLEStringsChange(Sender: TObject);
begin
  DelBtn.Enabled:=(VLE.RowCount>0);
  UpBtn.Enabled:=(VLE.Selection.Top>1);
  DownBtn.Enabled:=(VLE.Selection.Top<VLE.RowCount-1);
end;

end.
