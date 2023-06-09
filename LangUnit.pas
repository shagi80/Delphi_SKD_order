unit LangUnit;

interface

const
  lgRUS=0;
  lgENG=1;
  lgCN =2;

var
  Lang              : integer;
  tCaption          : string;
  tDtPnBomCap       : string;
  tDtPnCIOCap       : string;
  tDtPnEICap        : string;
  tDtPnNetCap       : string;
  tDtPnVolCap       : string;
  tDtPnCIBCap       : string;
  tDtPnBarCap       : string;
  tDtPnTCCap        : string;
  tDTPnLCCap        : string;
  tDtPnBoxGnetCap   : string;
  tDtPnPriceCap     : string;
  tDtPnPriceACap    : string;
  tDtPnPriceNCap    : string;
  tDtPnNameCap      : string;
  tDtPnTNCodeCap    : string;
  tDtPnBoxTypeCap   : string;

  tMaxContNetCap    : string;
  tMaxContVolCap    : string;
  tRealContNetCap   : string;
  tRealContVolCap   : string;
  tContNameCap      : string;
  tNewContFormCap   : string;
  tNewContFormCh    : string;
  tBoxItmCap        : string;
  tBoxCountCap      : string;
  tBoxNetCap        : string;
  tCreateBoxCap     : string;
  tEditBoxCap       : string;

  tOrdPnCap         : string;
  tOrgSGCol0        : string;
  tOrgSGCol1        : string;
  tOrgSGCol2        : string;
  tOrgSGCol3        : string;
  tOrgSGCol4        : string;
  tLoadPnCap        : string;
  tLoadSGCol1       : string;
  tLoadSGCol3       : string;
  tLoadSGCol4       : string;
  tLoadSGCol5       : string;
  tLoadSGCol6       : string;
  tLoadSGCol7       : string;
  tLoadSGCol8       : string;
  tLoadSGCol2       : string;
  tLoadSGCol9       : string;
  tLoadSGEdBtnHint  : string;
  tOrdPrintHint     : string;
  tContLstPrintHint : string;
  tSelAllBtnHint    : string;
  tUnSelAllBtnHint  : string;
  tInvSelBtnHint    : string;
  tOpnDlg1SCap      : string;
  tOpnDlgOFCap      : string;
  tSvDlgOFCap       : string;
  tPIName           : string;
  tMovBoxHint       : string;
  tFindInContHint   : string;
  tFindError        : string;
  tFindInOrdHint    : string;
  tRealContNNetCap  : string;
  tRealContBoxCap   : string;
  tAdvFindInOrdHint : string;
  tNewDtHint        : string;
  tCopyDtHint       : string;
  tEditDtHint       : string;
  tDelDtHint        : string;
  tExpContHint      : string;
  tExpOrdHint       : string;
  tCompScanHint     : string;
  tUpdateDtHint     : string;
  tOrdSumBtnHint    : string;

  actOpenOrdCap     : string;
  actDelOrdCap      : string;
  actDelOrdHint     : string;
  actNewContCap     : string;
  actOpenOrdHint    : string;
  actNewContHint    : string;
  actMaxLoadPnCap   : string;
  actMaxLoadPnHint  : string;
  actDelContCap     : string;
  actDelContHint    : string;
  //�������� ���� ����
  actNewCap         : string;
  actNewHint        : string;
  actOpenCap        : string;
  actOpenHint       : string;
  actSaveCap        : string;
  actSaveHint       : string;
  actSaveAsCap      : string;
  actSaveAsHint     : string;
  actExitCap        : string;
  actExitHint       : string;
  miFileCap         : string;
  miFileHint        : string;
  //�������� ���� ���������
  miSetCap          : string;
  miSetHint         : string;
  actPswrdCap       : string;
  actPswrdHint      : string;
  actSetRUSCap      : string;
  actSetENGCap      : string;
  actSetCnCap       : string;
  actSetRUSHint     : string;
  actSetENFHint     : string;
  actSetCnHint      : string;
  miLangCap         : string;
  miLangHint        : string;
  //�������� ���� ������
  actHelpCap        : string;
  actHelpHint       : string;
  miHelpCap         : string;
  miHelpHint        : string;

  btnAutoLoadHint   : string;
  btnCrBoxHint      : string;
  btnCrItmHint      : string;
  btnDelBoxHint     : string;
  btnDelItmHint     : string;

  msgOpenOrdExst    : string;
  msgNewContExst    : string;
  msgDelOrd         : string;
  msgDelOrd2        : string;
  msgDelCont        : string;
  msgDelCont2       : string;
  msgGNetEr         : string;
  msgNew            : string;
  msgNetError       : string;

  prstCap           : string;
  prstPIBGCap       : string;
  prstPRRGCap       : string;
  prstRI1           : string;
  prstRI2           : string;
  prstRI3           : string;

procedure SetLang(L:integer);
function TranslateEI(ei:string):string;

implementation

function TranslateEI(ei:string):string;
begin
  result:='';
  if ei='��' then result:='kg';
  if ei='�' then result:='g';
  if ei='�' then result:='m';
  if ei='��' then result:='cm';
  if ei='��' then result:='pcs';
end;

procedure SetLang(L:integer);
begin
  Lang:=L;
  if L=lgRUS then
    begin
      tCaption         :='��������� ���������� �����������';
      tDtPnBomCap      :='BOM ���:';
      tDtPnCIOCap      :='���-�� � ���.:';
      tDtPnEICap       :='������� ���.:';
      tDtPnNetCap      :='��� ������,��:';
      tDtPnVolCap      :='�����, � ���:';
      tDtPnCIBCap      :='� �����(���/����):';
      tDtPnBarCap      :='�����-���:';
      tDtPnTCCap       :='����� ���-��:';
      tDTPnLCCap       :='������ ���-��:';
      tDtPnTNCodeCap   :='��� �����:';
      tDtPnBoxTypeCap  :='��������:';
      tOrdPnCap        :='  ������ ������';
      tOrgSGCol0       :=' �';
      tOrgSGCol1       :=' ������������';
      tOrgSGCol2       :=' �������';
      tOrgSGCol3       :=' �� �����';
      tOrgSGCol4       :=' ����';
      tLoadPnCap       :='  ������ ��������';
      tLoadSGCol4      :=' ���-��';
      tLoadSGCol5      :=' ��� ����';
      tLoadSGCol6      :=' �����,��';
      tLoadSGCol7      :=' ������,��';
      tLoadSGCol8      :=' �����';
      tLoadSGCol1      :=' �����';
      tLoadSGCol2      :=' ��.�';
      tLoadSGCol9      :=' ��-��,��';
      tMaxContNetCap   :='���� ��� ����,��:';
      tMaxContVolCap   :='���� ����� ����,�3:';
      tRealContNetCap  :='���� ��� ������,��:';
      tRealContVolCap  :='���� ����� ����,�3:';
      tNewContFormCap  :='�������� ������ ����������';
      tNewContFormCh   :='��������� ������ � ����������';
      tContNameCap     :='������������ ����������:';
      tBoxItmCap       :='���������� �������:';
      tBoxCountCap     :='���������� �������:';
      tBoxNetCap       :='��� 1�� ��-��, ��';
      tCreateBoxCap    :='�������� ������� (�������)';
      tEditBoxCap      :='�������������� ������� (�������)';
      tLoadSGEdBtnHint :='�������������� ���������� � ���������� �������';
      tDtPnBoxGnetCap  :='������ ������,��:';
      tDtPnPriceCap    :='���� FOB,USD:';
      tDtPnPriceNCap   :='���� �������,USD:';
      tDtPnPriceACap   :='���� �������,USD:';
      tDtPnNameCap     :='�� ����������:';
      tOrdPrintHint    :='������ ������';
      tContLstPrintHint:='������ ����������� ����������';
      tSelAllBtnHint   :='������� ���';
      tUnSelAllBtnHint :='�������� ���';
      tInvSelBtnHint   :='������������� �����';
      tOpnDlg1SCap     :='�������� ����� ������ �� 1�';
      tOpnDlgOFCap     :='�������� ����� �������������';
      tSvDlgOFCap      :='��������� ���� ������������� ���';
      tPIName          :='����� ������� (��������� 4 �����): ';
      tMovBoxHint      :='����������� ������ ������� � ������ ���������';
      tFindInContHint  :='����� ������ � �����������';
      tFindError       :='������ �� ���������!';
      tFindInOrdHint   :='����� ������ � �������';
      tRealContNNetCap :='���� ��� �����,��:';
      tRealContBoxCap  :='��� ���-�� �������:';
      tAdvFindInOrdHint:='����������� ����� ������ �� �������';
      tNewDtHint       :='���������� ������ � ������� �����';
      tCopyDtHint      :='����������� ������ � ������� ������';
      tEditDtHint      :='�������������� ���������� � ������ � ������ (�������)';
      tDelDtHint       :='������� ������';
      tExpContHint     :='�������� ������� � ��������';
      tExpOrdHint      :='�������� ������ � �������';
      tCompScanHint    :='��������� � ������� �������';
      tUpdateDtHint    :='���������� ���������� � �������';
      tOrdSumBtnHint   :='����������� �������';

      actOpenOrdCap    :='������� �����';
      actDelOrdCap     :='������� �����';
      actDelOrdHint    :='�������� ���������� � ������� ������';
      actNewContCap    :='����� ���������';
      actOpenOrdHint   :='�������� ����� ������';
      actNewContHint   :='�������� ������ ����������';
      actMaxLoadPnCap  :='������ �������� �� ��� ����';
      actMaxLoadPnHint :='��������� ������ �������� �� ��� ���� ��� ��������� �� ��������� �������';
      actDelContCap    :='������� ���������';
      actDelContHint   :='"���������" � �������� ����������';

      btnAutoLoadHint  :='�������������� �������� ����� �������';
      btnCrBoxHint     :='�������� ������� (�������)';
      btnCrItmHint     :='���������� �������� (���������) � ������������ �������';
      btnDelBoxHint    :='������� ������� (�������) �� ���������';
      btnDelItmHint    :='������� ������� �� �������';


      msgOpenOrdExst   :='����� ����� ��� ������!';
      msgNewContExst   :='����� ��������� ��� ������!';
      msgDelOrd        :='�� ������������� ������ ������� ����� "';
      msgDelOrd2       :='"? ��� ������ ����� ������ ����� ������� �� ���� �����������!';
      msgDelCont       :='�� ������������� ������ ������� �������� "';
      msgDelCont2      :='"? ��� ����������� � ���� ������ ����� ���������� � ������!';
      msgGNetEr        :='��� ������ ������ ���� ������ 0!';
      msgNew           :='��������� ��������� � ������� �������������?';
      msgNetError      :='������ � �������� ���� �������! ������ ����������!';

      prstCap          :='������ ����������� ����������';
      prstPIBGCap      :='������: ';
      prstPRRGCap      :='��� ���-��: ';
      prstRI1          :='������';
      prstRI2          :='������ (��� �������)';
      prstRI3          :='������ (��������� �������)';
      //�������� ���� ���������
      miSetCap         :='���������';
      miSetHint        :='��������� ���������';
      actPswrdCap      :='������ ������';
      actPswrdHint     :='��������� ������� ������� �� ���� �������� ���������';
      miLangCap        :='����';
      miLangHint       :='����� �����';
      actSetRUSCap     :='�������';
      actSetENGCap     :='����������';
      actSetCnCap     :='��� � ���������� ��������������';
      actSetRUSHint    :='����������� �� ������� ����';
      actSetENFHint    :='����������� �� ���������� ����';
      actSetCnHint    :='����������� �� ��� ���� � ���������� ���������������';
       //�������� ���� ����
      actNewCap        :='�������';
      actNewHint       :='�������� ������ �������� ����';
      actOpenCap       :='�������';
      actOpenHint      :='�������� ����� �������� ����';
      actSaveCap       :='���������';
      actSaveHint      :='���������� �������� ���� � ����';
      actSaveAsCap     :='��������� ���';
      actSaveAsHint    :='���������� �������� ���� � ���� � ����� ������';
      actExitCap       :='�����';
      actExitHint      :='����� �� ���������';
      miFileCap        :='����';
      miFileHint       :='�������� � ������� �����';
      //�������� ���� ������
      actHelpCap       :='� ���������';
      actHelpHint      :='� ���������';
      miHelpCap        :='������';
      miHelpHint       :='������';
    end;
  if (L=lgENG)or(L=lgCN) then
    begin
      tCaption         :='Container filling program';
      tDtPnBomCap      :='BOM code:';
      tDtPnCIOCap      :='Qty in one WM:';
      tDtPnEICap       :='Unit:';
      tDtPnNetCap      :='Weight, kg:';
      tDtPnVolCap      :='Volume, m3:';
      tDtPnCIBCap      :='In box (new/old):';
      tDtPnBarCap      :='BAR code:';
      tDtPnTCCap       :='Ordered qty:';
      tDTPnLCCap       :='Loaded qty:';
      tDtPnTNCodeCap   :='Rus custom code:';
      tDtPnBoxTypeCap  :='Box type:';
      tOrdPnCap        :='  Order list';
      tOrgSGCol0       :=' �';
      tOrgSGCol1       :=' Name';
      tOrgSGCol2       :=' Rest';
      tOrgSGCol3       :=' Unit';
      tOrgSGCol4       :=' QIB';
      tLoadPnCap       :='  Load list';
      tLoadSGCol4      :=' Quatity';
      tLoadSGCol5      :=' Box qty';
      tLoadSGCol6      :=' Net,kg';
      tLoadSGCol7      :=' Gross,kg';
      tLoadSGCol8      :=' Volume';
      tLoadSGCol1      :=' Order';
      tLoadSGCol2      :=' Grp �';
      tLoadSGCol9      :=' Box,kg';
      tMaxContNetCap   :='Max cont weigth,kg:';
      tMaxContVolCap   :='Max cont volume,m3:';
      tRealContNetCap  :='Real gross weight,kg:';
      tRealContVolCap  :='Real cont volume,m3:';
      tNewContFormCap  :='Create new container';
      tNewContFormCh   :='Change container data';
      tContNameCap     :='Container name';
      tBoxItmCap       :='Items in box:';
      tBoxCountCap     :='Qty of boxes:';
      tBoxNetCap       :='Box net, kg:';
      tCreateBoxCap    :='Create box (boxes)';
      tEditBoxCap      :='Edit box (boxes)';
      tLoadSGEdBtnHint :='Edit qty of items';
      tDtPnBoxGnetCap  :='Box gross weight,kg:';
      tDtPnPriceCap    :='Price FOB,USD:';
      tDtPnPriceNCap   :='Price Nvr,USD:';
      tDtPnPriceACap   :='Price Ang,USD:';
      tDtPnNameCap     :='All name:';
      tOrdPrintHint    :='Print order';
      tContLstPrintHint:='Print container list';
      tSelAllBtnHint   :='Select all';
      tUnSelAllBtnHint :='Unselect all';
      tInvSelBtnHint   :='Invert selection';
      tOpnDlg1SCap     :='Open order file';
      tOpnDlgOFCap     :='Open work file';
      tSvDlgOFCap      :='Save work file as';
      tPIName          :='Invoice number (last 4 sumbols): ';
      tMovBoxHint      :='Mov group in another container';
      tFindInContHint  :='Find detail in containers';
      tFindError       :='Detail not loaded!';
      tFindInOrdHint   :='Find detail in orders';
      tRealContNNetCap :='Real net weight,kg:';
      tRealContBoxCap  :='Total boxes qty:';
      tAdvFindInOrdHint:='Advanced find in orders';
      tNewDtHint       :='New detail in current order';
      tCopyDtHint      :='Copy detail in current order';
      tEditDtHint      :='Edit datil data in current order (or all orders)';
      tDelDtHint       :='Delete detail';
      tExpContHint     :='Export container data';
      tExpOrdHint      :='Export order data';
      tCompScanHint    :='Compare data to scan';
      tUpdateDtHint    :='Update detail data';
      tOrdSumBtnHint   :='Sum order';

      actOpenOrdCap    :='Open order';
      actDelOrdCap     :='Delete order';
      actNewContCap    :='New container';
      actOpenOrdHint   :='Open order file';
      actDelOrdHint    :='Delete current order';
      actNewContHint   :='Create new conainer';
      actMaxLoadPnCap  :='Maximize Load panel';
      actMaxLoadPnHint :='Maximize or minimize load list panel';
      actDelContCap    :='Delete container';
      actDelContHint   :='"Unload" and delete container';

      btnAutoLoadHint  :='Create automatically group of boxes';
      btnCrBoxHint     :='Create manually box (boxes)';
      btnCrItmHint     :='Add manually item (items) to current box';
      btnDelBoxHint    :='Delete manually box (boxes)from container';
      btnDelItmHint    :='Delete manually item from box';

      msgOpenOrdExst   :='This order is already open!';
      msgNewContExst   :='This container is alredy created!';
      msgDelOrd        :='Do you really want to delete order "';
      msgDelOrd2       :='"? All detail of this order will be deleted!';
      msgDelCont       :='Do you really want to delete container "';
      msgDelCont2      :='"? All loaded details will be returned to orders!';
      msgGNetEr        :='Gross weight should be more zero!';
      msgNew           :='Do you want to save changes in current workspace?';
      msgNetError      :='Errors in the gross weight of boxes! Printing is impossible!';

      prstCap          :='Select print mode';
      prstPIBGCap      :='Invoice: ';
      prstPRRGCap      :='Doc type: ';
      prstRI1          :='list';
      prstRI2          :='box lables (all)';
      prstRI3          :='box lables (selection)';
      //�������� ���� ���������
      miSetCap         :='Settings';
      miSetHint        :='Program settings';
      actPswrdCap      :='Full access';
      actPswrdHint     :='Set full access to all functions';
      miLangCap        :='Language';
      miLangHint       :='Language settings';
      actSetRUSCap     :='Russian';
      actSetENGCap     :='English';
      actSetCnCap      :='Eng and chine name';
      actSetRUSHint    :='Set Russian language';
      actSetENFHint    :='Set English language';
      actSetCnHint     :='Set Eng and chine name';
      //�������� ���� ����
      actNewCap        :='New';
      actNewHint       :='New workspace';
      actOpenCap       :='Open';
      actOpenHint      :='Open workspace file';
      actSaveCap       :='Save';
      actSaveHint      :='Save workspace in file';
      actSaveAsCap     :='Save as';
      actSaveAsHint    :='Save workspace in new file';
      actExitCap       :='Exit';
      actExitHint      :='Eit to Windows';
      miFileCap        :='File';
      miFileHint       :='File command';
      //�������� ���� ������
      actHelpCap       :='About program';
      actHelpHint      :='About program';
      miHelpCap        :='Help';
      miHelpHint       :='Help';
    end;
end;

end.
