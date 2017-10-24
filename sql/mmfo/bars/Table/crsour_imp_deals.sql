

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CRSOUR_IMP_DEALS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CRSOUR_IMP_DEALS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CRSOUR_IMP_DEALS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CRSOUR_IMP_DEALS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CRSOUR_IMP_DEALS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CRSOUR_IMP_DEALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CRSOUR_IMP_DEALS 
   (	KF VARCHAR2(6 CHAR), 
	ND NUMBER(10,0), 
	CC_ID VARCHAR2(50 CHAR), 
	VIDD NUMBER(5,0), 
	START_DATE DATE, 
	EXPIRY_DATE DATE, 
	DEAL_AMOUNT NUMBER(24,4), 
	DEAL_CURRENCY NUMBER(3,0), 
	MAIN_ACCOUNT_ID NUMBER(38,0), 
	MAIN_ACCOUNT_NUMBER VARCHAR2(15 CHAR), 
	PLAN_REST NUMBER, 
	CURRENT_REST NUMBER, 
	INTEREST_ACCOUNT_ID NUMBER(38,0), 
	INTEREST_ACCOUNT_NUMBER VARCHAR2(15 CHAR), 
	ACCRUED_INTEREST_PLAN_REST NUMBER, 
	ACCRUED_INTEREST_CURRENT_REST NUMBER, 
	INTEREST_CALENDAR NUMBER(*,0), 
	PARTY_MAIN_ACCOUNT VARCHAR2(15 CHAR), 
	PARTY_INTEREST_ACCOUNT VARCHAR2(15 CHAR), 
	PARTY_MFO VARCHAR2(6 CHAR), 
	TRANSIT_ACCOUNT_NUMBER VARCHAR2(15 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CRSOUR_IMP_DEALS ***
 exec bpa.alter_policies('CRSOUR_IMP_DEALS');


COMMENT ON TABLE BARS.CRSOUR_IMP_DEALS IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.KF IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.ND IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.CC_ID IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.VIDD IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.START_DATE IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.EXPIRY_DATE IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.DEAL_AMOUNT IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.DEAL_CURRENCY IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.MAIN_ACCOUNT_ID IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.MAIN_ACCOUNT_NUMBER IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.PLAN_REST IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.CURRENT_REST IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.INTEREST_ACCOUNT_ID IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.INTEREST_ACCOUNT_NUMBER IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.ACCRUED_INTEREST_PLAN_REST IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.ACCRUED_INTEREST_CURRENT_REST IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.INTEREST_CALENDAR IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.PARTY_MAIN_ACCOUNT IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.PARTY_INTEREST_ACCOUNT IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.PARTY_MFO IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_DEALS.TRANSIT_ACCOUNT_NUMBER IS '';




PROMPT *** Create  constraint SYS_C006248 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRSOUR_IMP_DEALS MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006249 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRSOUR_IMP_DEALS MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CRSOUR_IMP_DEALS ***
grant SELECT                                                                 on CRSOUR_IMP_DEALS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CRSOUR_IMP_DEALS.sql =========*** End 
PROMPT ===================================================================================== 
