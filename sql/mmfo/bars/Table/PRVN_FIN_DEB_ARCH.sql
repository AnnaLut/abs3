-- ======================================================================================
-- Module : PRVN
-- Author : BAA
-- Date   : 19.04.2017
-- ======================================================================================
-- create table PRVN_FIN_DEB_ARCH
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
prompt -- create table PRVN_FIN_DEB_ARCH
prompt -- ======================================================

begin
  bpa.alter_policy_info( 'PRVN_FIN_DEB_ARCH', 'WHOLE' , null, null, null, 'E' ); 
  bpa.alter_policy_info( 'PRVN_FIN_DEB_ARCH', 'FILIAL',  'M',  'M',  'M', 'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table PRVN_FIN_DEB_ARCH
( CHG_ID     number(38)  constraint CC_PRVNFINDEBARCH_CHGID_NN Not Null
, CHG_DT     date        constraint CC_PRVNFINDEBARCH_CHGDT_NN Not Null
, CLS_DT     date        constraint CC_PRVNFINDEBARCH_CLSDT_NN Not Null
, KF         varchar2(6) constraint CC_PRVNFINDEBARCH_KF_NN    Not Null
, ACC_SS     number(38)  constraint CC_PRVNFINDEBARCH_ACCSS_NN Not Null
, ACC_SP     number(38)  constraint CC_PRVNFINDEBARCH_ACCSP_NN Not Null
, EFFECTDATE date        constraint CC_PRVNFINDEBARCH_EFFDT_NN Not Null
, AGRM_ID    number(38)
, CONSTRAINT PK_PRVNFINDEBARCH primary key ( CHG_ID ) using index tablespace BRSMDLI
) TABLESPACE BRSMDLD';
  dbms_output.put_line( 'Table PRVN_FIN_DEB_ARCH created.' );
exception
  when e_tab_exists 
  then dbms_output.put_line( 'Table PRVN_FIN_DEB_ARCH already exists.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

begin
  execute immediate 'CREATE INDEX BARS.IDX_PRVNFINDEBARCH_CLSDT_KF ON PRVN_FIN_DEB_ARCH ( CLS_DT, KF )';
  dbms_output.put_line('Index "IDX_PRVNFINDEBARCH_CLSDT_KF" created.');
exception
  when OTHERS then
    case
      when (sqlcode = -00955)
      then dbms_output.put_line( 'Index "IDX_PRVNFINDEBARCH_CLSDT_KF" already exists in the table.' );
      when (sqlcode = -01408)
      then dbms_output.put_line( 'Such column list already indexed.' );
      else raise;
    end case;
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

exec bars.bpa.alter_policies( 'PRVN_FIN_DEB_ARCH' ); 

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  PRVN_FIN_DEB_ARCH         IS 'Архів зв`язків рах. Фін.Деб.';

COMMENT ON COLUMN PRVN_FIN_DEB_ARCH.CHG_DT  IS 'Календарна дата/час перенесення в архів';
COMMENT ON COLUMN PRVN_FIN_DEB_ARCH.CLS_DT  IS 'Банківська дата закриття (перенесення в архів)';
COMMENT ON COLUMN PRVN_FIN_DEB_ARCH.KF      IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN PRVN_FIN_DEB_ARCH.ACC_SS  IS 'Рахунок нормального   тіла Фін.Деб.';
COMMENT ON COLUMN PRVN_FIN_DEB_ARCH.ACC_SP  IS 'Рахунок простроченого тіла Фін.Деб.';
COMMENT ON COLUMN PRVN_FIN_DEB_ARCH.AGRM_ID IS 'Ід. кредитного договору';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant select on PRVN_FIN_DEB_ARCH to BARSUPL, UPLD;
grant select on PRVN_FIN_DEB_ARCH to BARS_ACCESS_DEFROLE;
