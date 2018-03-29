begin
  Insert into FLAGS ( CODE, NAME, EDIT, OPT )
  Values ( 13, '�������� ��������� �������� (1-���)', 1, 0 );
  dbms_output.put_line( '1 row created.' );
exception
  when DUP_VAL_ON_INDEX then
    update FLAGS
       set NAME = '�������� ��������� �������� (1-���)'
         , EDIT = 1
         , OPT  = 0
     where CODE = 13;
    dbms_output.put_line( '1 row updated.' );
end;
/

COMMIT;