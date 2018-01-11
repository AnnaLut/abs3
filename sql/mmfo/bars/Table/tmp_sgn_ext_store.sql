

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SGN_EXT_STORE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SGN_EXT_STORE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SGN_EXT_STORE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SGN_EXT_STORE 
   (	REF NUMBER(38,0), 
	SIGN_ID NUMBER, 
	REC_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SGN_EXT_STORE ***
 exec bpa.alter_policies('TMP_SGN_EXT_STORE');


COMMENT ON TABLE BARS.TMP_SGN_EXT_STORE IS '';
COMMENT ON COLUMN BARS.TMP_SGN_EXT_STORE.REF IS '';
COMMENT ON COLUMN BARS.TMP_SGN_EXT_STORE.SIGN_ID IS '';
COMMENT ON COLUMN BARS.TMP_SGN_EXT_STORE.REC_ID IS '';




PROMPT *** Create  constraint SYS_C00119170 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SGN_EXT_STORE MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119171 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SGN_EXT_STORE MODIFY (SIGN_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SGN_EXT_STORE ***
grant SELECT                                                                 on TMP_SGN_EXT_STORE to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_SGN_EXT_STORE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SGN_EXT_STORE.sql =========*** End
PROMPT ===================================================================================== 
