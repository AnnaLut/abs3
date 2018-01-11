

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBM_ACSK_CERTIFICATE_REQ.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBM_ACSK_CERTIFICATE_REQ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBM_ACSK_CERTIFICATE_REQ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBM_ACSK_CERTIFICATE_REQ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBM_ACSK_CERTIFICATE_REQ ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBM_ACSK_CERTIFICATE_REQ 
   (	ID NUMBER, 
	REL_CUST_ID NUMBER, 
	REQUEST_TIME DATE, 
	REQUEST_STATE NUMBER, 
	REQUEST_STATE_MESSAGE VARCHAR2(4000), 
	CERTIFICATE_SN VARCHAR2(200), 
	TEMPLATE_NAME VARCHAR2(400), 
	TEMPLATE_OID VARCHAR2(200), 
	CERTIFICATE_ID VARCHAR2(200), 
	CERTIFICATE_BODY CLOB, 
	REVOKE_CODE NUMBER, 
	TOKEN_SN VARCHAR2(200), 
	TOKEN_NAME VARCHAR2(400)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (CERTIFICATE_BODY) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBM_ACSK_CERTIFICATE_REQ ***
 exec bpa.alter_policies('MBM_ACSK_CERTIFICATE_REQ');


COMMENT ON TABLE BARS.MBM_ACSK_CERTIFICATE_REQ IS 'Довідник запитів на сертифікати АЦСК';
COMMENT ON COLUMN BARS.MBM_ACSK_CERTIFICATE_REQ.ID IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_CERTIFICATE_REQ.REL_CUST_ID IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_CERTIFICATE_REQ.REQUEST_TIME IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_CERTIFICATE_REQ.REQUEST_STATE IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_CERTIFICATE_REQ.REQUEST_STATE_MESSAGE IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_CERTIFICATE_REQ.CERTIFICATE_SN IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_CERTIFICATE_REQ.TEMPLATE_NAME IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_CERTIFICATE_REQ.TEMPLATE_OID IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_CERTIFICATE_REQ.CERTIFICATE_ID IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_CERTIFICATE_REQ.CERTIFICATE_BODY IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_CERTIFICATE_REQ.REVOKE_CODE IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_CERTIFICATE_REQ.TOKEN_SN IS '';
COMMENT ON COLUMN BARS.MBM_ACSK_CERTIFICATE_REQ.TOKEN_NAME IS '';




PROMPT *** Create  constraint SYS_C00111426 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBM_ACSK_CERTIFICATE_REQ ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C00111426 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C00111426 ON BARS.MBM_ACSK_CERTIFICATE_REQ (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MBM_ACSK_CERTIFICATE_REQ ***
grant SELECT                                                                 on MBM_ACSK_CERTIFICATE_REQ to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on MBM_ACSK_CERTIFICATE_REQ to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBM_ACSK_CERTIFICATE_REQ to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBM_ACSK_CERTIFICATE_REQ.sql =========
PROMPT ===================================================================================== 
