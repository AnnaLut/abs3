SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED

begin

  savepoint sp;

  BC.GO('352457');

  insert 
    into BR_NORMAL_EDIT
       ( BR_ID, BDATE, KV, RATE, KF )
  select 3379 as BR_ID, BDATE, KV, RATE, KF
    from BR_NORMAL_EDIT
   where BR_ID = 337922;

  dbms_output.put_line( to_char(sql%rowcount)||' row(s) inserted.' );

  update INT_RATN
     set BR = 3379
   where BR = 337922;

  dbms_output.put_line( to_char(sql%rowcount)||' row(s) updated.' );

  delete BR_NORMAL_EDIT
   where BR_ID = 337922;

  dbms_output.put_line( to_char(sql%rowcount)||' row(s) deleted.' );

  BC.HOME;

  delete BRATES
   where BR_ID = 337922;

  dbms_output.put_line( to_char(sql%rowcount)||' row(s) deleted.' );

  commit;

exception
  when others then
    dbms_output.put_line( sqlerrm );
    rollback to sp;
    BC.HOME;
end;
/
