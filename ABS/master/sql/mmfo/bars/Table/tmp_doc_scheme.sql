

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DOC_SCHEME.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DOC_SCHEME ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DOC_SCHEME ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DOC_SCHEME 
   (	ID VARCHAR2(35), 
	NAME VARCHAR2(140), 
	PRINT_ON_BLANK NUMBER(1,0), 
	TEMPLATE CLOB, 
	HEADER CLOB, 
	FOOTER CLOB, 
	HEADER_EX CLOB, 
	D_CLOSE DATE, 
	FR NUMBER(1,0), 
	FILE_NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (TEMPLATE) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (HEADER) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (FOOTER) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (HEADER_EX) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DOC_SCHEME ***
 exec bpa.alter_policies('TMP_DOC_SCHEME');


COMMENT ON TABLE BARS.TMP_DOC_SCHEME IS '';
COMMENT ON COLUMN BARS.TMP_DOC_SCHEME.ID IS '';
COMMENT ON COLUMN BARS.TMP_DOC_SCHEME.NAME IS '';
COMMENT ON COLUMN BARS.TMP_DOC_SCHEME.PRINT_ON_BLANK IS '';
COMMENT ON COLUMN BARS.TMP_DOC_SCHEME.TEMPLATE IS '';
COMMENT ON COLUMN BARS.TMP_DOC_SCHEME.HEADER IS '';
COMMENT ON COLUMN BARS.TMP_DOC_SCHEME.FOOTER IS '';
COMMENT ON COLUMN BARS.TMP_DOC_SCHEME.HEADER_EX IS '';
COMMENT ON COLUMN BARS.TMP_DOC_SCHEME.D_CLOSE IS '';
COMMENT ON COLUMN BARS.TMP_DOC_SCHEME.FR IS '';
COMMENT ON COLUMN BARS.TMP_DOC_SCHEME.FILE_NAME IS '';




PROMPT *** Create  constraint SYS_C00119050 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DOC_SCHEME MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DOC_SCHEME ***
grant SELECT                                                                 on TMP_DOC_SCHEME  to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_DOC_SCHEME  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DOC_SCHEME.sql =========*** End **
PROMPT ===================================================================================== 
