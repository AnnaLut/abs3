

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_W4_DEALS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_W4_DEALS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_W4_DEALS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_W4_DEALS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_W4_DEALS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_W4_DEALS 
   (	ND NUMBER(22,0), 
	STATE VARCHAR2(100), 
	SET_DATE DATE DEFAULT sysdate, 
	ERR_MSG VARCHAR2(4000), 
	REQUEST CLOB, 
	RESPONSE CLOB, 
	INS_EXT_ID NUMBER, 
	INS_EXT_TMP NUMBER, 
	DEAL_ID VARCHAR2(100), 
	DATE_FROM DATE, 
	DATE_TO DATE, 
	REQUESTXML CLOB, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (REQUEST) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (RESPONSE) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (REQUESTXML) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_W4_DEALS ***
 exec bpa.alter_policies('INS_W4_DEALS');


COMMENT ON TABLE BARS.INS_W4_DEALS IS '';
COMMENT ON COLUMN BARS.INS_W4_DEALS.ND IS '';
COMMENT ON COLUMN BARS.INS_W4_DEALS.STATE IS '';
COMMENT ON COLUMN BARS.INS_W4_DEALS.SET_DATE IS '';
COMMENT ON COLUMN BARS.INS_W4_DEALS.ERR_MSG IS '';
COMMENT ON COLUMN BARS.INS_W4_DEALS.REQUEST IS '';
COMMENT ON COLUMN BARS.INS_W4_DEALS.RESPONSE IS '';
COMMENT ON COLUMN BARS.INS_W4_DEALS.INS_EXT_ID IS '';
COMMENT ON COLUMN BARS.INS_W4_DEALS.INS_EXT_TMP IS '';
COMMENT ON COLUMN BARS.INS_W4_DEALS.DEAL_ID IS '';
COMMENT ON COLUMN BARS.INS_W4_DEALS.DATE_FROM IS '';
COMMENT ON COLUMN BARS.INS_W4_DEALS.DATE_TO IS '';
COMMENT ON COLUMN BARS.INS_W4_DEALS.REQUESTXML IS '';
COMMENT ON COLUMN BARS.INS_W4_DEALS.KF IS '';




PROMPT *** Create  constraint SYS_C00138012 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_W4_DEALS ADD PRIMARY KEY (ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C00138012 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C00138012 ON BARS.INS_W4_DEALS (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_W4_DEALS ***
grant SELECT                                                                 on INS_W4_DEALS    to BARS_ACCESS_USER;
grant SELECT                                                                 on INS_W4_DEALS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_W4_DEALS.sql =========*** End *** 
PROMPT ===================================================================================== 
