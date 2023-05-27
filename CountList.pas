unit CountList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, ActnList, StdActns, Menus;


type
  TCountRec = record
    code      : string[10];
    count     : integer;
  end;

  TCountList = class
    Count : integer;
    Items : array of TCountRec;
    constructor Create;
    destructor  Destroy; override;
    function    Add(code:string;count:integer):boolean;
    procedure   Delete(code: string);
    function    IndFromCode(code:string):integer;
    function    CountFromCode(code:string):integer;
    procedure   Sort(ordfile:string);
  end;

implementation

constructor TCountList.Create;
begin
  inherited;
  count:=0;
  SetLength(self.Items,0);
end;

destructor TCountList.Destroy;
begin
  count:=0;
  SetLength(self.Items,0);
  inherited;
end;

function TCountList.Add(code:string;count:integer):boolean;
var
  i : integer;
begin
  i:=0;
  while(i<self.Count)and(self.Items[i].code<>code)do inc(i);
  if(i=self.Count)then
    begin
      inc(self.Count);
      SetLength(self.Items,self.Count);
      self.Items[self.Count-1].code:=code;
      self.Items[self.Count-1].count:=count;
      result:=true;
    end else result:=false;
end;

function TCountList.IndFromCode(code: string):integer;
var
  i : integer;
begin
  i:=0;
  while(i<self.Count)and(self.Items[i].code<>code)do inc(i);
  if(i<self.Count)and(self.Items[i].code=code)then result:=i else result:=-1;
end;

function TCountList.CountFromCode(code: string):integer;
var
  i : integer;
begin
  i:=0;
  while(i<self.Count)and(self.Items[i].code<>code)do inc(i);
  if(i<self.Count)and(self.Items[i].code=code)then result:=self.Items[i].count else result:=-1;
end;

procedure TCountList.Delete(code: string);
var
  i,j : integer;
begin
  i:=0;
  while(i<self.Count)and(self.Items[i].code<>code)do inc(i);
  if(i<self.Count)and(self.Items[i].code=code)then
    begin
      for j := i to self.Count - 2 do self.Items[j]:=self.Items[j+1];
      dec(self.Count);
      SetLength(self.Items,self.Count);
    end;
end;

procedure TCountList.Sort(ordfile: string);
type
  TSortRec = record
    code : string;
    cnt  : integer;
    pos  : integer;
  end;
var
  PrdCnt,i,ind : integer;
  orderlist : TStringList;
  sortlist  : array of TSortRec;

procedure SortMyList( min, max: Integer);
var
  i, n : Integer;
  tmp  : TSortRec;
  Sort: Boolean;
begin
  Sort:=True;
  n:=0;
  while Sort do begin
   Sort:=False;
   for i:=min to max-1-n do
    if SortList[i].pos>SortList[i+1].pos then begin
      Sort:=True;
      tmp:=SortList[i];
      SortList[i]:=SortList[i+1];
      SortList[i+1]:=tmp;
    end;
    n:=n+1;
   end;
end;

begin
  OrderList:=TStringList.Create;
  if FileExists(ordfile) then OrderList.LoadFromFile(ordfile);
  SetLength(SortList,self.Count);
  for i := 0 to self.Count - 1 do begin
    SortList[i].code:=self.Items[i].code;
    ind:=OrderList.IndexOfName(self.Items[i].code);
    SortList[i].cnt:=self.Items[i].count;
    if ind>-1 then SortList[i].pos:=ind else SortList[i].pos:=999999;
  end;
  //сортировка по номеру позиции, безномерные в конец в беспорядке
  if OrderList.Count>0 then SortMyList(0,high(SortList));
  OrderList.Free;
  for I := 0 to high(SortList) do begin
    self.Items[i].code:=SortList[i].code;
    self.Items[i].count:=SortList[i].cnt;
  end;
end;

end.
