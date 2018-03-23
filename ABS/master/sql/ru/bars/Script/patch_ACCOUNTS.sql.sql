-- ================================================================================
-- Author : BAA
-- Date   : 12.02.2018
-- ================================== <Comments> ==================================
-- create constraints
-- ================================================================================
declare
  E_CNSTRN_NOT_EXISTS     exception;
  pragma exception_init( E_CNSTRN_NOT_EXISTS, -02443 );
begin
  execute immediate q'[alter table ACCOUNTS drop constraint FK_ACCOUNTS_SBOB22]';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CNSTRN_NOT_EXISTS
  then null;
end;
/

prompt --
prompt -- create check constraint CC_ACCOUNTS_DAZS
prompt --

declare
  l_err_qty              pls_integer := 0;
  l_stmt                 varchar2(512);
  E_CHK_CNSTRN_EXISTS    exception;
  pragma exception_init( E_CHK_CNSTRN_EXISTS, -02264 );
begin
  for a in ( select KF, ACC, rowid as ROW_ID 
               from ACCOUNTS 
              where DAZS is not null 
                and OSTC <> 0 )
  loop
    begin
      bc.subst_mfo( a.KF );
      update ACCOUNTS
         set DAZS = null
       where ROWID = a.ROW_ID;
    exception
      when OTHERS then
        l_err_qty := l_err_qty + 1;
        dbms_output.put_line( 'ACC='||to_char(a.ACC)||' ERR'||sqlerrm );
    end;
  end loop;
  bc.set_context;
  l_stmt := 'alter table ACCOUNTS add constraint CC_ACCOUNTS_DAZS check ( OSTC = nvl2(DAZS,0,OSTC) )';
  if ( l_err_qty > 0 )
  then
    l_stmt := l_stmt || ' NOVALIDATE';
  end if;
  begin
    execute immediate l_stmt;
    dbms_output.put_line( 'Table altered.' );
  exception
    when E_CHK_CNSTRN_EXISTS 
    then null;
  end;
end;
/
