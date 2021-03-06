object MDIChild: TMDIChild
  Left = 197
  Top = 117
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Gravar/editar'
  ClientHeight = 183
  ClientWidth = 421
  Color = clBtnFace
  ParentFont = True
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object grpBancoDados: TGroupBox
    Left = 0
    Top = 0
    Width = 421
    Height = 183
    Align = alClient
    Caption = ' Banco de dados '
    TabOrder = 0
    object lblProtocolo: TLabel
      Left = 8
      Top = 59
      Width = 45
      Height = 13
      Caption = 'Protocolo'
    end
    object lblServer: TLabel
      Left = 8
      Top = 99
      Width = 40
      Height = 13
      Caption = 'Servidor'
    end
    object lbledtUsuario: TLabeledEdit
      Left = 8
      Top = 32
      Width = 174
      Height = 21
      EditLabel.Width = 36
      EditLabel.Height = 13
      EditLabel.Caption = 'Usu'#225'rio'
      TabOrder = 0
    end
    object lbledtSenha: TLabeledEdit
      Left = 188
      Top = 32
      Width = 174
      Height = 21
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Senha'
      PasswordChar = '*'
      TabOrder = 1
    end
    object chkMostrarSenha: TCheckBox
      Left = 364
      Top = 34
      Width = 61
      Height = 17
      Caption = 'Mostrar'
      TabOrder = 2
      OnClick = chkMostrarSenhaClick
    end
    object cbbProtocolo: TComboBox
      Left = 8
      Top = 75
      Width = 174
      Height = 21
      DropDownCount = 30
      TabOrder = 3
    end
    object lbledtPorta: TLabeledEdit
      Left = 188
      Top = 75
      Width = 174
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = 'Porta'
      NumbersOnly = True
      TabOrder = 4
    end
    object cbbServer: TComboBox
      Left = 8
      Top = 115
      Width = 174
      Height = 21
      DropDownCount = 30
      TabOrder = 5
      OnChange = cbbServerChange
      Items.Strings = (
        'Servidor local'
        'Servidor em rede')
    end
    object edtServidor: TEdit
      Left = 188
      Top = 115
      Width = 174
      Height = 21
      Enabled = False
      TabOrder = 6
    end
    object lbledtBase: TLabeledEdit
      Left = 8
      Top = 154
      Width = 174
      Height = 21
      EditLabel.Width = 115
      EditLabel.Height = 13
      EditLabel.Caption = 'Nome da base de dados'
      TabOrder = 7
    end
    object btnSalvar: TButton
      Left = 188
      Top = 152
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 8
      OnClick = btnSalvarClick
    end
  end
end
