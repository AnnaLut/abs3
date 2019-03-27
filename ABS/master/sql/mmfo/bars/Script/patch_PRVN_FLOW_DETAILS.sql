-- ======================================================================================
-- Module   : PRVN
-- Author   : BAA
-- Date     : 10.08.2016
-- ===================================== <Comments> =====================================
-- Modify Table "PRVN_FLOW_DETAILS":
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
  
  BARS.BPA.DISABLE_POLICIES( 'PRVN_FLOW_DETAILS' );
  
  BARS.BC.SUBST_MFO( BARS.F_OURMFO_G );
  
  execute immediate q'[alter TABLE BARS.PRVN_FLOW_DETAILS add KF VARCHAR2(6) default sys_context('bars_context','user_mfo') constraint CC_PRVNDEALSFLOW_KF_NN not null ]';
  
  dbms_output.put_line( 'Table altered.' );
  
  bars.bc.home;
  
  BARS.BPA.ENABLE_POLICIES( 'PRVN_FLOW_DETAILS' );
  
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
  q'[CREATE UNIQUE INDEX BARS.UK_PRVNDEALSFLOW ON BARS.PRVN_FLOW_DETAILS ( MDAT, KF, ID, FDAT )
  TABLESPACE BRSMDLI
  COMPRESS 3 ]';
  dbms_output.put_line('index "UK_PRVNDEALSFLOW" created.');
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line('Index "UK_PRVNDEALSFLOW" already exists in the table.');
      when (sqlcode = -01408)
      then dbms_output.put_line('Column(s) "MDAT", "KF", "ID", "FDAT" already indexed.');
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Policies
prompt -- ======================================================

begin
  
  bars.bpa.alter_policy_info( 'PRVN_FLOW_DETAILS', 'WHOLE' , NULL, NULL, NULL, NULL );
  bars.bpa.alter_policy_info( 'PRVN_FLOW_DETAILS', 'FILIAL',  'M',  'M',  'M',  'M' );
  bars.bpa.alter_policy_info( 'PRVN_FLOW_DETAILS', 'CENTER', NULL,  'E',  'E',  'E' );
  
  bars.bpa.alter_policies( 'PRVN_FLOW_DETAILS' );

  commit;
  
end;
/

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.KF      IS '��� �i�i��� (���)';

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================