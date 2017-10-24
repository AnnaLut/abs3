

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_STOPS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_STOPS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_STOPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_STOPS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	TYPE_ID VARCHAR2(100), 
	RESULT_QID VARCHAR2(100), 
	PLSQL VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_STOPS ***
 exec bpa.alter_policies('TMP_WCS_STOPS');


COMMENT ON TABLE BARS.TMP_WCS_STOPS IS '';
COMMENT ON COLUMN BARS.TMP_WCS_STOPS.ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_STOPS.NAME IS '';
COMMENT ON COLUMN BARS.TMP_WCS_STOPS.TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_STOPS.RESULT_QID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_STOPS.PLSQL IS '';




PROMPT *** Create  constraint SYS_C003175582 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_STOPS MODIFY (RESULT_QID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175581 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_STOPS MODIFY (TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003175580 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_STOPS MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_STOPS.sql =========*** End ***
PROMPT ===================================================================================== 
