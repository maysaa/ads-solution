unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Xml.xmldom, Xml.XMLIntf,
  Xml.Win.msxmldom, Xml.XMLDoc, Xml.adomxmldom, DIUnicode, DIHtmlParser,
  DIHtmlMisc, DIUtils, uADStanIntf, uADStanOption, uADStanError, uADGUIxIntf, uADPhysIntf, uADStanDef, uADStanPool, uADStanAsync,
  uADPhysManager, Data.DB, uADCompClient, uADPhysPG, uADStanParam, uADDatSManager, uADDAptIntf, uADDAptManager, uADCompDataSet,
  uADGUIxFormsWait, uADCompGUIx;

type
  ContactRecord = record
    Name: string;
    IsGSM: Boolean;
    Phone: string;
    PhoneOperator: string;
    Address1: string;
    Address2: string;
  end;

type
  TfrmMain = class(TForm)
    IdHTTP1: TIdHTTP;
    Button1: TButton;
    LOG: TMemo;
    Button2: TButton;
    MyHtmlParser: TDIHtmlParser;
    Button3: TButton;
    txtRegion: TEdit;
    Label1: TLabel;
    Button4: TButton;
    cbSaveLOG: TCheckBox;
    ADConnection1: TADConnection;
    ADPhysPgDriverLink1: TADPhysPgDriverLink;
    qryExistContact: TADQuery;
    ADGUIxWaitCursor1: TADGUIxWaitCursor;
    qryExistContactID: TIntegerField;
    qryExistContactName: TWideStringField;
    qryExistContactPhone: TWideStringField;
    qryExistContactAddress2: TWideStringField;
    qryExistContactPostCode: TWideStringField;
    qryExistContactPhoneOperator: TWideStringField;
    qryExistContactAddress1: TWideStringField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function ParseContactList(URL: String; var NextURL: String): Boolean;
    function IsContactList(PageSource: TMemoryStream): Boolean;
    function SaveContacts(ContactList: array of ContactRecord): Boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  AStop: Boolean = false;

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

  LOG.Text := Reader.ReadToEnd();

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
                                              LOG.Lines.Add(AName);
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
  aURL, URL, NextURL, MainURL, AName, ANameParam, ARegion, ARegionParam: String;
  i, ii, iii: Integer;
  aExit: Boolean;
  ALogFileName: String;
begin
  try
    AStop := false;
    URL := 'http://www.118.lt';
    MainURL := 'http://www.118.lt/gyventoju-paieska/paieskos-rezultatai?actionId=7';
    ANameParam := '&flname=';
    ARegionParam := '&rgn=';
    ARegion := Trim(txtRegion.Text);
    // A-Z 65-90
    for i := 71 to 90 do
    begin
      for ii := 65 to 90 do
      begin
        for iii := 65 to 90 do
        begin
          if AStop = True then
            Exit;

          AName := char(i) + char(ii) + char(iii);
          aURL := MainURL + ANameParam + AName + ARegionParam + ARegion;

          aExit := false;
          while not aExit = True do
          begin
            LOG.Lines.Add(DateTimeToStr(Now) + ' ' + aURL);
            sleep(2000);
            if not ParseContactList(aURL, NextURL) then
            begin
              if AStop = false then
                LOG.Lines[LOG.Lines.Count - 1] := LOG.Lines[LOG.Lines.Count - 1] + ' - NERASTAS';
              aExit := True;
              Break;
            end;
            if NextURL <> '' then
            begin
              aURL := URL + NextURL;
            end
            else
            begin
              aExit := True;
              Break;
            end;
            if AStop = True then
              Exit;
          end;
        end;
      end;
    end;
  finally
    if cbSaveLOG.Checked then
    begin
      ALogFileName := application.exename;
      ALogFileName := ChangeFileExt(ALogFileName, '.log');
      LOG.Lines.SaveToFile(ALogFileName);
    end;
  end;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  AStop := True;
  LOG.Lines.Add(DateTimeToStr(Now) + ' STOP');
end;

procedure TfrmMain.Button4Click(Sender: TObject);
var
  ALogFileName: string;
begin
  ALogFileName := application.exename;
  ALogFileName := ChangeFileExt(ALogFileName, '.log');
  LOG.Lines.SaveToFile(ALogFileName);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  ADConnection1.Connected := True;
end;

function TfrmMain.IsContactList(PageSource: TMemoryStream): Boolean;
var
  AHtmlParser: TDIHtmlParser;
begin
  Result := false;
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
                            Result := false;
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

function TfrmMain.ParseContactList(URL: String; var NextURL: String): Boolean;
var
  Contacts: array [1 .. 200] of ContactRecord;
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
      Result := false;
      Exit;
    end;

    RegisterHtmlTags;
    RegisterHtmlAttribs;
    RegisterHtmlDecodingEntities;

    MyHtmlParser.SourceStream := AStream;
    MyHtmlParser.ReadMethods := Read_UTF_8;

    { Show HTML tags and text }
    MyHtmlParser.FilterHtmlTags.SetStartEnd(fiShow);
    MyHtmlParser.FilterText := fiShow;
    MyHtmlParser.FilterScripts := fiShow;

    ARecord := 1;

    while MyHtmlParser.ParseNextPiece do
      case MyHtmlParser.PieceType of
        // What type of HTML piece did the parser find?
        ptHtmlTag: // Found a tag.
          begin
            case MyHtmlParser.HtmlTag.TagID of
              TAG_DIV_ID: // Found a DIV tag.
                begin
                  // Gal galima surastas DIV bloka kaip objekta ir tada analizuoti?

                  case MyHtmlParser.HtmlTag.TagType of

                    ttStartTag:
                      begin
                        application.ProcessMessages;
                        if AStop = True then
                          Exit;

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
                                      if (MyHtmlParser.PieceType = ptText) and (Trim(MyHtmlParser.DataAsStr) <> '') then
                                      begin
                                        Contacts[ARecord].Name := Trim(MyHtmlParser.DataAsStr);
                                        LOG.Lines.Add('     ' + Contacts[ARecord].Name);
                                      end
                                      else
                                      begin
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
                                                    LOG.Lines.Add('     ' + Trim(AName));
                                                    Contacts[ARecord].Name := Trim(AName);
                                                  end;
                                                end;
                                              end;
                                            end;
                                          end;
                                        end;
                                      end; // ELSE
                                      MyHtmlParser.ParseNextPiece;
                                      MyHtmlParser.ParseNextPiece;
                                      MyHtmlParser.ParseNextPiece;
                                      MyHtmlParser.ParseNextPiece;
                                      MyHtmlParser.ParseNextPiece;
                                      MyHtmlParser.ParseNextPiece;

                                      { mob/tel }
                                      if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptText) then
                                      begin
                                        if POS('Tel', MyHtmlParser.DataAsStr) > 0 then
                                          Contacts[ARecord].IsGSM := false
                                        else
                                          Contacts[ARecord].IsGSM := True;
                                        { phone }
                                        MyHtmlParser.ParseNextPiece;
                                        MyHtmlParser.ParseNextPiece;
                                        if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptScript) then
                                        begin
                                          Contacts[ARecord].Phone := Trim(MyHtmlParser.DataAsStr);
                                          Delete(Contacts[ARecord].Phone, 1, 16);
                                          Delete(Contacts[ARecord].Phone, Length(Contacts[ARecord].Phone) - 2, 3);
                                          LOG.Lines[LOG.Lines.Count - 1] := LOG.Lines[LOG.Lines.Count - 1] + ' | ' +
                                            Contacts[ARecord].Phone;
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
            application.ProcessMessages;
            { Paging,  class=next }
            if StrSameIW(MyHtmlParser.HtmlTag.ValueOfNameCI['class'], 'next') then
            begin
              MyHtmlParser.ParseNextPiece;
              if POS('/gyventoju-paieska/paieskos-rezultatai', Trim(MyHtmlParser.DataAsStr)) > 0 then
                NextURL := Trim(MyHtmlParser.DataAsStr)
              else
                NextURL := '';

            end;

            { <p class="address"> }
            if StrSameIW(MyHtmlParser.HtmlTag.ValueOfNameCI['class'], 'address') then
            begin
              MyHtmlParser.ParseNextPiece;
              MyHtmlParser.ParseNextPiece;
              if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptScript) then
              begin
                { address1 }
                Contacts[ARecord].Address1 := Trim(MyHtmlParser.DataAsStr);
                Delete(Contacts[ARecord].Address1, 1, 16);
                Delete(Contacts[ARecord].Address1, Length(Contacts[ARecord].Address1) - 2, 3);
                LOG.Lines[LOG.Lines.Count - 1] := LOG.Lines[LOG.Lines.Count - 1] + ' | ' + Contacts[ARecord].Address1;
              end;

              MyHtmlParser.ParseNextPiece;
              MyHtmlParser.ParseNextPiece;
              MyHtmlParser.ParseNextPiece;
              if MyHtmlParser.ParseNextPiece and (MyHtmlParser.PieceType = ptScript) then
              begin
                { address2 }
                Contacts[ARecord].Address2 := Trim(MyHtmlParser.DataAsStr);
                Delete(Contacts[ARecord].Address2, 1, 16);
                Delete(Contacts[ARecord].Address2, Length(Contacts[ARecord].Address2) - 2, 3);
                LOG.Lines[LOG.Lines.Count - 1] := LOG.Lines[LOG.Lines.Count - 1] + ' | ' + Contacts[ARecord].Address2;
                inc(ARecord);
              end;
            end;

          end; // HTML TAG - case end

        ptText:
          begin
            application.ProcessMessages;
            { Operatorius: }
            if Trim(MyHtmlParser.DataAsStr) = 'Operatorius:' then
            begin
              MyHtmlParser.ParseNextPiece;
              MyHtmlParser.ParseNextPiece;
              Contacts[ARecord].PhoneOperator := Trim(MyHtmlParser.DataAsStr);
              LOG.Lines[LOG.Lines.Count - 1] := LOG.Lines[LOG.Lines.Count - 1] + ' | ' + Contacts[ARecord].PhoneOperator;
            end;
          end;
      end;

    { Save data }
    if not SaveContacts(Contacts) then
    begin
      LOG.Lines.Add(DateTimeToStr(Now) + '  SAVE TO DB ERROR');
      Result := false;
      Exit;
    end;

    Result := True;
  finally
    AStream.Free;
  end;
end;

function TfrmMain.SaveContacts(ContactList: array of ContactRecord): Boolean;
var
  i: Integer;
begin
  try

    Result := false;
    for i := 0 to 199 do
    begin
      if ContactList[i].Name <> '' then
      begin
        qryExistContact.Close;
        qryExistContact.ParamByName('NAME').AsString := ContactList[i].Name;
        qryExistContact.ParamByName('PHONE').AsString := ContactList[i].Phone;
        qryExistContact.Open();

        { Update }
        if qryExistContact.RecordCount <> 0 then
        begin
          qryExistContact.Edit;
          qryExistContactPhoneOperator.Value := ContactList[i].PhoneOperator;
          qryExistContactAddress1.Value := ContactList[i].Address1;
          qryExistContactAddress2.Value := ContactList[i].Address2;
          qryExistContact.Post;
        end
        else
        begin
          { Insert }
          qryExistContact.Insert;
          qryExistContactName.Value := ContactList[i].Name;
          qryExistContactPhone.Value := ContactList[i].Phone;
          qryExistContactPhoneOperator.Value := ContactList[i].PhoneOperator;
          qryExistContactAddress1.Value := ContactList[i].Address1;
          qryExistContactAddress2.Value := ContactList[i].Address2;
          qryExistContact.Post;
        end;
      end;
    end;
    Result := True;
  except
    on e: exception do
    begin
      Result := false;
      LOG.Lines.Add(DateTimeToStr(Now) + ' ' + e.Message);
      Result := false;
    end
  end;
end;

end.
