unit ItemListUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ExtCtrls, ComCtrls, ActnList, ToolWin,
  Menus, StdActns, ImgList;

type
  TItemListForm = class(TForm)
    MainPn: TPanel;
    SG: TStringGrid;
    GroupTV: TTreeView;
    Splitter1: TSplitter;
    ActionList1: TActionList;
    CreateGroup: TAction;
    CreateItem: TAction;
    Edit: TAction;
    GoUp: TAction;
    TopPn: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    OwnerED: TStaticText;
    PopMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    DelItem: TAction;
    UnDelItem: TAction;
    DelMenuItem: TMenuItem;
    UnDelMenuItem: TMenuItem;
    SpeedButton1: TSpeedButton;
    ToolButton7: TToolButton;
    Cut: TAction;
    Paste: TAction;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    StBar: TStatusBar;
    TreeBtn: TToolButton;
    ImageList2: TImageList;
    procedure SGDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure PasteExecute(Sender: TObject);
    procedure CutExecute(Sender: TObject);
    procedure PopMenuPopup(Sender: TObject);
    procedure SGSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure UnDelItemExecute(Sender: TObject);
    procedure DelItemExecute(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GoUpExecute(Sender: TObject);
    procedure EditExecute(Sender: TObject);
    procedure CreateItemExecute(Sender: TObject);
    procedure CreateGroupExecute(Sender: TObject);
    procedure GroupTVClick(Sender: TObject);
    procedure SGDblClick(Sender: TObject);
    procedure UpdateSG;
    procedure UpdateTV;
    procedure CngCurFolder(onlytext:boolean);
    procedure FormShow(Sender: TObject);
    procedure UpdateBtn;
    procedure TreeBtnClick(Sender: TObject);
  private
    CurGrCode    : string; //код текущей группы
    ShowListMode : boolean;//режим отображения окна.
                           //Истина - режим редактирования спска,ложь - режим выбора элемента
    ItemBufer    : string; //"Буфер обмена"
    { Private declarations }
  public
    { Public declarations }
  end;

//показ окна в режиме редактировани списка
procedure ShowItemList(groupcode:string);
//показ окна в режиме подбора элемент
function GetSelectItems(groupcode:string):string;

implementation

{$R *.dfm}

uses ItemEditUnit;

//показ окна в режиме редактировани списка
procedure ShowItemList(groupcode:string);
var
  ItemListForm: TItemListForm;
begin
  ItemListForm:=TItemListForm.Create(application);
  ItemListForm.CurGrCode:=groupcode;
  ItemListForm.ToolBar1.Visible:=true;
  ItemListForm.Caption:='Редактор номеклатуры';
  ItemListForm.ShowListMode:=true;
  //ItemListForm.WindowState:=wsMaximized;
  //----------------------------------
  ItemListForm.Width:=round(screen.Width*0.75);
  ItemListForm.Height:=round(screen.Height*0.8);
  ItemListForm.Left:=round((screen.Width-ItemListForm.Width)/2);
  ItemListForm.Top:=round((screen.Height-ItemListForm.Height)/3);
  //----------------------------------
  ItemListForm.ShowModal;
  ItemListForm.Free;
end;

//показ окна в режиме подбора элемента
function GetSelectItems(groupcode:string):string;
var
  ItemListForm: TItemListForm;
begin
  ItemListForm:=TItemListForm.Create(application);
  ItemListForm.CurGrCode:=groupcode;
  ItemListForm.ShowListMode:=false;
  ItemListForm.ToolBar1.Visible:=false;
  //----------------------------------
  ItemListForm.Width:=round(screen.Width*0.5);
  ItemListForm.Height:=round(screen.Height*0.7);
  ItemListForm.Left:=round((screen.Width-ItemListForm.Width)/2);
  ItemListForm.Top:=round((screen.Height-ItemListForm.Height)/3);
  //----------------------------------
  ItemListForm.Caption:='Подбор номеклатуры в документ';
  ItemListForm.BorderStyle:=bsDialog;
  if ItemListForm.ShowModal=mrOk then result:=ItemListForm.SG.Cells[1,ItemListForm.SG.Selection.Top]
    else result:='';
  ItemListForm.Free;
end;

//подбор размеров столбцов таблицы
procedure TItemListForm.Splitter1Moved(Sender: TObject);
begin
  SG.ColWidths[3]:=SG.ClientWidth-SG.ColWidths[0]-SG.ColWidths[1]-SG.ColWidths[2]-4;
end;
procedure TItemListForm.TreeBtnClick(Sender: TObject);
begin
  self.UpdateSG;
end;

procedure TItemListForm.FormResize(Sender: TObject);
begin
  SG.ColWidths[3]:=SG.ClientWidth-SG.ColWidths[0]-SG.ColWidths[1]-SG.ColWidths[2]-4;
end;

procedure TItemListForm.FormShow(Sender: TObject);
begin
  self.UpdateTV;
  SG.Cells[1,0]:=' Код';
  SG.Cells[2,0]:=' Наименование';
  SG.Cells[3,0]:=' Описание';
  self.ItemBufer:='';
  self.UpdateSG;
  self.CngCurFolder(false);
end;

//переход в родетельскую группу
procedure TItemListForm.GoUpExecute(Sender: TObject);
begin
  if Length(CurGrCode)>0 then
    begin
      CurGrCode:=ItemList.Items[ItemList.IndFromCode(CurGrCode)].owner;
      self.CngCurFolder(false);
      self.UpdateSG;
    end;
end;

procedure TItemListForm.GroupTVClick(Sender: TObject);
begin
  if GroupTV.Selected<>nil then
    begin
      CurGrCode:=string(GroupTV.Selected.Data^);
      self.CngCurFolder(true);
      if TreeBtn.Down then self.UpdateSG;
    end;
end;

procedure TItemListForm.PasteExecute(Sender: TObject);
begin
  if length(ItemBufer)>0 then
    begin
      ItemList.Items[ItemList.IndFromCode(ItemBufer)].owner:=self.CurGrCode;
      self.ItemBufer:='';
      self.UpdateTV;
      self.UpdateSG;
      self.UpdateBtn;
      ItemList.SaveToFile(ItmListFileName);
    end;
end;

procedure TItemListForm.PopMenuPopup(Sender: TObject);
begin
  if not ShowListMode then Abort;
end;

procedure TItemListForm.SGDblClick(Sender: TObject);
var
  ind:integer;
begin
  if (SG.Selection.Top>0)then
    begin
      ind:=ItemList.IndFromCode(SG.Cells[1,SG.Selection.Top]);
      //есла дабл клик на папке - переход в указанную папку
      if (ind>=0)and(ItemList.Items[ind].folder) then
        begin
          CurGrCode:=ItemList.Items[ind].code;
          self.CngCurFolder(false);
          self.UpdateSG;
        end;
      //дабл клик на элементе
      if (ind>=0)and(not ItemList.Items[ind].folder) then
        //открываем для редактирования (только в режиме редактирования списка)
        if(ShowListMode)then
          begin
            if (self.Edit.Enabled)then self.EditExecute(SG)
          end
        //выбираем элемент
        else if not ItemList.Items[ind].delete then self.ModalResult:=mrOK
            else MessageDLG('Элемент помечен на удаление и не может быть выбран!',mtError,[mbOK],0);
    end;
end;

procedure TItemListForm.SGDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  img : TBitmap;
  ind : integer;
  itm : TMyItem;
begin
  //рисунок в нулевом столбце - состояние элемента
  if (Acol=0)and(arow>0)and(Length(SG.Cells[1,Arow])>0) then
    begin
      itm:=ItemList.Items[ItemList.IndFromCode(SG.Cells[1,Arow])];
      ind:=0;
      if (itm.folder)and(itm.delete) then ind:=7;
      if (itm.folder)and(not itm.delete) then ind:=6;
      if (not itm.folder)and(itm.delete) then ind:=10;
      if (not itm.folder)and(not itm.delete) then ind:=11;
      img:=TBitMap.Create;
      ImageList2.GetBitmap(ind,img);
      SG.Canvas.Draw(rect.Left+2,rect.Top+2,img);
      img.Free;
    end;
end;

procedure TItemListForm.SGSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  //обновленик кнопок при изменении элемента
  self.UpdateBtn;
end;

procedure TItemListForm.UnDelItemExecute(Sender: TObject);
var
  ind:integer;
begin
  if (SG.Selection.Top>0)then
    begin
      ind:=ItemList.IndFromCode(SG.Cells[1,SG.Selection.Top]);
      if (ind>=0) then
        begin
          ItemList.Items[ind].delete:=false;
          self.UpdateTV;
          self.SG.Repaint;
          ItemList.SaveToFile(ItmListFileName);
        end;
    end;
end;

procedure TItemListForm.UpdateSG;
var
  i,j : Integer;
begin
  //если по группамсчитаем количество строк
  if TreeBtn.Down then begin
    j:=1;
    for I := 0 to ItemList.Count - 1 do if (ItemList.Items[i].owner=curgrcode)then inc(j);
  end else j:=ItemList.Count+1;
  //Если количество строк больше 1 значит таблица не будет пустой
  //SG.Enabled:=(j>1);
  if j=1 then begin
      SG.RowCount:=2;
      SG.Rows[1].Clear;
  end else begin
    //вывод строк (j-номер строки)
    SG.RowCount:=j;
    j:=1;
    //Если по группам то сначала группы, потом детали
    if TreeBtn.Down then begin
      for I := 0 to ItemList.Count - 1 do
        if (ItemList.Items[i].folder)and(ItemList.Items[i].owner=curgrcode)then begin
          SG.Cells[1,j]:=ItemList.Items[i].code;
          SG.Cells[2,j]:=ItemList.Items[i].name;
          inc(j);
        end;
      for I := 0 to ItemList.Count - 1 do
        if (not ItemList.Items[i].folder)and(ItemList.Items[i].owner=curgrcode)then begin
          SG.Cells[1,j]:=ItemList.Items[i].code;
          SG.Cells[2,j]:=ItemList.Items[i].name;
          inc(j);
        end;
    end else begin
      //все подряд
      for I := 0 to ItemList.Count - 1 do begin
          SG.Cells[1,j]:=ItemList.Items[i].code;
          SG.Cells[2,j]:=ItemList.Items[i].name;
          inc(j);
        end;
    end;
  end;
  SG.ColWidths[3]:=SG.ClientWidth-SG.ColWidths[0]-SG.ColWidths[1]-SG.ColWidths[2]-4;
  self.SG.Repaint;
  self.UpdateBtn;
end;

procedure TItemListForm.UpdateTV;
var
  i  : Integer;
  newnode  : TTreeNode;

//установка свойств созданного элемента
procedure SetNodeProperty(node:TTreeNode;itm:TMyItem);
var
  pstr : ^string;
begin
  new(pstr);
  pstr^:=Itm.code;
  node.Data:=pstr;
  if Itm.delete then node.ImageIndex:=7 else node.ImageIndex:=6;
end;
//рекурсивное добавление детей
procedure MyAddChild(owner:TTreeNode);
var
  j        : integer;
  child    : TStringList;
  node     : TTreeNode;
begin
  Child:=TStringList.Create;
  ItemList.GetChildGroupList(string(owner.Data^),child);
  if child.Count>0 then
    for j := 0 to child.Count - 1 do
      begin
        node:=GroupTV.Items.AddChild(owner,ItemList.Items[ItemList.IndFromCode(child[j])].name);
        SetNodeProperty(node,ItemList.Items[ItemList.IndFromCode(child[j])]);
        MyAddChild(node);
      end;
  child.Free;
end;

begin
  GroupTV.Items.Clear;
  for I := 0 to ItemList.Count - 1 do
    //выбираем корневые элементы и рекурсивно добавлям детей
    if (ItemList.Items[i].folder)and(Length(ItemList.Items[i].owner)=0) then
      begin
        newnode:=GroupTV.Items.Add(nil,ItemList.Items[i].name);
        SetNodeProperty(newnode,ItemList.Items[i]);
        MyAddChild(newnode);
      end;
  self.CngCurFolder(false);
end;

//создание строки пути и выбор элемента дерева, соответсвующего текущей группе
//(выбор в дереве при onlytext=false)
procedure TItemListForm.CngCurFolder(onlytext:boolean);
var
  i        : Integer;
  pstr     : ^string;
  str,code : string;

begin
  //Создаем строку пути
  code:=CurGrCode;
  if Length(code)>0 then
    begin
      str:=ItemList.Items[ItemList.IndFromCode(code)].name;
      while Length(ItemList.Items[ItemList.IndFromCode(code)].owner)>0 do
        begin
          code:=ItemList.Items[ItemList.IndFromCode(code)].owner;
          str:=ItemList.Items[ItemList.IndFromCode(code)].name+' > '+str;
        end;
    end else str:='';
  OwnerED.Caption:=' >> '+str;
  //выбираем в дереве текущую группу (если не задно - корень)
  if not onlytext  then if Length(CurGrCode)=0 then GroupTV.Selected:=nil else
    begin
      i:=0;
      pstr:=GroupTV.Items[i].Data;
      while(i<GroupTV.Items.Count)and(pstr^<>curgrcode)do
        begin
          inc(i);
          pstr:=GroupTV.Items[i].Data;
        end;
      if(i<GroupTV.Items.Count)and(pstr^=curgrcode)then GroupTV.Select(GroupTV.Items[i]);
      GroupTV.Selected.Expand(false);
    end;
end;

procedure TItemListForm.CreateGroupExecute(Sender: TObject);
var
  itm     : TMyItem;
begin
  Itm:=TMyItem.Create(CurGrCode);
  itm.folder:=true;
  //выводим окно свойств
  if ItemEditFormShow(itm) then
    //добавляем в список
    if ItemList.AddItem(itm)then
      begin
        self.UpdateTV;
        self.UpdateSG;
        ItemList.SaveToFile(ItmListFileName);
      end else begin
        ShowMessage('Группа с таким кодом существует!');
        itm.Destroy;
      end
    else Itm.Destroy;
end;

procedure TItemListForm.CreateItemExecute(Sender: TObject);
var
  itm  : TMyItem;
begin
  if Length(CurGrCode)>0 then
    begin
      itm:=TMyItem.Create(ItemList.Items[ItemList.IndFromCode(CurGrCode)].code);
      itm.folder:=false;
      //выводим окно свойств
      if ItemEditFormShow(itm) then
        //добавляем в список
        if ItemList.AddItem(itm)then
          begin
            self.UpdateSG;
            ItemList.SaveToFile(ItmListFileName);
          end else begin
            ShowMessage('Элемент с таким кодом уже есть в списке!');
            itm.Destroy;
          end else Itm.Destroy;
    end;
end;

procedure TItemListForm.CutExecute(Sender: TObject);
var
  str : string;
begin
  if (Length(SG.Cells[1,SG.Selection.Top])>0)then
    begin
      ItemBufer:=ItemList.Items[ItemList.IndFromCode(SG.Cells[1,SG.Selection.Top])].code;
      str:='В буфере: ';
      if (ItemList.Items[ItemList.IndFromCode(SG.Cells[1,SG.Selection.Top])].folder) then
        str:=str+'группа "' else str:=str+'элемент "';
      str:=str+ItemList.Items[ItemList.IndFromCode(SG.Cells[1,SG.Selection.Top])].name+'"';
      self.StBar.Panels[1].Text:=str;
      self.Paste.Enabled:=true;
    end;
end;

procedure TItemListForm.DelItemExecute(Sender: TObject);
var
  ind:integer;
begin
  if (SG.Selection.Top>0)then
    begin
      ind:=ItemList.IndFromCode(SG.Cells[1,SG.Selection.Top]);
      if (ind>=0) then
        begin
          ItemList.Items[ind].delete:=true;
          self.UpdateTV;
          self.SG.Repaint;
          ItemList.SaveToFile(ItmListFileName);
        end;
    end;
end;

procedure TItemListForm.EditExecute(Sender: TObject);
var
  ind:integer;
begin
  if (SG.Selection.Top>0)then
    begin
      ind:=ItemList.IndFromCode(SG.Cells[1,SG.Selection.Top]);
      if (not ItemList.Items[ind].delete) then
        begin
          if (ind>=0)and(ItemEditFormShow(ItemList.Items[ind])) then
            begin
              self.UpdateTV;
              self.UpdateSG;
              ItemList.SaveToFile(ItmListFileName);
            end;
        end else MessageDLG('Деталь помечена на удаление!',mtError,[mbOk],0);
    end;
end;

procedure TItemListForm.UpdateBtn;
var
  ind:integer;
begin
  self.Paste.Enabled:=(Length(ItemBufer)>0);
  if (not ShowListMode) then self.StBar.Panels[1].Text:=''
    else if not self.Paste.Enabled then self.StBar.Panels[1].Text:='Буфер обмена пуст.';
  if (Length(SG.Cells[1,SG.Selection.Top])>0) then
    begin
      ind:=ItemList.IndFromCode(SG.Cells[1,SG.Selection.Top]);
      self.Edit.Enabled:=(not ItemList.Items[ind].delete);
      self.Cut.Enabled:=true;
      DelItem.Enabled:=not ItemList.Items[ind].delete;
      UnDelItem.Enabled:=ItemList.Items[ind].delete;
    end else
    begin
      self.Cut.Enabled:=false;
      self.Edit.Enabled:=false;
      self.DelItem.Enabled:=false;
      self.UnDelItem.Enabled:=false;
    end;
end;


end.
