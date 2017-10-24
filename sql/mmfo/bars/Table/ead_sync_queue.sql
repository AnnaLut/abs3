

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EAD_SYNC_QUEUE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EAD_SYNC_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EAD_SYNC_QUEUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_SYNC_QUEUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_SYNC_QUEUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EAD_SYNC_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.EAD_SYNC_QUEUE 
   (	ID NUMBER, 
	CRT_DATE DATE, 
	TYPE_ID VARCHAR2(100), 
	OBJ_ID VARCHAR2(100), 
	STATUS_ID VARCHAR2(100), 
	ERR_TEXT VARCHAR2(4000), 
	ERR_COUNT NUMBER DEFAULT 0, 
	MESSAGE_ID VARCHAR2(100), 
	MESSAGE_DATE DATE, 
	MESSAGE CLOB, 
	RESPONCE_ID VARCHAR2(100), 
	RESPONCE_DATE DATE, 
	RESPONCE CLOB, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSBIGD 
 LOB (MESSAGE) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (RESPONCE) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
  PARTITION BY RANGE (CRT_DATE) INTERVAL (NUMTOYMINTERVAL(1,''MONTH'')) 
 (PARTITION P_FIRST  VALUES LESS THAN (TO_DATE('' 2013-10-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD 
 LOB (MESSAGE) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (RESPONCE) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) )  ENABLE ROW MOVEMENT ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EAD_SYNC_QUEUE ***
 exec bpa.alter_policies('EAD_SYNC_QUEUE');


COMMENT ON TABLE BARS.EAD_SYNC_QUEUE IS 'Черга повідомлень для синхронізаціх з ЕА';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.CRT_DATE IS 'Дата створення';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.TYPE_ID IS 'Тип повідомлення';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.OBJ_ID IS 'Ід. обєкту (для док. - ід документу, для клієнта - РНК і тп)';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.STATUS_ID IS 'Ід. статусу';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.ERR_TEXT IS 'Текст помилки';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.ERR_COUNT IS 'Кіл-ть спроб з помилкою';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.MESSAGE_ID IS 'Ід. повідомлення';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.MESSAGE_DATE IS 'Дата відправки повідомлення';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.MESSAGE IS 'Текст повідомлення';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.RESPONCE_ID IS 'Ід. відповіді';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.RESPONCE_DATE IS 'Дата відповіді';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.RESPONCE IS 'Текст відповіді';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.KF IS '';




PROMPT *** Create  constraint CC_EADSYNCQ_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_QUEUE MODIFY (ID CONSTRAINT CC_EADSYNCQ_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADSYNCQ_CRTD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_QUEUE MODIFY (CRT_DATE CONSTRAINT CC_EADSYNCQ_CRTD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADSYNCQ_TID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_QUEUE MODIFY (TYPE_ID CONSTRAINT CC_EADSYNCQ_TID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADSYNCQ_OID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_QUEUE MODIFY (OBJ_ID CONSTRAINT CC_EADSYNCQ_OID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_EADSYNCQUEUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_QUEUE ADD CONSTRAINT FK_EADSYNCQUEUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADSYNCQ_ERRCOUNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_QUEUE MODIFY (ERR_COUNT CONSTRAINT CC_EADSYNCQ_ERRCOUNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADSYNCQUEUE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_QUEUE MODIFY (KF CONSTRAINT CC_EADSYNCQUEUE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_EADSYNCQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_QUEUE ADD CONSTRAINT PK_EADSYNCQ PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADSYNCQ_STSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_QUEUE MODIFY (STATUS_ID CONSTRAINT CC_EADSYNCQ_STSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EADSYNCQ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EADSYNCQ ON BARS.EAD_SYNC_QUEUE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_EADSYNCQUEUE_TYPE_OBJ ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_EADSYNCQUEUE_TYPE_OBJ ON BARS.EAD_SYNC_QUEUE (TYPE_ID, OBJ_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION P_FIRST 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EAD_SYNC_QUEUE ***
grant SELECT                                                                 on EAD_SYNC_QUEUE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EAD_SYNC_QUEUE  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_SYNC_QUEUE.sql =========*** End **
PROMPT ===================================================================================== 
