

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPA_170915.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPA_170915 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPA_170915 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DPA_170915 
   (	RDATE DATE, 
	MSG_V VARCHAR2(4000), 
	MSG_CLOB CLOB, 
	XML_ XMLTYPE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (MSG_CLOB) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 XMLTYPE COLUMN XML_ STORE AS SECUREFILE BINARY XML (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ALLOW NONSCHEMA DISALLOW ANYSCHEMA ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DPA_170915 ***
 exec bpa.alter_policies('TMP_DPA_170915');


COMMENT ON TABLE BARS.TMP_DPA_170915 IS '';
COMMENT ON COLUMN BARS.TMP_DPA_170915.MSG_CLOB IS '';
COMMENT ON COLUMN BARS.TMP_DPA_170915.XML_ IS '';
COMMENT ON COLUMN BARS.TMP_DPA_170915.RDATE IS '';
COMMENT ON COLUMN BARS.TMP_DPA_170915.MSG_V IS '';



PROMPT *** Create  grants  TMP_DPA_170915 ***
grant SELECT                                                                 on TMP_DPA_170915  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPA_170915.sql =========*** End **
PROMPT ===================================================================================== 
