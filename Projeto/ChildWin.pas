unit CHILDWIN;

interface

uses Winapi.Windows, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Dialogs, System.SysUtils, System.Win.Registry;

type
  TMDIChild = class(TForm)
    grpBancoDados: TGroupBox;
    lbledtUsuario: TLabeledEdit;
    lbledtSenha: TLabeledEdit;
    chkMostrarSenha: TCheckBox;
    lblProtocolo: TLabel;
    cbbProtocolo: TComboBox;
    lbledtPorta: TLabeledEdit;
    lblServer: TLabel;
    cbbServer: TComboBox;
    edtServidor: TEdit;
    lbledtBase: TLabeledEdit;
    btnSalvar: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkMostrarSenhaClick(Sender: TObject);
    procedure GravaLeitura(pUsuario,pSenha,pBase,pPorta:TLabeledEdit;pServidor:TEdit;pProtocolo,pComboServ:TComboBox;pGravar:Boolean);
    procedure FormActivate(Sender: TObject);
    procedure cbbServerChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    procedure SetParameters;
  public
    { Public declarations }
  end;

implementation

var
  Registro:TRegistry;
  vChave,vUserReg,vPassReg,
  vProtocol, vPorta, vServer, vBase:String;
  vJaPassou:Boolean=False;

{$R *.dfm}

procedure TMDIChild.btnSalvarClick(Sender: TObject);
begin
  GravaLeitura(lbledtUsuario,lbledtSenha,lbledtBase,
               lbledtPorta,edtServidor,cbbProtocolo,cbbServer,True);
end;


procedure TMDIChild.cbbServerChange(Sender: TObject);
begin
  if cbbServer.ItemIndex <= 0 then
    edtServidor.Text  :=  'localhost'
  else
    edtServidor.Clear;
  edtServidor.Enabled := cbbServer.ItemIndex >= 1;
end;

procedure TMDIChild.chkMostrarSenhaClick(Sender: TObject);
begin
  if (chkMostrarSenha.Checked) then
    lbledtSenha.PasswordChar  :=  #0
  else
    lbledtSenha.PasswordChar  :=  '*';
end;

procedure TMDIChild.FormActivate(Sender: TObject);
begin
  cbbProtocolo.Items.Clear;
  cbbProtocolo.Items.Add('ado');
  cbbProtocolo.Items.Add('asa');
  cbbProtocolo.Items.Add('ASA12');
  cbbProtocolo.Items.Add('ASA7');
  cbbProtocolo.Items.Add('ASA8');
  cbbProtocolo.Items.Add('ASA9');
  cbbProtocolo.Items.Add('firebird');
  cbbProtocolo.Items.Add('firebird-1.0');
  cbbProtocolo.Items.Add('firebird-1.5');
  cbbProtocolo.Items.Add('firebird-2.0');
  cbbProtocolo.Items.Add('firebird-2.1');
  cbbProtocolo.Items.Add('firebird-2.5');
  cbbProtocolo.Items.Add('firebird-3.0');
  cbbProtocolo.Items.Add('firebirdd-1.5');
  cbbProtocolo.Items.Add('firebirdd-2.0');
  cbbProtocolo.Items.Add('firebirdd-2.1');
  cbbProtocolo.Items.Add('firebirdd-2.5');
  cbbProtocolo.Items.Add('firebirdd-3.0');
  cbbProtocolo.Items.Add('FreeTDS_MsSql<=6.5');
  cbbProtocolo.Items.Add('FreeTDS_MsSql>=2005');
  cbbProtocolo.Items.Add('FreeTDS_MsSql-2000');
  cbbProtocolo.Items.Add('FreeTDS_MsSql-7.0');
  cbbProtocolo.Items.Add('FreeTDS_Sybase<10');
  cbbProtocolo.Items.Add('FreeTDS_Sybase-10+');
  cbbProtocolo.Items.Add('interbase');
  cbbProtocolo.Items.Add('interbase-6');
  cbbProtocolo.Items.Add('MariaDB-10');
  cbbProtocolo.Items.Add('MariaDB-5');
  cbbProtocolo.Items.Add('mssql');
  cbbProtocolo.Items.Add('mysql');
  cbbProtocolo.Items.Add('mysql-4.1');
  cbbProtocolo.Items.Add('mysql-5');
  cbbProtocolo.Items.Add('mysqld-4.1');
  cbbProtocolo.Items.Add('mysqld-5');
  cbbProtocolo.Items.Add('oracle');
  cbbProtocolo.Items.Add('oracle-9i');
  cbbProtocolo.Items.Add('pooled.*');
  cbbProtocolo.Items.Add('postgresql');
  cbbProtocolo.Items.Add('postgresql-7');
  cbbProtocolo.Items.Add('postgresql-8');
  cbbProtocolo.Items.Add('postgresql-9');
  cbbProtocolo.Items.Add('sqlite');
  cbbProtocolo.Items.Add('sqlite-3');
  cbbProtocolo.Items.Add('sybase');
end;

procedure TMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMDIChild.GravaLeitura(pUsuario,pSenha,pBase,pPorta:TLabeledEdit;pServidor:TEdit;pProtocolo,pComboServ:TComboBox;pGravar:Boolean);
var
  vServerTemp:String;
  function getServerDef(pValor:Boolean;pValorT,pValorF:String):String;
  begin
    if (pValor) then
    begin
      if (pComboServ.ItemIndex <= -1) then
        pComboServ.ItemIndex  :=  0;
      Result                  :=  IntToStr(pComboServ.ItemIndex)  + '-' + pValorT;
    end
    else
    begin
      if (pComboServ.ItemIndex <= -1) then
        pComboServ.ItemIndex  :=  1;
      Result                  :=  IntToStr(pComboServ.ItemIndex)  + '-' + pValorF;
    end;
  end;
  function verificaCampos:Boolean;
  var
    x:Integer;
  begin
    Result  :=  True;
    for x := 0 to Self.ComponentCount - 1  do
    begin
      if (Self.Components[x] is TLabeledEdit) then
      begin
        if (((not TLabeledEdit(Self.Components[x]).NumbersOnly) and
            (TLabeledEdit(Self.Components[x]).Text = '')) or
            ((TLabeledEdit(Self.Components[x]).NumbersOnly) and
            (TLabeledEdit(Self.Components[x]).Text = '0'))) then
            Result  :=  False;
      end
      else if (Self.Components[x] is TComboBox) then
      begin
        if (TComboBox(Self.Components[x]).ItemIndex = -1) then
          Result  :=  False;
      end;
    end;
  end;
begin
  SetParameters;
  if (Registro.OpenKey(vChave,True)) then
  begin
    with Registro do
    begin
      if (pGravar) then
      begin
        if (not verificaCampos) then
        begin
          Application.MessageBox('Todos os campos devem ser preenchidos',
            PChar(Application.Title), MB_OK + MB_ICONSTOP);
          Abort;
        end;
        WriteString(vUserReg,pUsuario.Text);
        WriteString(vPassReg,pSenha.Text);
        WriteString(vProtocol,IntToStr(pProtocolo.ItemIndex)+'-'+pProtocolo.Items[pProtocolo.ItemIndex]);
        WriteString(vPorta,pPorta.Text);
        WriteString(vServer,getServerDef(pServidor.Text='','localhost',pServidor.Text));
        WriteString(vBase,pBase.Text);
        Application.MessageBox('Chaves gravadas com sucesso!',
          PChar(Application.Title), MB_OK + MB_ICONINFORMATION);
      end
      else
      begin
        pUsuario.Text         :=  ReadString(vUserReg);
        pSenha.Text           :=  ReadString(vPassReg);
        pPorta.Text           :=  ReadString(vPorta);
        vServerTemp           :=  ReadString(vServer);
        pBase.Text            :=  ReadString(vBase);
        pComboServ.ItemIndex  :=  StrToIntDef(Copy(vServerTemp,1,Pos('-',vServerTemp)-1),0);
        pServidor.Text        :=  Copy(vServerTemp,Pos('-',vServerTemp)+1,length(vServerTemp));
        vServerTemp           :=  ReadString(vProtocol);
        pProtocolo.ItemIndex  :=  StrToIntDef(Copy(vServerTemp,1,Pos('-',vServerTemp)-1),-1);
      end;
    end;
  end;
  Registro.CloseKey;
  FreeAndNil(Registro);
end;

procedure TMDIChild.SetParameters;
begin
  Registro          :=  TRegistry.Create;
  Registro.RootKey  :=  HKEY_CURRENT_USER;
  vChave            :=  'SOFTWARE\SisGestao';
  vUserReg          :=  'DBUser';
  vPassReg          :=  'DBPassword';
  vProtocol         :=  'DBProtocol';
  vPorta            :=  'DBPort';
  vServer           :=  'DBServer';
  vBase             :=  'DBBase';
end;

end.
