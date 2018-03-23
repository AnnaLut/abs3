SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table ACCOUNTS_RSRV
prompt -- ======================================================

begin
  BARS.BPA.ALTER_POLICY_INFO( 'TMP_FILE03', 'WHOLE' , NULL, NULL, NULL, NULL );
  BARS.BPA.ALTER_POLICY_INFO( 'TMP_FILE03', 'FILIAL', NULL, NULL, NULL, NULL );
end;
/

begin
  execute immediate 'create global temporary table TMP_FILE03 
( ACCD  NUMBER, 
  TT    VARCHAR2(3), 
  REF   NUMBER, 
  KV    NUMBER, 
  NLSD  VARCHAR2(15),
  OB22D CHAR(2),
  S     NUMBER, 
  SQ    NUMBER, 
  FDAT  DATE, 
  NAZN  VARCHAR2(160), 
  ACCK  NUMBER, 
  NLSK  VARCHAR2(15),
  OB22K CHAR(2),
  ISP   NUMBER
) ON COMMIT PRESERVE ROWS';
exception when others then
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

prompt -- ======================================================
prompt -- Alters
prompt -- ======================================================

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table TMP_FILE03 add OB22D CHAR(2)';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "OB22D" already exists in table.' );
end;
/

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin
  execute immediate 'alter table TMP_FILE03 add OB22K CHAR(2)';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "OB22K" already exists in table.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

PROMPT *** Create  index I1_TMP_FILE03 ***
begin   
 execute immediate 'CREATE INDEX BARS.I1_TMP_FILE03 ON BARS.TMP_FILE03 (FDAT, ACCD, NLSK) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I2_TMP_FILE03 ***
begin   
 execute immediate 'CREATE INDEX BARS.I2_TMP_FILE03 ON BARS.TMP_FILE03 (FDAT, ACCK, NLSD) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I3_TMP_FILE03 ***
begin   
 execute immediate 'CREATE INDEX BARS.I3_TMP_FILE03 ON BARS.TMP_FILE03 (REF) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I4_TMP_FILE03 ***
begin   
 execute immediate 'CREATE INDEX BARS.I4_TMP_FILE03 ON BARS.TMP_FILE03 (NLSD, NLSK) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I5_TMP_FILE03 ***
begin   
 execute immediate 'CREATE INDEX BARS.I5_TMP_FILE03 ON BARS.TMP_FILE03 (NLSK) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICIES( 'TMP_FILE03' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  TMP_FILE03       IS 'Временная таблица для проводок файла отчетности #03';

comment on column TMP_FILE03.ACCD  IS 'Идентификатор Дт счета';
comment on column TMP_FILE03.TT    IS 'Код операции';
comment on column TMP_FILE03.REF   IS 'Референс док-та';
comment on column TMP_FILE03.KV    IS 'Код валюты';
comment on column TMP_FILE03.NLSD  IS 'Номер Дт счета';
comment on column TMP_FILE03.OB22D IS 'ОБ22 Дт счета';
comment on column TMP_FILE03.S     IS 'Сумма проводки';
comment on column TMP_FILE03.SQ    IS 'Сумма экв. проводки';
comment on column TMP_FILE03.FDAT  IS 'Дата проводки';
comment on column TMP_FILE03.NAZN  IS 'Назначение платежа';
comment on column TMP_FILE03.ACCK  IS 'Идентификатор Кт счета';
comment on column TMP_FILE03.NLSK  IS 'Номер Кт счета';
comment on column TMP_FILE03.OB22K IS 'ОБ22 Кт счета';
comment on column TMP_FILE03.ISP   IS 'Код пользователя';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant DELETE,INSERT,SELECT,UPDATE on TMP_FILE03 to ABS_ADMIN;

grant DELETE,INSERT,SELECT,UPDATE on TMP_FILE03 to BARS_ACCESS_DEFROLE;
grant SELECT                      on TMP_FILE03 to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE on TMP_FILE03 to RPBN002;
grant SELECT                      on TMP_FILE03 to UPLD;
grant DELETE,INSERT,SELECT,UPDATE on TMP_FILE03 to WR_ALL_RIGHTS;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FILE03.sql =========*** End *** ==
PROMPT ===================================================================================== 
