unit WBUtil;

interface

uses
  Classes,
  SysUtils, Variants,
  Controls, Forms, Dialogs,
  MSHTML_EWB,
  EwbCore,
  SHDocVw_EWB,
  EmbeddedWB;

function strip(s: string): string;
function safeStrToCurr(s: string): Currency;
function NumberOfForms(document: IHTMLDocument2): integer;
function GetFormByNumber(document: IHTMLDocument2; formNumber: integer): IHTMLFormElement;
function GetFormByName(document: IHTMLDocument2; const formName: string): IHTMLFormElement;
function GetFormNameByFormNumber(document: IHTMLDocument2; formNumber: integer): string;
function GetFormFieldNames(fromForm: IHTMLFormElement): TStringList;
function GetFieldValue(fromForm: IHTMLFormElement; const fieldName: string): string;
procedure SetFieldValue(theForm: IHTMLFormElement; const fieldName: string; const newValue: string; const instance: integer = 0);

implementation

function strip(s: string): string;
var
  retval: string;
  x: integer;
begin
  retval := '';
  if length(s) > 0 then
  begin
    for x := 1 to length(s) do
    begin
      if s[x] in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'] then
        retval := retval + s[x];
    end;
  end;
  result := retval;
end;

function safeStrToCurr(s: string): Currency;
var
  c: Currency;
begin
  c := 0.00;

  s := strip(s);
  if (s <> '') then
  begin
    try
      c := strtocurr(s);
    except
      c := 0.00;
    end;
  end;

  result := c;
end;

function NumberOfForms(document: IHTMLDocument2): integer;
var
  Forms: IHTMLElementCollection;
begin
  try
    Forms := document.Forms as IHTMLElementCollection;
    result := Forms.length;
  except
    result := -1;
  end;
end;

function GetFormByNumber(document: IHTMLDocument2; formNumber: integer): IHTMLFormElement;
var
  Forms: IHTMLElementCollection;
begin
  Forms := document.Forms as IHTMLElementCollection;
  if formNumber < Forms.length then
    result := Forms.Item(formNumber, '') as IHTMLFormElement
  else
    result := nil;
end;

function GetFormByName(document: IHTMLDocument2; const formName: string): IHTMLFormElement;
var
  Forms: IHTMLElementCollection;
begin
  Forms := document.Forms as IHTMLElementCollection;
  result := Forms.Item(formName, '') as IHTMLFormElement
end;

function GetFormNameByFormNumber(document: IHTMLDocument2; formNumber: integer): string;
var
  Form: IHTMLFormElement;
begin
  Form := GetFormByNumber(document, formNumber);
  if Assigned(Form) then
    result := Form.Name
  else
    result := 'No form name for form number:' + IntToStr(formNumber);
end;

function GetFormFieldNames(fromForm: IHTMLFormElement): TStringList;
var
  index: integer;
  field: IHTMLElement;
  input: IHTMLInputTextElement;
  select: IHTMLSelectElement;
  text: IHTMLTextAreaElement;
  s1, s2: string;
begin
  if (fromForm = nil) then
  begin
    result := nil;
    exit;
  end;
  result := TStringList.Create;
  for index := 0 to fromForm.length do
  begin
    field := fromForm.Item(index, '') as IHTMLElement;
    if Assigned(field) then
    begin
      if field.tagName = 'INPUT' then
      begin
        // Input field.
        input := fromForm.Item(index, '') as IHTMLInputTextElement;
        result.Add(input.Name);
        s1 := input.type_;
        s2 := input.value;
        // s3 := input.alt;
        // s4 := input.src;

      end
      else if field.tagName = 'SELECT' then
      begin
        // Select field.
        select := field as IHTMLSelectElement;
        result.Add(select.Name);
      end
      else if field.tagName = 'TEXTAREA' then
      begin
        // TextArea field.
        text := field as IHTMLTextAreaElement;
        result.Add(text.Name);
      end;
    end;
  end;
end;

function GetFieldValue(fromForm: IHTMLFormElement; const fieldName: string): string;
var
  field: IHTMLElement;
  inputField: IHTMLInputElement;
  selectField: IHTMLSelectElement;
  textField: IHTMLTextAreaElement;
begin
  field := fromForm.Item(fieldName, '') as IHTMLElement;
  if not Assigned(field) then
    result := ''
  else if field.tagName = 'INPUT' then
  begin
    inputField := field as IHTMLInputElement;
    if (inputField.type_ <> 'radio') and (inputField.type_ <> 'checkbox') then
      result := inputField.value
    else if inputField.checked then
      result := 'checked'
    else
      result := 'unchecked';
  end
  else if field.tagName = 'SELECT' then
  begin
    selectField := field as IHTMLSelectElement;
    result := selectField.value
  end
  else if field.tagName = 'TEXTAREA' then
  begin
    textField := field as IHTMLTextAreaElement;
    result := textField.value;
  end;
end;

procedure SetFieldValue(theForm: IHTMLFormElement; const fieldName: string; const newValue: string; const instance: integer = 0);
var
  field: IHTMLElement;
  inputField: IHTMLInputElement;
  selectField: IHTMLSelectElement;
  textField: IHTMLTextAreaElement;
begin
  field := theForm.Item(fieldName, instance) as IHTMLElement;
  if Assigned(field) then
  begin
    if field.tagName = 'INPUT' then
    begin
      inputField := field as IHTMLInputElement;
      if (inputField.type_ <> 'radio') and (inputField.type_ <> 'checkbox') then
        inputField.value := newValue
      else
        inputField.checked := (newValue = 'checked');
    end
    else if field.tagName = 'SELECT' then
    begin
      selectField := field as IHTMLSelectElement;
      selectField.value := newValue;
    end
    else if field.tagName = 'TEXTAREA' then
    begin
      textField := field as IHTMLTextAreaElement;
      textField.value := newValue;
    end;
  end;
end;

end.
