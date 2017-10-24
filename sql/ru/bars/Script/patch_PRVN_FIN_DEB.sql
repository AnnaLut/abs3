-- ======================================================================================
-- Module   : DPU
-- Author   : BAA
-- Date     : 24.02.2016
-- Modifier : BAA
-- Modified : 10.08.2016
-- ===================================== <Comments> =====================================
-- Modify Table "PRVN_FIN_DEB":
--  1) Create constraint "CC_PRVNFINDEB_ACCSS_NN"
--  3) Create column "EFFECTDATE" with NOT NULL constraint
--  4) Create index "IDX_PRVNFINDEB_EFFECTDT_ACCSS"
--  5) Add column "KF" with NOT NULL constraint
--  6) Create unique index "UK_PRVNFINDEB_KF_ACCSS"
--  7) Add column "AGRM_ID"
--  8) Add policies
--  9) Create error log table
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF
SET TIMING       OFF

prompt -- ======================================================
prompt -- Create constraint CC_PRVNFINDEB_ACCSS_NN
prompt -- ======================================================

begin
  execute immediate 'ALTER TABLE BARS.PRVN_FIN_DEB MODIFY ACC_SS CONSTRAINT CC_PRVNFINDEB_ACCSS_NN NOT NULL';
  dbms_output.put_line( 'Table altered.' );
exception
  when others then 
    if (sqlcode = -01442)
    then dbms_output.put_line( 'Column "ACC_SS" is already NOT NULL.' );
    else raise;
    end if;  
end;
/

prompt -- ======================================================
prompt -- Create column EFFECTDATE with NOT NULL constraint
prompt -- ======================================================

begin
  execute immediate q'[ALTER TABLE BARS.PRVN_FIN_DEB ADD ( EFFECTDATE DATE 
  DEFAULT nvl(to_date(sys_context('bars_gl','bankdate'),'MM/DD/YYYY'),trunc(sysdate)) 
  CONSTRAINT CC_PRVNFINDEB_EFFECTDATE_NN NOT NULL )]';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "EFFECTDATE" already exists in table.');
    else raise;
    end if;
end;
/

prompt -- ======================================================
prompt -- Create index IDX_PRVNFINDEB_EFFECTDT_ACCSS
prompt -- ======================================================

begin
  execute immediate 'CREATE INDEX BARS.IDX_PRVNFINDEB_EFFECTDT_ACCSS ON BARS.PRVN_FIN_DEB ( EFFECTDATE, ACC_SS )';
  dbms_output.put_line('Index "IDX_PRVNFINDEB_EFFECTDT_ACCSS" created.');
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line('Index "IDX_PRVNFINDEB_EFFECTDT_ACCSS" already exists in the table.');
      when (sqlcode = -01408)
      then dbms_output.put_line('Such column list already indexed.');
      else raise;
    end case;
end;
/

prompt -- ======================================================
prompt -- Column KF with NOT NULL constraint
prompt -- ======================================================

begin
  
  BARS.BPA.DISABLE_POLICIES( 'PRVN_FIN_DEB' );
  
  BARS.BC.SUBST_MFO( BARS.F_OURMFO_G );
  
  execute immediate q'[alter TABLE BARS.PRVN_FIN_DEB add KF VARCHAR2(6) default sys_context('bars_context','user_mfo') constraint CC_PRVNFINDEB_KF_NN not null ]';
  
  dbms_output.put_line( 'Table altered.' );
  
  bars.bc.home;
  
  BARS.BPA.ENABLE_POLICIES( 'PRVN_FIN_DEB' );
  
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column KF already exists in table.');
    else raise;
    end if;
end;
/

prompt -- ======================================================
prompt -- Create unique index UK_PRVNFINDEB_KF_ACCSS
prompt -- ======================================================

-- begin
--   execute immediate 'create unique index BARS.UK_PRVNFINDEB_KF_ACCSS on BARS.PRVN_FIN_DEB ( KF, ACC_SS )';
--   dbms_output.put_line( 'Index "UK_PRVNFINDEB_KF_ACCSS" created.' );
-- exception
--   when OTHERS then
--     case
--       when (sqlcode = -00955)
--       then dbms_output.put_line( 'Index "UK_PRVNFINDEB_KF_ACCSS" already exists in the table.' );
--       when (sqlcode = -01408)
--       then dbms_output.put_line( 'Such column list already indexed.' );
--       else raise;
--     end case;
-- end;
-- /

prompt -- ======================================================
prompt -- Create column AGRM_ID
prompt -- ======================================================

declare
  e_col_exists  exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate q'[alter table BARS.PRVN_FIN_DEB add ( AGRM_ID number(38) )]';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "AGRM_ID" already exists in table.' );
end;
/

prompt -- ======================================================
prompt -- Policies
prompt -- ======================================================

begin

  bars.bpa.alter_policy_info( 'PRVN_FIN_DEB', 'WHOLE' , NULL, NULL, NULL, NULL );
  bars.bpa.alter_policy_info( 'PRVN_FIN_DEB', 'FILIAL',  'M',  'M',  'M',  'M' );

  bars.bpa.alter_policies( 'PRVN_FIN_DEB' );

  commit;

end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON COLUMN BARS.PRVN_FIN_DEB.KF      IS ' Ó‰ ÙiÎi‡ÎÛ (Ã‘Œ)';

prompt -- ======================================================
prompt -- Create error log table
prompt -- ======================================================

declare
  l_tab_nm  varchar2(30); -- src tab name
  l_errlog  varchar2(30); -- err log 
  --
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  
  l_tab_nm := 'PRVN_FIN_DEB';
  
  l_errlog := l_tab_nm || '_ERRLOG';
  
  BARS.BPA.ALTER_POLICY_INFO( l_errlog, 'WHOLE', null, null, null, null );
  
  SYS.DBMS_ERRLOG.CREATE_ERROR_LOG( l_tab_nm, l_errlog, 'BARS' );
  
  DBMS_OUTPUT.PUT_LINE( 'Table ' || l_errlog || ' created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table ' || l_errlog || ' already exists.' );
end;
/

prompt -- ======================================================
prompt -- Finish
prompt -- ======================================================
