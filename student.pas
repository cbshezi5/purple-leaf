unit student;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.Layouts,
  FMX.ListBox, FMX.Effects,DataCapsule;


type
  TStudent = class

private
    ids : String;
    age : Integer;
    dob : TDate;
    fname : String;
    lname : String;
    idno : String;
    email : String;
    phoneno : String;
    user_score : Integer;
    ProfileImage : TBytes;
    password : String;
    dataPort : TDataModule1;

public
    procedure set_StudentFromRemote(SQL : String; id :Boolean);
    procedure initializer();
    procedure setPersonalDetails(firstname : String; lastname : String);
    procedure setContactDetails(phoneNum : String; mail :String);
    procedure setAccountCreds(idnum : String; passwordRef : String);

    procedure idParseInfo(IdNumber : String);
    function get_score():Integer;
    function get_age(): Integer;
    function get_dob(): TDate;
    function get_fname(): String;
    function get_lname(): String;
    function get_idno(): String;
    function get_email(): String;
    function get_phoneno(): String;
    function get_ProfileImage(): TBytes;
    function get_password(): String;
    function get_id(): String;

end;

implementation

    procedure TStudent.initializer();
    begin
       dataPort := TDataModule1.Create(nil);
    end;


    procedure TStudent.set_StudentFromRemote(SQL : String; id : Boolean);
    begin
       if id then
       begin
         dataPort.SQL_Students('SELECT email FROM `users` WHERE id_number = '''+SQL+'''');
         email := dataPort.getField_Student('email').AsString;
         idno := SQL;
       end
       else
       begin
         dataPort.SQL_Students('SELECT id_number FROM `users` WHERE email = '''+SQL+'''');
         idno := dataPort.getField_Student('id_number').AsString;
         email := SQL;
       end;
    end;

    //------------------Student Details in Steps of Registration
    procedure TStudent.setPersonalDetails(firstname : String; lastname : String);
    begin
        lname := lastname;
        fname := firstname;
    end;

    procedure TStudent.setContactDetails(phoneNum : String; mail :String);
    begin
        phoneno := phoneNum;
        email := mail;
    end;


    procedure TStudent.setAccountCreds(idnum : String; passwordRef : String);
    begin
        idno := idnum;
        password := passwordRef;
        idParseInfo(idno);
    end;


    procedure TStudent.idParseInfo(IdNumber : String);
    begin


    end;


    function TStudent.get_score():Integer;
    begin
        dataPort.SQL_Students('SELECT user_score FROM `users` WHERE id_number = '''+idno+'''');
         user_score := dataPort.getField_Student('user_score').AsInteger;
        get_score := user_score;
    end;



    function TStudent.get_id(): String;
    begin
        dataPort.SQL_Students('SELECT user_id FROM `users` WHERE id_number = '''+idno+'''');
         ids := dataPort.getField_Student('user_id').AsString;
        get_id := ids;
    end;

    function  TStudent.get_age(): Integer;
    begin

        get_age := age;
    end;
    function  TStudent.get_dob(): TDate;
    begin

        get_dob := dob;
    end;
    function  TStudent.get_fname(): String;
    begin
        dataPort.SQL_Students('SELECT name FROM `users` WHERE id_number = '''+idno+'''');
         fname := dataPort.getField_Student('name').AsString;
        get_fname :=  fname;
    end;
    function  TStudent.get_lname(): String;
    begin
        dataPort.SQL_Students('SELECT surname FROM `users` WHERE id_number = '''+idno+'''');
         lname := dataPort.getField_Student('surname').AsString;
        get_lname :=  lname;
    end;
    function  TStudent.get_idno(): String;
    begin
        dataPort.SQL_Students('SELECT id_number FROM `users` WHERE id_number = '''+idno+'''');
         idno := dataPort.getField_Student('id_number').AsString;
        get_idno :=  idno;
    end;
    function  TStudent.get_email(): String;
    begin
        dataPort.SQL_Students('SELECT email FROM `users` WHERE id_number = '''+idno+'''');
         email := dataPort.getField_Student('email').AsString;
       get_email :=  email;
    end;
    function  TStudent.get_phoneno(): String;
    begin
          dataPort.SQL_Students('SELECT phoneno FROM `users` WHERE id_number = '''+idno+'''');
         phoneno := dataPort.getField_Student('phoneno').AsString;
       get_phoneno :=  phoneno;
    end;
    function  TStudent.get_ProfileImage(): TBytes;
    begin
        dataPort.SQL_Students('SELECT profilepic FROM `users` WHERE id_number = '''+idno+'''');
         profileImage := dataPort.getField_Student('profilepic').AsBytes;
       get_ProfileImage := ProfileImage;
    end;
    function  TStudent.get_password(): String;
    begin
        dataPort.SQL_Students('SELECT pass_word FROM `users` WHERE id_number = '''+idno+'''');
         password := dataPort.getField_Student('pass_word').AsString;
        get_password := password;
    end;
end.
