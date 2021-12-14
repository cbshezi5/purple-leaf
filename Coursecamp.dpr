program Coursecamp;

uses
  System.StartUpCopy,
  FMX.Forms,
  Login in 'Login.pas' {Form2},
  DataCapsule in 'DataCapsule.pas' {DataModule1: TDataModule},
  Register in 'Register.pas' {Form1},
  student in 'student.pas',
  Dashboard in 'Dashboard.pas' {Form3},
  courses in 'courses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
