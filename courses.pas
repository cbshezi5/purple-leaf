unit courses;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.Layouts,
  FMX.ListBox, FMX.Effects ,DataCapsule;

type

TCourse = class

public
  facName : TLabel;
  courseName : TLabel;
  campName : TLabel;
  underDraw : TLine;
  blockLayout : TLayout;
  blockAps : TLayout;
  apsScore : TLabel;
  procedure allocation();
  procedure setupBlock(vertParent : TVertScrollBox; Sample : TLabel; counter : Integer);

end;

implementation

  procedure TCourse.allocation();
  begin
      facName := TLabel.Create(nil);
      courseName := TLabel.Create(nil);
      campName := TLabel.Create(nil);
      underDraw := TLine.Create(nil);
      blockLayout := TLayout.Create(nil);
      blockAps := TLayout.Create(nil);
      apsScore := TLabel.Create(nil);
  end;

  procedure TCourse.setupBlock(vertParent : TVertScrollBox; Sample : TLabel; counter : Integer);
  begin

        blockLayout.Parent := vertParent;
        blockLayout.Align := TAlignLayout.Horizontal;
        blockLayout.Height := 90;
        blockLayout.Position.Y := ((1 - counter) * blockLayout.Height) + 10;


        campName.StyledSettings := Sample.StyledSettings;
        campName.Parent := blockLayout;
        campName.Font.Size := 13;
        campName.Position.Y := 49;
        campName.Align := TAlignLayout.Horizontal;
        campName.FontColor := TAlphaColorRec.Lightslategray;
        campName.TextAlign := TTextAlign.Leading;
        campName.Text := '';
        campName.WordWrap := false;

        facName.StyledSettings := Sample.StyledSettings;
        facName.Parent := blockLayout;
        facName.Font.Size := 12;
        facName.Position.X := 0;
        facName.Position.Y := 0;
        facName.Align := TAlignLayout.Horizontal;
        facName.FontColor := TAlphaColorRec.Black;
        facName.Text := '';
        facName.WordWrap := false;

        courseName.StyledSettings := Sample.StyledSettings;
        courseName.Parent := blockLayout;
        courseName.Font.Size := 15;
        courseName.Position.Y := 25;
        courseName.Position.X := 0;
        courseName.Width := 300;
        courseName.FontColor := TAlphaColorRec.Gray;
        courseName.Align := TAlignLayout.None;
        courseName.TextAlign := TTextAlign.Leading;
        courseName.Text := '';
        courseName.WordWrap := false;

        blockAps.Parent := blockLayout;
        blockAps.Align := TAlignLayout.Client;

        apsScore.StyledSettings := Sample.StyledSettings;
        apsScore.Parent := blockAps;
        apsScore.Align := TAlignLayout.Right;
        apsScore.TextAlign := TTextAlign.Trailing;
        apsScore.Font.Size := 25;
        apsScore.Font.Style := [TFontStyle.fsBold];
        apsScore.FontColor := TAlphaColorRec.Lightslategray;
        apsScore.Text := '';

        underDraw.Parent := blockLayout;
        underDraw.LineType := TLineType.Bottom;
        underDraw.Width := 310;
        underDraw.Height := 1;
        underDraw.Position.Y := blockLayout.Height - 1;
        underDraw.Position.X := 20;
        underDraw.Stroke.Color := TAlphaColorRec.Lightgray;

        counter := counter + 1;
  end;
end.
