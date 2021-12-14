unit DataCapsule;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.UI.Intf,
  FireDAC.FMXUI.Wait,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.IBDef,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.IB,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  DBAccess,
  MyAccess,
  MemDS,
  System.Threading;


type
    TDataModule1 = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);


  private
    { Private declarations }
    connection: TMyConnection;
    MyQ_student: TMyQuery;
    MyQ_subject: TMyQuery;
    MyQ_course: TMyQuery;
    MyQ_tempQuery: TMyQuery;
    MyC_DMLsql: TMyCommand;
    MyC_DMLsqlTwo: TMyCommand;

  public
    { Public declarations }
    procedure SQL_Students(SQL: String);
    function getField_Student(Field : String):TField;
    procedure SQL_Subject(SQL: String);
    function SQL_SubjectNo(): Integer;
    function getField_Subject(Field : String):TField;
    procedure operation_Subject(operate: char; table : String);
    procedure SQL_Course(SQL: String);
    function SQL_CourseNo():Integer;
    function getField_Course(Field : String):TField;
    procedure operation_Course(operate: char);
    procedure SQL_TempQuery(SQL: String);
    function getField_TempQury(Field : String):TField;
    procedure SQL_DML_ONE(DMLSQL : String);
    procedure SQL_DML_TWO(DMLSQL : String);
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}


{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
var
  messag : Exception;
begin
    {connection initialization}
    connection := TMyConnection.Create(nil);
    connection.Port := 3306;
    connection.Password := 'Tut@123';
    connection.Database := 'coursecamp';
    connection.Server := '192.168.43.128';
    connection.Username := 'cousecamp';

    try

       if connection.Connected <> true then
        connection.Connected := true;
    except
        messag := Exception.Create('Error1');
        ApplicationShowException(messag);
    end;


    {Memory allocation}
    MyQ_student := TMyQuery.Create(nil);
    MyQ_subject := TMyQuery.Create(nil);
    MyQ_course := TMyQuery.Create(nil);
    MyQ_tempQuery := TMyQuery.Create(nil);
    MyC_DMLsql := TMyCommand.Create(nil);
    MyC_DMLsqlTwo := TMyCommand.Create(nil);
    {DB controls assigne to connection}
    MyQ_student.Connection := connection;
    MyQ_subject.Connection := connection;
    MyQ_course.Connection := connection;
    MyQ_tempQuery.Connection := connection;
    MyC_DMLsql.Connection := connection;
    MyC_DMLsqlTwo.Connection := connection;
end;

procedure TDataModule1.SQL_Students(SQL: String);

begin
      MyQ_student.Active := false;
      MyQ_student.SQL.Clear();
      MyQ_student.SQL.Add(SQL);
      MyQ_student.Active := true;
end;

function TDataModule1.getField_Student(Field : String):TField;
begin
   getField_Student := MyQ_student.FieldByName(Field);
end;


procedure TDataModule1.SQL_Subject(SQL: String);
begin

      MyQ_subject.Active := false;
      MyQ_subject.SQL.Clear();
      MyQ_subject.SQL.Add(SQL);
      MyQ_subject.Active := true;

end;

function TDataModule1.getField_Subject(Field : String):TField;
begin
        getField_Subject :=  MyQ_subject.FieldByName(Field);
end;

function TDataModule1.SQL_SubjectNo():Integer;
begin
    SQL_SubjectNo :=  MyQ_subject.RecordCount;
end;

procedure TDataModule1.operation_Subject(operate: char; table : String);
begin

    if table = 'subject' then
    begin
    case(operate) of
    'N' :  MyQ_subject.Next();
    'P' :  MyQ_subject.Prior();
    'F' :  MyQ_subject.First();
    'L' :  MyQ_subject.Last();
    'S':  MyQ_subject.Post();
    'I' : MyQ_subject.Insert();
    'E' : MyQ_subject.Edit();
     end;
    end;

    if table = 'courses' then
    begin
    case(operate) of
    'N' :  MyQ_course.Next();
    'P' :  MyQ_course.Prior();
    'F' :  MyQ_course.First();
    'L' :  MyQ_course.Last();
    'S':  MyQ_course.Post();
    'I' : MyQ_course.Insert();
    'E' : MyQ_course.Edit();
     end;
    end;




end;

 //-------------Courses

procedure TDataModule1.SQL_Course(SQL: String);
begin
      MyQ_course.Active := false;
      MyQ_course.SQL.Clear();
      MyQ_course.SQL.Add(SQL);
      MyQ_course.Active := true;
end;

function TDataModule1.getField_Course(Field : String):TField;
begin
        getField_Course := MyQ_course.FieldByName(Field);
end;

function TDataModule1.SQL_CourseNo():Integer;
begin
      SQL_CourseNo := MyQ_course.RecordCount;
end;

procedure TDataModule1.operation_Course(operate: char);
begin

  case(operate) of
    'N' :  MyQ_course.Next();
    'P' :  MyQ_course.Prior();
    'F' :  MyQ_course.First();
    'L' :  MyQ_course.Last();
    'S':  MyQ_course.Post();
    'I' : MyQ_course.Insert();
    'E' : MyQ_course.Edit();
  end;

end;

//-------------Courses

procedure TDataModule1.SQL_TempQuery(SQL: String);
begin
      MyQ_tempQuery.Active := false;
      MyQ_tempQuery.SQL.Clear();
      MyQ_tempQuery.SQL.Add(SQL);
      MyQ_tempQuery.Active := true;
end;

function TDataModule1.getField_TempQury(Field : String):TField;
begin
        getField_TempQury := MyQ_tempQuery.FieldByName(Field);
end;

procedure TDataModule1.SQL_DML_ONE(DMLSQL : String);
begin
          MyC_DMLsql.SQL.Clear();
          MyC_DMLsql.SQL.Add(DMLSQL);
          MyC_DMLsql.Execute;
end;

procedure TDataModule1.SQL_DML_TWO(DMLSQL : String);
begin
          MyC_DMLsqlTwo.SQL.Clear();
          MyC_DMLsqlTwo.SQL.Add(DMLSQL);
          MyC_DMLsqlTwo.Execute;
end;

end.






