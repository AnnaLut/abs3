

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SYNC_QUEUE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SYNC_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SYNC_QUEUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SYNC_QUEUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SYNC_QUEUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SYNC_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SYNC_QUEUE 
   (	ID NUMBER, 
	TYPE_ID VARCHAR2(100), 
	STATUS_ID VARCHAR2(100), 
	CRT_DATE DATE DEFAULT sysdate, 
	CRT_STAFF_ID NUMBER DEFAULT sys_context(''bars_context'', ''user_id''), 
	DS_ID VARCHAR2(6), 
	PARAMS BARS.T_WCS_SYNC_PARAMS , 
	FAILURES NUMBER DEFAULT 0, 
	ERROR_MESSAGE VARCHAR2(2000)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSDYND 
  PARTITION BY RANGE (CRT_DATE) INTERVAL (NUMTOYMINTERVAL(4,''MONTH'')) STORE IN (BRSBIGD) 
 (PARTITION P_WCSSYNCQUEUE_FIRST  VALUES LESS THAN (TO_DATE('' 2014-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSDYND ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SYNC_QUEUE ***
 exec bpa.alter_policies('WCS_SYNC_QUEUE');


COMMENT ON TABLE BARS.WCS_SYNC_QUEUE IS 'Журнал синхронизации';
COMMENT ON COLUMN BARS.WCS_SYNC_QUEUE.ID IS 'Идентификатор записи';
COMMENT ON COLUMN BARS.WCS_SYNC_QUEUE.TYPE_ID IS 'Тип синхронизации';
COMMENT ON COLUMN BARS.WCS_SYNC_QUEUE.STATUS_ID IS 'Идентификатор статуса';
COMMENT ON COLUMN BARS.WCS_SYNC_QUEUE.CRT_DATE IS 'Дата создания записи';
COMMENT ON COLUMN BARS.WCS_SYNC_QUEUE.CRT_STAFF_ID IS 'Ид. пользователя создавшего запись';
COMMENT ON COLUMN BARS.WCS_SYNC_QUEUE.DS_ID IS 'Ид. источника';
COMMENT ON COLUMN BARS.WCS_SYNC_QUEUE.PARAMS IS 'Параметры';
COMMENT ON COLUMN BARS.WCS_SYNC_QUEUE.FAILURES IS 'Кол-во сбойных попыток';
COMMENT ON COLUMN BARS.WCS_SYNC_QUEUE.ERROR_MESSAGE IS 'Текст ошибки';




PROMPT *** Create  constraint CC_WCSSYNCQUEUE_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_QUEUE MODIFY (TYPE_ID CONSTRAINT CC_WCSSYNCQUEUE_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSYNCQUEUE_STSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_QUEUE MODIFY (STATUS_ID CONSTRAINT CC_WCSSYNCQUEUE_STSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSSYNCQUEUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_QUEUE ADD CONSTRAINT PK_WCSSYNCQUEUE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSYNCQUEUE_PARAMS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_QUEUE MODIFY (PARAMS CONSTRAINT CC_WCSSYNCQUEUE_PARAMS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSYNCQUEUE_FLRS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_QUEUE MODIFY (FAILURES CONSTRAINT CC_WCSSYNCQUEUE_FLRS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSYNCQUEUE_DSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_QUEUE MODIFY (DS_ID CONSTRAINT CC_WCSSYNCQUEUE_DSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSYNCQUEUE_CRTSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_QUEUE MODIFY (CRT_STAFF_ID CONSTRAINT CC_WCSSYNCQUEUE_CRTSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSYNCQUEUE_CRTD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_QUEUE MODIFY (CRT_DATE CONSTRAINT CC_WCSSYNCQUEUE_CRTD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSSYNCQUEUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSSYNCQUEUE ON BARS.WCS_SYNC_QUEUE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SYNC_QUEUE ***
grant INSERT,SELECT,UPDATE                                                   on WCS_SYNC_QUEUE  to WCS_SYNC_USER;



PROMPT *** Create SYNONYM  to WCS_SYNC_QUEUE ***

  CREATE OR REPLACE PUBLIC SYNONYM WCS_SYNC_QUEUE FOR BARS.WCS_SYNC_QUEUE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SYNC_QUEUE.sql =========*** End **
PROMPT ===================================================================================== 
