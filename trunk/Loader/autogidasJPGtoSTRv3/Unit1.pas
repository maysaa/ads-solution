unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const juodumokonstanta=300;

var
  Form1: TForm1;
  skPvz:array[1..12,1..8] of byte;
procedure autogidasTelJpgToStrReadDatafile;
function autogidasTelJpgToStr(paveiksliukas:tpicture):string;
implementation

{$R *.dfm}

procedure autogidasTelJpgToStrReadDatafile;
var failas:textfile;
    sk,eilute:integer;
    b:byte;
begin
//BEGIN is failo nusiskaityti skaitmenu pavyzdzius i masyva
assign(failas,ExtractFilePath(Application.ExeName)+'\skaitmenys.dat');
reset(failas);
sk:=1;
eilute:=1;
while not eof(failas) do
   begin
   readln(failas,b);
   skPvz[sk,eilute]:=b;
   eilute:=eilute+1;
   if eilute>8 then
     begin
     sk:=sk+1;
     eilute:=1;
     end;
   end;
closefile(failas);
//END is failo nusiskaityti skaitmenu pavyzdzius i masyva
end;

function autogidasTelJpgToStr(paveiksliukas:tpicture):string;
var pixelsInByte: array[1..14,1..8] of byte;//[kelintas simbolis,kelinta pikseliu eilute]
    rezultatas,s:string;
    pvz,x,sk,f,eilute,skaitmuo,klaidu,bitukas,pikseliuBaitas,rr,gg,bb,ll,minimumklaidu,artimiausiasskaitmuo,bi:integer;
    sutampa,atpazinome:boolean;
    bmpPav:tbitmap;
    bait1,bait2:byte;
    pic2:tpicture;
   function pvzinttostr(sk:integer):string;
   begin
   pvzinttostr:='#';
   if sk in [1..9] then pvzinttostr:=inttostr(sk)
    else case sk of
         10:pvzinttostr:='0';
         11:pvzinttostr:='+';
         12:pvzinttostr:=' ';
         end;
   end;
begin
bmpPav:=tbitmap.create;
//pic2:=tpicture.Create;

//s:=form1.edit2.text;
pic2:=paveiksliukas;
//pic2.loadfromfile(ExtractFilePath(Application.ExeName)+s);
bmpPav.Assign(pic2.graphic);

//nustatom pikseli juoda arba balta ir patalpinam i masyva pixelsInByte
for sk:=1 to 14 do
  for eilute:=1 to 8 do
     begin
     pikseliuBaitas:=0;
     bitukas:=128;
     for x:=1 to 8 do
        begin
        LL:=bmppav{form1.image2.picture.bitmap}.canvas.pixels[(sk-1)*8+x,eilute+1];
        RR := ((LL shr 16) and $FF);
        GG :=  ((LL shr 8) and $FF) div 2;//geltona tarkim ne tiek daug priduoda juodumo
        BB :=  (LL and $FF);
        if rr+gg+bb<juodumokonstanta //juodumo konstanta
          then pikseliuBaitas:=pikseliuBaitas + bitukas;
        bitukas:=bitukas div 2;
        end;
     pixelsInByte[sk,eilute]:=pikseliuBaitas;
     end;
//ENDnustatom juoda balta ir patalpinam i masyva pixelsInByte

rezultatas:='';
for skaitmuo:=1 to 14 do
   begin
   atpazinome:=false;
   pvz:=1;
   while pvz<=12 do//for pvz:=1 to 12
      begin
      sutampa:=true;
      eilute:=1;
      while ((eilute<=8)and(pvz<20)) do//for eilute:=1 to 8 do
         begin
         if (pixelsInByte[skaitmuo,eilute] xor skPvz[pvz,eilute] <> 0) then
           begin
           sutampa:=false;
           pvz:=99;{exitfor};
           end;
         eilute:=eilute+1;
         end;
      if sutampa and not atpazinome then
        begin
        rezultatas:=rezultatas+pvzinttostr(pvz);
        atpazinome:=true;
        pvz:=99;{exitfor;}
        end;
      pvz:=pvz+1;
      end;
   if not atpazinome then
     begin//skaiciuojamPaklaidas;
     minimumklaidu:=999;
     artimiausiasskaitmuo:=99;
     for pvz:=1 to 12 do
        begin
        klaidu:=0;
        for eilute:=1 to 8 do
           begin
           if (pixelsInByte[skaitmuo,eilute] xor skpvz[pvz,eilute]<>0)
             then begin
                  bait1:=pixelsInByte[skaitmuo,eilute];
                  bait2:=skpvz[pvz,eilute];
                  for bi:=1 to 8 do
                     begin
                     if ((bait1 mod 2)<>(bait2 mod 2)) then klaidu:=klaidu+1;
                     bait1:=bait1 div 2;
                     bait2:=bait2 div 2;
                     end;
                  end;
           end;
        if minimumklaidu>klaidu then begin
                                     artimiausiasskaitmuo:=pvz;
                                     minimumklaidu:=klaidu;
                                     end;
        end;
     rezultatas:=rezultatas+pvzinttostr(artimiausiasskaitmuo);
     end;//ENDskaiciuojampaklaidas
   end;
autogidasteljpgtostr:=rezultatas;
bmppav.FreeImage;
bmppav.free;
end;

procedure TForm1.Button1Click(Sender: TObject);
var pic:tpicture;
begin
autogidasTelJpgToStrReadDatafile;
pic:=tpicture.create;
pic.loadfromfile(ExtractFilePath(Application.ExeName)+edit2.text);
edit1.text:=autogidasTelJpgToStr(pic);
image1.Picture:=pic;
pic.free;
end;

end.
