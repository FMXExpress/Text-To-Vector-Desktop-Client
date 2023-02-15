unit uMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Types,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FMX.Layouts,
  FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation, Skia, Skia.FMX;

type
  TMainForm = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    Button1: TButton;
    MaterialOxfordBlueSB: TStyleBook;
    Layout1: TLayout;
    Edit1: TEdit;
    Label1: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    SkSvg2: TSkSvg;
    SkSvg3: TSkSvg;
    SkSvg1: TSkSvg;
    Layout2: TLayout;
    VertScrollBox1: TVertScrollBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  const
  API_KEY = 'your api key';

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses
  System.Hash, System.IOUtils;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  RestRequest1.Execute;

  var I := 1;
  FDMemTable1.First;
  while not FDMemTable1.EOF do
  begin
     case I of
     1: SkSVG1.Svg.Source := FDMemTable1.FieldByName('Array').AsWideString;
     2: SkSVG2.Svg.Source := FDMemTable1.FieldByName('Array').AsWideString;
     3: SkSVG3.Svg.Source := FDMemTable1.FieldByName('Array').AsWideString;
     end;
    Inc(I);
    var LSL := TStringList.Create;
    LSL.Text := FDMemTable1.FieldByName('Array').AsWideString;
    LSL.SaveToFile(TPath.Combine(ExtractFilePath(ParamStr(0)),THashMD5.GetHashString(LSL.Text)+'.svg'));
    LSL.Free;

    var LSVG := TSkSVG.Create(Self);
    LSVG.Svg.Source := FDMemTable1.FieldByName('Array').AsWideString;
    LSVG.Height := VertScrollBox1.Width;
    LSVG.Position.Y := -1;
    LSVG.Align := TAlignLayout.Top;
    LSVG.Parent := VertScrollBox1;


    FDMemTable1.Next;
  end;

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  RestRequest1.Params[0].Value := RestRequest1.Params[0].Value + API_KEY;
end;

end.
