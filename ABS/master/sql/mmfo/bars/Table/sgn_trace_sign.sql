

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SGN_TRACE_SIGN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SGN_TRACE_SIGN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SGN_TRACE_SIGN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SGN_TRACE_SIGN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SGN_TRACE_SIGN ***
begin 
  execute immediate '
  CREATE TABLE BARS.SGN_TRACE_SIGN 
   (	CR_DATE TIMESTAMP (6) DEFAULT localtimestamp, 
	USER_ID NUMBER(38,0), 
	REF NUMBER(38,0), 
	VISA_LEVEL NUMBER(3,0), 
	KEY_ID VARCHAR2(256), 
	SIGN_MODE VARCHAR2(20), 
	BUFFER_TYPE VARCHAR2(3), 
	BUFFER_HEX CLOB, 
	BUFFER_BIN CLOB, 
	SIGN_HEX CLOB, 
	VERIFY_STATUS NUMBER(3,0), 
	VERIFY_ERROR VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (BUFFER_HEX) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (BUFFER_BIN) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (SIGN_HEX) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SGN_TRACE_SIGN ***
 exec bpa.alter_policies('SGN_TRACE_SIGN');


COMMENT ON TABLE BARS.SGN_TRACE_SIGN IS 'Діагностика перевірки робочого місця користувача';
COMMENT ON COLUMN BARS.SGN_TRACE_SIGN.CR_DATE IS '';
COMMENT ON COLUMN BARS.SGN_TRACE_SIGN.USER_ID IS '';
COMMENT ON COLUMN BARS.SGN_TRACE_SIGN.REF IS '';
COMMENT ON COLUMN BARS.SGN_TRACE_SIGN.VISA_LEVEL IS '';
COMMENT ON COLUMN BARS.SGN_TRACE_SIGN.KEY_ID IS '';
COMMENT ON COLUMN BARS.SGN_TRACE_SIGN.SIGN_MODE IS '';
COMMENT ON COLUMN BARS.SGN_TRACE_SIGN.BUFFER_TYPE IS '';
COMMENT ON COLUMN BARS.SGN_TRACE_SIGN.BUFFER_HEX IS '';
COMMENT ON COLUMN BARS.SGN_TRACE_SIGN.BUFFER_BIN IS '';
COMMENT ON COLUMN BARS.SGN_TRACE_SIGN.SIGN_HEX IS '';
COMMENT ON COLUMN BARS.SGN_TRACE_SIGN.VERIFY_STATUS IS '';
COMMENT ON COLUMN BARS.SGN_TRACE_SIGN.VERIFY_ERROR IS '';




PROMPT *** Create  constraint SYS_C00109884 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SGN_TRACE_SIGN MODIFY (CR_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SGN_TRACE_SIGN ***
grant SELECT                                                                 on SGN_TRACE_SIGN  to BARSREADER_ROLE;
grant SELECT                                                                 on SGN_TRACE_SIGN  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SGN_TRACE_SIGN.sql =========*** End **
PROMPT ===================================================================================== 
