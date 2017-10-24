-- ======================================================================================
-- Module : GL
-- Author : BAA
-- Date   : 09.06.2016
-- ======================================================================================
-- create table VIP_MGR_USR_LST
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        100
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table VIP_MGR_USR_LST
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'VIP_MGR_USR_LST', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'VIP_MGR_USR_LST', 'FILIAL', NULL,  'E',  'E',  'E' );
--BARS.BPA.ALTER_POLICY_INFO( 'VIP_MGR_USR_LST', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

begin
  execute immediate q'[create table BARS.VIP_MGR_USR_LST
( BRANCH          VARCHAR2(30) constraint CC_VIPMGRUSRLST_BRANCH_NN Not Null
, USR_ID          NUMBER(38)
, constraint UK_VIPMGRUSRLST             unique ( BRANCH, USR_ID ) using index tablespace BRSMDLI
, constraint FK_VIPMGRUSRLST_BRANCH foreign key ( BRANCH ) references BARS.BRANCH ( BRANCH )
, constraint FK_VIPMGRUSRLST_STAFF  foreign key ( USR_ID ) references BARS.STAFF$BASE ( ID )
) tablespace BRSMDLD]';
  
  dbms_output.put_line('table "VIP_MGR_USR_LST" created.');
  
exception
  when OTHERS then
    if ( sqlcode = -00955 )
    then dbms_output.put_line( 'Table "VIP_MGR_USR_LST" already exists.' );
    else raise;
    end if;  
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bpa.alter_policies( 'VIP_MGR_USR_LST' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.VIP_MGR_USR_LST        IS 'Довідник користувачів які відкритвають рахунки з обмеженою групою доступу';

COMMENT ON COLUMN BARS.VIP_MGR_USR_LST.BRANCH IS 'Код VIP відділення або відділення з VIP зоною';
COMMENT ON COLUMN BARS.VIP_MGR_USR_LST.USR_ID IS 'Ід. користувача АБС';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT, INSERT, UPDATE, DELETE ON BARS.VIP_MGR_USR_LST TO START1;
GRANT SELECT, INSERT, UPDATE, DELETE ON BARS.VIP_MGR_USR_LST TO BARS_ACCESS_DEFROLE;
