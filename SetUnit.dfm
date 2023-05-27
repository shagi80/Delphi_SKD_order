object SetPlanForm: TSetPlanForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 205
  ClientWidth = 269
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PC: TPageControl
    Left = 0
    Top = 0
    Width = 269
    Height = 160
    ActivePage = DelivCalck
    Align = alTop
    MultiLine = True
    TabOrder = 0
    object DelivTime: TTabSheet
      Caption = #1057#1088#1086#1082#1080' '#1087#1086#1089#1090#1072#1074#1082#1080
      object Label3: TLabel
        Left = 16
        Top = 9
        Width = 79
        Height = 13
        Caption = #1057#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080':'
      end
      object Label4: TLabel
        Left = 16
        Top = 40
        Width = 110
        Height = 13
        Caption = #1058#1072#1084#1086#1078#1077#1085#1085#1072#1103' '#1086#1095#1080#1089#1090#1082#1072':'
      end
      object Label5: TLabel
        Left = 16
        Top = 72
        Width = 103
        Height = 13
        Caption = #1057#1088#1086#1082' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072':'
      end
      object Tm2ED: TEdit
        Left = 139
        Top = 6
        Width = 41
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object Tm2UD: TUpDown
        Left = 180
        Top = 6
        Width = 16
        Height = 21
        Associate = Tm2ED
        TabOrder = 1
      end
      object Tm3UD: TUpDown
        Left = 180
        Top = 37
        Width = 16
        Height = 21
        Associate = Tm3ED
        TabOrder = 2
      end
      object Tm3ED: TEdit
        Left = 139
        Top = 37
        Width = 41
        Height = 21
        TabOrder = 3
        Text = '0'
      end
      object Tm4ED: TEdit
        Left = 139
        Top = 69
        Width = 41
        Height = 21
        TabOrder = 4
        Text = '0'
      end
      object Tm4UD: TUpDown
        Left = 180
        Top = 69
        Width = 16
        Height = 21
        Associate = Tm4ED
        TabOrder = 5
      end
    end
    object DelivCalck: TTabSheet
      Caption = #1056#1072#1089#1095#1077#1090' '#1087#1086#1089#1090#1072#1074#1082#1080
      ImageIndex = 1
      object Label1: TLabel
        Left = 15
        Top = 16
        Width = 147
        Height = 13
        Caption = #1052#1080#1085' '#1086#1089#1090#1072#1090#1086#1082' (% '#1086#1090' '#1087#1088#1086#1076#1072#1078'):'
      end
      object MinOstED: TEdit
        Left = 179
        Top = 13
        Width = 41
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object MinOstUD: TUpDown
        Left = 220
        Top = 13
        Width = 16
        Height = 21
        Associate = MinOstED
        TabOrder = 1
      end
      object NegativeCB: TCheckBox
        Left = 15
        Top = 48
        Width = 221
        Height = 17
        Alignment = taLeftJustify
        Caption = #1056#1072#1079#1088#1077#1096#1080#1090#1100' '#1086#1090#1088#1080#1094#1072#1090#1077#1083#1100#1085#1099#1081' '#1086#1089#1090#1072#1090#1086#1082
        TabOrder = 2
      end
    end
    object FilesAndFolder: TTabSheet
      Caption = #1060#1072#1081#1083#1099' '#1080' '#1076#1080#1088#1088#1077#1082#1090#1086#1088#1080#1080
      ImageIndex = 2
      object Label2: TLabel
        Left = 16
        Top = 10
        Width = 188
        Height = 13
        Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1084#1072' '#1088#1077#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1079#1072#1082#1072#1079#1086#1074':'
      end
      object OrderEdtProgBtn: TSpeedButton
        Left = 200
        Top = 29
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = OrderEdtProgBtnClick
      end
      object DelOrderEditProgBtn: TSpeedButton
        Left = 224
        Top = 29
        Width = 23
        Height = 22
        Caption = 'X'
        OnClick = DelOrderEditProgBtnClick
      end
      object OrderEditProgED: TEdit
        Left = 32
        Top = 29
        Width = 162
        Height = 21
        ReadOnly = True
        TabOrder = 0
        Text = 'OrderEditProgED'
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 57
    Top = 167
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 138
    Top = 167
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    Kind = bkCancel
  end
  object OpenDlg: TOpenDialog
    Filter = #1048#1089#1087#1086#1083#1085#1103#1077#1084#1099#1077' '#1092#1072#1081#1083#1099'|*.exe'
    Title = #1042#1099#1073#1086#1088' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1079#1072#1082#1072#1079#1086#1074
    Left = 232
    Top = 120
  end
end
