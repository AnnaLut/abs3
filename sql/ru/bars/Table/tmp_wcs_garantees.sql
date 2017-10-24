

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_GARANTEES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_GARANTEES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_GARANTEES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_GARANTEES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	GRT_TABLE_ID NUMBER, 
	SCOPY_ID VARCHAR2(100), 
	SURVEY_ID VARCHAR2(100), 
	COUNT_QID VARCHAR2(100), 
	STATUS_QID VARCHAR2(100), 
	WS_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_GARANTEES ***
 exec bpa.alter_policies('TMP_WCS_GARANTEES');


COMMENT ON TABLE BARS.TMP_WCS_GARANTEES IS '';
COMMENT ON COLUMN BARS.TMP_WCS_GARANTEES.ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_GARANTEES.NAME IS '';
COMMENT ON COLUMN BARS.TMP_WCS_GARANTEES.GRT_TABLE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_GARANTEES.SCOPY_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_GARANTEES.SURVEY_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_GARANTEES.COUNT_QID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_GARANTEES.STATUS_QID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_GARANTEES.WS_ID IS '';




PROMPT *** Create  constraint SYS_C003175510 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_GARANTEES MODIFY (COUNT_QID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175509 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_GARANTEES MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175512 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_GARANTEES MODIFY (WS_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175511 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_GARANTEES MODIFY (STATUS_QID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_GARANTEES.sql =========*** End
PROMPT ===================================================================================== 
