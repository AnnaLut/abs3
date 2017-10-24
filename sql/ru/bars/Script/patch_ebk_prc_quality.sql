SET DEFINE OFF;

delete from EBK_PRC_QUALITY;

commit;

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table EBK_PRC_QUALITY add PRC_QLY number(2)';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then dbms_output.put_line( 'Column "PRC_QLY" already exists in table.' );
end;
/

declare
  e_chk_cnstrn_exists    exception;
  pragma exception_init( e_chk_cnstrn_exists, -02264 );
begin
  execute immediate 'alter table EBK_PRC_QUALITY add constraint CC_EBKPRCQUALITY_PRCQLY check ( PRC_QLY >= 0 or PRC_QLY <= 99 )';
  dbms_output.put_line( 'Constraint "CC_EBKPRCQUALITY_PRCQLY" created.' );
exception
  when e_chk_cnstrn_exists
  then dbms_output.put_line( 'Constraint "CC_EBKPRCQUALITY_PRCQLY" already exists in table.' );
end;
/

declare
  e_key_exists  exception;
  pragma exception_init( e_key_exists, -02261 );
begin
  execute immediate 'alter table EBK_PRC_QUALITY add constraint UK_EBKPRCQUALITY_PRCQLY unique ( PRC_QLY )';
  dbms_output.put_line( 'Unique key UK_EBKPRCQUALITY_PRCQLY created.' );
EXCEPTION
  when e_key_exists 
  then dbms_output.put_line( 'Such unique or primary key already exists in the table.' );
END;
/

declare
  e_col_not_exists exception;
  pragma exception_init(e_col_not_exists,-00904);
begin
  execute immediate 'alter table EBK_PRC_QUALITY drop column NAME';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_not_exists then
    dbms_output.put_line( 'Column "NAME" does not exist in table.' );
end;
/

alter table EBK_PRC_QUALITY add NAME varchar2(5) as ( '> '||to_char(PRC_QLY,'FM00') );

declare
  e_col_not_exists exception;
  pragma exception_init(e_col_not_exists,-00904);
begin
  execute immediate 'alter table EBK_PRC_QUALITY drop column DESCR';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_not_exists then
    dbms_output.put_line( 'Column "DESCR" does not exist in table.' );
end;
/

alter table EBK_PRC_QUALITY add DESCR varchar2(27) as ( 'Заповнені більш ніж на '||to_char(PRC_QLY,'FM00')||'%' );
