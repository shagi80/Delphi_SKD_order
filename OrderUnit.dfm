object OrderForm: TOrderForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1086#1088#1103#1076#1086#1082' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1077' '#1074' '#1087#1083#1072#1085#1077' '#1087#1088#1086#1076#1072#1078
  ClientHeight = 478
  ClientWidth = 388
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 382
    Height = 22
    AutoSize = True
    ButtonWidth = 74
    Caption = 'ToolBar1'
    Images = ImageList2
    List = True
    ShowCaptions = True
    TabOrder = 0
    object AddBtn: TToolButton
      Left = 0
      Top = 0
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      ImageIndex = 1
      OnClick = AddBtnClick
    end
    object DelBtn: TToolButton
      Left = 74
      Top = 0
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 0
      OnClick = DelBtnClick
    end
    object UpBtn: TToolButton
      Left = 148
      Top = 0
      Caption = #1042#1074#1077#1088#1093
      ImageIndex = 2
      OnClick = UpBtnClick
    end
    object DownBtn: TToolButton
      Left = 222
      Top = 0
      Caption = #1042#1085#1080#1079
      ImageIndex = 3
      OnClick = DownBtnClick
    end
  end
  object VLE: TValueListEditor
    AlignWithMargins = True
    Left = 3
    Top = 31
    Width = 382
    Height = 444
    Align = alClient
    Ctl3D = False
    KeyOptions = [keyUnique]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowMoving, goRowSelect, goThumbTracking]
    ParentCtl3D = False
    TabOrder = 1
    OnSelectCell = VLESelectCell
    OnStringsChange = VLEStringsChange
    ExplicitLeft = -2
    ColWidths = (
      150
      228)
  end
  object ImageList2: TImageList
    Left = 80
    Top = 80
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000017469E000343
      B3000442BC000343B400033DA400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000035803C003079
      35002B713000266B2A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9F9F900FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC008BA9DF002866CA002177
      E6000579EA000164DD00044DBC000345B8000000000000000000F9F9F900FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC003D8B440081C5
      87007CC282002C74320000000000000000000000000000000000000000000000
      00000000000000000000286E2D0025692900216425001E602200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000067C6730065C2700000000000000000000000
      0000000000000000000000000000000000000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC001E59C000639DF400187F
      FF000076F8000076EE000368E1000345B9000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC0045964D0088C9
      900082C68A00448D4A001A441D00000000000000000000000000000000000000
      000000000000000000002D75330074BD7A0072BD780022652600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000066C572007ECA88007BC885005DB86800000000000000
      0000000000000000000000000000000000000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FBFBFB00FBFBFB000543BC00AECDFE000000
      00000000000000000000187FEF000442BC000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FBFBFB0083C48A0057AB61006AB4730090CE
      97008ACB91006AB07000357F3C00307935000000000000000000000000000000
      00000000000000000000337D390079C07E0076BF7C00266B2B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000068C7740066C472007CCA87009ED6A7009CD4A50073C07D0055AC5E0050A6
      5900000000000000000000000000000000000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FBFBFB00FBFBFB00FAFAFA00245CC2008DB5F6004D92
      FF001177FF002186FF00408AEB000344B9000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FBFBFB00FBFBFB00F6F8F70070BC780071BC7B0096D2
      9F0091CF990061AA69003B8642002F7135000000000000000000000000000000
      0000000000000000000039853F007DC282007AC180002B723000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000065C3710062BF6E0079C683009AD4A30098D3A1007DC386004FA458004A9E
      5300000000000000000000000000000000000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FBFBFB00FBFBFB00FBFBFB0093AEE1003D76D2008DB5
      F700B8D6FE0072A8F5002D6BCA000442B9000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FBFBFB00FBFBFB00FBFBFB00FAFAFA0078C1800073BE
      7C006EB978006CB0730000000000000000000000000000000000000000000000
      000000000000000000003F8D460081C587007EC38500317A3600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005BB4650096D29F0094D09C005DAC6500499C52000000
      0000000000000000000000000000000000000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FBFBFB0092ADE0002A61
      C7000543BC001F5AC10002379500000000000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FBFBFB00F9F9F9007DC4
      86007CC18400FCFCFC0000000000000000000000000000000000000000000000
      0000000000000000000045954C0085C78C0082C6890036823D00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000056AD5F0093CF9A0090CE9800489A5000000000000000
      0000000000000000000000000000000000000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FAFAFA00F9F9F900F6F6
      F600F6F6F600FCFCFC0000000000000000000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FAFAFA00F9F9F900F6F6
      F600F6F6F600FCFCFC0000000000000000000000000000000000000000000000
      000000000000000000004A9E53008ACA910087C98E003C8A4300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000050A659008ECC95008BCB930042924A00000000000000
      0000000000000000000000000000000000000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FBFBFB00F8F8F800F6F6F600F3F3
      F300F2F2F200FCFCFC0000000000000000000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FBFBFB00F8F8F800F6F6F600F3F3
      F300F2F2F200FCFCFC0000000000000000000000000000000000000000000000
      0000000000000000000050A659008ECC95008BCB930042924A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004A9E53008ACA910087C98E003C8A4300000000000000
      0000000000000000000000000000000000000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FBFBFB00F8F8F800F5F5F500F2F2F200EFEF
      EF00EDEDED00FCFCFC0000000000000000000000000000000000FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FBFBFB00F8F8F800F5F5F500F2F2F200EFEF
      EF00EDEDED00FCFCFC0000000000000000000000000000000000000000000000
      0000000000000000000056AD5F0093CF9A0090CE9800489A5000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000045954C0085C78C0082C6890036823D00000000000000
      0000000000000000000000000000000000000000000000000000FCFCFC00FBFB
      FB00FCFCFC00FCFCFC00FBFBFB00F8F8F800F5F5F500F1F1F100ECECEC00EAEA
      EA00E6E6E600FCFCFC0000000000000000000000000000000000FCFCFC00FBFB
      FB00FCFCFC00FCFCFC00FBFBFB00F8F8F800F5F5F500F1F1F100ECECEC00EAEA
      EA00E6E6E600FCFCFC0000000000000000000000000000000000000000000000
      000000000000000000005BB4650096D29F0094D09C005DAC6500499C52000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003F8D460081C587007EC38500317A3600000000000000
      0000000000000000000000000000000000000000000000000000FCFCFC00F9F9
      F900F9F9F900F9F9F900F7F7F700F6F6F600F2F2F200EBEBEB00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC0000000000000000000000000000000000FCFCFC00F9F9
      F900F9F9F900F9F9F900F7F7F700F6F6F600F2F2F200EBEBEB00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC0000000000000000000000000000000000000000000000
      000065C3710062BF6E0079C683009AD4A30098D3A1007DC386004FA458004A9E
      5300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000039853F007DC282007AC180002B723000000000000000
      0000000000000000000000000000000000000000000000000000FCFCFC00F7F7
      F700F9F9F900F7F7F700F7F7F700F3F3F300F0F0F000EAEAEA00FCFCFC00F6F6
      F600F4F4F4009999990000000000000000000000000000000000FCFCFC00F7F7
      F700F9F9F900F7F7F700F7F7F700F3F3F300F0F0F000EAEAEA00FCFCFC00F6F6
      F600F4F4F4009999990000000000000000000000000000000000000000000000
      000068C7740066C472007CCA87009ED6A7009CD4A50073C07D0055AC5E0050A6
      5900000000000000000000000000000000000000000000000000000000000000
      00000000000000000000337D390079C07E0076BF7C00266B2B00000000000000
      0000000000000000000000000000000000000000000000000000FBFBFB00F4F4
      F400F5F5F500F5F5F500F5F5F500F1F1F100EFEFEF00E9E9E900FCFCFC00E7E7
      E700959595000000000000000000000000000000000000000000FBFBFB00F4F4
      F400F5F5F500F5F5F500F5F5F500F1F1F100EFEFEF00E9E9E900FCFCFC00E7E7
      E700959595000000000000000000000000000000000000000000000000000000
      0000000000000000000066C572007ECA88007BC885005DB86800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002D75330074BD7A0072BD780022652600000000000000
      0000000000000000000000000000000000000000000000000000F8F8F800FBFB
      FB00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00F8F8F8009494
      9400000000000000000000000000000000000000000000000000F8F8F800FBFB
      FB00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00F8F8F8009494
      9400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000067C6730065C2700000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000286E2D0025692900216425001E602200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080018001FFFFFFFF80008001FC3FFE7F
      00000001FC3FFC3F001C0000FC3FF00F00000000FC3FF00F00000000FC3FFC1F
      00000000FC3FFC3F00000000FC3FFC3F00000000FC3FFC3F00000000FC3FFC3F
      00000000FC1FFC3F00000000F00FFC3F00010001F00FFC3F80018001FC3FFC3F
      80038003FE7FFC3F80078007FFFFFFFF}
  end
end