unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, Menus, ValEdit, Spin, MDButton, MDButtonFocus;

type

  { TMainPage }

  TMainPage = class(TForm)
    btn_convert1: TMDButton;
    btn_revert: TMDButton;
    btn_zeile: TMDButton;
    btn_convert: TMDButton;
    btn_zeilenadden: TMDButton;
    btn_zeileweg: TMDButton;
    spin_rows: TSpinEdit;
    strGrid_ergebnisPa: TStringGrid;
    StringGrid1: TStringGrid;
    strGrid_ergebnis: TStringGrid;

    procedure btn_convert1Click(Sender: TObject);
    procedure btn_convertClick(Sender: TObject);
    procedure btn_revertClick(Sender: TObject);
    procedure btn_zeilenaddenClick(Sender: TObject);
    procedure btn_zeilewegClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure btn_zeileClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainPage: TMainPage;

implementation

{$R *.lfm}

{ TMainPage }

procedure TMainPage.FormCreate(Sender: TObject);
begin

end;

procedure TMainPage.btn_convertClick(Sender: TObject);
var i :integer;
  h_gemessen,t_gemessen,ergebnis : double;
begin
        strGrid_ergebnis.RowCount:= StringGrid1.RowCount;
        strGrid_ergebnisPa.RowCount:= StringGrid1.RowCount;
        for i := 1 to strGrid_ergebnis.RowCount-1 do begin
           Try
           h_gemessen := StrToFloat(StringGrid1.Cells[0,i]);
            except
             On h_gemessen : Exception do
              ShowMessage('Fehler(Keine Zahl?) : ' + h_gemessen.Message);
            end;

           Try
           t_gemessen := StrToFloat(StringGrid1.Cells[1,i]);
            except
             On t_gemessen : Exception do
              ShowMessage('Fehler(Keine Zahl?) : ' + t_gemessen.Message);
            end;

               ergebnis:= (h_gemessen) / (1+ (0.00018 * t_gemessen));

                strGrid_ergebnis.Cells[0,i] := FloatToStr(ergebnis);
                strGrid_ergebnisPa.Cells[0,i] := FloatToStr(StrToFloat(strGrid_ergebnis.Cells[0,i]) *133.322);
           end;
        end;

procedure TMainPage.btn_convert1Click(Sender: TObject);
begin
      ShowMessage('Werte können direkt aus Execel kopiert werden (ganze Spalten einfügen mit klick auf das Kästchen, so dass kein weißes Feld erscheint und dann strg + V )Um den Fehler zu minimieren wird die Ausdehnung des Quecksilbers zurück gerechnet. PS nicht die Luft vergessen ;) ');
end;

procedure TMainPage.btn_revertClick(Sender: TObject);
begin
       StringGrid1.RowCount:= 1;
       strGrid_ergebnis.RowCount:= 1;
       strGrid_ergebnisPa.RowCount:= 1;
end;

procedure TMainPage.btn_zeilenaddenClick(Sender: TObject);
begin
         StringGrid1.RowCount:= spin_rows.Value;
end;

procedure TMainPage.btn_zeilewegClick(Sender: TObject);
begin
        StringGrid1.RowCount:= StringGrid1.RowCount - 1;
end;

procedure TMainPage.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
         ShowMessage('Weitere Science-Tools auf Brandhoff.tk');
end;


procedure TMainPage.btn_zeileClick(Sender: TObject);
begin
        StringGrid1.RowCount:= StringGrid1.RowCount + 1;
end;


end.

