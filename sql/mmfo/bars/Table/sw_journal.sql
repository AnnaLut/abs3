

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_JOURNAL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_JOURNAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_JOURNAL'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_JOURNAL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_JOURNAL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_JOURNAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_JOURNAL 
   (	SWREF NUMBER(38,0), 
	MT NUMBER(38,0), 
	TRN VARCHAR2(16), 
	IO_IND CHAR(1), 
	CURRENCY CHAR(3), 
	SENDER CHAR(11), 
	RECEIVER CHAR(11), 
	PAYER VARCHAR2(35), 
	PAYEE VARCHAR2(35), 
	AMOUNT NUMBER(24,0) DEFAULT 0, 
	ACCD NUMBER(38,0), 
	ACCK NUMBER(38,0), 
	DATE_IN DATE DEFAULT sysdate, 
	DATE_OUT DATE, 
	DATE_PAY DATE, 
	DATE_REC DATE, 
	VDATE DATE DEFAULT trunc(sysdate), 
	ID NUMBER(38,0), 
	PAGE VARCHAR2(30), 
	TRANSIT VARCHAR2(200), 
	FLAGS VARCHAR2(3), 
	SOS NUMBER(3,0) DEFAULT 0, 
	LAU VARCHAR2(8), 
	LAU_FLAG NUMBER(1,0), 
	LAU_UID NUMBER(38,0), 
	LAU_ACT NUMBER(1,0), 
	IMPORTED CHAR(1) DEFAULT ''N'', 
	APP_FLAG VARCHAR2(5), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''),
        COUNT_SEND_SMS NUMBER 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/



begin
execute immediate 'alter table bars.sw_journal add count_send_sms number';
exception when others then if (sqlcode=-1430) then null; else raise; end if;
end;
/



PROMPT *** ALTER_POLICIES to SW_JOURNAL ***
 exec bpa.alter_policies('SW_JOURNAL');


COMMENT ON TABLE BARS.SW_JOURNAL IS 'SWT. Сообщения';
COMMENT ON COLUMN BARS.SW_JOURNAL.SWREF IS 'Референс сообщения';
COMMENT ON COLUMN BARS.SW_JOURNAL.MT IS 'Код типа сообщения';
COMMENT ON COLUMN BARS.SW_JOURNAL.TRN IS 'SWIFT референс сообщения';
COMMENT ON COLUMN BARS.SW_JOURNAL.IO_IND IS 'Тип сообщения Входящее/Исходящее';
COMMENT ON COLUMN BARS.SW_JOURNAL.CURRENCY IS 'Валюта сообщения';
COMMENT ON COLUMN BARS.SW_JOURNAL.SENDER IS 'Код отправителя';
COMMENT ON COLUMN BARS.SW_JOURNAL.RECEIVER IS 'Код получателя';
COMMENT ON COLUMN BARS.SW_JOURNAL.PAYER IS 'Плательщик';
COMMENT ON COLUMN BARS.SW_JOURNAL.PAYEE IS 'Получатель';
COMMENT ON COLUMN BARS.SW_JOURNAL.AMOUNT IS 'Сумма сообщения';
COMMENT ON COLUMN BARS.SW_JOURNAL.ACCD IS 'Код счета дебета';
COMMENT ON COLUMN BARS.SW_JOURNAL.ACCK IS 'Код счета кредита';
COMMENT ON COLUMN BARS.SW_JOURNAL.DATE_IN IS 'Дата поступления';
COMMENT ON COLUMN BARS.SW_JOURNAL.DATE_OUT IS 'Дата отправления';
COMMENT ON COLUMN BARS.SW_JOURNAL.DATE_PAY IS 'Дата оплаты в АБС';
COMMENT ON COLUMN BARS.SW_JOURNAL.DATE_REC IS 'Дата записи';
COMMENT ON COLUMN BARS.SW_JOURNAL.VDATE IS 'Дата валютирования';
COMMENT ON COLUMN BARS.SW_JOURNAL.ID IS 'Код пользователя, на которого распределено сообщение';
COMMENT ON COLUMN BARS.SW_JOURNAL.PAGE IS 'Часть';
COMMENT ON COLUMN BARS.SW_JOURNAL.TRANSIT IS '';
COMMENT ON COLUMN BARS.SW_JOURNAL.FLAGS IS 'Флаги сообщения';
COMMENT ON COLUMN BARS.SW_JOURNAL.SOS IS 'Состояние сообщения';
COMMENT ON COLUMN BARS.SW_JOURNAL.LAU IS 'Контрольная сумма на сообщении (LAU)';
COMMENT ON COLUMN BARS.SW_JOURNAL.LAU_FLAG IS 'Флаг проверки корректности (LAU)';
COMMENT ON COLUMN BARS.SW_JOURNAL.LAU_UID IS 'Код пользователя изменившего обработку сообщения';
COMMENT ON COLUMN BARS.SW_JOURNAL.LAU_ACT IS 'Признак обработки сообщения';
COMMENT ON COLUMN BARS.SW_JOURNAL.IMPORTED IS 'Признак импортированного сообщения';
COMMENT ON COLUMN BARS.SW_JOURNAL.APP_FLAG IS 'Флаги сообщения SWIFT';
COMMENT ON COLUMN BARS.SW_JOURNAL.KF IS '';
comment on column sw_journal.count_send_sms is 'Відправка смс';




PROMPT *** Create  constraint UK_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT UK_SWJOURNAL UNIQUE (MT, IO_IND, TRN, SENDER, RECEIVER, CURRENCY, VDATE, PAGE, AMOUNT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_MT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT CC_SWJOURNAL_MT CHECK (mt between 100 and 999 or mt = 2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK2_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT UK2_SWJOURNAL UNIQUE (KF, SWREF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWJOURNAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT PK_SWJOURNAL PRIMARY KEY (SWREF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_IOIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT CC_SWJOURNAL_IOIND CHECK (io_ind in (''I'', ''O'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_FLAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT CC_SWJOURNAL_FLAGS CHECK (flags in (''L'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_LAUACT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT CC_SWJOURNAL_LAUACT CHECK (lau_act in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_IMPORTED ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT CC_SWJOURNAL_IMPORTED CHECK (imported in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL ADD CONSTRAINT CC_SWJOURNAL_SOS CHECK (sos in (0, -2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_SWREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (SWREF CONSTRAINT CC_SWJOURNAL_SWREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_TRN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (TRN CONSTRAINT CC_SWJOURNAL_TRN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_IOIND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (IO_IND CONSTRAINT CC_SWJOURNAL_IOIND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_SENDER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (SENDER CONSTRAINT CC_SWJOURNAL_SENDER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_RECEIVER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (RECEIVER CONSTRAINT CC_SWJOURNAL_RECEIVER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_AMOUNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (AMOUNT CONSTRAINT CC_SWJOURNAL_AMOUNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_DATEIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (DATE_IN CONSTRAINT CC_SWJOURNAL_DATEIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_VDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (VDATE CONSTRAINT CC_SWJOURNAL_VDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_PAGE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (PAGE CONSTRAINT CC_SWJOURNAL_PAGE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_SOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (SOS CONSTRAINT CC_SWJOURNAL_SOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_LAUACT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (LAU_ACT CONSTRAINT CC_SWJOURNAL_LAUACT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_IMPORTED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (IMPORTED CONSTRAINT CC_SWJOURNAL_IMPORTED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_APPFLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (APP_FLAG CONSTRAINT CC_SWJOURNAL_APPFLAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (KF CONSTRAINT CC_SWJOURNAL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWJOURNAL_MT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_JOURNAL MODIFY (MT CONSTRAINT CC_SWJOURNAL_MT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SWJOURNAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SWJOURNAL ON BARS.SW_JOURNAL (MT, IO_IND, TRN, SENDER, RECEIVER, CURRENCY, VDATE, PAGE, AMOUNT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK2_SWJOURNAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK2_SWJOURNAL ON BARS.SW_JOURNAL (KF, SWREF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I7_SWJOURNAL ***
begin   
 execute immediate '
  CREATE INDEX BARS.I7_SWJOURNAL ON BARS.SW_JOURNAL (DATE_PAY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_SWJOURNAL_TRN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_SWJOURNAL_TRN ON BARS.SW_JOURNAL (TRN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWJOURNAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWJOURNAL ON BARS.SW_JOURNAL (SWREF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_SWJOURNAL ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_SWJOURNAL ON BARS.SW_JOURNAL (FLAGS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I5_SWJOURNAL ***
begin   
 execute immediate '
  CREATE INDEX BARS.I5_SWJOURNAL ON BARS.SW_JOURNAL (VDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_JOURNAL ***
grant SELECT,UPDATE                                                          on SW_JOURNAL      to BARS013;
grant SELECT                                                                 on SW_JOURNAL      to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on SW_JOURNAL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_JOURNAL      to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on SW_JOURNAL      to FOREX;
grant SELECT                                                                 on SW_JOURNAL      to START1;
grant SELECT,UPDATE                                                          on SW_JOURNAL      to SWTOSS;
grant SELECT                                                                 on SW_JOURNAL      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_JOURNAL      to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_JOURNAL ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_JOURNAL FOR BARS.SW_JOURNAL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_JOURNAL.sql =========*** End *** ==
PROMPT ===================================================================================== 




