unit StartUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TStartForm = class(TForm)
    CaptionLB: TLabel;
    NoteLB: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TStartForm.SpeedButton1Click(Sender: TObject);
begin
  self.Tag:=1;
end;

procedure TStartForm.SpeedButton2Click(Sender: TObject);
begin
  self.Tag:=2;
end;

procedure TStartForm.SpeedButton3Click(Sender: TObject);
begin
  self.Tag:=3;
end;

end.
