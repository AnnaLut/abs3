

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_JOURNAL_X.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_JOURNAL_X ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_JOURNAL_X'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_JOURNAL_X'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SW_JOURNAL_X'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_JOURNAL_X ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_JOURNAL_X 
   (	SWREF NUMBER, 
	MT NUMBER(*,0), 
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
	DATE_IN DATE DEFAULT SYSDATE, 
	DATE_OUT DATE, 
	DATE_PAY DATE, 
	DATE_REC DATE, 
	VDATE DATE DEFAULT SYSDATE, 
	ID NUMBER(*,0), 
	PAGE VARCHAR2(30), 
	TRANSIT VARCHAR2(200), 
	X_DATE_IN DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
  PARALLEL ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_JOURNAL_X ***
 exec bpa.alter_policies('SW_JOURNAL_X');


COMMENT ON TABLE BARS.SW_JOURNAL_X IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.SWREF IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.MT IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.TRN IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.IO_IND IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.CURRENCY IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.SENDER IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.RECEIVER IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.PAYER IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.PAYEE IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.AMOUNT IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.ACCD IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.ACCK IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.DATE_IN IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.DATE_OUT IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.DATE_PAY IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.DATE_REC IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.VDATE IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.ID IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.PAGE IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.TRANSIT IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL_X.X_DATE_IN IS '';




PROMPT *** Create  constraint SYS_C008053 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_X MODIFY (SWREF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008054 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_X MODIFY (TRN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008055 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_X MODIFY (DATE_IN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008056 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL_X MODIFY (PAGE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_JOURNAL_X ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_JOURNAL_X    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_JOURNAL_X    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_JOURNAL_X.sql =========*** End *** 
PROMPT ===================================================================================== 
