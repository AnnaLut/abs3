

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MWAY_MATCH.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MWAY_MATCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MWAY_MATCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MWAY_MATCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MWAY_MATCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.MWAY_MATCH 
   (	ID NUMBER, 
	DATE_TR DATE, 
	SUM_TR NUMBER(38,0), 
	LCV_TR VARCHAR2(3), 
	NLS_TR VARCHAR2(15), 
	RRN_TR VARCHAR2(100), 
	DRN_TR VARCHAR2(100), 
	STATE NUMBER, 
	REF_TR NUMBER(*,0), 
	REF_FEE_TR NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MWAY_MATCH ***
 exec bpa.alter_policies('MWAY_MATCH');


COMMENT ON TABLE BARS.MWAY_MATCH IS 'Таблиця операцій з кліент-банка WAY4';
COMMENT ON COLUMN BARS.MWAY_MATCH.ID IS 'Ід. номер';
COMMENT ON COLUMN BARS.MWAY_MATCH.DATE_TR IS 'Дата транзакції';
COMMENT ON COLUMN BARS.MWAY_MATCH.SUM_TR IS 'Сума транзакції';
COMMENT ON COLUMN BARS.MWAY_MATCH.LCV_TR IS 'Валюта транзакції';
COMMENT ON COLUMN BARS.MWAY_MATCH.NLS_TR IS 'Номер рахунку клієнта';
COMMENT ON COLUMN BARS.MWAY_MATCH.RRN_TR IS 'РРН код';
COMMENT ON COLUMN BARS.MWAY_MATCH.DRN_TR IS 'ДРН код';
COMMENT ON COLUMN BARS.MWAY_MATCH.STATE IS 'Статус';
COMMENT ON COLUMN BARS.MWAY_MATCH.REF_TR IS '';
COMMENT ON COLUMN BARS.MWAY_MATCH.REF_FEE_TR IS '';




PROMPT *** Create  constraint SYS_C002638760 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MWAY_MATCH ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_MWAYMATCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.MWAY_MATCH ADD CONSTRAINT UK_MWAYMATCH UNIQUE (REF_TR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C002638760 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C002638760 ON BARS.MWAY_MATCH (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_MWAYMATCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_MWAYMATCH ON BARS.MWAY_MATCH (REF_TR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MWAY_MATCH ***
grant SELECT                                                                 on MWAY_MATCH      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MWAY_MATCH.sql =========*** End *** ==
PROMPT ===================================================================================== 
