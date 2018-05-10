

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EAD_SYNC_QUEUE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EAD_SYNC_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
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
   (	ID NUMBER(38) not null, 
	CRT_DATE DATE not null, 
	TYPE_ID VARCHAR2(100) not null, 
	OBJ_ID VARCHAR2(100) not null, 
	STATUS_ID VARCHAR2(100) not null, 
	ERR_TEXT VARCHAR2(4000), 
	ERR_COUNT NUMBER(38) DEFAULT 0 not null, 
	MESSAGE_ID VARCHAR2(100), 
	MESSAGE_DATE DATE, 
	MESSAGE CLOB, 
	RESPONCE_ID VARCHAR2(100), 
	RESPONCE_DATE DATE, 
	RESPONCE CLOB, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'') not null
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSBIGD 
 LOB (MESSAGE) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (RESPONCE) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
  PARTITION BY RANGE (CRT_DATE) INTERVAL (NUMTOYMINTERVAL(1,''MONTH'')) 
 (PARTITION P_FIRST  VALUES LESS THAN (TO_DATE('' 2013-10-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION DEFERRED 
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


-- Add/modify columns 
begin
  for i in (select 1 from dual where not exists (select 1 from user_tab_cols where TABLE_NAME = 'EAD_SYNC_QUEUE' and COLUMN_NAME = 'KF')) loop
    execute immediate 'alter table bars.ead_sync_queue add kf VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')';
  end loop;
  for i in (select 1 from dual where not exists (select 1 from user_tab_cols where TABLE_NAME = 'EAD_SYNC_QUEUE' and COLUMN_NAME = 'RNK')) loop
    execute immediate 'alter table bars.ead_sync_queue add rnk number(38)';
  end loop;
end;
/


PROMPT *** ALTER_POLICIES to EAD_SYNC_QUEUE ***
 exec bpa.alter_policies('EAD_SYNC_QUEUE');


COMMENT ON TABLE BARS.EAD_SYNC_QUEUE IS 'Черга повідомлень для синхронізаціх з ЕА';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.CRT_DATE IS 'Дата створення';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.TYPE_ID IS 'Тип повідомлення';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.OBJ_ID IS 'Ід. обєкту (для док. - ід документу, для клієнта - РНК і тп)';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.RNK IS 'РНК клієнта по котрому формується повідомлення';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.STATUS_ID IS 'Ід. статусу';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.ERR_TEXT IS 'Текст помилки';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.ERR_COUNT IS 'Кіл-ть спроб з помилкою';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.MESSAGE_ID IS 'Ід. повідомлення';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.MESSAGE_DATE IS 'Дата відправки повідомлення';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.MESSAGE IS 'Текст повідомлення';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.RESPONCE_ID IS 'Ід. відповіді';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.RESPONCE_DATE IS 'Дата відповіді';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.RESPONCE IS 'Текст відповіді';
COMMENT ON COLUMN BARS.EAD_SYNC_QUEUE.KF IS 'МФО';



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



PROMPT *** Create  constraint FK_EADSYNCQ_STSID_STATUSES ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_QUEUE ADD CONSTRAINT FK_EADSYNCQ_STSID_STATUSES FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.EAD_STATUSES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/



PROMPT *** Drop  constraint FK_EADSYNCQ_TID_TYPES ***
begin   
  execute immediate 'ALTER TABLE BARS.EAD_SYNC_QUEUE DROP CONSTRAINT FK_EADSYNCQ_TID_TYPES';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-2443 then null; else raise; end if;
end;
/

PROMPT *** Create  constraint FK_EADSYNCQ_TID_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_SYNC_QUEUE ADD CONSTRAINT FK_EADSYNCQ_TID_TYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.EAD_TYPES (ID) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
end;
/


PROMPT *** Create  index I_EADSYNCQUEUE_TYPE_OBJ ***
begin
  for i in (select 1 from dual where not exists (select 1 from user_indexes where index_name = 'I_EADSYNCQUEUE_TYPE_OBJ')) loop
    execute immediate '
      CREATE INDEX BARS.I_EADSYNCQUEUE_TYPE_OBJ ON BARS.EAD_SYNC_QUEUE (TYPE_ID, OBJ_ID) 
      TABLESPACE BRSBIGI  LOCAL (PARTITION P_FIRST TABLESPACE BRSBIGI ) ';
  end loop;
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



PROMPT *** Create  grants  EAD_SYNC_QUEUE ***
grant SELECT on EAD_SYNC_QUEUE  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_SYNC_QUEUE.sql =========*** End **
PROMPT ===================================================================================== 
