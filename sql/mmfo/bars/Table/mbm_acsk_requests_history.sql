

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBM_ACSK_REQUESTS_HISTORY.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBM_ACSK_REQUESTS_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBM_ACSK_REQUESTS_HISTORY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBM_ACSK_REQUESTS_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBM_ACSK_REQUESTS_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBM_ACSK_REQUESTS_HISTORY 
   (	NONCE VARCHAR2(128), 
	REQUEST_DATE DATE, 
	REQUEST_BODY CLOB, 
	RESPONSE_DATE DATE, 
	RESPONSE_CODE VARCHAR2(100), 
	RESPONSE_MESSAGE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (REQUEST_BODY) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBM_ACSK_REQUESTS_HISTORY ***
 exec bpa.alter_policies('MBM_ACSK_REQUESTS_HISTORY');


COMMENT ON TABLE BARS.MBM_ACSK_REQUESTS_HISTORY IS 'Історія звернень до АЦСК';
COMMENT ON COLUMN BARS.MBM_ACSK_REQUESTS_HISTORY.NONCE IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_REQUESTS_HISTORY.REQUEST_DATE IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_REQUESTS_HISTORY.REQUEST_BODY IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_REQUESTS_HISTORY.RESPONSE_DATE IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_REQUESTS_HISTORY.RESPONSE_CODE IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_REQUESTS_HISTORY.RESPONSE_MESSAGE IS '';




PROMPT *** Create  constraint SYS_C00111424 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_ACSK_REQUESTS_HISTORY MODIFY (REQUEST_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111425 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_ACSK_REQUESTS_HISTORY ADD PRIMARY KEY (NONCE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C00111425 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C00111425 ON BARS.MBM_ACSK_REQUESTS_HISTORY (NONCE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MBM_ACSK_REQUESTS_HISTORY ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MBM_ACSK_REQUESTS_HISTORY to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBM_ACSK_REQUESTS_HISTORY.sql ========
PROMPT ===================================================================================== 
