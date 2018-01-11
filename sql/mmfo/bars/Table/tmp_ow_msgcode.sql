

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OW_MSGCODE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OW_MSGCODE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OW_MSGCODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OW_MSGCODE 
   (	MSGCODE VARCHAR2(100), 
	DK NUMBER(1,0), 
	SYNTHCODE VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OW_MSGCODE ***
 exec bpa.alter_policies('TMP_OW_MSGCODE');


COMMENT ON TABLE BARS.TMP_OW_MSGCODE IS '';
COMMENT ON COLUMN BARS.TMP_OW_MSGCODE.MSGCODE IS '';
COMMENT ON COLUMN BARS.TMP_OW_MSGCODE.DK IS '';
COMMENT ON COLUMN BARS.TMP_OW_MSGCODE.SYNTHCODE IS '';



PROMPT *** Create  grants  TMP_OW_MSGCODE ***
grant SELECT                                                                 on TMP_OW_MSGCODE  to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_OW_MSGCODE  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OW_MSGCODE.sql =========*** End **
PROMPT ===================================================================================== 
