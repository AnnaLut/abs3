

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MIGR_MAILNLS_CLOB.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MIGR_MAILNLS_CLOB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MIGR_MAILNLS_CLOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.MIGR_MAILNLS_CLOB 
   (	X CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (X) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MIGR_MAILNLS_CLOB ***
 exec bpa.alter_policies('MIGR_MAILNLS_CLOB');


COMMENT ON TABLE BARS.MIGR_MAILNLS_CLOB IS '';
COMMENT ON COLUMN BARS.MIGR_MAILNLS_CLOB.X IS '';



PROMPT *** Create  grants  MIGR_MAILNLS_CLOB ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MIGR_MAILNLS_CLOB to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MIGR_MAILNLS_CLOB.sql =========*** End
PROMPT ===================================================================================== 
