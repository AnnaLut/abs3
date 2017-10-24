-- ======================================================================================
-- Module   : PRVN
-- Author   : BAA
-- Date     : 10.08.2016
-- ===================================== <Comments> =====================================
-- Modify Table "PRVN_FLOW_DEALS_VAR":
--  1) Add column "KF"
--  2) Create index
--  3) Add policies
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        100
SET TERMOUT      ON
SET TRIMSPOOL    ON

begin
  
  BARS.BPA.DISABLE_POLICIES( 'PRVN_FLOW_DEALS_VAR' );
  
  BARS.BC.SUBST_MFO( BARS.F_OURMFO_G );
  
  execute immediate q'[alter TABLE BARS.PRVN_FLOW_DEALS_VAR add KF VARCHAR2(6) default sys_context('bars_context','user_mfo') constraint CC_PRVNDEALSVAR_KF_NN not null ]';
  
  dbms_output.put_line( 'Table altered.' );
  
  bars.bc.home;
  
  BARS.BPA.ENABLE_POLICIES( 'PRVN_FLOW_DEALS_VAR' );
  
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column KF already exists in table.');
    else raise;
    end if;
end;
/

-- ======================================================
-- Indexes
-- ======================================================

begin
  execute immediate
  q'[CREATE UNIQUE INDEX BARS.UK_PRVNDEALSVAR ON BARS.PRVN_FLOW_DEALS_VAR ( ZDAT, KF, ID )
  TABLESPACE BRSMDLI
  COMPRESS 2 ]';
  dbms_output.put_line('index "UK_PRVNDEALSVAR" created.');
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line('Index "UK_PRVNDEALSVAR" already exists in the table.');
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "ZDAT", "KF", "ID" already indexed.');
      else raise;
    end case;
end;
/

begin
  execute immediate q'[alter table BARS.PRVN_FLOW_DEALS_VAR add constraint FK_PRVNDEALSVAR_PRVNDEALSCONST foreign key ( ID ) references PRVN_FLOW_DEALS_CONST ( ID ) ]';
  dbms_output.put_line( 'Table altered.' );
exception
  when OTHERS then
    if ( sqlcode = -02275 )
    then dbms_output.put_line( 'Such a referential constraint already exists in the table.' );
    else raise;
    end if;  
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Policies
prompt -- ======================================================

begin

  bars.bpa.alter_policy_info( 'PRVN_FLOW_DEALS_VAR', 'WHOLE' , NULL, NULL, NULL, NULL );
  bars.bpa.alter_policy_info( 'PRVN_FLOW_DEALS_VAR', 'FILIAL',  'M',  'M',  'M',  'M' );

  bars.bpa.alter_policies( 'PRVN_FLOW_DEALS_VAR' );

  commit;

end;
/

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_VAR.KF      IS ' Ó‰ ÙiÎi‡ÎÛ (Ã‘Œ)';

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
