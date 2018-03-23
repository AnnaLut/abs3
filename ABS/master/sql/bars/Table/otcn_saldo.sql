
prompt -- ======================================================
prompt -- create table OTCN_SALDO
prompt -- ======================================================

begin
  bpa.alter_policy_info( 'OTCN_SALDO', 'FILIAL', null, null, null, null );
  bpa.alter_policy_info( 'OTCN_SALDO', 'WHOLE',  null, null, null, null );
end;
/

begin
  execute immediate 'create global temporary table OTCN_SALDO 
( ODATE DATE   NOT NULL, 
  FDAT  DATE   NOT NULL, 
  ACC   NUMBER NOT NULL, 
  NLS   VARCHAR2(15), 
  KV NUMBER(38,0), 
  NBS VARCHAR2(4),
  OB22 CHAR(2),
  RNK NUMBER, 
  OST NUMBER, 
  OSTQ NUMBER, 
  DOS NUMBER, 
  DOSQ NUMBER, 
  KOS NUMBER, 
  KOSQ NUMBER, 
  DOS96P NUMBER, 
  DOSQ96P NUMBER, 
  KOS96P NUMBER, 
  KOSQ96P NUMBER, 
  DOS96 NUMBER, 
  DOSQ96 NUMBER, 
  KOS96 NUMBER, 
  KOSQ96 NUMBER, 
  DOS99 NUMBER, 
  DOSQ99 NUMBER, 
  KOS99 NUMBER, 
  KOSQ99 NUMBER, 
  DOSZG NUMBER, 
  KOSZG NUMBER, 
  DOS96ZG NUMBER, 
  KOS96ZG NUMBER, 
  DOS99ZG NUMBER, 
  KOS99ZG NUMBER, 
  VOST NUMBER, 
  VOSTQ NUMBER
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
  execute immediate 'alter table OTCN_SALDO add OB22 CHAR(2)';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists then
    dbms_output.put_line( 'Column "OB22" already exists in table.' );
end;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

PROMPT *** Create  index I2_OTCN_SALDO ***
begin   
 execute immediate 'CREATE INDEX BARS.I2_OTCN_SALDO ON BARS.OTCN_SALDO (RNK, ACC) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I3_OTCN_SALDO ***
begin   
 execute immediate 'CREATE INDEX BARS.I3_OTCN_SALDO ON BARS.OTCN_SALDO (NLS,KV)';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I1_OTCN_SALDO ***
begin   
 execute immediate 'CREATE INDEX BARS.I1_OTCN_SALDO ON BARS.OTCN_SALDO (ACC, FDAT) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I4_OTCN_SALDO ***
begin   
 execute immediate 'CREATE INDEX BARS.I4_OTCN_SALDO ON BARS.OTCN_SALDO (NBS,OB22)';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  BPA.ALTER_POLICIES( 'OTCN_SALDO' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  OTCN_SALDO IS 'Временна¤ таблица оборотов и остатков по счетам дл¤ формировани¤ файлов отчетности';

COMMENT ON COLUMN OTCN_SALDO.ODATE IS '';
COMMENT ON COLUMN OTCN_SALDO.FDAT IS '';
COMMENT ON COLUMN OTCN_SALDO.ACC IS '';
COMMENT ON COLUMN OTCN_SALDO.NLS IS '';
COMMENT ON COLUMN OTCN_SALDO.KV IS '';
COMMENT ON COLUMN OTCN_SALDO.NBS IS '';
COMMENT ON COLUMN OTCN_SALDO.OB22 IS 'ОБ22';
COMMENT ON COLUMN OTCN_SALDO.RNK IS '';
COMMENT ON COLUMN OTCN_SALDO.OST IS '';
COMMENT ON COLUMN OTCN_SALDO.OSTQ IS '';
COMMENT ON COLUMN OTCN_SALDO.DOS IS '';
COMMENT ON COLUMN OTCN_SALDO.DOSQ IS '';
COMMENT ON COLUMN OTCN_SALDO.KOS IS '';
COMMENT ON COLUMN OTCN_SALDO.KOSQ IS '';
COMMENT ON COLUMN OTCN_SALDO.DOS96P IS '';
COMMENT ON COLUMN OTCN_SALDO.DOSQ96P IS '';
COMMENT ON COLUMN OTCN_SALDO.KOS96P IS '';
COMMENT ON COLUMN OTCN_SALDO.KOSQ96P IS '';
COMMENT ON COLUMN OTCN_SALDO.DOS96 IS '';
COMMENT ON COLUMN OTCN_SALDO.DOSQ96 IS '';
COMMENT ON COLUMN OTCN_SALDO.KOS96 IS '';
COMMENT ON COLUMN OTCN_SALDO.KOSQ96 IS '';
COMMENT ON COLUMN OTCN_SALDO.DOS99 IS '';
COMMENT ON COLUMN OTCN_SALDO.DOSQ99 IS '';
COMMENT ON COLUMN OTCN_SALDO.KOS99 IS '';
COMMENT ON COLUMN OTCN_SALDO.KOSQ99 IS '';
COMMENT ON COLUMN OTCN_SALDO.DOSZG IS '';
COMMENT ON COLUMN OTCN_SALDO.KOSZG IS '';
COMMENT ON COLUMN OTCN_SALDO.DOS96ZG IS '';
COMMENT ON COLUMN OTCN_SALDO.KOS96ZG IS '';
COMMENT ON COLUMN OTCN_SALDO.DOS99ZG IS '';
COMMENT ON COLUMN OTCN_SALDO.KOS99ZG IS '';
COMMENT ON COLUMN OTCN_SALDO.VOST IS '';
COMMENT ON COLUMN OTCN_SALDO.VOSTQ IS '';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================


grant DELETE,INSERT,SELECT,UPDATE on OTCN_SALDO to BARS_ACCESS_DEFROLE;
grant SELECT                      on OTCN_SALDO to RPBN001;
grant DELETE,INSERT,SELECT,UPDATE on OTCN_SALDO to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE on OTCN_SALDO to WR_ALL_RIGHTS;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_SALDO.sql =========*** End *** ==
PROMPT ===================================================================================== 
