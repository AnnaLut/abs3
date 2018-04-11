-- ======================================================================================
-- Module : CAC
-- Author : BAA
-- Date   : 22.09.2017
-- ======================================================================================
-- create table SPECPARAM
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET FEEDBACK     OFF
SET TIMING       OFF
SET DEFINE       OFF
SET LINES        200
SET PAGES        200
SET TERMOUT      ON
SET TRIMSPOOL    ON

prompt -- ======================================================
prompt -- create table SPECPARAM
prompt -- ======================================================

begin
  bpa.alter_policy_info( 'SPECPARAM', 'CENTER', null, 'E', 'E', 'E' );
  bpa.alter_policy_info( 'SPECPARAM', 'FILIAL',  'M', 'M', 'M', 'M' );
  bpa.alter_policy_info( 'SPECPARAM', 'WHOLE',  null, 'E', 'E', 'E' );
end;
/

declare
  e_tab_exists exception;
  pragma exception_init( e_tab_exists, -00955 );
begin 
  execute immediate 'create table SPECPARAM
( KF     VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')
                     constraint CC_SPECPARAM_KF_NN  NOT NULL
, ACC    NUMBER(38)  constraint CC_SPECPARAM_ACC_NN NOT NULL
, R011   VARCHAR2(1)
, R012   VARCHAR2(1)
, R013   VARCHAR2(1)
, R014   VARCHAR2(1)
, R016   VARCHAR2(2)
, R114   VARCHAR2(1)
, D020   CHAR(2)
, K072   VARCHAR2(1)
, KEKD   NUMBER(38)
, KTK    NUMBER(38)
, KVK    NUMBER(38)
, IDG    NUMBER(38)
, IDS    NUMBER(38)
, SPS    NUMBER(38)
, KBK    NUMBER(38)
, NKD    VARCHAR2(40)
, ISTVAL NUMBER(1)
, S031   VARCHAR2(2)
, S080   VARCHAR2(1)
, S090   CHAR(1)
, S120   VARCHAR2(1)
, S130   VARCHAR2(2)
, S180   VARCHAR2(1)
, S181   VARCHAR2(1)
, S182   VARCHAR2(1)
, S190   VARCHAR2(1)
, S200   VARCHAR2(1)
, S230   VARCHAR2(3)
, S240   VARCHAR2(1)
, S250   VARCHAR2(1)
, S260   VARCHAR2(2)
, S270   VARCHAR2(2)
, S280   VARCHAR2(2)
, S290   VARCHAR2(2)
, S370   VARCHAR2(1)
, S580   VARCHAR2(1)
, Z290   VARCHAR2(2)
, D1#F9  VARCHAR2(1)
, NF#F9  VARCHAR2(2)
, DP1    VARCHAR2(1)
, KVD    NUMBER
, constraint PK_SPECPARAM primary key (ACC) using index tablespace BRSBIGI
) tablespace BRSBIGD
PARTITION BY LIST (KF)
( PARTITION P_300465 VALUES (''300465'')
, PARTITION P_302076 VALUES (''302076'')
, PARTITION P_303398 VALUES (''303398'')
, PARTITION P_304665 VALUES (''304665'')
, PARTITION P_305482 VALUES (''305482'')
, PARTITION P_311647 VALUES (''311647'')
, PARTITION P_312356 VALUES (''312356'')
, PARTITION P_313957 VALUES (''313957'')
, PARTITION P_315784 VALUES (''315784'')
, PARTITION P_322669 VALUES (''322669'')
, PARTITION P_323475 VALUES (''323475'')
, PARTITION P_324805 VALUES (''324805'')
, PARTITION P_325796 VALUES (''325796'')
, PARTITION P_326461 VALUES (''326461'')
, PARTITION P_328845 VALUES (''328845'')
, PARTITION P_331467 VALUES (''331467'')
, PARTITION P_333368 VALUES (''333368'')
, PARTITION P_335106 VALUES (''335106'')
, PARTITION P_336503 VALUES (''336503'')
, PARTITION P_337568 VALUES (''337568'')
, PARTITION P_338545 VALUES (''338545'')
, PARTITION P_351823 VALUES (''351823'')
, PARTITION P_352457 VALUES (''352457'')
, PARTITION P_353553 VALUES (''353553'')
, PARTITION P_354507 VALUES (''354507'')
, PARTITION P_356334 VALUES (''356334'')
)';

  dbms_output.put_line( 'Table "SPECPARAM" created.' );

exception
  when e_tab_exists then
    dbms_output.put_line( 'Table "SPECPARAM" already exists.' );
end;
/

prompt -- ======================================================
prompt -- Alter table
prompt -- ======================================================

prompt -- drop column SPECPARAM.K150

declare
  e_col_not_exists      exception;
  pragma exception_init(e_col_not_exists,-00904);
begin   
  execute immediate 'alter table SPECPARAM drop column K150';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_not_exists then
    null;
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create unique index UK_SPECPARAM on SPECPARAM ( KF, ACC ) tablespace BRSBIGI local compress 1';
  dbms_output.put_line( 'Index "UK_SPECPARAM" created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_SPECPARAM_IDG on SPECPARAM ( KF, IDG ) tablespace BRSBIGI local compress 1';
  dbms_output.put_line( 'Index "IDX_SPECPARAM_IDG" created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bpa.alter_policies( 'SPECPARAM' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  SPECPARAM        IS 'Таблиця спец.параметрів рахунків';

COMMENT ON COLUMN SPECPARAM.KF     IS 'Код филиала';
COMMENT ON COLUMN SPECPARAM.ACC    IS 'Внутренний номер счета';
COMMENT ON COLUMN SPECPARAM.S230   IS 'Символ банка';
COMMENT ON COLUMN SPECPARAM.D020   IS '';
COMMENT ON COLUMN SPECPARAM.KEKD   IS 'Символ дох';
COMMENT ON COLUMN SPECPARAM.KTK    IS 'Код тек';
COMMENT ON COLUMN SPECPARAM.KVK    IS 'КВК';
COMMENT ON COLUMN SPECPARAM.IDG    IS 'Гр. перекрытия';
COMMENT ON COLUMN SPECPARAM.IDS    IS 'Схема перекр';
COMMENT ON COLUMN SPECPARAM.SPS    IS 'Способ вычисления';
COMMENT ON COLUMN SPECPARAM.KBK    IS '';
COMMENT ON COLUMN SPECPARAM.S130   IS 'Вид ЦП';
COMMENT ON COLUMN SPECPARAM.NKD    IS 'Номер договору (ф.71)';
COMMENT ON COLUMN SPECPARAM.S031   IS 'Вид забезпечення кредиту (ф.71)';
COMMENT ON COLUMN SPECPARAM.S182   IS 'Вид кредиту (ф.71)';
COMMENT ON COLUMN SPECPARAM.ISTVAL IS 'Джерело вал.виручки';
COMMENT ON COLUMN SPECPARAM.R014   IS 'Признак дистанцiйного обслуг.рахунку';
COMMENT ON COLUMN SPECPARAM.K072   IS 'Код сектора экономики ( используется при формировании файла #08)';
COMMENT ON COLUMN SPECPARAM.S090   IS 'Вид заборгованостi';
COMMENT ON COLUMN SPECPARAM.S270   IS 'Код строку погашення основного боргу';
COMMENT ON COLUMN SPECPARAM.S260   IS 'Коди iндивiд.споживання за цiлями';
COMMENT ON COLUMN SPECPARAM.R114   IS 'Додатковий параметр для файлів В5, В6';
COMMENT ON COLUMN SPECPARAM.D1#F9  IS '';
COMMENT ON COLUMN SPECPARAM.NF#F9  IS '';
COMMENT ON COLUMN SPECPARAM.Z290   IS '';
COMMENT ON COLUMN SPECPARAM.DP1    IS '';
COMMENT ON COLUMN SPECPARAM.KVD    IS '';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant INSERT,SELECT,UPDATE on SPECPARAM to ABS_ADMIN;
grant INSERT,SELECT,UPDATE on SPECPARAM to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT,UPDATE on SPECPARAM to WR_ALL_RIGHTS;
grant SELECT               on SPECPARAM to BARSUPL;
grant SELECT               on SPECPARAM to BARS_DM;
grant UPDATE               on SPECPARAM to DEP_SKRN;
grant SELECT               on SPECPARAM to REF0000;
grant SELECT               on SPECPARAM to RPBN001;
grant SELECT               on SPECPARAM to RPBN002;
grant UPDATE               on SPECPARAM to R_KP;
grant UPDATE               on SPECPARAM to SALGL;
grant SELECT               on SPECPARAM to START1;

prompt -- ======================================================
prompt -- FINISH
prompt -- ======================================================
