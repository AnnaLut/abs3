begin
  Insert into BARS.CC_VIDD
    ( VIDD, CUSTTYPE, TIPD, NAME )
  Values
    ( 9, 2, 1, '������i� (�����)' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert into BARS.CC_VIDD
    ( VIDD, CUSTTYPE, TIPD, NAME )
   Values
    ( 19, 2, 1, '���������� (�����)' );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert into BARS.CC_VIDD
    ( VIDD, CUSTTYPE, TIPD, NAME )
  Values
    ( 29, 2, 1, '������� (�����)');
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert into BARS.CC_VIDD
    (VIDD, CUSTTYPE, TIPD, NAME)
   Values
    ( 39, 2, 1, '���� (�����)');
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

COMMIT;
