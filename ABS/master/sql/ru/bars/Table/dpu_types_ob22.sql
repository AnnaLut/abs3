-- ======================================================================================
-- Module : DPU
-- Author : BAA
-- Date   : 15.01.2018
-- ===================================== <Comments> =====================================
-- create table DPU_TYPES_OB22
-- 15.01.2018 - Депозити буджетних орган. відкриваються лише терміном до року
-- 30.09.2015 - Депозити буджетних орган. відкриваються лише в нац.валюті та лише терміном до року
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table DPU_TYPES_OB22
prompt -- ======================================================

begin 
  bpa.alter_policy_info('DPU_TYPES_OB22', 'WHOLE',  null, null, null, null); 
  bpa.alter_policy_info('DPU_TYPES_OB22', 'FILIAL', null,  'E',  'E', 'E' ); 
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate 'create table DPU_TYPES_OB22
( TYPE_ID    NUMBER(38)  constraint CC_DPUTYPESOB22_TYPEID_NN   NOT NULL
, K013       CHAR(1)     constraint CC_DPUTYPESOB22_K013_NN     NOT NULL
, S181       VARCHAR2(1) constraint CC_DPUTYPESOB22_S181_NN     NOT NULL
, R034       VARCHAR2(1) constraint CC_DPUTYPESOB22_R034_NN     NOT NULL
, NBS_DEP    CHAR(4)     constraint CC_DPUTYPESOB22_NBSDEP_NN   NOT NULL
, OB22_DEP   CHAR(2)     constraint CC_DPUTYPESOB22_OB22DEP_NN  NOT NULL
, NBS_INT    CHAR(4)     constraint CC_DPUTYPESOB22_NBSINT_NN   NOT NULL
, OB22_INT   CHAR(2)     constraint CC_DPUTYPESOB22_OB22INT_NN  NOT NULL
, NBS_EXP    CHAR(4)     constraint CC_DPUTYPESOB22_NBSEXP_NN   NOT NULL
, OB22_EXP   CHAR(2)     constraint CC_DPUTYPESOB22_OB22EXP_NN  NOT NULL
, NBS_RED    CHAR(4)
, OB22_RED   CHAR(2)
, IRVK       VARCHAR2(1) constraint CC_DPUTYPESOB22_IRVK_NN     NOT NULL
, constraint PK_DPUTYPESOB22 primary key ( TYPE_ID, NBS_DEP, R034, S181 ) using index tablespace BRSSMLI
, constraint UK_DPUTYPESOB22 unique ( R034, NBS_DEP, OB22_DEP ) using index tablespace BRSSMLI
, constraint CC_DPUTYPESOB22_S181 CHECK (S181 in (''1'',''2''))
, constraint CC_DPUTYPESOB22_R034 check (R034 in (''1'',''2''))
, constraint CC_DPUTYPESOB22_IRVK check (IRVK in (''0'',''1''))
, constraint CC_DPUTYPESOB22_K013_S181   check ( S181 = case when K013 = ''1'' then ''1'' else S181 end )
, constraint CC_DPUTYPESOB22_K013_IRVK   check ( IRVK = case when K013 = ''1'' then ''0'' else IRVK end )
) TABLESPACE BRSSMLD';

  dbms_output.put_line( 'Table "DPU_TYPES_OB22" created.' );

exception
  when e_tab_exists 
  then dbms_output.put_line( 'Table "DPU_TYPES_OB22" already exists.' );
end;
/


prompt -- ======================================================
prompt -- Foreign keys
prompt -- ======================================================

declare
  E_REF_CNSTRN_EXISTS exception;
  pragma exception_init( E_REF_CNSTRN_EXISTS, -02275 );
begin

  begin
    dbms_output.put_line( '-- ======================================================' );
    dbms_output.put_line( '-- == create "FK_DPUTYPESOB22_TYPEID"' );
    dbms_output.put_line( '-- ======================================================' );
    execute immediate q'[alter table DPU_TYPES_OB22 add constraint FK_DPUTYPESOB22_TYPEID foreign key (TYPE_ID)
    references DPU_TYPES (TYPE_ID) ON DELETE CASCADE]';
    dbms_output.put_line( 'Table altered.' );
  exception
    when E_REF_CNSTRN_EXISTS
    then dbms_output.put_line( 'Such a referential constraint already exists in the table.' );
  end;

  begin
    dbms_output.put_line( '-- ======================================================' );
    dbms_output.put_line( '-- == create "FK_DPUTYPESOB22_DPUNBS4CUST"' );
    dbms_output.put_line( '-- ======================================================' );
    execute immediate q'[alter table DPU_TYPES_OB22 add constraint FK_DPUTYPESOB22_DPUNBS4CUST foreign key (K013,NBS_DEP)
    references DPU_NBS4CUST (K013,NBS_DEP) ON DELETE CASCADE]';
    dbms_output.put_line( 'Table altered.' );
  exception
    when E_REF_CNSTRN_EXISTS
    then dbms_output.put_line( 'Such a referential constraint already exists in the table.' );
  end;

  begin
    dbms_output.put_line( '-- ======================================================' );
    dbms_output.put_line( '-- == create "FK_DPUTYPESOB22_SBOB22_DEP"' );
    dbms_output.put_line( '-- ======================================================' );
    execute immediate q'[alter table DPU_TYPES_OB22 add constraint FK_DPUTYPESOB22_SBOB22_DEP foreign key (NBS_DEP,OB22_DEP)
    references SB_OB22 (R020,OB22) ON DELETE CASCADE]';
    dbms_output.put_line( 'Table altered.' );
  exception
    when E_REF_CNSTRN_EXISTS
    then dbms_output.put_line( 'Such a referential constraint already exists in the table.' );
  end;

  begin
    dbms_output.put_line( '-- ======================================================' );
    dbms_output.put_line( '-- == create "FK_DPUTYPESOB22_SBOB22_INT"' );
    dbms_output.put_line( '-- ======================================================' );
    execute immediate q'[alter table DPU_TYPES_OB22 add constraint FK_DPUTYPESOB22_SBOB22_INT foreign key (NBS_INT,OB22_INT)
    references SB_OB22 (R020,OB22) ON DELETE CASCADE]';
    dbms_output.put_line( 'Table altered.' );
  exception
    when E_REF_CNSTRN_EXISTS
    then dbms_output.put_line( 'Such a referential constraint already exists in the table.' );
  end;

  begin
    dbms_output.put_line( '-- ======================================================' );
    dbms_output.put_line( '-- == create "FK_DPUTYPESOB22_SBOB22_EXP"' );
    dbms_output.put_line( '-- ======================================================' );
    execute immediate q'[alter table DPU_TYPES_OB22 add constraint FK_DPUTYPESOB22_SBOB22_EXP foreign key (NBS_EXP,OB22_EXP)
    references SB_OB22 (R020,OB22) ON DELETE CASCADE]';
    dbms_output.put_line( 'Table altered.' );
  exception
    when E_REF_CNSTRN_EXISTS
    then dbms_output.put_line( 'Such a referential constraint already exists in the table.' );
  end;

  begin
    dbms_output.put_line( '-- ======================================================' );
    dbms_output.put_line( '-- == create "FK_DPUTYPESOB22_SBOB22_RED"' );
    dbms_output.put_line( '-- ======================================================' );
    execute immediate q'[alter table DPU_TYPES_OB22 add constraint FK_DPUTYPESOB22_SBOB22_RED foreign key (NBS_RED,OB22_RED)
    references SB_OB22 (R020,OB22) ON DELETE CASCADE]';
    dbms_output.put_line( 'Table altered.' );
  exception
    when E_REF_CNSTRN_EXISTS
    then dbms_output.put_line( 'Such a referential constraint already exists in the table.' );
  end;

end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICIES( 'DPU_TYPES_OB22' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  DPU_TYPES_OB22          IS 'Параметри OB22 депозитів ЮО';

COMMENT ON COLUMN DPU_TYPES_OB22.TYPE_ID  IS 'Тип (вид) договору';
COMMENT ON COLUMN DPU_TYPES_OB22.K013     IS 'Код виду клієнта';
COMMENT ON COLUMN DPU_TYPES_OB22.S181     IS 'Код строку';
COMMENT ON COLUMN DPU_TYPES_OB22.R034     IS 'Ознака належності до національної/іноземної валюти';
COMMENT ON COLUMN DPU_TYPES_OB22.NBS_DEP  IS 'Балансовий рахунок депозиту';
COMMENT ON COLUMN DPU_TYPES_OB22.OB22_DEP IS 'Значення OB22 рах. депозиту';
COMMENT ON COLUMN DPU_TYPES_OB22.NBS_INT  IS 'Балансовий рахунок відсотків';
COMMENT ON COLUMN DPU_TYPES_OB22.OB22_INT IS 'Значення OB22 рах. відсотків';
COMMENT ON COLUMN DPU_TYPES_OB22.NBS_EXP  IS 'Балансовий рахунок ПРОЦЕНТНИХ витрат';
COMMENT ON COLUMN DPU_TYPES_OB22.OB22_EXP IS 'Значення OB22 рах. ПРОЦЕНТНИХ витрат';
COMMENT ON COLUMN DPU_TYPES_OB22.NBS_RED  IS 'Балансовий рахунок ЗМЕНШЕННЯ витрат';
COMMENT ON COLUMN DPU_TYPES_OB22.OB22_RED IS 'Значення OB22 рах. ЗМЕНШЕННЯ витрат';
COMMENT ON COLUMN DPU_TYPES_OB22.IRVK     IS '1 - безвідкличний (строковий) / 0 - відкличний (на вимогу)';

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

declare
  E_CNSTRN_NOT_EXISTS    exception;
  pragma exception_init( E_CNSTRN_NOT_EXISTS, -02443 );
begin
  execute immediate 'alter table DPU_TYPES_OB22 drop constraint CC_DPUTYPESOB22_K013_R034';
  dbms_output.put_line( 'Table altered.' );
exception
  when E_CNSTRN_NOT_EXISTS
  then dbms_output.put_line( 'Constraint does not exist in the table.' );
end;
/

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
