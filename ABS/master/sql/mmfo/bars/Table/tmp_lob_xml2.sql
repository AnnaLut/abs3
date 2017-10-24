

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_LOB_XML2.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_LOB_XML2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_LOB_XML2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_LOB_XML2 
   (	TELO CLOB
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (TELO) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_LOB_XML2 ***
 exec bpa.alter_policies('TMP_LOB_XML2');


COMMENT ON TABLE BARS.TMP_LOB_XML2 IS '';
COMMENT ON COLUMN BARS.TMP_LOB_XML2.TELO IS '';



PROMPT *** Create  grants  TMP_LOB_XML2 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LOB_XML2    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LOB_XML2    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_LOB_XML2.sql =========*** End *** 
PROMPT ===================================================================================== 
