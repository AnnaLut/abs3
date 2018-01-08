

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PFU_CA_FILES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PFU_CA_FILES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PFU_CA_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_PFU_CA_FILES 
   (	ID NUMBER, 
	FILE_TYPE NUMBER, 
	FILE_DATA CLOB, 
	STATE NUMBER(2,0), 
	MESSAGE VARCHAR2(4000), 
	SIGN RAW(128), 
	RESP_DATA CLOB, 
	KF VARCHAR2(8)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (FILE_DATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (RESP_DATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PFU_CA_FILES ***
 exec bpa.alter_policies('TMP_PFU_CA_FILES');


COMMENT ON TABLE BARS.TMP_PFU_CA_FILES IS '';
COMMENT ON COLUMN BARS.TMP_PFU_CA_FILES.ID IS '';
COMMENT ON COLUMN BARS.TMP_PFU_CA_FILES.FILE_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_PFU_CA_FILES.FILE_DATA IS '';
COMMENT ON COLUMN BARS.TMP_PFU_CA_FILES.STATE IS '';
COMMENT ON COLUMN BARS.TMP_PFU_CA_FILES.MESSAGE IS '';
COMMENT ON COLUMN BARS.TMP_PFU_CA_FILES.SIGN IS '';
COMMENT ON COLUMN BARS.TMP_PFU_CA_FILES.RESP_DATA IS '';
COMMENT ON COLUMN BARS.TMP_PFU_CA_FILES.KF IS '';




PROMPT *** Create  constraint SYS_C00132259 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PFU_CA_FILES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132260 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PFU_CA_FILES MODIFY (FILE_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132261 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PFU_CA_FILES MODIFY (FILE_DATA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132262 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PFU_CA_FILES MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_PFU_CA_FILES ***
grant SELECT                                                                 on TMP_PFU_CA_FILES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PFU_CA_FILES.sql =========*** End 
PROMPT ===================================================================================== 
