unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, Xml.adomxmldom, DIUnicode, DIHtmlParser,
  DIHtmlMisc, DIUtils;

type
  ContactRecord = record
    Name: string;
    Phone: string;
    PhoneOperator: string;
    Address: string;
  end;

type
  TfrmMain = class(TForm)
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    MyHtmlParser: TDIHtmlParser;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    function ParseContacList(URL: String): Boolean;
    function IsContactList(PageSource: TMemoryStream): Boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
var
  s: TMemoryStream;
  Reader: TStreamReader;
  aURL: String;
  AName: String;
begin
  aURL := 'http://www.118.lt/gyventoju-paieska/paieskos-rezultatai?actionId=7&flname=AB&hnr=&street=&rgn=Vilnius&det=1&sexp=0&sasc=1';
  IdHTTP1.HandleRedirects := True;
  s := TMemoryStream.Create;
  IdHTTP1.Get(aURL, s);
  s.Position := 0;
  Reader := TStreamReader.Create(s, TEncoding.UTF8);

  Memo1.Text := Reader.ReadToEnd();

  s.Position := 0;
  RegisterHtmlTags;
  RegisterHtmlAttribs;
  RegisterHtmlDecodingEntities;

  // MyHtmlParser.SourceFile := 'd:\a.html';
  MyHtmlParser.SourceStream := s;
  // MyHtmlParser.ReadMethods := Read_UTF_16_LE;
  MyHtmlParser.ReadMethods := Read_UTF_8;

  { Show HTML tags and text }
  MyHtmlParser.FilterHtmlTags.SetStartEnd(fiShow);
  MyHtmlParser.FilterText := fiShow;

  while MyHtmlParser.ParseNextPiece do
    case MyHtmlParser.PieceType of
      // What type of HTML piece did the parser find?
      ptHtmlTag: // Found a tag.
        case MyHtmlParser.HtmlTag.TagID of
          TAG_DIV_ID: // Found a DIV tag.
            begin
              // Gal galima surastas DIV bloka kaip objekta ir tada analizuoti?

              case MyHtmlParser.HtmlTag.TagType of

                ttStartTag:
                  begin
                    AName := '';
                    // Case insensitive test for 'Company' attribute value.
                    if StrSameIW(MyHtmlParser.HtmlTag.ValueOfNameCI['class'], 'result') then
                    begin
                      MyHtmlParser.ParseNextPiece;
                      if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptHtmlTag) then
                      begin
                        if MyHtmlParser.DataAsStr = 'header clear' then
                        begin
                          MyHtmlParser.ParseNextPiece;
                          if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptHtmlTag) then
                          begin
                            if MyHtmlParser.DataAsStr = 'h2' then
                            begin
                              MyHtmlParser.ParseNextPiece;
                              if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptHtmlTag) then
                              begin
                                if MyHtmlParser.DataAsStr = 'strong' then
                                begin
                                  MyHtmlParser.ParseNextPiece;
                                  if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptHtmlTag) then
                                  begin
                                    if MyHtmlParser.DataAsStr = 'highlighted' then
                                    begin
                                      if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptText) then
                                      begin
                                        AName := MyHtmlParser.DataAsStr;
                                        if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptHtmlTag) then
                                        begin
                                          if MyHtmlParser.DataAsStr = 'span' then
                                          begin
                                            if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptText) then
                                            begin
                                              AName := AName + MyHtmlParser.DataAsStr;
                                              Memo2.Lines.Add(AName);
                                            end;
                                          end;
                                        end
                                      end;
                                    end;
                                  end;
                                end;
                              end;
                            end;
                          end;
                        end;
                      end;
                      // DivNesting := 1;
                      // WriteLn('Opening DIV found');
                    end
                    else
                    begin
                      // if DivNesting > 0 then
                      // Inc(DivNesting);
                    end;
                  end;

                ttEndTag:
                  begin
                    // if DivNesting > 0 then
                    // begin
                    // Dec(DivNesting);
                    // if DivNesting = 0 then
                    // begin
                    // WriteLn('Closing DIV found');
                    // end;
                    // end;
                  end;

              end;
            end;
        end;

      ptText:
        begin

        end;
    end;
  // Memo1.Lines.LoadFromStream(s);
  Reader.Free();
end;

procedure TfrmMain.Button2Click(Sender: TObject);
var
  aURL, MainURL, AName, ANameParam, ARegion, ARegionParam: String;
  i, ii, iii: Integer;
begin
  MainURL := 'http://www.118.lt/gyventoju-paieska/paieskos-rezultatai?actionId=7';
  ANameParam := '&flname=';
  ARegionParam := '&rgn=';
  ARegion := 'Vilnius';
  // A-Z 65-90
  for i := 65 to 65 do
  begin
    for ii := 65 to 66 do
    begin
      for iii := 65 to 65 do
      begin
        AName := char(i) + char(ii) + char(iii);
        aURL := MainURL + ANameParam + AName + ARegionParam + ARegion;
        if not ParseContacList(aURL) then
        inputBox ('Nera','URL: ', aURL)
        else
          inputBox ('Yra','URL: ', aURL);
      end;
    end;
  end;
end;

function TfrmMain.IsContactList(PageSource: TMemoryStream): Boolean;
var
  AHtmlParser: TDIHtmlParser;
begin
  Result := False;
  try
    AHtmlParser := TDIHtmlParser.Create(nil);

    PageSource.Position := 0;

    RegisterHtmlTags;
    RegisterHtmlAttribs;
    RegisterHtmlDecodingEntities;

    MyHtmlParser.SourceStream := PageSource;
    MyHtmlParser.ReadMethods := Read_UTF_8;

    { Show HTML tags and text }
    MyHtmlParser.FilterHtmlTags.SetStartEnd(fiShow);
    MyHtmlParser.FilterText := fiShow;

    while MyHtmlParser.ParseNextPiece do
      case MyHtmlParser.PieceType of
        // What type of HTML piece did the parser find?
        ptHtmlTag: // Found a tag.
          case MyHtmlParser.HtmlTag.TagID of
            TAG_DIV_ID: // Found a DIV tag.
              begin
                case MyHtmlParser.HtmlTag.TagType of
                  ttStartTag:
                    begin
                      { div class="socContainer"> }
                      { class="socdiv p118" }
                      if StrSameIW(MyHtmlParser.HtmlTag.ValueOfNameCI['class'], 'socdiv p118') then
                      begin
                        MyHtmlParser.ParseNextPiece;
                        MyHtmlParser.ParseNextPiece;
                        MyHtmlParser.ParseNextPiece;
                        MyHtmlParser.ParseNextPiece;
                        MyHtmlParser.ParseNextPiece;
                        MyHtmlParser.ParseNextPiece;
                        MyHtmlParser.ParseNextPiece;
                        MyHtmlParser.ParseNextPiece;
                        if MyHtmlParser.PieceType = ptText then
                          if MyHtmlParser.DataAsStr = '0' then
                          begin
                            Result := False;
                            Break;
                          end
                          else
                          begin
                            Result := True;
                            Break;
                          end;
                      end;
                    end;
                end;
              end;
          end;
      end;
  finally
    AHtmlParser.Free;
  end;
end;

function TfrmMain.ParseContacList(URL: String): Boolean;
var
  Contact: array [1 .. 200] of ContactRecord;
  ARecord: Integer;
  AName: String;
  AStream: TMemoryStream;
begin
  try
    IdHTTP1.HandleRedirects := True;
    AStream := TMemoryStream.Create;
    IdHTTP1.Get(URL, AStream);
    AStream.Position := 0;

    if not IsContactList(AStream) then
    begin
      Result:= False;
      Exit;
    end
    else
    begin
      Result := True;
      Exit;
    end;

    //============EXIT============\\

    RegisterHtmlTags;
    RegisterHtmlAttribs;
    RegisterHtmlDecodingEntities;

    MyHtmlParser.SourceStream := AStream;
    MyHtmlParser.ReadMethods := Read_UTF_8;

    { Show HTML tags and text }
    MyHtmlParser.FilterHtmlTags.SetStartEnd(fiShow);
    MyHtmlParser.FilterText := fiShow;

    while MyHtmlParser.ParseNextPiece do
      case MyHtmlParser.PieceType of
        // What type of HTML piece did the parser find?
        ptHtmlTag: // Found a tag.
          case MyHtmlParser.HtmlTag.TagID of
            TAG_DIV_ID: // Found a DIV tag.
              begin
                // Gal galima surastas DIV bloka kaip objekta ir tada analizuoti?

                case MyHtmlParser.HtmlTag.TagType of

                  ttStartTag:
                    begin
                      AName := '';
                      if StrSameIW(MyHtmlParser.HtmlTag.ValueOfNameCI['class'], 'result') then
                      begin
                        MyHtmlParser.ParseNextPiece;
                        if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptHtmlTag) then
                        begin
                          if MyHtmlParser.DataAsStr = 'header clear' then
                          begin
                            MyHtmlParser.ParseNextPiece;
                            if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptHtmlTag) then
                            begin
                              if MyHtmlParser.DataAsStr = 'h2' then
                              begin
                                MyHtmlParser.ParseNextPiece;
                                if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptHtmlTag) then
                                begin
                                  if MyHtmlParser.DataAsStr = 'strong' then
                                  begin
                                    MyHtmlParser.ParseNextPiece;
                                    if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptHtmlTag) then
                                    begin
                                      if MyHtmlParser.DataAsStr = 'highlighted' then
                                      begin
                                        if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptText) then
                                        begin
                                          AName := MyHtmlParser.DataAsStr;
                                          if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptHtmlTag) then
                                          begin
                                            if MyHtmlParser.DataAsStr = 'span' then
                                            begin
                                              if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptText) then
                                              begin
                                                AName := AName + MyHtmlParser.DataAsStr;
                                                Memo2.Lines.Add(AName);
                                              end;
                                            end;
                                          end
                                        end;
                                      end;
                                    end;
                                  end;
                                end;
                              end;
                            end;
                          end;
                        end;
                      end;

                    end;
                end;
              end;
          end;

        ptText:
          begin

          end;
      end;
    Result := False;
  finally
    AStream.Free;
  end;
end;

end.
