

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OW_FILE_TYPE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OW_FILE_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OW_FILE_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OW_FILE_TYPE 
   (	FILE_TYPE VARCHAR2(30), 
	NAME VARCHAR2(100), 
	IO VARCHAR2(1), 
	PRIORITY NUMBER(10,0), 
	TYPE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OW_FILE_TYPE ***
 exec bpa.alter_policies('TMP_OW_FILE_TYPE');


COMMENT ON TABLE BARS.TMP_OW_FILE_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_OW_FILE_TYPE.FILE_TYPE IS '';
COMMENT ON COLUMN BARS.TMP_OW_FILE_TYPE.NAME IS '';
COMMENT ON COLUMN BARS.TMP_OW_FILE_TYPE.IO IS '';
COMMENT ON COLUMN BARS.TMP_OW_FILE_TYPE.PRIORITY IS '';
COMMENT ON COLUMN BARS.TMP_OW_FILE_TYPE.TYPE IS '';



PROMPT *** Create  grants  TMP_OW_FILE_TYPE ***
grant SELECT                                                                 on TMP_OW_FILE_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_OW_FILE_TYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OW_FILE_TYPE.sql =========*** End 
PROMPT ===================================================================================== 
