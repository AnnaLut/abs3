-- ======================================================================================
-- Module : 
-- Author : 
-- Date   : 11.07.2017
-- ======================================================================================
-- create table XML_IMPFILES
-- ======================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table XML_IMPFILES
prompt -- ======================================================

begin  
  bpa.alter_policy_info( 'XML_IMPFILES', 'CENTER', null, 'E', 'E', 'E' );
  bpa.alter_policy_info( 'XML_IMPFILES', 'FILIAL',  'M', 'M', 'M', 'M' );
  bpa.alter_policy_info( 'XML_IMPFILES', 'WHOLE',  null, 'E', 'E', 'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin 
  execute immediate 'create table XML_IMPFILES 
(	FN         VARCHAR2(30)                                                       constraint CC_XMLIMPFILES_FN_NN      Not Null
, DAT        DATE                                                               constraint CC_XMLIMPFILES_DT_NN      Not Null
, USERID     NUMBER(38)                                                         constraint CC_XMLIMPFILES_USRID_NN   Not Null
, BRANCH     VARCHAR2(30) default sys_context(''bars_context'',''user_branch'') constraint CC_XMLIMPFILES_BR_NN      Not Null
, KF         VARCHAR2(6)  default sys_context(''bars_context'',''user_mfo'')    constraint CC_XMLIMPFILES_KF_NN      Not Null
, DOCS_QTY   number(5)    default 0                                             constraint CC_XMLIMPFILES_DOCSQTY_NN Not Null
, DOCS_SUM   number(24)   default 0                                             constraint CC_XMLIMPFILES_DOCSSUM_NN Not Null
, constraint FK_XMLIMPFILES_STAFF foreign key (USERID) references STAFF$BASE (ID)
) tablespace BRSMDLD';
  
  dbms_output.put_line( 'Table "XML_IMPFILES" created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "XML_IMPFILES" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
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

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin   
  execute immediate 'create index IDX_XMLIMPFILES_DAT_USRID on XML_IMPFILES ( DAT, USERID )
  compute statistics 
  tablespace BRSMDLI';
  dbms_output.put_line( 'Index "IDX_XMLIMPFILES_DAT_USRID" created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bpa.alter_policies( 'XML_IMPFILES' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  XML_IMPFILES          IS 'Архiв прийнятих файлiв iмпорту iз зовнiшнiх задач';
COMMENT ON COLUMN XML_IMPFILES.FN       IS 'Iмя файлу iмпорту';
COMMENT ON COLUMN XML_IMPFILES.DAT      IS 'Банкiвська дата обробки';
COMMENT ON COLUMN XML_IMPFILES.USERID   IS 'Ід. користувача';
COMMENT ON COLUMN XML_IMPFILES.BRANCH   IS 'Бранч де проходить обробка';
COMMENT ON COLUMN XML_IMPFILES.KF       IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN XML_IMPFILES.DOCS_QTY is 'К-ть документів у файлі';
COMMENT ON COLUMN XML_IMPFILES.DOCS_SUM is 'Сума документів у файлі';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT,INSERT,UPDATE         on XML_IMPFILES to BARS_ACCESS_DEFROLE;
grant SELECT                       on XML_IMPFILES to BARS_DM;
grant SELECT,INSERT,UPDATE,DELETE  on XML_IMPFILES to WR_ALL_RIGHTS;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
