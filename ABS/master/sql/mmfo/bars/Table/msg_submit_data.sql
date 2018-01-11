

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MSG_SUBMIT_DATA.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MSG_SUBMIT_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MSG_SUBMIT_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MSG_SUBMIT_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MSG_SUBMIT_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MSG_SUBMIT_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.MSG_SUBMIT_DATA 
   (	MSG_ID NUMBER(*,0), 
	CREATION_TIME DATE DEFAULT sysdate, 
	EXPIRATION_TIME DATE DEFAULT sysdate, 
	PHONE VARCHAR2(30), 
	ENCODE VARCHAR2(3), 
	MSG_TEXT VARCHAR2(160), 
	STATUS VARCHAR2(30) DEFAULT ''NEW'', 
	STATUS_TIME DATE DEFAULT sysdate, 
	SUBMIT_CODE VARCHAR2(2), 
	LAST_ERROR VARCHAR2(4000), 
	SMPP_ERROR_MSG CLOB, 
	PAYEDREF NUMBER DEFAULT null, 
	REF VARCHAR2(20), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (SMPP_ERROR_MSG) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MSG_SUBMIT_DATA ***
 exec bpa.alter_policies('MSG_SUBMIT_DATA');


COMMENT ON TABLE BARS.MSG_SUBMIT_DATA IS 'Повідомлення для посилки SMS';
COMMENT ON COLUMN BARS.MSG_SUBMIT_DATA.KF IS '';
COMMENT ON COLUMN BARS.MSG_SUBMIT_DATA.MSG_ID IS 'ID повідомлення';
COMMENT ON COLUMN BARS.MSG_SUBMIT_DATA.CREATION_TIME IS 'Час створення повідомлення';
COMMENT ON COLUMN BARS.MSG_SUBMIT_DATA.EXPIRATION_TIME IS 'Граничний час актуальності повідомлення';
COMMENT ON COLUMN BARS.MSG_SUBMIT_DATA.PHONE IS '№ моб. телефону';
COMMENT ON COLUMN BARS.MSG_SUBMIT_DATA.ENCODE IS 'Кодування повідомлення cyr/lat';
COMMENT ON COLUMN BARS.MSG_SUBMIT_DATA.MSG_TEXT IS 'Текст повідомлення';
COMMENT ON COLUMN BARS.MSG_SUBMIT_DATA.STATUS IS 'Статус повідомлення';
COMMENT ON COLUMN BARS.MSG_SUBMIT_DATA.STATUS_TIME IS 'Час зміни статусу';
COMMENT ON COLUMN BARS.MSG_SUBMIT_DATA.SUBMIT_CODE IS 'Результат відправки повідомлення';
COMMENT ON COLUMN BARS.MSG_SUBMIT_DATA.LAST_ERROR IS 'Описа останньої помилки';
COMMENT ON COLUMN BARS.MSG_SUBMIT_DATA.SMPP_ERROR_MSG IS '';
COMMENT ON COLUMN BARS.MSG_SUBMIT_DATA.PAYEDREF IS '';
COMMENT ON COLUMN BARS.MSG_SUBMIT_DATA.REF IS 'Референс повідомлення в центрі відправки повідомлень для пошуку повідомлення при проставленні статусу після відправки';




PROMPT *** Create  constraint PK_MSGSUBMIT1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_SUBMIT_DATA ADD CONSTRAINT PK_MSGSUBMIT1 PRIMARY KEY (MSG_ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGSUBMIT_STATUS_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_SUBMIT_DATA ADD CONSTRAINT CC_MSGSUBMIT_STATUS_CC CHECK (status in (''NEW'',''SUBMITTED'',''REJECTED'',''EXPIRED'',''ERROR'', ''INVREQ'', ''ACCEPT'', ''INVSRC'', ''INVDST'', ''INVMSG'', ''DELIVERED'', ''EXPIRED'', ''UNDELIV'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGSUBMIT_MSGID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_SUBMIT_DATA MODIFY (MSG_ID CONSTRAINT CC_MSGSUBMIT_MSGID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGSUBMIT_CRTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_SUBMIT_DATA MODIFY (CREATION_TIME CONSTRAINT CC_MSGSUBMIT_CRTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGSUBMIT_EXPTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_SUBMIT_DATA MODIFY (EXPIRATION_TIME CONSTRAINT CC_MSGSUBMIT_EXPTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGSUBMIT_PHONE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_SUBMIT_DATA MODIFY (PHONE CONSTRAINT CC_MSGSUBMIT_PHONE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGSUBMIT_ENCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_SUBMIT_DATA MODIFY (ENCODE CONSTRAINT CC_MSGSUBMIT_ENCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGSUBMIT_MSGTEXT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_SUBMIT_DATA MODIFY (MSG_TEXT CONSTRAINT CC_MSGSUBMIT_MSGTEXT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGSUBMIT_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_SUBMIT_DATA MODIFY (STATUS CONSTRAINT CC_MSGSUBMIT_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MSGSUBMIT_STATUSTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_SUBMIT_DATA MODIFY (STATUS_TIME CONSTRAINT CC_MSGSUBMIT_STATUSTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MSGSUBMIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MSGSUBMIT ON BARS.MSG_SUBMIT_DATA (MSG_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_MSGSUBMIT_STATUSTIME ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_MSGSUBMIT_STATUSTIME ON BARS.MSG_SUBMIT_DATA (STATUS_TIME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_MSGSUBMIT_STATUS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_MSGSUBMIT_STATUS ON BARS.MSG_SUBMIT_DATA (STATUS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UQ_MSG_SBMT_DATA_REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UQ_MSG_SBMT_DATA_REF ON BARS.MSG_SUBMIT_DATA (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MSGSUBMIT1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MSGSUBMIT1 ON BARS.MSG_SUBMIT_DATA (MSG_ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MSG_SUBMIT_DATA ***
grant SELECT                                                                 on MSG_SUBMIT_DATA to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on MSG_SUBMIT_DATA to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on MSG_SUBMIT_DATA to START1;
grant SELECT                                                                 on MSG_SUBMIT_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MSG_SUBMIT_DATA.sql =========*** End *
PROMPT ===================================================================================== 
