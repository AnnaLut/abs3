

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_DEPOSIT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_DEPOSIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_DEPOSIT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_DEPOSIT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_DEPOSIT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_DEPOSIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_DEPOSIT 
   (	DEPOSIT_ID NUMBER(38,0), 
	VIDD NUMBER(38,0), 
	ACC NUMBER(38,0), 
	KV NUMBER(3,0), 
	RNK NUMBER(38,0), 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	COMMENTS VARCHAR2(128), 
	MFO_P VARCHAR2(12), 
	NLS_P VARCHAR2(15), 
	LIMIT NUMBER(24,0), 
	DEPOSIT_COD VARCHAR2(4), 
	NAME_P VARCHAR2(128), 
	DATZ DATE, 
	OKPO_P VARCHAR2(14), 
	DAT_EXT_INT DATE, 
	CNT_DUBL NUMBER(10,0), 
	CNT_EXT_INT NUMBER(10,0), 
	FREQ NUMBER(3,0), 
	ND VARCHAR2(35), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	STATUS NUMBER(1,0), 
	DPT_D NUMBER(38,0), 
	ACC_D NUMBER(38,0), 
	MFO_D VARCHAR2(12), 
	NLS_D VARCHAR2(15), 
	NMS_D VARCHAR2(38), 
	OKPO_D VARCHAR2(14), 
	DAT_END_ALT DATE, 
	STOP_ID NUMBER(38,0) DEFAULT 0, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	USERID NUMBER(38,0), 
	ARCHDOC_ID NUMBER(38,0) DEFAULT -1, 
	FORBID_EXTENSION NUMBER(1,0), 
	WB CHAR(1) DEFAULT ''N''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_DEPOSIT ***
 exec bpa.alter_policies('DPT_DEPOSIT');


COMMENT ON TABLE BARS.DPT_DEPOSIT IS 'Депозитный портфель ФЛ';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.WB IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.DEPOSIT_ID IS '№ депозита';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.VIDD IS 'Вид вклада';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.ACC IS 'Внутр. номер осн. счета';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.RNK IS 'Рег.№ вкладчика';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.DAT_BEGIN IS 'Дата начала вклада';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.DAT_END IS 'Дата окончания вклада';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.COMMENTS IS 'Комментраии';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.MFO_P IS 'МФО для выплаты %%';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.NLS_P IS 'Счет для выплаты %%';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.LIMIT IS 'Лимит';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.DEPOSIT_COD IS 'Код договора';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.NAME_P IS 'Получатель  %%';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.DATZ IS 'Дата заключ.вклада';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.OKPO_P IS 'ОКПО для выплаты %%';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.DAT_EXT_INT IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.CNT_DUBL IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.CNT_EXT_INT IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.FREQ IS 'Периодичность выплаты %%';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.ND IS '№ депозитного договора (альтернативный)';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.STATUS IS 'Состояние договора (0-активный, 9-не подписан, -1 - closed (да, вот такая логика!))';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.DPT_D IS '№ техн.вклада';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.ACC_D IS 'Внутр.номер техн.счета';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.MFO_D IS 'МФО техн.счета';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.NLS_D IS 'Техн.счет';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.NMS_D IS 'Наименование техн.счета';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.OKPO_D IS 'Идент.код техн.счета';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.DAT_END_ALT IS 'План.дата закрытия техн.счета';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.STOP_ID IS 'Код штрафа за досрочное расторжение';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.KF IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.USERID IS 'Пользователь-инициатор открытия вклада';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.ARCHDOC_ID IS 'Ідентифікатор депозитного договору в ЕАД';
COMMENT ON COLUMN BARS.DPT_DEPOSIT.FORBID_EXTENSION IS '';




PROMPT *** Create  constraint PK_DPTDEPOSIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT PK_DPTDEPOSIT PRIMARY KEY (DEPOSIT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPTDEPOSIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT UK_DPTDEPOSIT UNIQUE (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSIT_ARCHDOCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT MODIFY (ARCHDOC_ID CONSTRAINT CC_DPTDEPOSIT_ARCHDOCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSIT_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT MODIFY (USERID CONSTRAINT CC_DPTDEPOSIT_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSIT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT MODIFY (KF CONSTRAINT CC_DPTDEPOSIT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSIT_STOPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT MODIFY (STOP_ID CONSTRAINT CC_DPTDEPOSIT_STOPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSIT_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT MODIFY (BRANCH CONSTRAINT CC_DPTDEPOSIT_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSIT_FREQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT MODIFY (FREQ CONSTRAINT CC_DPTDEPOSIT_FREQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSIT_DATZ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT MODIFY (DATZ CONSTRAINT CC_DPTDEPOSIT_DATZ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSIT_DATBEGIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT MODIFY (DAT_BEGIN CONSTRAINT CC_DPTDEPOSIT_DATBEGIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSIT_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT MODIFY (RNK CONSTRAINT CC_DPTDEPOSIT_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSIT_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT MODIFY (KV CONSTRAINT CC_DPTDEPOSIT_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSIT_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT MODIFY (ACC CONSTRAINT CC_DPTDEPOSIT_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSIT_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT MODIFY (VIDD CONSTRAINT CC_DPTDEPOSIT_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSIT_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT MODIFY (DEPOSIT_ID CONSTRAINT CC_DPTDEPOSIT_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_DPTDPTALL2 FOREIGN KEY (KF, DEPOSIT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_DPTSTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_DPTSTOP FOREIGN KEY (STOP_ID)
	  REFERENCES BARS.DPT_STOP (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_FREQ FOREIGN KEY (FREQ)
	  REFERENCES BARS.FREQ (FREQ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_BANKS FOREIGN KEY (MFO_P)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_BANKS2 FOREIGN KEY (MFO_D)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_DPTDEPOSIT2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_DPTDEPOSIT2 FOREIGN KEY (KF, DPT_D)
	  REFERENCES BARS.DPT_DEPOSIT (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK2_DPTDEPOSIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT UK2_DPTDEPOSIT UNIQUE (KF, DEPOSIT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPT_DEPOSIT_DPT_D ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPT_DEPOSIT_DPT_D FOREIGN KEY (DPT_D)
	  REFERENCES BARS.DPT_DEPOSIT (DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_ACCOUNTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_ACCOUNTS2 FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSIT_ACCOUNTS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT ADD CONSTRAINT FK_DPTDEPOSIT_ACCOUNTS3 FOREIGN KEY (KF, ACC_D)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I6_DPTDEPOSIT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I6_DPTDEPOSIT ON BARS.DPT_DEPOSIT (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK2_DPTDEPOSIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK2_DPTDEPOSIT ON BARS.DPT_DEPOSIT (KF, DEPOSIT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I5_DPTDEPOSIT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I5_DPTDEPOSIT ON BARS.DPT_DEPOSIT (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I4_DPTDEPOSIT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I4_DPTDEPOSIT ON BARS.DPT_DEPOSIT (DAT_END) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTDEPOSIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTDEPOSIT ON BARS.DPT_DEPOSIT (DEPOSIT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTDEPOSIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTDEPOSIT ON BARS.DPT_DEPOSIT (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_DPTDEPOSIT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_DPTDEPOSIT ON BARS.DPT_DEPOSIT (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_DPTDEPOSIT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_DPTDEPOSIT ON BARS.DPT_DEPOSIT (VIDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_DEPOSIT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT     to ABS_ADMIN;
grant SELECT                                                                 on DPT_DEPOSIT     to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_DEPOSIT     to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on DPT_DEPOSIT     to BARS_DM;
grant SELECT                                                                 on DPT_DEPOSIT     to CC_DOC;
grant SELECT                                                                 on DPT_DEPOSIT     to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT     to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT     to DPT_ADMIN;
grant SELECT                                                                 on DPT_DEPOSIT     to DPT_ROLE;
grant SELECT                                                                 on DPT_DEPOSIT     to KLBX;
grant SELECT                                                                 on DPT_DEPOSIT     to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT     to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_DEPOSIT     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_DEPOSIT     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_DEPOSIT.sql =========*** End *** =
PROMPT ===================================================================================== 
