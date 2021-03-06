unit MAIN;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.Menus, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Buttons, Winapi.Messages,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin,
  Vcl.ImgList, System.ImageList, System.Actions;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    OpenDialog: TOpenDialog;
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    FileNew1: TAction;
    FileOpen1: TAction;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton9: TToolButton;
    ImageList1: TImageList;
    procedure FileNew1Execute(Sender: TObject);
    procedure AbreTela(pBuscarReg:Boolean);
    procedure FileOpen1Execute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses CHILDWIN;

procedure TMainForm.AbreTela(pBuscarReg:Boolean);
var
  Child: TMDIChild;
begin
  if (not (MainForm.ActiveMDIChild is TMDIChild)) then
  begin
    Child         := TMDIChild.Create(Self);
    with Child do
    begin
      if (pBuscarReg) then
        GravaLeitura(lbledtUsuario,lbledtSenha,lbledtBase,
                     lbledtPorta,edtServidor,cbbProtocolo,cbbServer,False);
    end;
    Child.Show;
  end
  else
    Application.MessageBox('Esta tela j? est? em execu??o',
      PChar(Application.Title), MB_OK + MB_ICONWARNING);
end;

procedure TMainForm.FileNew1Execute(Sender: TObject);
begin
  AbreTela(False);
end;

procedure TMainForm.FileOpen1Execute(Sender: TObject);
begin
  AbreTela(True);
end;

end.
