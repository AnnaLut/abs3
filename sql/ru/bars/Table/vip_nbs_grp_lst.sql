-- ======================================================================================
-- Module : GL
-- Author : BAA
-- Date   : 09.06.2016
-- ======================================================================================
-- create table VIP_NBS_GRP_LST
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
prompt -- create table VIP_NBS_GRP_LST
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'VIP_NBS_GRP_LST', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'VIP_NBS_GRP_LST', 'FILIAL', NULL,  'E',  'E',  'E' );
--BARS.BPA.ALTER_POLICY_INFO( 'VIP_NBS_GRP_LST', 'CENTER', NULL,  'E',  'E',  'E' );
end;
/

begin
  execute immediate q'[create table BARS.VIP_NBS_GRP_LST
( R020            CHAR(4)    constraint CC_VIPNBSGRPLST_R020_NN  Not Null
, GRP_ID          NUMBER(38) constraint CC_VIPNBSGRPLST_GRPID_NN Not Null
, constraint PK_VIPNBSGRPLST        primary key ( R020, GRP_ID ) using index tablespace BRSMDLI
, constraint FK_VIPNBSGRPLST_PS        foreign key ( R020 )   references BARS.PS ( NBS )
, constraint FK_VIPNBSGRPLST_GROUPSACC foreign key ( GRP_ID ) references BARS.GROUPS_ACC ( ID )
) tablespace BRSMDLD]';
  
  dbms_output.put_line('table "VIP_NBS_GRP_LST" created.');
  
exception
  when OTHERS then
    if ( sqlcode = -00955 )
    then dbms_output.put_line( 'Table "VIP_NBS_GRP_LST" already exists.' );
    else raise;
    end if;  
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bpa.alter_policies( 'VIP_NBS_GRP_LST' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.VIP_NBS_GRP_LST        IS 'Довідник груп рахунків з обмеженим доступом';

COMMENT ON COLUMN BARS.VIP_NBS_GRP_LST.R020   IS 'Номер балансового рахунка';
COMMENT ON COLUMN BARS.VIP_NBS_GRP_LST.GRP_ID IS 'Ід. групи рахунків';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT, INSERT, UPDATE, DELETE ON BARS.VIP_NBS_GRP_LST TO START1;
GRANT SELECT, INSERT, UPDATE, DELETE ON BARS.VIP_NBS_GRP_LST TO BARS_ACCESS_DEFROLE;
