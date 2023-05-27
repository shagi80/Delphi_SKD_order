unit CheckListUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, ExtCtrls;

type
  TCheckListForm = class(TForm)
    MainPn: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CaptionLB: TLabel;
    CB: TCheckListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function CheckList(cap : string; list : TStringList; var check:TStringList):boolean;

implementation

{$R *.dfm}

function CheckList(cap : string; list : TStringList; var check:TStringList):boolean;
var
  i,ind : integer;
  form  : TCheckListForm;
begin
  form := TCheckListForm.Create(application);
  with form do begin
    CaptionLB.Caption:=cap;
    CB.Items.Clear;
    for I := 0 to List.Count - 1 do
      begin
        CB.Items.Add(list.Names[i]);
        ind:=check.IndexOf(list.ValueFromIndex[i]);
        CB.Checked[CB.Count-1]:=(ind>=0);
      end;
    if ShowModal=mrOK then
      begin
        check.Clear;
        for i := 0 to CB.Count - 1 do
          if CB.Checked[i] then check.Add(list.ValueFromIndex[i]);
        result:=true;
      end else result:=false;
  end;
  form.Free;
end;


end.
