

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_EXPORT_TO_DBF.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_EXPORT_TO_DBF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_EXPORT_TO_DBF ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_EXPORT_TO_DBF 
   (	ID NUMBER, 
	KODZ NUMBER, 
	USERID NUMBER, 
	CREATING_DATE DATE, 
	DATA BLOB, 
	FILE_NAME VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (DATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_EXPORT_TO_DBF ***
 exec bpa.alter_policies('TMP_EXPORT_TO_DBF');


COMMENT ON TABLE BARS.TMP_EXPORT_TO_DBF IS '';
COMMENT ON COLUMN BARS.TMP_EXPORT_TO_DBF.FILE_NAME IS '';
COMMENT ON COLUMN BARS.TMP_EXPORT_TO_DBF.ID IS '';
COMMENT ON COLUMN BARS.TMP_EXPORT_TO_DBF.KODZ IS '';
COMMENT ON COLUMN BARS.TMP_EXPORT_TO_DBF.USERID IS '';
COMMENT ON COLUMN BARS.TMP_EXPORT_TO_DBF.CREATING_DATE IS '';
COMMENT ON COLUMN BARS.TMP_EXPORT_TO_DBF.DATA IS '';



PROMPT *** Create  grants  TMP_EXPORT_TO_DBF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_EXPORT_TO_DBF to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_EXPORT_TO_DBF.sql =========*** End
PROMPT ===================================================================================== 
