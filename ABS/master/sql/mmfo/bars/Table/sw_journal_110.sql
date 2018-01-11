

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_JOURNAL_110.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_JOURNAL_110 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_JOURNAL_110'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_JOURNAL_110'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SW_JOURNAL_110'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_JOURNAL_110 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_JOURNAL_110 
   (	SWREF NUMBER, 
	MT NUMBER(38,0), 
	TRN VARCHAR2(16), 
	IO_IND CHAR(1), 
	CURRENCY CHAR(3), 
	SENDER CHAR(11), 
	RECEIVER CHAR(11), 
	PAYER VARCHAR2(35), 
	PAYEE VARCHAR2(35), 
	AMOUNT NUMBER(24,0), 
	ACCD NUMBER, 
	ACCK NUMBER, 
	DATE_IN DATE, 
	DATE_OUT DATE, 
	DATE_PAY DATE, 
	DATE_REC DATE, 
	VDATE DATE, 
	ID NUMBER(*,0), 
	PAGE VARCHAR2(30), 
	TRANSIT VARCHAR2(200), 
	X_DATE_IN DATE, 
	FLAGS VARCHAR2(3), 
	SOS NUMBER(3,0), 
	LAU VARCHAR2(8), 
	LAU_FLAG NUMBER(1,0), 
	LAU_UID NUMBER(38,0), 
	LAU_ACT NUMBER(1,0), 
	IMPORTED CHAR(1), 
	MTREF VARCHAR2(16), 
	APP_FLAG VARCHAR2(5)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_JOURNAL_110 ***
 exec bpa.alter_policies('SW_JOURNAL_110');


COMMENT ON TABLE BARS.SW_JOURNAL_110 IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.SWREF IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.MT IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.TRN IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.IO_IND IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.CURRENCY IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.SENDER IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.RECEIVER IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.PAYER IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.PAYEE IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.AMOUNT IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.ACCD IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.ACCK IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.DATE_IN IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.DATE_OUT IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.DATE_PAY IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.DATE_REC IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.VDATE IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.ID IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.PAGE IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.TRANSIT IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.X_DATE_IN IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.FLAGS IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.SOS IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.LAU IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.LAU_FLAG IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.LAU_UID IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.LAU_ACT IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.IMPORTED IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.MTREF IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_110.APP_FLAG IS '';




PROMPT *** Create  constraint SYS_C009297 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_110 MODIFY (SWREF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009298 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_110 MODIFY (MT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009299 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_110 MODIFY (TRN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009300 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_110 MODIFY (IO_IND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009301 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_110 MODIFY (SENDER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009302 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_110 MODIFY (RECEIVER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009303 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_110 MODIFY (AMOUNT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009304 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_110 MODIFY (DATE_IN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009305 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_110 MODIFY (VDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009306 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_110 MODIFY (PAGE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009307 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_110 MODIFY (SOS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009308 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_110 MODIFY (LAU_ACT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009309 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_110 MODIFY (IMPORTED NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009310 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_110 MODIFY (APP_FLAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_JOURNAL_110 ***
grant SELECT                                                                 on SW_JOURNAL_110  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_JOURNAL_110  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_JOURNAL_110  to START1;
grant SELECT                                                                 on SW_JOURNAL_110  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_JOURNAL_110.sql =========*** End **
PROMPT ===================================================================================== 
