declare
  e_trg_not_exists       exception;
  pragma exception_init( e_trg_not_exists, -04080 );
begin
  execute immediate 'drop trigger TIU_ACC_BALANCE_CHANGES';
  dbms_output.put_line( 'Trigger dropped.' );
exception
  when e_trg_not_exists
  then null;
end;
/

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table ACC_BALANCE_CHANGES_UPDATE';
  dbms_output.put_line( 'Table dropped.' );
exception
  when e_tab_not_exists
  then null;
end;
/