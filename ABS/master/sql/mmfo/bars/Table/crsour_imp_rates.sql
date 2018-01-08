

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CRSOUR_IMP_RATES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CRSOUR_IMP_RATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CRSOUR_IMP_RATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CRSOUR_IMP_RATES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CRSOUR_IMP_RATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CRSOUR_IMP_RATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CRSOUR_IMP_RATES 
   (	KF VARCHAR2(6 CHAR), 
	DEAL_ID NUMBER(10,0), 
	DEAL_NUMBER VARCHAR2(30 CHAR), 
	DEAL_START_DATE DATE, 
	ACCOUNT_ID NUMBER(10,0), 
	ACCOUNT_NUMBER VARCHAR2(15 CHAR), 
	ACCOUNT_CURRENCY NUMBER(3,0), 
	START_DATE DATE, 
	RATE_VALUE NUMBER(22,12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CRSOUR_IMP_RATES ***
 exec bpa.alter_policies('CRSOUR_IMP_RATES');


COMMENT ON TABLE BARS.CRSOUR_IMP_RATES IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_RATES.KF IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_RATES.DEAL_ID IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_RATES.DEAL_NUMBER IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_RATES.DEAL_START_DATE IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_RATES.ACCOUNT_ID IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_RATES.ACCOUNT_NUMBER IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_RATES.ACCOUNT_CURRENCY IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_RATES.START_DATE IS '';
COMMENT ON COLUMN BARS.CRSOUR_IMP_RATES.RATE_VALUE IS '';




PROMPT *** Create  constraint SYS_C007479 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRSOUR_IMP_RATES MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CRSOUR_IMP_RATES ***
grant SELECT                                                                 on CRSOUR_IMP_RATES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CRSOUR_IMP_RATES.sql =========*** End 
PROMPT ===================================================================================== 
