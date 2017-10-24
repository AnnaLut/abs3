

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MIGR_MAILNLS_XML.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MIGR_MAILNLS_XML ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MIGR_MAILNLS_XML ***
begin 
  execute immediate '
  CREATE TABLE BARS.MIGR_MAILNLS_XML 
   (	X SYS.XMLTYPE 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 XMLTYPE COLUMN X STORE AS BASICFILE CLOB (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MIGR_MAILNLS_XML ***
 exec bpa.alter_policies('MIGR_MAILNLS_XML');


COMMENT ON TABLE BARS.MIGR_MAILNLS_XML IS '';
COMMENT ON COLUMN BARS.MIGR_MAILNLS_XML.X IS '';



PROMPT *** Create  grants  MIGR_MAILNLS_XML ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MIGR_MAILNLS_XML to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MIGR_MAILNLS_XML.sql =========*** End 
PROMPT ===================================================================================== 
