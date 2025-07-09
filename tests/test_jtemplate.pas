unit test_jtemplate;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testregistry, jtemplate;

type
  TJTemplateTest = class(TTestCase)
  published
    procedure TestStrToHtml;
    procedure TestReplaceSimple;
    procedure TestEscape;
  end;

implementation

procedure TJTemplateTest.TestStrToHtml;
begin
  AssertEquals('&lt;', StrToHtml('<'));
  AssertEquals('&gt;', StrToHtml('>'));
  AssertEquals('&quot;', StrToHtml('"'));
end;

procedure TJTemplateTest.TestReplaceSimple;
var
  P: TJTemplateParser;
begin
  P := TJTemplateParser.Create;
  try
    P.Content := 'Hello, @name@!';
    P.TagSuffix := '@';
    P.Fields.Add('name', 'World');
    P.Replace;
    AssertEquals('Hello, World!', P.Content);
  finally
    P.Free;
  end;
end;

procedure TJTemplateTest.TestEscape;
var
  P: TJTemplateParser;
begin
  P := TJTemplateParser.Create;
  try
    P.Content := '@@name@';
    P.TagEscape := '@';
    P.TagSuffix := '@';
    P.Fields.Add('name', 'World');
    P.Replace;
    AssertEquals('@name@', P.Content);
  finally
    P.Free;
  end;
end;

initialization
  RegisterTest(TJTemplateTest);
end.
