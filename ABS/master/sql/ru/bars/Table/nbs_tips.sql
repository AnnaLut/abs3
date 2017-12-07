-- ================================================================================
-- Module   : GL
-- Author   : BAA
-- Date     : 15.11.2017
-- ================================== <Comments> ==================================
-- create table NBS_TIPS
-- ================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET DEFINE       OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TIMING       OFF
SET TRIMSPOOL    ON
SET VERIFY       OFF

prompt -- ======================================================
prompt -- create table NBS_TIPS
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'NBS_TIPS', 'WHOLE',  null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'NBS_TIPS', 'FILIAL', null,  'E',  'E',  'E' );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table NBS_TIPS
( NBS        CHAR(4) constraint CC_NBSTIPS_NBS_NN NOT NULL
, OB22       CHAR(4)
, TIP        CHAR(3) constraint CC_NBSTIPS_TIP_NN NOT NULL
, OPT        NUMBER
, constraint UK_NBSTIPS unique ( NBS, OB22, TIP )
) tablespace BRSSMLD';

  dbms_output.put_line( 'Table "NBS_TIPS" created.');

exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "NBS_TIPS" already exists.' );
end;
/


SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICIES( 'NBS_TIPS' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  NBS_TIPS      IS 'Связь R020+OB22<->Типы счетов';

COMMENT ON COLUMN NBS_TIPS.NBS  IS 'Номер балансового рахунку (R020)';
COMMENT ON COLUMN NBS_TIPS.OB22 IS 'Параметр OB22';
COMMENT ON COLUMN NBS_TIPS.TIP  IS 'Тип рахунку';

prompt -- ======================================================
prompt -- Foreign Keys
prompt -- ======================================================

declare
  e_ref_cnstrn_exists exception;
  pragma exception_init( e_ref_cnstrn_exists, -02275 );
begin
  execute immediate q'[alter table NBS_TIPS ADD constraint FK_NBSTIPS_NBS foreign key ( NBS )
  references PS ( NBS ) ]';
  dbms_output.put_line( 'Foreign key "FK_NBSTIPS_NBS" created.' );
exception
  when e_ref_cnstrn_exists then
    dbms_output.put_line( 'Such a referential constraint already exists in the table.' );
end;
/

declare
  e_ref_cnstrn_exists exception;
  pragma exception_init( e_ref_cnstrn_exists, -02275 );
begin
  execute immediate q'[alter table NBS_TIPS ADD constraint FK_NBSTIPS_TIP foreign key ( TIP )
  references TIPS ( TIP ) ]';
  dbms_output.put_line( 'Foreign key "FK_NBSTIPS_TIP" created.' );
exception
  when e_ref_cnstrn_exists then
    dbms_output.put_line( 'Such a referential constraint already exists in the table.' );
end;
/

declare
  e_ref_cnstrn_exists exception;
  pragma exception_init( e_ref_cnstrn_exists, -02275 );
begin
  execute immediate q'[alter table NBS_TIPS add constraint FK_NBSTIPS_SBOB22 foreign key ( NBS, OB22 )
  references SB_OB22 ( R020, OB22 ) ]';
  dbms_output.put_line( 'Foreign key "FK_NBSTIPS_SBOB22" created.' );
exception
  when e_ref_cnstrn_exists then
    dbms_output.put_line('Such a referential constraint already exists in the table.');
end;
/

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on NBS_TIPS to BARS_ACCESS_DEFROLE;
grant SELECT on NBS_TIPS to BARS_DM;
grant SELECT on NBS_TIPS to WR_REFREAD;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
