unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Math, LCLIntf;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnVerificar: TButton;
    btnGerarCaptcha: TButton;
    edtCaptcha: TEdit;
    imgCaptcha: TImage;
    Label1: TLabel;
    procedure btnGerarCaptchaClick(Sender: TObject);
    procedure btnVerificarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FCaptchaCode: string;
    procedure GerarCaptcha;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnVerificarClick(Sender: TObject);
begin
  if edtCaptcha.Text = FCaptchaCode then
    ShowMessage('CAPTCHA correto!')
  else
    ShowMessage('CAPTCHA incorreto, tente novamente.');
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  GerarCaptcha;
end;

procedure TForm1.btnGerarCaptchaClick(Sender: TObject);
begin
  GerarCaptcha;
end;

procedure TForm1.GerarCaptcha;
var
  Bmp: TBitmap;
  i, x, y: Integer;
  Angulo: Integer;
  TextoChar: Char;
  Fontes: array[1..5] of string = ('Arial', 'Courier New', 'Times New Roman', 'Verdana', 'Comic Sans MS');
begin
  FCaptchaCode := '';
  for i := 1 to 5 do
    FCaptchaCode := FCaptchaCode + Chr(Random(26) + Ord('A')); // Gera letras aleatórias

  Bmp := TBitmap.Create;
  try
    Bmp.SetSize(imgCaptcha.Width, imgCaptcha.Height);

    x := 20;
    for i := 1 to Length(FCaptchaCode) do
    begin
      TextoChar := FCaptchaCode[i];
      Angulo := RandomRange(-20, 20); // Rotação aleatória

      Bmp.Canvas.Font.Name := Fontes[Random(Length(Fontes)) + 1]; // Seleciona uma fonte aleatória
      Bmp.Canvas.Font.Bold := True;
      Bmp.Canvas.Font.Size := RandomRange(24, 36); // Pequena variação no tamanho
      Bmp.Canvas.Font.Orientation := Angulo * 10; // Rotação aleatória
      Bmp.Canvas.Font.Color := RGB(Random(255), Random(255), Random(255)); // Cor aleatória

      Bmp.Canvas.TextOut(x + Random(5), 20 + Random(5), TextoChar); // Pequena variação na posição
      x := x + 40;
    end;

    // Adiciona ruído extra com linhas aleatórias
    Bmp.Canvas.Pen.Color := clRed;
    for i := 1 to 15 do
    begin
      Bmp.Canvas.Pen.Color := RGB(Random(255), Random(255), Random(255)); // Cor aleatória
      x := Random(Bmp.Width);
      y := Random(Bmp.Height);
      Bmp.Canvas.MoveTo(x, y);
      Bmp.Canvas.LineTo(Random(Bmp.Width), Random(Bmp.Height));
    end;

    // Adiciona pontos aleatórios como ruído
    Bmp.Canvas.Pen.Color := clBlue;
    for i := 1 to 300 do
      Bmp.Canvas.Pixels[Random(Bmp.Width), Random(Bmp.Height)] := clBlue;

    imgCaptcha.Picture.Assign(Bmp);
  finally
    Bmp.Free;
  end;
end;

end.

