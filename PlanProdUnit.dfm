object PlanProdForm: TPlanProdForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1055#1083#1072#1085' '#1087#1088#1086#1076#1072#1078
  ClientHeight = 162
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PPWarningPn: TPanel
    Left = 0
    Top = 139
    Width = 418
    Height = 23
    Align = alBottom
    AutoSize = True
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Visible = False
    object PPWarningLB: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 286
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = #1044#1072#1085#1085#1099#1077' '#1074' '#1101#1090#1086#1081' '#1090#1072#1073#1083#1080#1094#1077' '#1085#1091#1078#1076#1072#1102#1090#1089#1103' '#1074' '#1087#1088#1086#1074#1077#1088#1082#1077'!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = PPWarningLBClick
    end
  end
  object SG: TStringGrid
    Left = 0
    Top = 0
    Width = 418
    Height = 139
    Hint = #1055#1083#1072#1085' '#1087#1088#1086#1076#1072#1078
    Align = alClient
    Ctl3D = False
    DefaultRowHeight = 20
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
    ParentCtl3D = False
    ParentShowHint = False
    PopupMenu = PopMenu
    ShowHint = True
    TabOrder = 1
    OnDrawCell = SGDrawCell
    OnKeyPress = SGKeyPress
    OnMouseDown = SGMouseDown
    OnMouseMove = SGMouseMove
    OnMouseUp = SGMouseUp
    OnSelectCell = SGSelectCell
    OnSetEditText = SGSetEditText
    ColWidths = (
      101
      64
      64
      64
      64)
  end
  object CountPN: TPanel
    Left = 296
    Top = 96
    Width = 114
    Height = 29
    BevelKind = bkFlat
    BevelOuter = bvNone
    Caption = 'CountPN'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object ActionLst: TActionList
    Left = 24
    object EditCopy: TEditCopy
      Category = 'Edit'
      Caption = '&'#1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100'|'#1050#1086#1087#1080#1088#1086#1074#1072#1090#1100'  '#1076#1072#1085#1085#1099#1077' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      ImageIndex = 1
      ShortCut = 16429
      OnExecute = EditCopyExecute
    end
    object EditPaste: TEditPaste
      Category = 'Edit'
      Caption = '&'#1042#1089#1090#1072#1074#1080#1090#1100
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100'|'#1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079' '#1073#1091#1092#1077#1088#1072' '#1086#1073#1084#1077#1085#1072
      ImageIndex = 2
      ShortCut = 8237
      OnExecute = EditPasteExecute
    end
    object EditCut: TEditCut
      Category = 'Edit'
      Caption = #1042#1099'&'#1088#1077#1079#1072#1090#1100
      Hint = #1042#1099#1088#1077#1079#1072#1090#1100'|'#1042#1099#1088#1077#1079#1072#1090#1100' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      ImageIndex = 0
      ShortCut = 16430
      OnExecute = EditCutExecute
    end
    object MoveLeft: TAction
      Category = 'Edit'
      Caption = #1057#1076#1074#1080#1085#1091#1090#1100' '#1074#1083#1077#1074#1086
      Hint = #1057#1076#1074#1080#1085#1091#1090#1100' '#1074#1083#1077#1074#1086'|'#1057#1076#1074#1080#1085#1091#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1085#1072' '#1086#1076#1080#1085' '#1087#1077#1088#1080#1086#1076' '#1074#1083#1077#1074#1086
      OnExecute = MoveLeftExecute
    end
    object LoadPlane: TAction
      Category = 'Edit'
      Caption = #1048#1084#1087#1086#1088#1090' '#1080#1079' '#1092#1072#1081#1083#1072
      Hint = #1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1080' '#1092#1072#1081#1083#1072' '#1074#1099#1075#1088#1091#1079#1082#1080' 1'#1057
      OnExecute = LoadPlaneExecute
    end
  end
  object PopMenu: TPopupMenu
    OnPopup = PopMenuPopup
    Left = 64
    object N1: TMenuItem
      Action = EditCut
    end
    object N2: TMenuItem
      Action = EditCopy
    end
    object N3: TMenuItem
      Action = EditPaste
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object LoadPlane1: TMenuItem
      Action = LoadPlane
    end
    object N5: TMenuItem
      Action = MoveLeft
    end
  end
  object OpenDlg: TOpenDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt'
    Title = #1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1080#1079' 1'#1057
    Left = 104
  end
end
