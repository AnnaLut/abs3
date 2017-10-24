

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SMSARCHIVE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SMSARCHIVE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SMSARCHIVE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SMSARCHIVE 
   (	ACC NUMBER(38,0), 
	PHONE VARCHAR2(20), 
	SENDTIME DATE, 
	STMT NUMBER(38,0), 
	REF NUMBER(38,0), 
	OPERTIME DATE, 
	NUMDOC VARCHAR2(10), 
	SMINUS NUMBER(24,0), 
	SPLUS NUMBER(24,0), 
	ENDBALANCE NUMBER(24,0), 
	NAZN VARCHAR2(160), 
	COR_MFO VARCHAR2(12), 
	COR_NLS VARCHAR2(15), 
	COR_NK VARCHAR2(38), 
	ONOPER NUMBER(1,0) DEFAULT 0, 
	SENDEDONOPER NUMBER(1,0) DEFAULT 0, 
	SENDEDONDAY NUMBER(1,0) DEFAULT 0, 
	COR_OKPO VARCHAR2(14)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SMSARCHIVE ***
 exec bpa.alter_policies('TMP_SMSARCHIVE');


COMMENT ON TABLE BARS.TMP_SMSARCHIVE IS 'Архів створених SMS повідомлень для клієнтів (приложення SmsGuard.exe)';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.ACC IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.PHONE IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.SENDTIME IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.STMT IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.REF IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.OPERTIME IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.NUMDOC IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.SMINUS IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.SPLUS IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.ENDBALANCE IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.COR_MFO IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.COR_NLS IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.COR_NK IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.ONOPER IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.SENDEDONOPER IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.SENDEDONDAY IS '';
COMMENT ON COLUMN BARS.TMP_SMSARCHIVE.COR_OKPO IS '';




PROMPT *** Create  constraint TMP_SMSARCHIVE_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSARCHIVE ADD CONSTRAINT TMP_SMSARCHIVE_PK PRIMARY KEY (ACC, PHONE, SENDTIME, STMT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217402 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSARCHIVE MODIFY (SENDEDONDAY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217401 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSARCHIVE MODIFY (SENDEDONOPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217400 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSARCHIVE MODIFY (ONOPER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217399 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSARCHIVE MODIFY (STMT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217398 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSARCHIVE MODIFY (SENDTIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217397 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSARCHIVE MODIFY (PHONE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002217396 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SMSARCHIVE MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index TMP_SMSARCHIVE_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.TMP_SMSARCHIVE_PK ON BARS.TMP_SMSARCHIVE (ACC, PHONE, SENDTIME, STMT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SMSARCHIVE.sql =========*** End **
PROMPT ===================================================================================== 
