unit Dashboard;
//------------------ File Starts
interface

uses
  //Common Libraries
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Effects, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation,student,
  FMX.ListBox,DataCapsule, FMX.Edit,Generics.Collections,courses,System.Threading,
  FMX.ScrollBox
  //---------------Android Libs
  {$IFDEF ANDROID}
  ,Androidapi.JNI.Os, Androidapi.JNI.GraphicsContentViewText,Androidapi.Helpers,Androidapi.JNIBridge
  {$ENDIF}
  ;
 //--------------- course save class
type
  TcoursesTemp = class
    public
    course_Name : String;
    course_aps : Integer;
    course_faculty : String;
    course_camps : String;
end;
//--------------------Main class Starts
type
  TForm3 = class(TForm)
    //---------------------------- FMX UI/UX Controls
    Rectangle1: TRectangle;
    Circle1: TCircle;
    Layout1: TLayout;
    ShadowEffect1: TShadowEffect;
    Layout2: TLayout;
    Layout3: TLayout;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Rectangle2: TRectangle;
    Label1: TLabel;
    Layout5: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Layout6: TLayout;
    Button1: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Image6: TImage;
    Image4: TImage;
    Image7: TImage;
    marks: TLayout;
    courses: TLayout;
    Subj1: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Layout7: TLayout;
    Subj2: TComboBox;
    Subj3: TComboBox;
    Subj6: TComboBox;
    Subj5: TComboBox;
    Subj4: TComboBox;
    Subj7: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label6: TLabel;
    Label14: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    ScoreMeter: TLayout;
    TrackBar1: TTrackBar;
    Rectangle3: TRectangle;
    Label15: TLabel;
    Layout9: TLayout;
    Image5: TImage;
    perc: TLabel;
    Circle2: TCircle;
    ShadowEffect2: TShadowEffect;
    total: TLabel;
    GlowEffect1: TGlowEffect;
    Timer1: TTimer;
    Label16: TLabel;
    Line1: TLine;
    Label17: TLabel;
    Timer2: TTimer;
    VertScrollBox1: TVertScrollBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Layout4: TLayout;
    search: TEdit;
    sample: TLabel;
    Label21: TLabel;
    VertScrollBox2: TVertScrollBox;
    GlowEffect2: TGlowEffect;
    InnerGlowEffect1: TInnerGlowEffect;
    Toaster: TLayout;
    Rectangle4: TRectangle;
    toasterMsg: TLabel;
    Dashboard: TLayout;
    procedure Button1Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Subj1Popup(Sender: TObject);
    procedure Label15Click(Sender: TObject);
    procedure TrackBar1Tracking(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Subj1ClosePopup(Sender: TObject);
    procedure Subj4ClosePopup(Sender: TObject);
    procedure Subj5ClosePopup(Sender: TObject);
    procedure Image3Gesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Circle2Click(Sender: TObject);
    procedure marksClick(Sender: TObject);

  private
    { Private declarations }
    //----------------- Priv Data Members
    loginForm :TForm;
    user : TStudent;
    dataController : TDataModule1;
    clickedNumber : TControl;
    tot : Integer;
    timerTracker : Integer;
    timerTracker2 : Integer;
    delay : TTimer;
    userPoints : Integer;
    buttonShowing : Boolean;
    marksShowing : Boolean;
    profileShows : Boolean;
    prev : Integer;
    courseBlock : TCourse;
    courseTemp : TcoursesTemp;
    courseTempList : TObjectList<TcoursesTemp>;
    taskingDownloading : ITask;
    taskingAssigning : ITask;
    saveYBtn : Single;
    toastTracker :Integer;
    toastShowing : Boolean;
    //------------------- Priv Function Members
    procedure hideOrShow();
    procedure silderCourse();
    procedure sliderMarks();
    procedure sliderProfile();
    procedure setScale();
    procedure saveSubjects();
    function subjectID() : Integer;
    function subjectCode(subjName : String) : String;
    procedure toasterShow(msg : String);
    procedure delayTick(Sender: TObject);
  public
    { Public declarations }
    //--------------------- Public fuction Members
    procedure allow(login : TForm; userCred : String; isID : Boolean);
    procedure get_courses(aps_Score : Integer; fac_Name : String; cou_Name : String; cam_Name : String; me : Boolean);
  end;
  //-----------------------------------Declaration Ends
  //-----------------------------------Implementation Start
var
  Form3: TForm3;

implementation

{$R *.fmx}

var
    courseList : TObjectList<TCourse>;
//---------------------------------Constructor or Initializer
procedure  TForm3.allow(login : TForm; userCred : String; isID : Boolean);
 var
    I: Integer;
    numOfLang : Integer;
    langSubj : String;
begin
   loginForm := TForm.CreateNew(Self);
   loginForm := login;
   user := TStudent.Create;
   user.initializer;
   user.set_StudentFromRemote(userCred,isID);
   Label1.Text := user.get_fname + ' ' + user.get_lname;
   Label2.Text := user.get_idno;
   Label3.Text := user.get_email+' | '+user.get_phoneno;
   total.Text := IntToStr(user.get_score);
   buttonShowing := true;
   marksShowing := true;
   toastShowing := false;
   profileShows := false;
   prev := 0;
   saveYBtn := Layout1.Position.Y;

    dataController := TDataModule1.Create(nil);
    dataController.DataModuleCreate(nil);

    subj1.Items.Clear;
    subj1.Items.Add('Select subject');
    subj2.Items.Clear;
    subj2.Items.Add('Add 1st Subject First');
    subj2.ItemIndex := 0;
    subj1.ItemIndex := 0;
    subj3.Items.Add('Select subject');
    subj3.ItemIndex := 0;
    subj4.Items.Add('Select subject');
    subj4.ItemIndex := 0;
    subj5.Items.Add('Add 4th Subject First');
    subj5.ItemIndex := 0;
    subj6.Items.Add('Add 5th Subject First');
    subj6.ItemIndex := 0;


    //First additional assignement
    dataController.SQL_Subject('SELECT subj_name FROM `subjects` WHERE subj_type = ''Lang''  AND NOT subj_name = '''+Subj1.Items[Subj1.ItemIndex]+''' AND NOT subj_name = '''+Subj2.Items[Subj2.ItemIndex]+'''');
    numOfLang := dataController.SQL_SubjectNo();
    for I := 1 to numOfLang do
    begin
        langSubj := dataController.getField_Subject('subj_name').AsString;
        Subj1.Items.Add(langSubj);
        dataController.operation_Subject('N','subject');
    end;
//
    //Other Additional Assignment
    dataController.SQL_Subject('SELECT subj_name FROM `subjects` WHERE subj_type = ''Other'' ');
    numOfLang := dataController.SQL_SubjectNo();

    for I := 1 to numOfLang do
    begin
        langSubj := dataController.getField_Subject('subj_name').AsString;
        Subj4.Items.Add(langSubj);
        dataController.operation_Subject('N','subject');
    end;

    //Mathematics assignment
    dataController.SQL_Subject('SELECT subj_name FROM `subjects` WHERE subj_type = ''Math'' ');
    numOfLang := dataController.SQL_SubjectNo();

    for I := 1 to numOfLang do
    begin
        langSubj := dataController.getField_Subject('subj_name').AsString;
        Subj3.Items.Add(langSubj);
        dataController.operation_Subject('N','subject');
    end;

     //LO Lang Assignment
    dataController.SQL_Subject('SELECT subj_name FROM `subjects` WHERE subj_type = ''LO'' ');
    numOfLang := dataController.SQL_SubjectNo();

    for I := 1 to numOfLang do
    begin
        langSubj := dataController.getField_Subject('subj_name').AsString;
        Subj7.Items.Add(langSubj);
        dataController.operation_Subject('N','subject');
    end;

    Subj7.ItemIndex := 0;
    timerTracker := 0;
    timerTracker2 := 0;
    clickedNumber := TControl.Create(nil);


    setScale();
    sliderProfile();

end;

procedure TForm3.Button1Click(Sender: TObject);
begin
    loginForm.Show();
    Self.Hide();
end;

procedure TForm3.Circle2Click(Sender: TObject);
begin
   saveSubjects();
end;
//--- Show Course(s) and UnHide btn
procedure TForm3.Image1Click(Sender: TObject);
begin
      GlowEffect2.Parent := Image1;
      GlowEffect2.GlowColor := TAlphaColorRec.Darkviolet;
      GlowEffect2.AnimateFloat('Opacity',1,0.4);
      silderCourse();
      GlowEffect2.AnimateFloat('Opacity',0,0.4);

      if not buttonShowing then
      begin
      GlowEffect2.Parent := Image1;
      GlowEffect2.GlowColor := TAlphaColorRec.Red;
      GlowEffect2.AnimateFloat('Opacity',1,0.4);
      Layout1.AnimateFloat('RotationAngle',0,0.2);
      Layout1.AnimateFloat('Position.Y',saveYBtn,0.2);
      Layout1.Align := TAlignLayout.Bottom;
      buttonShowing := true;
      GlowEffect2.Parent := Image1;
      GlowEffect2.AnimateFloat('Opacity',0,0.4);
      end;
end;
//---- Show Marks slide
procedure TForm3.Image2Click(Sender: TObject);
begin
      if not marksShowing then
      begin
          GlowEffect2.Parent := Image2;
          GlowEffect2.GlowColor := TAlphaColorRec.Darkviolet;
          GlowEffect2.AnimateFloat('Opacity',1,0.4);
          sliderMarks();
          GlowEffect2.AnimateFloat('Opacity',0,0.4);
      end
      else
      begin
          GlowEffect2.AnimateFloat('Opacity',1,0.4);
          GlowEffect2.AnimateFloat('Opacity',0,0.4);
      end;
end;

//----------------------------------------------- Main Button Gesture Stress--
procedure TForm3.Image3Gesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
{$IFDEF WIN32}
var
  I : Integer;
{$ENDIF}
{$IFDEF ANDROID}
var
  Vibrator:JVibrator;
  I : Integer;
{$ENDIF}
begin

    if marksShowing then
    begin
      if EventInfo.GestureID = System.UITypes.igiDoubleTap then
      begin
           InnerGlowEffect1.AnimateFloat('Softness',1,0.2);
           InnerGlowEffect1.AnimateFloat('Softness',0,0.2);
           InnerGlowEffect1.AnimateFloat('Softness',1,0.2);

           tot := StrToInt(Button2.Text)+StrToInt(Button3.Text)+StrToInt(Button4.Text)+StrToInt(Button5.Text)+StrToInt(Button6.Text)+StrToInt(Button7.Text);
           Total.Text := '0';
           timerTracker := 0;
           Timer1.Enabled := true;
           Label14.Text := 'Click the score to save your scoreboard';

           InnerGlowEffect1.AnimateFloat('Softness',0,0.2);
           InnerGlowEffect1.AnimateFloat('Softness',1,0.2);
           InnerGlowEffect1.AnimateFloat('Softness',0,0.2);
      end;

      if EventInfo.GestureID = System.UITypes.igiLongTap then
      begin
            InnerGlowEffect1.AnimateFloat('Softness',1,0.6);
            sliderProfile();
            {$IFDEF ANDROID}
          Vibrator:=TJVibrator.Wrap((SharedActivityContext.getSystemService(TJContext.JavaClass.VIBRATOR_SERVICE) as ILocalObject).GetObjectID);
        // Vibrate for 500 milliseconds
          Vibrator.vibrate(10);
          {$ENDIF}
          InnerGlowEffect1.AnimateFloat('Softness',0,0.2);
      end;

    end;

    if not marksShowing then
    begin
      if EventInfo.GestureID = System.UITypes.igiDoubleTap then
      begin
          if search.Text = '' then
          begin
              InnerGlowEffect1.AnimateFloat('Softness',1,0.2);
              InnerGlowEffect1.AnimateFloat('Softness',0,0.2);
              InnerGlowEffect1.AnimateFloat('Softness',1,0.2);

              get_courses(StrToInt(total.Text),'','','',True);
              Label20.Text := 'Click score to save courseboard';

              InnerGlowEffect1.AnimateFloat('Softness',0,0.2);
              InnerGlowEffect1.AnimateFloat('Softness',1,0.2);
              InnerGlowEffect1.AnimateFloat('Softness',0,0.2);
          end;

      end;

      if EventInfo.GestureID = System.UITypes.igiLongTap then
      begin
            InnerGlowEffect1.AnimateFloat('Softness',1,0.6);
            hideOrShow();
            {$IFDEF ANDROID}
          Vibrator:=TJVibrator.Wrap((SharedActivityContext.getSystemService(TJContext.JavaClass.VIBRATOR_SERVICE) as ILocalObject).GetObjectID);
        // Vibrate for 10 milliseconds
          Vibrator.vibrate(10);
          {$ENDIF}
          InnerGlowEffect1.AnimateFloat('Softness',0,0.2);
      end;

    end;


end;

procedure TForm3.Image4Click(Sender: TObject);
begin
    if profileShows then
    begin
      Layout5.AnimateFloat('Position.Y',ClientHeight + 1,0.2);
      profileShows := false
    end;
end;

procedure TForm3.Image5Click(Sender: TObject);
var
  score : String;
begin

  score  := Label15.Text;

  case (clickedNumber.Tag) of
    1 :  Button2.Text := score;
    2 :  Button3.Text := score;
    3 :  Button4.Text := score;
    4 :  Button5.Text := score;
    5 :  Button6.Text := score;
    6 :  Button7.Text := score;
    7 :  Button8.Text := score;
  end;


  scoreMeter.Visible := false;

end;
//-------------------------------- Value assign of Slide Bar OR TrackBar
procedure TForm3.Label15Click(Sender: TObject);

begin

  clickedNumber := (Sender as TControl);

  scoreMeter.Visible := true;

  case (clickedNumber.Tag) of
    1 :  TrackBar1.Value := StrToInt(Button2.Text);
    2 :  TrackBar1.Value := StrToInt(Button3.Text);
    3 :  TrackBar1.Value := StrToInt(Button4.Text);
    4 :  TrackBar1.Value := StrToInt(Button5.Text);
    5 :  TrackBar1.Value := StrToInt(Button6.Text);
    6 :  TrackBar1.Value := StrToInt(Button7.Text);
    7 :  TrackBar1.Value := StrToInt(Button8.Text);
  end;

  TrackBar1Tracking(Self);

end;
procedure TForm3.marksClick(Sender: TObject);
begin

end;

//-------------------------------------------------subject Controllers
procedure TForm3.Subj1ClosePopup(Sender: TObject);
begin
    if subj1.Selected.Text <> 'Select subject' then
    begin
      subj2.Items := subj1.Items;
      subj2.Items.Delete(subj1.ItemIndex);
      subj2.ItemIndex := 0;
    end;
end;

procedure TForm3.Subj1Popup(Sender: TObject);
var
    I: Integer;
    numOfLang : Integer;
    langSubj : String;
begin
    if subj2.Selected.Text = 'Add 1st Subject First' then
    begin
      subj1.Items.Clear;
      subj1.Items.Add('Select subject');
      subj1.ItemIndex := 0;

      dataController.SQL_Subject('SELECT subj_name FROM `subjects` WHERE subj_type = ''Lang''  AND NOT subj_name = '''+Subj1.Items[Subj1.ItemIndex]+''' AND NOT subj_name = '''+Subj1.Selected.Text+'''');
      numOfLang := dataController.SQL_SubjectNo();
      for I := 1 to numOfLang do
      begin
        langSubj := dataController.getField_Subject('subj_name').AsString;
        Subj1.Items.Add(langSubj);
        dataController.operation_Subject('N','subject');
      end;
    end;
end;

procedure TForm3.Subj4ClosePopup(Sender: TObject);
begin

      if subj4.Selected.Text <> 'Select subject' then
      begin
        subj5.Items := subj4.Items;
        subj5.Items.Delete(subj4.ItemIndex);
        subj5.ItemIndex := 0;
      end;

      if subj4.Selected.Text = subj6.Selected.Text then
      begin
         subj6.Items.Clear;
         subj6.Items.Add('Select 5th Subject first');
         subj6.ItemIndex := 0;
      end;

end;

procedure TForm3.Subj5ClosePopup(Sender: TObject);
begin
    if subj5.Selected.Text <> 'Select subject' then
    begin
      subj6.Items := subj5.Items;
      subj6.Items.Delete(subj5.ItemIndex);
      subj6.ItemIndex := 0;
    end;

    if subj5.Selected.Text = 'Add 4th Subject First' then
    begin
      Subj6.Items.Add('Add 5th Subject First');
      subj6.ItemIndex := 0;
      end;
end;
//---------------------------------------------- Counter in UI.UX effect
procedure TForm3.Timer1Timer(Sender: TObject);
begin
     total.Text := IntToStr(StrToInt(total.Text) + 1);

     timerTracker := timerTracker + 1;

     if(timerTracker >= tot) then
     Timer1.Enabled := false;
end;

procedure TForm3.Timer2Timer(Sender: TObject);
begin
    Label4.Text := IntToStr(timerTracker2);

     timerTracker2 := timerTracker2 + 1;

     if(timerTracker2 >= user.get_score+1) then
     Timer2.Enabled := false;
end;
//-------------------------------------------------- Marks Tracking Slide
procedure TForm3.TrackBar1Tracking(Sender: TObject);
begin
      Label15.Text := TrackBar1.Value.ToString;

      case(Label15.Text[1]) of
      '1' : perc.Text := '0 to 29 %';
      '2' : perc.Text := '30 to 39 %';
      '3' : perc.Text := '40 to 49 %';
      '4' : perc.Text := '50 to 59 %';
      '5' : perc.Text := '60 to 69 %';
      '6' : perc.Text := '70 to 79 %';
      '7' : perc.Text := '80 to 100 %';
      end;
end;
//----------------------------------------------Courses retrevial
procedure TForm3.get_courses(aps_Score : Integer; fac_Name : String; cou_Name : String; cam_Name : String; me : Boolean);
var
I : Integer;
y : Integer;
p : Integer;
k : Integer;
begin
        courseTempList := TObjectList<TcoursesTemp>.Create;
        courseList := TObjectList<TCourse>.Create;


        VertScrollBox2.Content.DeleteChildren;

        dataController.SQL_Course('SELECT count(course_id) as totalCourse FROM `courses` WHERE faculty = '''+fac_Name+'''  OR  course = '''+cou_Name+''' OR course_aps < '+IntToStr(aps_Score)+' OR campus = '''+cam_Name+''' ');
        p := dataController.getField_Course('totalCourse').AsInteger;
        prev := p;



        taskingDownloading := TTask.Create(procedure
        var
        x : Integer;
        begin
               dataController.SQL_Course('SELECT faculty,course,course_aps,campus FROM `courses` WHERE faculty = '''+fac_Name+'''  OR  course = '''+cou_Name+''' OR course_aps < '+IntToStr(aps_Score)+' OR campus = '''+cam_Name+''' ');

              for x := 1 to p do
              begin
                      courseTemp := TcoursesTemp.Create;
                      courseTemp.course_Name := dataController.getField_Course('course').AsString;
                      courseTemp.course_faculty := dataController.getField_Course('faculty').AsString;
                      courseTemp.course_aps := dataController.getField_Course('course_aps').AsInteger;
                      courseTemp.course_camps := dataController.getField_Course('campus').AsString;
                      courseTempList.Add(courseTemp);
                      dataController.operation_Course('N');
              end;
        end);


        taskingDownloading.Start;


        for I := 1 to p do
        begin
            courseBlock := TCourse.Create;
            courseBlock.allocation;
            courseBlock.setupBlock(VertScrollBox2,sample,I);
            courseList.Add(courseBlock);
        end;

        TTask.WaitForAll(taskingDownloading);


        for y := 0 to p - 1 do
        begin
                courseList[y].facName.Text := courseTempList[y].course_faculty;
                courseList[y].courseName.Text := courseTempList[y].course_Name;
                courseList[y].campName.Text := courseTempList[y].course_camps;
                courseList[y].apsScore.Text := IntToStr(courseTempList[y].course_aps) + ' ';
        end;

        k := k +1;
        courseTempList.DisposeOf;
        courseList.DisposeOf;

        toasterShow(IntToStr(p)+' Course(s) meet your criteria');


end;
//---------------------------------------Transitions-----Slides
procedure TForm3.hideOrShow();
begin
    if buttonShowing then
    begin
      Layout1.AnimateFloat('RotationAngle',270,0.2);
      Layout1.AnimateFloat('Position.Y',ClientHeight - 50,0.2);
      Layout1.Align := TAlignLayout.None;
      buttonShowing := false;
    end
end;

procedure TForm3.silderCourse();
begin
    marks.AnimateFloat('Position.X',(ClientWidth) * -1,0.2);
    courses.AnimateFloat('Position.X',0,0.2);
    marksShowing := false;
end;

procedure TForm3.sliderMarks();
begin
    marks.AnimateFloat('Position.X',0,0.2);
    courses.AnimateFloat('Position.X',(ClientWidth),0.2);
    marksShowing := true;
end;

procedure TForm3.setScale();
begin
      marks.Height := ClientHeight;
      marks.Width := ClientWidth;
      courses.Width := ClientWidth;
      courses.Height := ClientHeight;
      courses.Position.X := ClientWidth;
      marks.Position.X := 0;
      Layout5.Position.X := 0;
      Layout5.Position.Y := ClientHeight;
      Layout5.Width := ClientWidth;
      Layout5.Height := ClientHeight;
end;

procedure TForm3.sliderProfile();
begin
    if not profileShows then
    begin
      timerTracker2 := 0;
      Layout5.AnimateFloat('Position.Y',0,0.2);
      Timer2.Enabled := true;
      profileShows := true;
    end;

end;
//--------------------------------------------------Saving Subject
procedure TForm3.saveSubjects();
var
subjectName : String;
subjectScore : String;
numOfSub : Integer;
begin

    numOfSub := 0;

    dataController.SQL_DML_ONE('DELETE FROM `user_subject` WHERE user_id = '+user.get_id+'');
    //-----------------------------------Save Subject 1  Lang
    subjectScore := Button2.Text;
    subjectName := Subj1.Selected.Text;

    if (subjectName <> 'Select subject')  then
    begin
        dataController.SQL_DML_ONE('INSERT INTO user_subject VALUES('+IntToStr(subjectID)+','''+subjectCode(subjectName)+''','+user.get_id+','+subjectScore+')');
        numOfSub := numOfSub + 1;
    end;


    //-----------------------------------Save Subject 2 Lang
    subjectScore := Button3.Text;
    subjectName := Subj2.Selected.Text;

    if ((subjectName <> 'Select subject') AND (subjectName <> 'Add 1st Subject First'))  then
    begin
        dataController.SQL_DML_ONE('INSERT INTO user_subject VALUES('+IntToStr(subjectID)+','''+subjectCode(subjectName)+''','+user.get_id+','+subjectScore+')');
        numOfSub := numOfSub + 1;
    end;


    //-----------------------------------Save Subject 3  Math
    subjectScore := Button4.Text;
    subjectName := Subj3.Selected.Text;

    if (subjectName <> 'Select subject')  then
    begin
        dataController.SQL_DML_ONE('INSERT INTO user_subject VALUES('+IntToStr(subjectID)+','''+subjectCode(subjectName)+''','+user.get_id+','+subjectScore+')');
        numOfSub := numOfSub + 1;
    end;


    //-----------------------------------Save Subject 4 Other
    subjectScore := Button5.Text;
    subjectName := Subj4.Selected.Text;

    if (subjectName <> 'Select subject')  then
    begin
        dataController.SQL_DML_ONE('INSERT INTO user_subject VALUES('+IntToStr(subjectID)+','''+subjectCode(subjectName)+''','+user.get_id+','+subjectScore+')');
        numOfSub := numOfSub + 1;
    end;


    //-----------------------------------Save Subject 5 Other
    subjectScore := Button6.Text;
    subjectName := Subj5.Selected.Text;

    if ((subjectName <> 'Select subject') AND (subjectName <> 'Add 4th Subject First'))  then
    begin
        dataController.SQL_DML_ONE('INSERT INTO user_subject VALUES('+IntToStr(subjectID)+','''+subjectCode(subjectName)+''','+user.get_id+','+subjectScore+')');
        numOfSub := numOfSub + 1;
    end;


    //-----------------------------------Save Subject 6 Other
    subjectScore := Button7.Text;
    subjectName := Subj6.Selected.Text;

    if ((subjectName <> 'Select subject') AND (subjectName <> 'Add 5th Subject First'))  then
    begin
        dataController.SQL_DML_ONE('INSERT INTO user_subject VALUES('+IntToStr(subjectID)+','''+subjectCode(subjectName)+''','+user.get_id+','+subjectScore+')');
        numOfSub := numOfSub + 1;
    end;



    //-----------------------------------Save Subject 7 L.O
    subjectScore := Button8.Text;
    subjectName := Subj7.Selected.Text;

    dataController.SQL_DML_ONE('INSERT INTO user_subject VALUES('+IntToStr(subjectID)+','''+subjectCode(subjectName)+''','+user.get_id+','+subjectScore+')');
    numOfSub := numOfSub + 1;

    toasterShow(IntToStr(numOfSub)+' Subject(s) saved');


end;

function TForm3.subjectID() : Integer;
var
  return : Integer;
begin
      return := 0;
     dataController.SQL_Subject('SELECT MAX(id) as ID FROM `user_subject`');
     return := dataController.getField_Subject('ID').AsInteger;
     return := return + 1;
     subjectID := return;
end;

function TForm3.subjectCode(subjName : String) : String;
begin
    dataController.SQL_Subject('SELECT subj_code FROM `subjects` WHERE Subj_Name = '''+subjName+'''');
     subjectCode := dataController.getField_Subject('subj_code').AsString;
end;
//---------------------------------------------------------Toaster
procedure TForm3.toasterShow(msg : String);
begin
      if not toastShowing then
      begin
      toastShowing := true;
      toastTracker := 0;
      toasterMsg.Text := msg;
      Toaster.AnimateFloat('opacity',1,0.4);
      delay := TTimer.Create(nil);
      delay.Interval := 1000;
      delay.OnTimer := delayTick;
      delay.Enabled := true;
      end
      else
      begin
         toasterMsg.Text := msg;
      end;
end;

procedure TForm3.delayTick(Sender: TObject);
begin
      toastTracker := toastTracker + 1;
      if toastTracker >= 2 then
      begin
      Toaster.AnimateFloat('opacity',0,0.4);
      delay.Enabled := false;
      toastShowing := false;
      end;
end;


//-------------------------------------------------------------Implementation Ends
end.
//-------------------------------------------------------------File ends
