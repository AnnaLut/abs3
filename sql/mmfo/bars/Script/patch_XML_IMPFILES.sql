SET FEEDBACK OFF

prompt -- ======================================================
prompt -- drop primary key
prompt -- ======================================================

declare
  e_pk_not_exist  exception;
  pragma exception_init( e_pk_not_exist, -02441 );
begin
  execute immediate 'alter table XML_IMPFILES drop primary key cascade drop index';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_PK_NOT_EXIST then
    dbms_output.put_line( 'Cannot drop nonexistent primary key.' );
end;
/

prompt -- ======================================================
prompt -- remove duplicates
prompt -- ======================================================

exec bpa.disable_policies( 'XML_IMPFILES' );

SET FEEDBACK ON

delete XML_IMPFILES t1
 where t1.ROWID > ( select min(ROWID)
                      from XML_IMPFILES t2
                     where t2.KF = t1.KF
                       and t2.FN = t1.FN );

SET FEEDBACK OFF

exec bpa.enable_policies( 'XML_IMPFILES' );

commit;

prompt -- ======================================================
prompt -- create not null constraint
prompt -- ======================================================

declare
  e_already_nn  exception;
  pragma exception_init( e_already_nn, -01442 );
begin
  execute immediate 'alter table XML_IMPFILES modify FN constraint CC_XMLIMPFILES_FN_NN Not Null';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_already_nn then 
    dbms_output.put_line( 'Column "FN" is already NOT NULL.' );
end;
/

declare
  e_already_nn  exception;
  pragma exception_init( e_already_nn, -01442 );
begin
  execute immediate 'alter table XML_IMPFILES modify DAT constraint CC_XMLIMPFILES_DT_NN Not Null';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_already_nn then 
    dbms_output.put_line( 'Column "DAT" is already NOT NULL.' );
end;
/

declare
  e_already_nn  exception;
  pragma exception_init( e_already_nn, -01442 );
begin
  execute immediate 'alter table XML_IMPFILES modify USERID constraint CC_XMLIMPFILES_USRID_NN Not Null';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_already_nn then 
    dbms_output.put_line( 'Column "USERID" is already NOT NULL.' );
end;
/

prompt -- ======================================================
prompt -- create unique index
prompt -- ======================================================

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
 execute immediate q'[create unique index UK_XMLIMPFILES on XML_IMPFILES ( KF, FN )
  tablespace BRSMDLI
  compress 1 ]';
  dbms_output.put_line( 'Index "UK_XMLIMPFILES" created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

prompt -- ======================================================
prompt -- add new columns
prompt -- ======================================================

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table XML_IMPFILES add DOCS_QTY number(5)';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "DOCS_QTY" already exists in table.' );
end;
/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table XML_IMPFILES add DOCS_SUM number(24)';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "DOCS_SUM" already exists in table.' );
end;
/

declare
  e_already_nn  exception;
  pragma exception_init( e_already_nn, -01442 );
begin
  execute immediate 'alter table XML_IMPFILES modify DOCS_QTY default 0 constraint CC_XMLIMPFILES_DOCSQTY_NN Not Null ENABLE NOVALIDATE';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_already_nn then 
    dbms_output.put_line( 'Column "DOCS_QTY" is already NOT NULL.' );
end;
/

declare
  e_already_nn  exception;
  pragma exception_init( e_already_nn, -01442 );
begin
  execute immediate 'alter table XML_IMPFILES modify DOCS_SUM default 0 constraint CC_XMLIMPFILES_DOCSSUM_NN Not Null ENABLE NOVALIDATE';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_already_nn then 
    dbms_output.put_line( 'Column "DOCS_QTY" is already NOT NULL.' );
end;
/

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON COLUMN XML_IMPFILES.DOCS_QTY is 'К-ть документів у файлі';
COMMENT ON COLUMN XML_IMPFILES.DOCS_SUM is 'Сума документів у файлі';

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
