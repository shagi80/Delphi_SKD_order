object DelivForm: TDelivForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1086#1089#1090#1072#1074#1082#1072
  ClientHeight = 248
  ClientWidth = 638
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
  object BitBtn1: TBitBtn
    Left = 231
    Top = 210
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
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
    Left = 312
    Top = 210
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 1
    Kind = bkCancel
  end
  object Panel4: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 632
    Height = 39
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 2
    object Label2: TLabel
      Left = 8
      Top = 8
      Width = 73
      Height = 13
      Caption = #1048#1084#1103' '#1087#1086#1089#1090#1072#1074#1082#1080':'
    end
    object Label1: TLabel
      Left = 212
      Top = 8
      Width = 53
      Height = 13
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
    end
    object NameED: TEdit
      Left = 88
      Top = 5
      Width = 100
      Height = 21
      TabOrder = 0
      Text = 'NameED'
    end
    object NoteED: TEdit
      Left = 280
      Top = 5
      Width = 345
      Height = 21
      TabOrder = 1
      Text = 'NoteED'
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 45
    Width = 638
    Height = 160
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 200
      Height = 154
      Align = alLeft
      BevelKind = bkFlat
      BevelOuter = bvNone
      TabOrder = 0
      object Label6: TLabel
        Left = 10
        Top = 15
        Width = 84
        Height = 13
        Caption = #1062#1074#1077#1090' '#1074' '#1090#1072#1073#1083#1080#1094#1077':'
      end
      object Label8: TLabel
        Left = 10
        Top = 49
        Width = 58
        Height = 13
        Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077':'
      end
      object Label9: TLabel
        Left = 10
        Top = 80
        Width = 67
        Height = 13
        Caption = #1060#1072#1081#1083' '#1079#1072#1082#1072#1079#1072':'
      end
      object LinkAddBtn: TSpeedButton
        Left = 21
        Top = 125
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF196B37196B37196B
          37196B37196B37FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF196B37288C5364BA8D95D2B264BA8D288C53196B37FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1B6C3962BA8B60BA87FFFF
          FF60B98767BC8F196B37FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFF317B4C9CD4B6FFFFFFFFFFFFFFFFFF95D2B2196B37FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF44875D90D3B192D6B1FFFF
          FF65BC8C67BC8F196B37FFFFFF2626263F3F3F4A4A4A6464646B6B6B6B6B6B57
          57575757575E7D6961AB8195D4B4BAE6D06ABB8F2D8F57196B37FFFFFF292929
          4D4D4D8D8D8DAAAAAAAEAEAE97979771717178787897979785A18F5C95714F8E
          664182582D6D44FFFFFFFFFFFF2D2D2D67676796969652525241414146464651
          51515151514646464141415252529696966767672D2D2DFFFFFFFFFFFF323232
          8282829393934F4F4F3F3F3FBDBDBDCECECEC2C2C2ADADAD3F3F3F4F4F4F9393
          93828282323232FFFFFFFFFFFF313131737373D5D5D55858584B4B4B65656592
          92927979796565654B4B4B585858A8A8A8737373313131FFFFFFFFFFFF323232
          4C4C4C919191E8E8E8DDDDDDC1C1C18181817B7B7BD9D9D9DDDDDDC4C4C49191
          914C4C4C323232FFFFFFFFFFFFFFFFFF3E3E3E6A6A6A8585859E9E9E7C7C7C6C
          6C6C6C6C6C7C7C7C9E9E9E8585856A6A6A3E3E3EFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        OnClick = LinkAddBtnClick
      end
      object LinkDelBtn: TSpeedButton
        Left = 50
        Top = 125
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD1673ADE915FCC552CFFFFFFDA
          8655C85127C85027CD5932C74E25FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFD57042DE9261CC562DCF5932CB5429D98050C85127FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD87B49D46E40CC
          572EDA8350CB542BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2626263F3F3F
          4A4A4A6464646B6B6B6B6B6B575757FFFFFF6D63606B6B6B6B6B6B6464644A4A
          4A3F3F3F262626FFFFFF2929294D4D4D8D8D8DAAAAAAAEAEAE979797717171FF
          FFFF787878979797AEAEAEAAAAAA8D8D8D4D4D4D292929FFFFFF2D2D2D676767
          969696525252414141464646515151FFFFFF5151514646464141415252529696
          966767672D2D2DFFFFFF3232328282829393936565653F3F3FBDBDBDCECECEFF
          FFFFC2C2C2ADADAD3F3F3F656565939393828282323232FFFFFF313131737373
          D5D5D55858584B4B4B656565929292FFFFFF6F6F6F6565654B4B4B585858A8A8
          A8737373313131FFFFFF3232324C4C4C919191E8E8E8DDDDDDC1C1C1818181FF
          FFFF7B7B7BD9D9D9DDDDDDC4C4C49191914C4C4C323232FFFFFFFFFFFF3E3E3E
          6A6A6A8585859E9E9E7C7C7C6F6762FFFFFF6C6C6C7C7C7C9E9E9E8585856A6A
          6A3E3E3EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDA8146E5A26CD9
          7C44DE8A51E09155FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFDD864AE6A974DC8348DC864BDA7D44E6AA79DD8A50FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDE8A4CE19454DD884ADD8649E7
          AC79FFFFFFDA8046E7AB7BDD864CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        OnClick = LinkDelBtnClick
      end
      object LinkEditBtn: TSpeedButton
        Left = 79
        Top = 125
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFF113D55285F874988BD428DBC2D77B3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2B658394C7F991C9F941
          85C91C64AA2E79B9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF4389AAE0F2FF549AD81A7ABE4998C53482C13788D2FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1D699C7AB6D590B7D155
          C9E45BDFF578D0ED4194DA388DD8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF1983B673B8D6C2F6FD63DFF75DE2F879D3F04395DB388C
          D8FFFFFFFFFFFFFFFFFF2626263F3F3F4A4A4A6464646B6B6B6B6B6B32718F77
          CBE7C7F7FD5EDCF55AE1F77BD4F14294DB3588D3FFFFFFFFFFFF2929294D4D4D
          8D8D8DAAAAAAAEAEAE9797977171715F889579D3EEC7F7FD5FDCF55BE2F77AD6
          F24097DC448DCDFFFFFF2D2D2D67676796969652525241414146464651515151
          51513C66737CD3EDC4F6FD6CDDF66DCAED63A3D75D9BD25192CA323232828282
          9393934F4F4F3F3F3FBDBDBDCECECEC2C2C2ADADAD3568777ED5EEB2E3F98BC0
          E7AED3F6C4E0FC669FD3313131737373D5D5D55858584B4B4B65656592929279
          79796565654B4B4B40819477BEE7B4D2F0E5F3FFACD2EF488CC73232324C4C4C
          919191E8E8E8DDDDDDC1C1C18181817B7B7BD9D9D9DDDDDDC4C4C4729BAA58A5
          D885B1DB469DD02B95D1FFFFFF3E3E3E6A6A6A8585859E9E9E7C7C7C6C6C6C6C
          6C6C7C7C7C9E9E9E8585856A6A6A3E3E3EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        OnClick = LinkEditBtnClick
      end
      object SpeedButton1: TSpeedButton
        Left = 108
        Top = 125
        Width = 67
        Height = 22
        Caption = #1047#1072#1082#1072#1079
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SpeedButton1Click
      end
      object ColorCB: TColorBox
        Left = 100
        Top = 12
        Width = 89
        Height = 22
        ItemHeight = 16
        TabOrder = 0
      end
      object StateCB: TComboBox
        Left = 100
        Top = 46
        Width = 88
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          #1085#1077' '#1079#1072#1076#1072#1085#1086
          #1087#1086#1076#1075#1086#1090#1086#1074#1082#1072
          #1074' '#1087#1091#1090#1080
          #1090#1072#1084#1086#1078#1085#1103)
      end
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 209
      Top = 3
      Width = 204
      Height = 154
      Align = alLeft
      BevelKind = bkFlat
      BevelOuter = bvNone
      TabOrder = 1
      object Label3: TLabel
        Left = 8
        Top = 42
        Width = 79
        Height = 13
        Caption = #1057#1088#1086#1082' '#1087#1086#1089#1090#1072#1074#1082#1080':'
      end
      object Label4: TLabel
        Left = 8
        Top = 93
        Width = 110
        Height = 13
        Caption = #1058#1072#1084#1086#1078#1077#1085#1085#1072#1103' '#1086#1095#1080#1089#1090#1082#1072':'
      end
      object Label5: TLabel
        Left = 8
        Top = 120
        Width = 103
        Height = 13
        Caption = #1057#1088#1086#1082' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072':'
      end
      object Label7: TLabel
        Left = 8
        Top = 15
        Width = 79
        Height = 13
        Caption = #1044#1072#1090#1072' '#1086#1090#1075#1088#1091#1079#1082#1080':'
      end
      object PortLB: TLabel
        Left = 8
        Top = 68
        Width = 177
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'PortLB'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Tm2ED: TEdit
        Left = 131
        Top = 39
        Width = 41
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = Tm2EDChange
        OnKeyPress = DelivVLEKeyPress
      end
      object Tm3ED: TEdit
        Left = 131
        Top = 90
        Width = 41
        Height = 21
        TabOrder = 1
        Text = '0'
        OnKeyPress = DelivVLEKeyPress
      end
      object Tm4ED: TEdit
        Left = 131
        Top = 118
        Width = 41
        Height = 21
        TabOrder = 2
        Text = '0'
        OnKeyPress = DelivVLEKeyPress
      end
      object Tm2UD: TUpDown
        Left = 172
        Top = 39
        Width = 16
        Height = 21
        Associate = Tm2ED
        TabOrder = 3
      end
      object Tm3UD: TUpDown
        Left = 172
        Top = 90
        Width = 16
        Height = 21
        Associate = Tm3ED
        TabOrder = 4
      end
      object Tm4UD: TUpDown
        Left = 172
        Top = 118
        Width = 16
        Height = 21
        Associate = Tm4ED
        TabOrder = 5
      end
      object DateED: TMaskEdit
        Left = 131
        Top = 12
        Width = 56
        Height = 21
        EditMask = '!99/99/00;1;_'
        MaxLength = 8
        TabOrder = 6
        Text = '  .  .  '
        OnChange = DateEDChange
      end
    end
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 419
      Top = 3
      Width = 216
      Height = 154
      Align = alClient
      BevelKind = bkFlat
      BevelOuter = bvNone
      Caption = 'Panel2'
      TabOrder = 2
      object SubItemBtn: TSpeedButton
        Left = 0
        Top = 5
        Width = 148
        Height = 22
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1089#1087#1080#1089#1086#1082
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFBB6A34
          BA6530BB6631BA6630BA6630BA6630BA6530BA652FB9652EB9652EB9642EB964
          2EB7622CB7622EFFFFFFFFFFFFBC6933F8F1EAF7ECDFF6EBDEF6EADEF6EADCF6
          EADCFAF3EBFAF3EBFAF2EAFCF7F3FCF8F4FEFEFDB7602AFFFFFFFFFFFFBF7138
          F5EBDFFDBF68FCBD67FBBE65FCBE64FCBE64FCBD62FBBD63FBBC61FCBE60FCBC
          62FDFBF8B9642DFFFFFFFFFFFFC1783CF7EDE3FDC26E1842572B61874C89BC70
          9FB3E3C99AFFD695FFD594FFD493FBBE65FBF7F4BB6731FFFFFFFFFFFFC47C40
          F7F0E6F8B4552E668294C7F991C9F94185C92668A6D2A865F7B251F7B24FF7B2
          4FFCF9F5BF6F36FFFFFFFFFFFFC58042F8F1E8FEE5D54389AAE0F2FF549AD81A
          7ABE4998C5488CC2DAD2CDFBE0C9FBE1C8FDFAF7C1763BFFFFFFFFFFFFC58245
          F8F2EBFEE7D6A6B6BF7AB6D590B7D155C9E45BDFF578D0ED519BD9E1D6CDFBE1
          C9FBF7F2C57C3FFFFFFFFFFFFFC68447F9F3ECFEE8D6FEE8D7B3C6CC76B9D6C2
          F6FD63DFF75DE2F879D3F04998DAE2D5C8FAF2EAC68042FFFFFFFFFFFFC68849
          F9F4EDFEE8D8FEE8D8FEE8D7B0C6CC77CBE7C7F7FD5EDCF55AE1F77BD4F14B99
          DBD2DFE9C68245FFFFFFFFFFFFC6884AF9F4EFFEE7D7FDE7D6FDE7D5FDE6D4BD
          D6D579D3EEC7F7FD5FDCF55BE2F77AD6F251A1E0AD8560FFFFFFFFFFFFC6894B
          F9F4F0FCE6D3FCE6D4FDE7D3FCE4D1FBE3CDBED4D07DD4EEC4F6FD6CDDF66DCA
          ED63A3D76499C85192CAFFFFFFC6894BF9F5F1FCE3CFFBE4D0FCE4CFFCE3CDFA
          E1CAF9DDC4AFCDC981D5EEB2E3F98BC0E7AED3F6C4E0FC669FD3FFFFFFC6894C
          F9F5F1FCE3CDFBE3CEFBE3CDFBE2CBF9E0C8F8DCC2F5D6BAAFE3F177BEE7B4D2
          F0E5F3FFACD2EF488CC7FFFFFFC5884BFAF6F2FAE0C7FBE1C9FBE2C9FBE0C8F9
          DFC5F8DBC1F4D6B8FFFBF8B6CBC258A5D885B1DB469DD02B95D1FFFFFFC48549
          F7F2ECF8F4EEF8F4EDF8F3EDF8F3EDF8F3EDF8F2ECF7F2ECF2E6D7E2B27DDB94
          65B3683BFFFFFFFFFFFFFFFFFFC17D44C88B4DC88C4FC88C4FC88C4FC88C4FC8
          8D4FC98C4FC78B4FC5894BC4763BB3683CFFFFFFFFFFFFFFFFFF}
        OnClick = SubItemEditBtnClick
      end
      object DelivVLE: TValueListEditor
        AlignWithMargins = True
        Left = 3
        Top = 31
        Width = 206
        Height = 116
        Align = alBottom
        TabOrder = 0
        TitleCaptions.Strings = (
          ' '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          ' '#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086)
        OnKeyPress = DelivVLEKeyPress
        ColWidths = (
          114
          86)
      end
    end
  end
  object FNameED: TEdit
    Left = 24
    Top = 146
    Width = 168
    Height = 21
    ReadOnly = True
    TabOrder = 4
    Text = 'FNameED'
  end
  object OpenDlg: TOpenDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt'
    Title = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1089#1074#1103#1079#1080' '#1089' '#1092#1072#1081#1083#1086#1084' '#1079#1072#1082#1072#1079#1072
    Left = 8
    Top = 208
  end
  object SaveDlg: TSaveDialog
    DefaultExt = '*.txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099'|*.txt'
    Title = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1079#1072#1082#1072#1079#1072
    Left = 48
    Top = 208
  end
end
