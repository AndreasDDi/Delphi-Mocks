unit Delphi.Mocks.Tests.Utils;

interface
uses
  DUnitX.TestFramework,
  Rtti,
  Delphi.Mocks.Helpers;

type
  //Testing TValue helper methods in TValueHelper
  {$M+}
  [TestFixture]
  TTestTValue = class
  published
    procedure Test_TValue_Equals_Interfaces;
    procedure Test_TValue_NotEquals_Interfaces;
    procedure Test_TValue_Equals_Strings;
    procedure Test_TValue_NotEquals_Strings;

    procedure Test_TValue_Equals_SameGuid_Instance;
    procedure Test_TValue_Equals_DifferentGuid_Instance;
    procedure Test_TValue_NotEquals_Guid;

    procedure Test_TRttiMethod_IsAbstract;
    procedure Test_TRttiMethod_IsVirtual;
  end;
  {$M-}

implementation

uses
  SysUtils;

type
  TMyClass = class
    procedure NormalMethod;
    procedure AbstractMethod; virtual; abstract;
    procedure VirtualMethod; virtual;
  end;

{ TTestTValue }

procedure TTestTValue.Test_TValue_Equals_Interfaces;
var
  i1,i2 : IInterface;
  v1, v2 : TValue;
begin
  i1 := TInterfacedObject.Create;
  i2 := i1;
  v1 := TValue.From<IInterface>(i1);
  v2 := TValue.From<IInterface>(i2);

  Assert.IsTrue(v1.Equals(v2));
end;

procedure TTestTValue.Test_TValue_Equals_Strings;
var
  s1,s2 : string;
  v1, v2 : TValue;
begin
  s1 := 'hello';
  s2 := 'hello';
  v1 := s1;
  v2 := s2;
  Assert.IsTrue(v1.Equals(v2));
end;

procedure TTestTValue.Test_TValue_Equals_SameGuid_Instance;
var
  s1,s2 : TGUID;
  v1, v2 : TValue;
begin
  s1 := StringToGUID( '{2933052C-79D0-48C9-86D3-8FF29416033C}' );
  s2 := s1;
  v1 := TValue.From<TGUID>( s1 );
  v2 := TValue.From<TGUID>( s2 );
  Assert.IsTrue(v1.Equals(v2));
end;

procedure TTestTValue.Test_TRttiMethod_IsAbstract;
var
  LCtx: TRttiContext;
begin
  Assert.IsFalse(LCtx.GetType(TMyClass).GetMethod('NormalMethod').IsAbstract);
  Assert.IsFalse(LCtx.GetType(TMyClass).GetMethod('NormalMethod').IsVirtual);

  Assert.IsTrue(LCtx.GetType(TMyClass).GetMethod('AbstractMethod').IsAbstract);
  Assert.IsTrue(LCtx.GetType(TMyClass).GetMethod('AbstractMethod').IsVirtual);

  Assert.IsFalse(LCtx.GetType(TMyClass).GetMethod('VirtualMethod').IsAbstract);
  Assert.IsTrue(LCtx.GetType(TMyClass).GetMethod('VirtualMethod').IsVirtual);
end;

procedure TTestTValue.Test_TRttiMethod_IsVirtual;
begin

end;

procedure TTestTValue.Test_TValue_Equals_DifferentGuid_Instance;
var
  s1,s2 : TGUID;
  v1, v2 : TValue;
begin
  s1 := StringToGUID( '{2933052C-79D0-48C9-86D3-8FF29416033C}' );
  s2 := StringToGUID( '{2933052C-79D0-48C9-86D3-8FF29416033C}' );
  v1 := TValue.From<TGUID>( s1 );
  v2 := TValue.From<TGUID>( s2 );
  Assert.IsTrue(v1.Equals(v2));
end;

procedure TTestTValue.Test_TValue_NotEquals_Guid;
var
  s1,s2 : TGUID;
  v1, v2 : TValue;
begin
  s1 := StringToGUID( '{2933052C-79D0-48C9-86D3-8FF294160000}' );
  s2 := StringToGUID( '{2933052C-79D0-48C9-86D3-8FF29416FFFF}' );
  v1 := TValue.From<TGUID>( s1 );
  v2 := TValue.From<TGUID>( s2 );
  Assert.IsFalse(v1.Equals(v2));
end;

procedure TTestTValue.Test_TValue_NotEquals_Interfaces;
var
  i1,i2 : IInterface;
  v1, v2 : TValue;
begin
  i1 := TInterfacedObject.Create;
  i2 := TInterfacedObject.Create;
  v1 := TValue.From<IInterface>(i1);
  v2 := TValue.From<IInterface>(i2);
  Assert.IsFalse(v1.Equals(v2));
end;

procedure TTestTValue.Test_TValue_NotEquals_Strings;
var
  s1,s2 : string;
  v1, v2 : TValue;
begin
  s1 := 'hello';
  s2 := 'goodbye';
  v1 := s1;
  v2 := s2;
  Assert.IsFalse(v1.Equals(v2));
end;

{ TMyClass }

procedure TMyClass.NormalMethod;
begin
  //No op
end;

procedure TMyClass.VirtualMethod;
begin
  //No op
end;

initialization
  TDUnitX.RegisterTestFixture(TTestTValue);

end.
