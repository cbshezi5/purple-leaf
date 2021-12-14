unit Register;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.Layouts,
  FMX.ListBox, FMX.Effects,student,character;

type
  TForm1 = class(TForm)
    Step1: TRectangle;
    Step3: TRectangle;
    Step2: TRectangle;
    fname: TEdit;
    lastname: TEdit;
    email: TEdit;
    phoneNumber: TEdit;
    veriButton: TRectangle;
    eightDigit: TEdit;
    buttonLab: TLabel;
    idNumber: TEdit;
    password: TEdit;
    rePassword: TEdit;
    buttonFoward: TRectangle;
    nextLbl: TLabel;
    back: TButton;
    Step4: TRectangle;
    confirmation: TListBox;
    Step5: TRectangle;
    licenceAgree: TListBox;
    prograss: TLine;
    currentPrograss: TLine;
    Details: TLabel;
    passClear: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    GlowEffect1: TGlowEffect;
    cerrRegi: TLabel;
    procedure backClick(Sender: TObject);
    procedure nextLblClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure passClearClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure fnameTyping(Sender: TObject);
    procedure fnameEnter(Sender: TObject);
    procedure lastnameEnter(Sender: TObject);
    procedure fnameExit(Sender: TObject);
    procedure lastnameExit(Sender: TObject);
    procedure emailExit(Sender: TObject);
    procedure emailEnter(Sender: TObject);
    procedure lastnameTyping(Sender: TObject);
  private
    { Private declarations }
    page : Integer;
    login : TForm;
    step1Cerr : Boolean;
    step2Cerr : Boolean;
    step3Cerr : Boolean;
    step4Cerr : Boolean;
    step5Cerr : Boolean;
    studentHolder : TStudent;
    procedure pager(page : Integer);

  public
    { Public declarations }
    procedure Allo(loginForm : TForm);
  end;

var
  Form1: TForm1;



implementation
{$R *.fmx}

procedure TForm1.Allo(loginForm : TForm);
begin
    login := TForm.CreateNew(Self);
    login := loginForm;
    page := 1;
    studentHolder := TStudent.Create;
    step1Cerr := false;
    step2Cerr := false;
    step3Cerr := false;
    step4Cerr := false;
    step5Cerr := false;
end;



procedure TForm1.backClick(Sender: TObject);
begin
    GlowEffect1.Parent := back;
    GlowEffect1.AnimateFloat('Opacity',1,0.3);
    if page > 0 then
    page := page -  1;
    pager(page);

    if page = 0 then
    begin
      login.Show();
      Self.Hide();
    end;
     GlowEffect1.AnimateFloat('Opacity',0,0.3);
end;

procedure TForm1.emailEnter(Sender: TObject);
begin
          cerrRegi.Text := 'Incorrect E-mail';
          cerrRegi.AnimateFloat('Opacity',0,0.3);
          step1Cerr := false;
end;

procedure TForm1.emailExit(Sender: TObject);
var
tempStore : string;
begin

    if email.Text.IndexOf('@') < 0 then
    begin
          cerrRegi.Text := 'Incorrect E-mail';
          cerrRegi.AnimateFloat('Opacity',1,0.3);
          step1Cerr := true;
    end;

    if email.Text.IndexOf('.') < 0 then
    begin
          cerrRegi.Text := 'Incorrect E-mail';
          cerrRegi.AnimateFloat('Opacity',1,0.3);
          step1Cerr := true;
    end;

    if email.Text.IndexOf('@') > email.Text.IndexOf('.') then
    begin
          cerrRegi.Text := 'Incorrect E-mail';
          cerrRegi.AnimateFloat('Opacity',1,0.3);
          step1Cerr := true;
    end;


    if email.Text.Length > 1 then
    begin
    if not  IsLetterOrDigit(email.Text[1]) then
    begin
          cerrRegi.Text := 'Incorrect E-mail';
          cerrRegi.AnimateFloat('Opacity',1,0.3);
          step1Cerr := true;
    end;
    end;


    if email.Text.IsEmpty then
    begin
          cerrRegi.Text := 'E-mail Field can not be empty';
          cerrRegi.AnimateFloat('Opacity',1,0.3);
          step1Cerr := true;
    end;

end;

procedure TForm1.fnameEnter(Sender: TObject);
begin
      step1Cerr := false;
end;

procedure TForm1.fnameExit(Sender: TObject);
begin
      fnameTyping(Self);
     lastnameTyping(Self);


     if(not step1Cerr) then
     begin
      if fname.Text.IsEmpty then
      begin
          cerrRegi.Text := 'Field for First name is empty';
          cerrRegi.AnimateFloat('Opacity',1,0.3);
          step1Cerr := true;
      end
      
     else
     if fname.Text.Length < 2 then
     begin
          cerrRegi.Text := 'Too Short First name';
          cerrRegi.AnimateFloat('Opacity',1,0.3);
          step1Cerr := true;
     end
      else
      begin
          cerrRegi.Text := '';
          cerrRegi.AnimateFloat('Opacity',0,0.3);
          step1Cerr := false;
      end;
     end;



end;

procedure TForm1.fnameTyping(Sender: TObject);
begin
     if(not step1Cerr) then
     begin
      if fname.Text.IndexOf(' ') > 0 then
      begin
          cerrRegi.Text := 'You can not have a space on your First name';
          cerrRegi.AnimateFloat('Opacity',1,0.3);
          step1Cerr := true;
      end;


      if fname.Text.Length > 30 then
      begin
          cerrRegi.Text := 'Too long First name';
          cerrRegi.AnimateFloat('Opacity',1,0.3);
          step1Cerr := true;
      end;
     end;

     if fname.Text.IndexOf(' ') = -1 then
     begin
          cerrRegi.Text := '';
          cerrRegi.AnimateFloat('Opacity',0,0.3);
          step1Cerr := false;
     end;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
    lastname.Text := '';
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
    phoneNumber.Text := '';
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
  email.Text := '';
end;

procedure TForm1.Image4Click(Sender: TObject);
begin
    rePassword.Text := '';
end;

procedure TForm1.Image5Click(Sender: TObject);
begin
    password.Text := '';
end;

procedure TForm1.Image6Click(Sender: TObject);

begin
  idNumber.Text := '';
end;

procedure TForm1.Image7Click(Sender: TObject);
begin
        if password.Password then
        begin
            password.Password := false;
            rePassword.Password := false;
        end
        else
        begin
            password.Password := true;
            rePassword.Password := true;
        end;
end;

procedure TForm1.lastnameEnter(Sender: TObject);
begin
    step1Cerr := false;
end;

procedure TForm1.lastnameExit(Sender: TObject);
begin
    fnameTyping(Self);
     lastnameTyping(Self);

    if(not step1Cerr) then
     begin
      if lastname.Text.IsEmpty then
      begin
          cerrRegi.Text := 'Field for Last name is empty';
          cerrRegi.AnimateFloat('Opacity',1,0.3);
          step1Cerr := true;
      end
      else
     if lastname.Text.Length < 2 then
     begin
          cerrRegi.Text := 'Too Short Last name';
          cerrRegi.AnimateFloat('Opacity',1,0.3);
          step1Cerr := true;
     end
      else
      begin
          cerrRegi.Text := '';
          cerrRegi.AnimateFloat('Opacity',0,0.3);
          step1Cerr := false;
      end;
     end;


end;

procedure TForm1.lastnameTyping(Sender: TObject);
begin
     if(not step1Cerr) then
     begin
      if lastname.Text.IndexOf(' ') > 0 then
      begin
          cerrRegi.Text := 'You can not have a space on your Last name';
          cerrRegi.AnimateFloat('Opacity',1,0.3);
          step1Cerr := true;
      end;


      if lastname.Text.Length > 30 then
      begin
          cerrRegi.Text := 'Too long Last name';
          cerrRegi.AnimateFloat('Opacity',1,0.3);
          step1Cerr := true;
      end;
     end;

     if lastname.Text.IndexOf(' ') = -1 then
     begin
          cerrRegi.Text := '';
          cerrRegi.AnimateFloat('Opacity',0,0.3);
          step1Cerr := false;
     end;
end;

procedure TForm1.nextLblClick(Sender: TObject);
begin
      GlowEffect1.Parent := buttonFoward;
      GlowEffect1.AnimateFloat('Opacity',1,0.3);

      if page = 1 then
      begin
      lastnameExit(Self);
      fnameExit(Self);
      if fname.Text = lastname.Text then
      begin
        cerrRegi.Text := 'First name can not be the same as your Last name';
        cerrRegi.AnimateFloat('Opacity',1,0.3);
        step1Cerr := true;
      end;
      end;
      if  not step1Cerr then
      begin
      if page < 6 then
      page := page + 1;
      pager(page);
      studentHolder.setPersonalDetails(fname.Text,lastname.Text);
      end;
      GlowEffect1.AnimateFloat('Opacity',0,0.3);
end;


procedure TForm1.pager(page : Integer);
begin
          case(page) of
          1 :
              begin
                  Step1.Visible := true;
                  Step2.Visible := false;
                  Step3.Visible := false;
                  Step4.Visible := false;
                  Step5.Visible := false;
                  back.Text := 'Login';
                  currentPrograss.AnimateFloat('Width',prograss.Width * 0.15,0.3);
                  Details.Text := 'Personal Details';
                  cerrRegi.Position.Y := 592;
              end;
          2  :
              begin
                  Step1.Visible := false;
                  Step2.Visible := true;
                  Step3.Visible := false;
                  Step4.Visible := false;
                  Step5.Visible := false;
                  back.Text := 'Back';
                  currentPrograss.AnimateFloat('Width',prograss.Width * 0.30,0.3);
                  Details.Text := 'Contact Details & Verificaton';
                  cerrRegi.Position.Y := 392;
              end;
          3  :
              begin
                  Step1.Visible := false;
                  Step2.Visible := false;
                  Step3.Visible := true;
                  Step4.Visible := false;
                  Step5.Visible := false;
                  currentPrograss.AnimateFloat('Width',prograss.Width * 0.60,0.3);
                  Details.Text := 'Account Credintials';
                  cerrRegi.Position.Y := 528;
              end;
          4  :
              begin
                  Step1.Visible := false;
                  Step2.Visible := false;
                  Step3.Visible := false;
                  Step4.Visible := true;
                  Step5.Visible := false;
                  currentPrograss.AnimateFloat('Width',prograss.Width * 0.80,0.3);
                  Details.Text := 'Details Confirmation';
              end;
          5  :
              begin
                  Step1.Visible := false;
                  Step2.Visible := false;
                  Step3.Visible := false;
                  Step4.Visible := false;
                  Step5.Visible := true;
                  nextLbl.Text := 'Next';
                  currentPrograss.AnimateFloat('Width',prograss.Width * 1,0.3);
                  prograss.Visible := true;
                  Details.Text := 'License Agreement';
              end;
          6   :
              begin
                  Step1.Visible := false;
                  Step2.Visible := false;
                  Step3.Visible := false;
                  Step4.Visible := false;
                  Step5.Visible := false;
                  nextLbl.Text := 'Welcome';
                  prograss.Visible := false;
              end;
          end;
end;

procedure TForm1.passClearClick(Sender: TObject);
begin
  fname.Text := '';
end;

end.

