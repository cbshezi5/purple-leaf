unit Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Filter.Effects, FMX.Edit,DataCapsule,Register,Dashboard,Character,student;

type
  TForm2 = class(TForm)
    idOrEmail: TEdit;
    passwordLogin: TEdit;
    dashbordLinkPnl: TRectangle;
    dashboardLink: TLabel;
    Label3: TLabel;
    Button1: TButton;
    passHide: TImage;
    passClear: TImage;
    idOrEmailClear: TImage;
    forgotBtn: TButton;
    errorLogin: TLabel;
    GlowEffect1: TGlowEffect;
    Button2: TButton;
    procedure registerLinkClick(Sender: TObject);
    procedure idOrEmailClearClick(Sender: TObject);
    procedure passClearClick(Sender: TObject);
    procedure passHideClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure idOrEmailTyping(Sender: TObject);
    procedure passwordLoginExit(Sender: TObject);
    procedure idOrEmailExit(Sender: TObject);
    procedure idOrEmailEnter(Sender: TObject);
    procedure passwordLoginEnter(Sender: TObject);
    procedure dashbordLinkPnlClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    Connect: TDataModule1;
    regist : TForm1;
    error : Boolean;
    dash : TForm3;
    user : TStudent;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Button2Click(Sender: TObject);
begin
    passwordLogin.Text := 'Tut@2017';
    idOrEmail.Text := 'cbshezi';
end;

procedure TForm2.dashbordLinkPnlClick(Sender: TObject);
var
  I: Integer;
  isID : Boolean;
  password : String;
  next : Boolean;
begin
    GlowEffect1.Parent := dashbordLinkPnl;
    GlowEffect1.AnimateFloat('Opacity',1,0.3);
    isID := true;
    next := false;


    if idOrEmail.Text = '' then
    begin
         idOrEmailExit(Self);
         error := true;
    end;


    if passwordLogin.Text = ''  then
    begin
         passwordLoginExit(Self);
         error := true;
    end;

    if not error then
    begin

    for I := 1 to idOrEmail.Text.Length do
    begin
        if not IsDigit(idOrEmail.Text[I]) then
        begin
            isID := false;

        end;
    end;

    if isID then
    begin
      Connect.SQL_Students('SELECT pass_word FROM `users` WHERE id_number = '''+idOrEmail.Text+'''');
      password := Connect.getField_Student('pass_word').AsString;


      if password = passwordLogin.Text then
      begin
        next := true;
      end
      else
      begin
         errorLogin.Text := 'Password is wrong';
          errorLogin.AnimateFloat('Opacity',1,0.3);
      end;

       if password = '' then
      begin
          errorLogin.Text := 'ID number does not exist';
          errorLogin.AnimateFloat('Opacity',1,0.3);
      end;
    end
    else
    begin
       Connect.SQL_Students('SELECT pass_word FROM `users` WHERE email = '''+idOrEmail.Text+'''');
      password := Connect.getField_Student('pass_word').AsString;


      if password = passwordLogin.Text then
      begin
        next := true;
      end
      else
      begin
          errorLogin.Text := 'Password is wrong';
          errorLogin.AnimateFloat('Opacity',1,0.3);
      end;

      if password = '' then
      begin
          errorLogin.Text := 'Email does not exist';
          errorLogin.AnimateFloat('Opacity',1,0.3);
      end;
    end;

    if next then
    begin
    dash := TForm3.Create(nil);
    dash.allow(Form2,idOrEmail.Text,isID);
    dash.Show();
    Self.Hide();
    end;

    end;
    GlowEffect1.AnimateFloat('Opacity',0,0.3);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
   Connect :=  TDataModule1.Create(nil);
    error := false;
end;

procedure TForm2.idOrEmailClearClick(Sender: TObject);
begin
        idOrEmail.Text := '';
end;

procedure TForm2.idOrEmailEnter(Sender: TObject);
begin
    error := false;
end;

procedure TForm2.idOrEmailExit(Sender: TObject);
begin
    idOrEmailTyping(Self);
    if(not error) then
    begin
    if idOrEmail.Text.IsEmpty then
    begin
          errorLogin.Text := 'ID or E-mail field can not be empty';
          errorLogin.AnimateFloat('Opacity',1,0.3);
          error := true;
    end
    else
    begin
          errorLogin.Text := '';
          errorLogin.AnimateFloat('Opacity',0,0.3);
          error := false;
    end;
    end;

end;

procedure TForm2.idOrEmailTyping(Sender: TObject);
begin
     if idOrEmail.Text.IndexOf(' ') = -1 then
    begin
          errorLogin.Text := '';
          errorLogin.AnimateFloat('Opacity',0,0.3);
          error := false;
    end;

    if(not error) then
    begin
        if idOrEmail.Text.IndexOf(' ') > 0 then
        begin
          errorLogin.Text := 'You can not have a space on the id or email field';
          errorLogin.AnimateFloat('Opacity',1,0.3);
          error := true;
        end
    end;


end;

procedure TForm2.passClearClick(Sender: TObject);
begin
      passwordLogin.Text := '';
end;

procedure TForm2.passHideClick(Sender: TObject);
begin
    if passwordLogin.Password then
      passwordLogin.Password := false
    else
      passwordLogin.Password := true;
end;

procedure TForm2.passwordLoginEnter(Sender: TObject);
begin
  error := false;
end;

procedure TForm2.passwordLoginExit(Sender: TObject);
begin
    if(not error) then
    begin
    if passwordLogin.Text = '' then
    begin
          errorLogin.Text := 'Password field can not be empty';
          errorLogin.AnimateFloat('Opacity',1,0.5);
          error := true;
    end
    else
    begin
          errorLogin.Text := '';
          errorLogin.AnimateFloat('Opacity',0,0.5);
          error := false;
    end;
    end;
end;

procedure TForm2.registerLinkClick(Sender: TObject);
begin
   GlowEffect1.Parent := dashbordLinkPnl;
   GlowEffect1.AnimateFloat('Opacity',1,0.3);
   regist := TForm1.Create(nil);
   regist.Allo(Form2);
   regist.Show();
   Form2.Hide();
   GlowEffect1.AnimateFloat('Opacity',0,0.3);
end;
end.
