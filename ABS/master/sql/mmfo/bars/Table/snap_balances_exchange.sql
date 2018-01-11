

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SNAP_BALANCES_EXCHANGE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SNAP_BALANCES_EXCHANGE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SNAP_BALANCES_EXCHANGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SNAP_BALANCES_EXCHANGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SNAP_BALANCES_EXCHANGE 
   (	FDAT DATE, 
	KF VARCHAR2(6), 
	ACC NUMBER(*,0), 
	RNK NUMBER(*,0), 
	OST NUMBER(24,0), 
	DOS NUMBER(24,0), 
	KOS NUMBER(24,0), 
	OSTQ NUMBER(24,0), 
	DOSQ NUMBER(24,0), 
	KOSQ NUMBER(24,0), 
	CALDT_ID NUMBER(38,0) GENERATED ALWAYS AS (TO_NUMBER(TO_CHAR(FDAT,''j''))-2447892) VIRTUAL VISIBLE 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 0 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 COMPRESS BASIC LOGGING
  TABLESPACE BRSACCM ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SNAP_BALANCES_EXCHANGE ***
 exec bpa.alter_policies('SNAP_BALANCES_EXCHANGE');


COMMENT ON TABLE BARS.SNAP_BALANCES_EXCHANGE IS 'Знімок балансу за день';
COMMENT ON COLUMN BARS.SNAP_BALANCES_EXCHANGE.FDAT IS 'Дата балансу';
COMMENT ON COLUMN BARS.SNAP_BALANCES_EXCHANGE.KF IS 'Код філіалу (МФО)';
COMMENT ON COLUMN BARS.SNAP_BALANCES_EXCHANGE.ACC IS 'Ід. рахунка';
COMMENT ON COLUMN BARS.SNAP_BALANCES_EXCHANGE.RNK IS 'Ід. клієнта';
COMMENT ON COLUMN BARS.SNAP_BALANCES_EXCHANGE.OST IS 'Вихідний залишок по рахунку (номінал)';
COMMENT ON COLUMN BARS.SNAP_BALANCES_EXCHANGE.DOS IS 'Сума дебетових оборотів (номінал)';
COMMENT ON COLUMN BARS.SNAP_BALANCES_EXCHANGE.KOS IS 'Сума кредитових оборотів (номінал)';
COMMENT ON COLUMN BARS.SNAP_BALANCES_EXCHANGE.OSTQ IS 'Вихідний залишок по рахунку (еквівалент)';
COMMENT ON COLUMN BARS.SNAP_BALANCES_EXCHANGE.DOSQ IS 'Сума дебетових оборотів (еквівалент)';
COMMENT ON COLUMN BARS.SNAP_BALANCES_EXCHANGE.KOSQ IS 'Сума кредитових оборотів (еквівалент)';
COMMENT ON COLUMN BARS.SNAP_BALANCES_EXCHANGE.CALDT_ID IS 'Ід. дати балансу';




PROMPT *** Create  constraint SYS_C0033013 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES_EXCHANGE MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033014 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES_EXCHANGE MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033015 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES_EXCHANGE MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033016 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES_EXCHANGE MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033017 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES_EXCHANGE MODIFY (OST NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033018 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES_EXCHANGE MODIFY (DOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033019 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES_EXCHANGE MODIFY (KOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033020 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES_EXCHANGE MODIFY (OSTQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033021 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES_EXCHANGE MODIFY (DOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033022 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNAP_BALANCES_EXCHANGE MODIFY (KOSQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SNAP_BALANCES_EXCHANGE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SNAP_BALANCES_EXCHANGE ON BARS.SNAP_BALANCES_EXCHANGE (FDAT, KF, ACC) 
  PCTFREE 0 INITRANS 2 MAXTRANS 255 COMPRESS 2 
  TABLESPACE BRSACCM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SNAP_BALANCES_EXCHANGE ***
grant SELECT                                                                 on SNAP_BALANCES_EXCHANGE to BARSREADER_ROLE;
grant ALTER,SELECT                                                           on SNAP_BALANCES_EXCHANGE to DM;
grant SELECT                                                                 on SNAP_BALANCES_EXCHANGE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SNAP_BALANCES_EXCHANGE.sql =========**
PROMPT ===================================================================================== 
