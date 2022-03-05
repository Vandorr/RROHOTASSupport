unit About;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, IdHTTP, ShellApi, System.Threading;

type
  TFrm_About = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MemoSupporters: TMemo;
    Label4: TLabel;
    Label5: TLabel;
    Img_PayPalLink: TImage;
    Img_DiscordLink: TImage;
    procedure FormShow(Sender: TObject);
    procedure Img_PayPalLinkClick(Sender: TObject);
    procedure Img_DiscordLinkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_About: TFrm_About;

implementation

{$R *.dfm}

procedure TFrm_About.FormShow(Sender: TObject);
var
  S: string;
  IdHTTP: TIdHTTP;
begin
  MemoSupporters.Text := 'Loading...';
  TTask.Run(procedure
  begin
    IdHTTP := TIdHTTP.Create(nil);
    try
      S := IdHTTP.Get('https://vandorr.info/hotas/supporters.txt');
      TThread.Synchronize(nil,
        procedure
        begin
          MemoSupporters.Text := S;
        end);
    finally
      IdHTTP.Free;
    end;
  end);
end;

procedure TFrm_About.Img_DiscordLinkClick(Sender: TObject);
begin
  ShellExecute( 0, 'open', PChar('https://discord.gg/VvsMfJWjyp'), '', '', SW_SHOWNORMAL );
end;

procedure TFrm_About.Img_PayPalLinkClick(Sender: TObject);
begin
  ShellExecute( 0, 'open', PChar('https://www.paypal.com/donate?business=KQBCBMERRWP7N&no_recurring=0&item_name=Donation+for+HOTAS+Support+&currency_code=EUR'), '', '', SW_SHOWNORMAL );
end;

end.
