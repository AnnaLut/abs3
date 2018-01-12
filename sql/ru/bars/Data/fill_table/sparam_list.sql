SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF

begin
  BARS_CONTEXT.HOME;
  update SPARAM_LIST
     set TABNAME = 'ACCOUNTS'
       , INUSE   = 0
   where NAME = 'OB22';
  dbms_output.put_line( 'Changed name of the table for parameter OB22.' );
end;
/

begin
	update sparam_list
	set def_flag = 'Y'
	where name in ('R011', 'R013');
	dbms_output.put_line( 'Установка флага умолчательного заполнения для R011, R013' );
end;
/

commit;
