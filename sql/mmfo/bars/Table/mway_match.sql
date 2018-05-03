

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MWAY_MATCH.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MWAY_MATCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MWAY_MATCH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MWAY_MATCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MWAY_MATCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MWAY_MATCH ***
begin 
  execute immediate 'create table MWAY_MATCH 
( ID         NUMBER(38)
, DATE_TR    DATE
, SUM_TR     NUMBER(24)
, LCV_TR     VARCHAR2(3)
, NLS_TR     VARCHAR2(15)
, RRN_TR     VARCHAR2(100)
, DRN_TR     VARCHAR2(100)
, STATE      NUMBER
, REF_TR     NUMBER(38)
, REF_FEE_TR NUMBER(38)
, constraint PK_MWAYMATCH PRIMARY KEY (ID) using index tablespace BRSMDLI
, constraint UK_MWAYMATCH UNIQUE (REF_TR)  using index tablespace BRSMDLI
) tablespace BRSMDLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to MWAY_MATCH ***
exec bpa.alter_policies('MWAY_MATCH');

COMMENT ON TABLE BARS.MWAY_MATCH IS 'Таблиця операцій з кліент-банка WAY4';
COMMENT ON COLUMN BARS.MWAY_MATCH.SUM_TR IS 'Сума транзакції';
COMMENT ON COLUMN BARS.MWAY_MATCH.LCV_TR IS 'Валюта транзакції';
COMMENT ON COLUMN BARS.MWAY_MATCH.NLS_TR IS 'Номер рахунку клієнта';
COMMENT ON COLUMN BARS.MWAY_MATCH.RRN_TR IS 'РРН код';
COMMENT ON COLUMN BARS.MWAY_MATCH.DRN_TR IS 'ДРН код';
COMMENT ON COLUMN BARS.MWAY_MATCH.STATE IS 'Статус';
COMMENT ON COLUMN BARS.MWAY_MATCH.REF_TR IS '';
COMMENT ON COLUMN BARS.MWAY_MATCH.REF_FEE_TR IS '';
COMMENT ON COLUMN BARS.MWAY_MATCH.ID IS 'Ід. номер';
COMMENT ON COLUMN BARS.MWAY_MATCH.DATE_TR IS 'Дата транзакції';

PROMPT *** Create  index UK_MWAYMATCH ***
begin   
 execute immediate 'CREATE UNIQUE INDEX BARS.UK_MWAYMATCH ON BARS.MWAY_MATCH (REF_TR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

prompt -- ======================================================
prompt -- create index UK_MWAYMATCH_RRNTR
prompt -- ======================================================

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index UK_MWAYMATCH_RRNTR on MWAY_MATCH ( RRN_TR )';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists 
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

PROMPT *** Create  grants  MWAY_MATCH ***
grant SELECT                                                                 on MWAY_MATCH      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MWAY_MATCH.sql =========*** End *** ==
PROMPT ===================================================================================== 
