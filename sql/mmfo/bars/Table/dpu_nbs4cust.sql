-- ======================================================================================
-- Module : DPU
-- Author : BAA
-- Date   : 22.01.2015
-- ===================================== <Comments> =====================================
-- create table DPU_NBS4CUST
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table DPU_NBS4CUST
prompt -- ======================================================

declare
  l_tab_nm               varchar2(30);
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  l_tab_nm := 'DPU_NBS4CUST';
  execute immediate 'drop table '||l_tab_nm||' cascade constraint';
  dbms_output.put_line( 'Table "'||l_tab_nm||'" dropped.' );
exception
  when e_tab_not_exists 
  then null;
end;
/

declare
  l_synm_nm              varchar2(30);
  e_synm_not_exists      exception;
  pragma exception_init( e_synm_not_exists, -01432 );
begin
  l_synm_nm := 'DPU_NBS4CUST';
  execute immediate 'drop public synonym '||l_synm_nm;
  dbms_output.put_line( 'Synonym dropped.' );
exception
  when e_synm_not_exists
  then dbms_output.put_line( 'Public synonym "'|| l_synm_nm || '" does not exist.' );
end;
/

begin
  BPA.ALTER_POLICY_INFO( 'DPU_NBS4CUST', 'WHOLE',  null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'DPU_NBS4CUST', 'FILIAL', null,  'E',  'E', 'E'  );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin
  execute immediate q'[create table DPU_NBS4CUST
( K013     CHAR(1)     CONSTRAINT CC_DPUNBS4CUST_K013_NN NOT NULL
, IRVK     VARCHAR2(1) CONSTRAINT CC_DPUNBS4CUST_IRVK_NN NOT NULL
, NBS_DEP  CHAR(4)     CONSTRAINT CC_DPUNBS4CUST_NBS_NN  NOT NULL
, NBS_INT  CHAR(4) Generated Always as (SubStr(NBS_DEP,1,3)||'8')
, NBS_EXP  CHAR(4) Generated Always as (case when K013='1' then '7030' when K013='2' then '707'||IRVK when K013='5' then '704'||IRVK else '702'||IRVK end)
, NBS_RED  CHAR(4) Generated Always as ('6350')
, constraint PK_DPUNBS4CUST primary key (K013, NBS_DEP) using index tablespace BRSSMLI
, constraint CC_DPUNBS4CUST_K013   check ( K013 <> '5' )
, constraint CC_DPUNBS4CUST_IRVCBL check ( IRVK in ('0','1') )
) TABLESPACE BRSSMLD]';

  dbms_output.put_line( 'Table "DPU_NBS4CUST" created.' );

exception
  when e_tab_exists 
  then dbms_output.put_line( 'Table "DPU_NBS4CUST" already exists.' );
end;
/

begin
  bpa.alter_policies('DPU_NBS4CUST');
end;
/

commit;

prompt -- ======================================================
prompt -- Constraints
prompt -- ======================================================

begin
  execute immediate q'[alter table DPU_NBS4CUST ADD CONSTRAINT FK_DPUNBS4CUST_PS FOREIGN KEY (NBS_DEP) REFERENCES PS (NBS)]';
  dbms_output.put_line('Constraint FK_DPUNBS4CUST_PS created.');
exception
  when OTHERS then
    case 
      when (sqlcode = -02275)
      then dbms_output.put_line('Such a referential constraint already exists in the table.');
      when (sqlcode = -00942)
      then dbms_output.put_line('Table BARS.PS does not exist.');
      else dbms_output.put_line( SubStr(sqlerrm, instr(sqlerrm,'ORA-')+11) );
    end case;
end;
/

prompt -- ======================================================
prompt -- comments
prompt -- ======================================================

SET FEEDBACK ON

COMMENT ON TABLE BARS.DPU_NBS4CUST          IS 'Види клієнтів (K013) <-> бал.рах. депозитів ЮО';

COMMENT ON COLUMN BARS.DPU_NBS4CUST.K013    IS 'Код виду клиента';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.IRVK    IS '1 - безвідкличний (строковий) / 0 - відкличний (на вимогу)';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.NBS_DEP IS 'Бал. рах. депозиту';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.NBS_INT IS 'Бал. рах. відсотків';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.NBS_EXP IS 'Бал. рах. витрат';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.NBS_RED IS 'Бал. рах. повернення';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on DPU_NBS4CUST to BARS_ACCESS_DEFROLE;
GRANT SELECT on DPU_NBS4CUST to DPT_ROLE;
GRANT SELECT on DPU_NBS4CUST to BARS_ACCESS_DEFROLE;
GRANT SELECT on DPU_NBS4CUST to DPT_ADMIN;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
