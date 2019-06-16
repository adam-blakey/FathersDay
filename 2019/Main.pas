//               HOW-MANY-YEARS-YOU'VE-SPENT-AS-A-FATHER-ERER
//                                    v2019
//
// This program suffers from various problems including, but not limited to:
//    * memory leakage,
//    * seriously bad programming practices,
//    * and general shittiness.
//
// This is a program in memory of my late father, who inspired me to program.
//
// This program //should// allow you to add your children and their
// date-of-births and the program //should// then tell you how many Fathers'
// Days you've had.

unit Main;

interface

uses
  {System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.DateTimeCtrls, FMX.Edit, FMX.ScrollBox; }

  System.SysUtils, System.Classes, System.Types, System.UIConsts,
  FMX.Forms, FMX.Dialogs, FMX.Objects, FMX.Types, FMX.Layouts, FMX.Controls, FMX.Styles, FMX.Ani,
  FMX.Edit, FMX.ListBox, FMX.TabControl, FMX.ExtCtrls, FMX.TreeView, FMX.Effects, FMX.Viewport3D,
  FMX.Memo, FMX.Colors, FMX.Menus, FMX.Layers3D, FMX.Types3D, FMX.Controls3D, FMX.StdCtrls,
  FMX.DateTimeCtrls, FMX.ComboTrackBar, FMX.ComboEdit, FMX.SpinBox, FMX.Calendar, FMX.EditBox, FMX.NumberBox,
  FMX.Controls.Presentation, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, FMX.ScrollBox, DateUtils;

type
  ChildWithDOB = Class
    private
      ClassName: String;
      ClassDOB: TDateTime;
      function ThirdSundayOfJune(Year: Integer) : TDateTime;
      function YearToDate(Year: Integer) : TDateTime;
    published
      constructor Create(Name: String; DOB: Double);
      destructor Destroy; override;
      function TotalNumberOfFathersDays() : Integer;
  end;

  THeaderFooterForm = class(TForm)
    Header: TToolBar;
    Footer: TToolBar;
    HeaderLabel: TLabel;
    Label1: TLabel;
    ChildBox: TVertScrollBox;
    ChildAdd: TButton;
    ChildName: TEdit;
    ChildDOB: TDateEdit;
    Calculate: TButton;
    YearsAsFather: TLabel;
    PleaseAddAChild: TLabel;
    procedure ChildAddClick(Sender: TObject);
    procedure CalculateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ChildCounter: Integer;
    ChildID: Integer;
    Children: array of ChildWithDOB;
    Rectangles: array of TRectangle;
    ChildNames: array of TLabel;
    ChildDOBs: array of TLabel;
    DeleteButtons: array of TButton;
    procedure DeleteButtonClicked(Sender: TObject);
  end;





var
  HeaderFooterForm: THeaderFooterForm;

implementation
{$R *.fmx}
{$ExtendedSyntax On}

constructor ChildWithDOB.Create(Name: string; DOB: Double);
begin
  ClassName := Name;
  ClassDOB := DOB;
end;

destructor ChildWithDOB.Destroy();
begin
  inherited;
end;

function ChildWithDOB.ThirdSundayOfJune(Year: Integer) : TDateTime;
var
  DaysBeforeJune: Integer;
  Date: TDateTime;
  JuneDate: TDateTime;
  JuneDay: Integer;
  FirstSundayDay: Integer;
begin
  Date := YearToDate(Year);
  JuneDate := EncodeDate(Year, 06, 01);

  { Translates stupid day numbers to sensible ones. }
  case DayOfWeek(JuneDate) of
    2 : JuneDay := 0;
    3 : JuneDay := 1;
    4 : JuneDay := 2;
    5 : JuneDay := 3;
    6 : JuneDay := 4;
    7 : JuneDay := 5;
    1 : JuneDay := 6;
    else JuneDay := 0;
  end;

  FirstSundayDay := 7 - JuneDay;

  Result := EncodeDate(Year, 06, FirstSundayDay + 14);
end;

function ChildWithDOB.TotalNumberOfFathersDays() : Integer;
var
  ThisYear: Integer;
  LastYear: Integer;
  I: Integer;
  MostRecentFathersDay: Integer;
  OldestChildYear: Integer;
  YearsSpent: Integer;
begin
  ThisYear := YearOf(Now);
  LastYear := ThisYear - 1;

  if CompareDate(Now, ThirdSundayOfJune(ThisYear)) < 0
  then
    MostRecentFathersDay := LastYear
  else
    MostRecentFathersDay := ThisYear;

  OldestChildYear := YearOf(ClassDOB);

  YearsSpent := 0;
  for I := OldestChildYear + 1 to MostRecentFathersDay do
  begin
    YearsSpent := YearsSpent + 1;
  end;

  if CompareDate(ClassDOB, ThirdSundayOfJune(OldestChildYear)) < 0 then
  begin
    YearsSpent := YearsSpent + 1;
  end;

  Result := YearsSpent;
end;

function ChildWithDOB.YearToDate(Year: Integer) : TDateTime;
begin
  Result := EncodeDate(Year, 01, 01);
end;



procedure THeaderFooterForm.CalculateClick(Sender: TObject);
var
  Child: ChildWithDOB;
  I: Integer;
  MaxNumberOfFathersDays: Integer;
  Temp: Integer;
begin
  Temp := 0;
  MaxNumberOfFathersDays := 0;

  for I := 0 to ChildCounter - 1 do
  begin
    Child := Children[I];
    Temp := Child.TotalNumberOfFathersDays();

    if Temp > MaxNumberOfFathersDays then
    begin
      MaxNumberOfFathersDays := Temp;
    end;
    
  end;

  YearsAsFather.Text := IntToStr(MaxNumberOfFathersDays) + ' years';
end;

procedure THeaderFooterForm.DeleteButtonClicked(Sender: TObject);
var
  Rectangle: TRectangle;
  ChildNamesSingle: TLabel;
  ChildDOBsSingle: TLabel;
  DeleteButton: TButton;
  Counter: Integer;
begin
  Counter := TButton(Sender).Tag;

  ChildNamesSingle := ChildNames[Counter];
  ChildNamesSingle.Destroy;

  ChildDOBsSingle := ChildDOBs[Counter];
  ChildDOBsSingle.Destroy;

  DeleteButton := DeleteButtons[Counter];
  DeleteButton.Destroy;

  Rectangle := Rectangles[Counter];
  Rectangle.Destroy;

  Dec(ChildCounter);

  if ChildCounter = 0 then
  begin
    PleaseAddAChild.Visible := True;
  end;
end;


procedure THeaderFooterForm.ChildAddClick(Sender: TObject);
var
  Rectangle: TRectangle;
  ChildNamesSingle: TLabel;
  ChildDOBsSingle: TLabel;
  DeleteButton: TButton;
begin
  SetLength(Children, ChildCounter + 1);
  Children[ChildCounter] := ChildWithDOB.Create(ChildName.Text, ChildDOB.Date);

  {SingleRectangle := TRectangle.Create(parent := ChildBox);}

  SetLength(Rectangles, ChildCounter + 1);
  Rectangles[ChildCounter] := TRectangle.Create(Self);

  Rectangle := Rectangles[ChildCounter];

  Rectangle.Parent := ChildBox;
  Rectangle.Width := ChildBox.Width - 25;
  Rectangle.Hittest := false;
  Rectangle.Position.X := 0;
  Rectangle.Position.Y := 60*ChildCounter;
  Rectangle.XRadius := 5;
  Rectangle.YRadius := rectangle.XRadius;
  {$R-}
  Rectangle.fill.Color := ((50 + random(205)) shl 24) or random($FFFFFF);
  {$R+}

  SetLength(ChildNames, ChildCounter + 1);
  ChildNames[ChildCounter] := TLabel.Create(Self);

  ChildNamesSingle := ChildNames[ChildCounter];

  ChildNamesSingle.Parent := Rectangle;
  ChildNamesSingle.Width := 200;
  ChildNamesSingle.Hittest := false;
  ChildNamesSingle.Position.X := 10;
  ChildNamesSingle.Position.Y := 8;
  ChildNamesSingle.Text := ChildName.Text;

  SetLength(ChildDOBs, ChildCounter + 1);
  ChildDOBs[ChildCounter] := TLabel.Create(Self);

  ChildDOBsSingle := ChildDOBs[ChildCounter];

  ChildDOBsSingle.Parent := Rectangle;
  ChildDOBsSingle.Width := 200;
  ChildDOBsSingle.Hittest := false;
  ChildDOBsSingle.Position.X := ChildBox.Width - 200 - 80 - 25 - 10 - 10;
  ChildDOBsSingle.Position.Y := 8;
  ChildDOBsSingle.Text := DateToStr(ChildDOB.Date);
  ChildDOBsSingle.TextSettings.HorzAlign := TTextAlign.Trailing;

  SetLength(DeleteButtons, ChildCounter + 1);
  DeleteButtons[ChildCounter] := TButton.Create(Self);

  DeleteButton := DeleteButtons[ChildCounter];

  DeleteButton.Parent := Rectangle;
  DeleteButton.OnClick := DeleteButtonClicked;
  DeleteButton.Width := 80;
  DeleteButton.Height := 35;
  DeleteButton.Hittest := false;
  DeleteButton.Position.X := ChildBox.Width - 80 - 25 - 10;
  DeleteButton.Position.Y := 8;
  DeleteButton.Text := 'Delete';
  DeleteButton.CanFocus := True;
  DeleteButton.Tag := ChildCounter;
  DeleteButton.Enabled := True;
  DeleteButton.TabOrder := 4 + ChildCounter;


  PleaseAddAChild.Visible := False;

  ChildBox.BeginUpdate;
  {ChildBox.AddObject(SingleChild);}
  Inc(ChildCounter);
  Inc(ChildID);
  ChildBox.EndUpdate;

  ChildName.Text := '';
  ChildDOB.Date := StrToDate('2000-01-01');
end;

end.
