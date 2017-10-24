

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_INSURANCES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_INSURANCES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_INSURANCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_INSURANCES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	INS_TYPE_ID NUMBER, 
	SURVEY_ID VARCHAR2(100), 
	COUNT_QID VARCHAR2(100), 
	STATUS_QID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_INSURANCES ***
 exec bpa.alter_policies('TMP_WCS_INSURANCES');


COMMENT ON TABLE BARS.TMP_WCS_INSURANCES IS '';
COMMENT ON COLUMN BARS.TMP_WCS_INSURANCES.ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_INSURANCES.NAME IS '';
COMMENT ON COLUMN BARS.TMP_WCS_INSURANCES.INS_TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_INSURANCES.SURVEY_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_INSURANCES.COUNT_QID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_INSURANCES.STATUS_QID IS '';




PROMPT *** Create  constraint SYS_C003175519 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_INSURANCES MODIFY (STATUS_QID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175518 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_INSURANCES MODIFY (COUNT_QID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175517 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_INSURANCES MODIFY (INS_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175516 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_INSURANCES MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_INSURANCES.sql =========*** En
PROMPT ===================================================================================== 
