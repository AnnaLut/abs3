-- ======================================================================================
-- Module : DMD
-- Author : BAA
-- Date   : 22.09.2017
-- ======================================================================================
-- create table DPU_TAB_UPDATE
-- ======================================================================================


prompt -- ======================================================
prompt -- create table DPU_TAB_UPDATE
prompt -- ======================================================

begin
  bars.bpa.alter_policy_info( 'DPU_TAB_UPDATE', 'WHOLE' , NULL, NULL, NULL, NULL );
  bars.bpa.alter_policy_info( 'DPU_TAB_UPDATE', 'FILIAL', NULL, NULL, NULL, NULL );
end;
/

declare
  e_tab_exists           exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table DPU_TAB_UPDATE
( CHG_ID          NUMBER(38)     constraint CC_DPUTABUPDATE_CHGID_NN   NOT NULL
, CHG_TP          CHAR(1)        constraint CC_DPUTABUPDATE_CHGTP_NN   NOT NULL
, CHG_DT          DATE           constraint CC_DPUTABUPDATE_CHGDT_NN   NOT NULL
, CHG_USR         VARCHAR2(30)   constraint CC_DPUTABUPDATE_CHGUSR_NN  NOT NULL
, EFF_DT          DATE           constraint CC_DPUTABUPDATE_EFFDT_NN   NOT NULL
, TAB_NM          varchar2(30)   constraint CC_DPUTABUPDATE_TABNM_NN   NOT NULL
, PK_VAL          NUMBER(38)     constraint CC_DPUTABUPDATE_PKVAL_NN   NOT NULL
, COL_NM          varchar2(30)   constraint CC_DPUTABUPDATE_COLNM_NN   NOT NULL
, COL_VAL         varchar2(4000)
, constraint PK_DPUTABUPDATE primary key ( CHG_ID ) using index tablespace BRSMDLI
) TABLESPACE BRSMDLD ]';
  
  dbms_output.put_line( 'Table "DPU_TAB_UPDATE" created.' );
  
exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "DPU_TAB_UPDATE" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate q'[create index IDX_DPUTABUPDATE_TABNM_COLNM on DPU_TAB_UPDATE ( TAB_NM, COL_NM, PK_VAL )
  TABLESPACE BRSBIGI ]';
  dbms_output.put_line( 'Index "IDX_DPUTABUPDATE_TABNM_COLNM" created.' );
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "IDX_DPUTABUPDATE_TABNM_COLNM" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Column(s) "TAB_NM", "COL_NM", "PK_VAL" already indexed.' );
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bars.bpa.alter_policies( 'DPU_TAB_UPDATE' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  DPU_TAB_UPDATE             IS 'Портфель поточних рахунків юридичних осіб';

COMMENT ON COLUMN DPU_TAB_UPDATE.CHG_ID      IS 'Ідентифікатор зміни';
COMMENT ON COLUMN DPU_TAB_UPDATE.CHG_TP      IS 'Тип зміни (I/U/D)';
COMMENT ON COLUMN DPU_TAB_UPDATE.CHG_DT      IS 'Дата зміни (системна)';
COMMENT ON COLUMN DPU_TAB_UPDATE.CHG_USR     IS 'Користувач, що виконав зміни';
COMMENT ON COLUMN DPU_TAB_UPDATE.EFF_DT      IS 'Дата зміни (банківська)';
COMMENT ON COLUMN DPU_TAB_UPDATE.TAB_NM      IS 'Affected table name';
COMMENT ON COLUMN DPU_TAB_UPDATE.PK_VAL      IS 'Affected table PK value';
COMMENT ON COLUMN DPU_TAB_UPDATE.COL_NM      IS 'Affected column name';
COMMENT ON COLUMN DPU_TAB_UPDATE.COL_VAL     IS 'Affected column value';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON DPU_TAB_UPDATE TO BARS_ACCESS_DEFROLE;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
