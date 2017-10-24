

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_INFOQUERIES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_INFOQUERIES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_INFOQUERIES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_INFOQUERIES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	TYPE_ID VARCHAR2(100), 
	RESULT_QID VARCHAR2(100), 
	RESULT_MSG_QID VARCHAR2(100), 
	PLSQL CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (PLSQL) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_INFOQUERIES ***
 exec bpa.alter_policies('TMP_WCS_INFOQUERIES');


COMMENT ON TABLE BARS.TMP_WCS_INFOQUERIES IS '';
COMMENT ON COLUMN BARS.TMP_WCS_INFOQUERIES.ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_INFOQUERIES.NAME IS '';
COMMENT ON COLUMN BARS.TMP_WCS_INFOQUERIES.TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_INFOQUERIES.RESULT_QID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_INFOQUERIES.RESULT_MSG_QID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_INFOQUERIES.PLSQL IS '';




PROMPT *** Create  constraint SYS_C003175515 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_INFOQUERIES MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_INFOQUERIES.sql =========*** E
PROMPT ===================================================================================== 
