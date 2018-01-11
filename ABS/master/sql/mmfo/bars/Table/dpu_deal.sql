

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_DEAL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_DEAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_DEAL'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPU_DEAL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPU_DEAL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_DEAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_DEAL 
   (	DPU_ID NUMBER(38,0), 
	ND VARCHAR2(35), 
	VIDD NUMBER(38,0), 
	RNK NUMBER(38,0), 
	ACC NUMBER(38,0), 
	USER_ID NUMBER(38,0), 
	FREQV NUMBER(3,0), 
	SUM NUMBER(24,0), 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	DATZ DATE, 
	DATV DATE, 
	MFO_D VARCHAR2(12), 
	NLS_D VARCHAR2(15), 
	NMS_D VARCHAR2(38), 
	MFO_P VARCHAR2(12), 
	NLS_P VARCHAR2(15), 
	NMS_P VARCHAR2(38), 
	COMMENTS VARCHAR2(128), 
	CLOSED NUMBER(1,0) DEFAULT 0, 
	COMPROC NUMBER(1,0) DEFAULT 0, 
	DPU_GEN NUMBER(38,0), 
	DPU_ADD NUMBER(38,0), 
	MIN_SUM NUMBER(24,0), 
	ID_STOP NUMBER(38,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	TRUSTEE_ID NUMBER(38,0) DEFAULT 0, 
	ACC2 NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	CNT_DUBL NUMBER(10,0), 
	OKPO_P VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_DEAL ***
 exec bpa.alter_policies('DPU_DEAL');


COMMENT ON TABLE BARS.DPU_DEAL IS 'Портфель депозитов ЮЛ';
COMMENT ON COLUMN BARS.DPU_DEAL.DPU_ID IS 'Идентификатор договора';
COMMENT ON COLUMN BARS.DPU_DEAL.ND IS 'Номер договора';
COMMENT ON COLUMN BARS.DPU_DEAL.VIDD IS 'Код вида депозитного договора';
COMMENT ON COLUMN BARS.DPU_DEAL.RNK IS 'Рег.№ клиента';
COMMENT ON COLUMN BARS.DPU_DEAL.ACC IS 'Основной счет';
COMMENT ON COLUMN BARS.DPU_DEAL.USER_ID IS 'Инспектор договора';
COMMENT ON COLUMN BARS.DPU_DEAL.FREQV IS 'Периодичность выплаты %%';
COMMENT ON COLUMN BARS.DPU_DEAL.SUM IS 'Сумма договора';
COMMENT ON COLUMN BARS.DPU_DEAL.DAT_BEGIN IS 'Дата начала договора';
COMMENT ON COLUMN BARS.DPU_DEAL.DAT_END IS 'Дата окончания договора';
COMMENT ON COLUMN BARS.DPU_DEAL.DATZ IS 'Дата заключения договора';
COMMENT ON COLUMN BARS.DPU_DEAL.DATV IS 'Дата возврата договора';
COMMENT ON COLUMN BARS.DPU_DEAL.MFO_D IS 'МФО для возврата депозита';
COMMENT ON COLUMN BARS.DPU_DEAL.NLS_D IS 'Счет для возврата депозита';
COMMENT ON COLUMN BARS.DPU_DEAL.NMS_D IS 'Получатель для возврата депозита';
COMMENT ON COLUMN BARS.DPU_DEAL.MFO_P IS 'МФО для выплаты %%';
COMMENT ON COLUMN BARS.DPU_DEAL.NLS_P IS 'Счет для выплаты %%';
COMMENT ON COLUMN BARS.DPU_DEAL.NMS_P IS 'Получатель для выплаты %%';
COMMENT ON COLUMN BARS.DPU_DEAL.COMMENTS IS 'Коментарий';
COMMENT ON COLUMN BARS.DPU_DEAL.CLOSED IS 'Флаг активности';
COMMENT ON COLUMN BARS.DPU_DEAL.COMPROC IS 'Флаг капитализации %%';
COMMENT ON COLUMN BARS.DPU_DEAL.DPU_GEN IS 'Референс генерального договора';
COMMENT ON COLUMN BARS.DPU_DEAL.DPU_ADD IS '№ доп.соглашения';
COMMENT ON COLUMN BARS.DPU_DEAL.MIN_SUM IS 'Неснижаемый остаток';
COMMENT ON COLUMN BARS.DPU_DEAL.ID_STOP IS 'Код штрафа';
COMMENT ON COLUMN BARS.DPU_DEAL.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.DPU_DEAL.TRUSTEE_ID IS 'Идентификатор дов.лица';
COMMENT ON COLUMN BARS.DPU_DEAL.ACC2 IS 'АСС счета до востребования (для комб.вкладов)';
COMMENT ON COLUMN BARS.DPU_DEAL.KF IS '';
COMMENT ON COLUMN BARS.DPU_DEAL.CNT_DUBL IS '';
COMMENT ON COLUMN BARS.DPU_DEAL.OKPO_P IS 'Код ЄДРПОУ для виплати відсотків';




PROMPT *** Create  constraint CC_DPUDEAL_TRUSTEEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (TRUSTEE_ID CONSTRAINT CC_DPUDEAL_TRUSTEEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_DATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT CC_DPUDEAL_DATES CHECK (
     datz <= dat_begin
 AND
    (
       (dat_end IS NULL AND datv IS NULL)
     OR
       (dat_begin < dat_end AND dat_end <= datv)
    )
  ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT PK_DPUDEAL PRIMARY KEY (DPU_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_CLOSED ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT CC_DPUDEAL_CLOSED CHECK (closed in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_COMPROC ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT CC_DPUDEAL_COMPROC CHECK (comproc in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPUDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL ADD CONSTRAINT UK_DPUDEAL UNIQUE (KF, DPU_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_DPUID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (DPU_ID CONSTRAINT CC_DPUDEAL_DPUID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (ND CONSTRAINT CC_DPUDEAL_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (VIDD CONSTRAINT CC_DPUDEAL_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (RNK CONSTRAINT CC_DPUDEAL_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (ACC CONSTRAINT CC_DPUDEAL_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (USER_ID CONSTRAINT CC_DPUDEAL_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_FREQV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (FREQV CONSTRAINT CC_DPUDEAL_FREQV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_DATBEGIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (DAT_BEGIN CONSTRAINT CC_DPUDEAL_DATBEGIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_DATZ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (DATZ CONSTRAINT CC_DPUDEAL_DATZ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_CLOSED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (CLOSED CONSTRAINT CC_DPUDEAL_CLOSED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_COMPROC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (COMPROC CONSTRAINT CC_DPUDEAL_COMPROC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_IDSTOP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (ID_STOP CONSTRAINT CC_DPUDEAL_IDSTOP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (BRANCH CONSTRAINT CC_DPUDEAL_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEAL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL MODIFY (KF CONSTRAINT CC_DPUDEAL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUDEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUDEAL ON BARS.DPU_DEAL (DPU_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPUDEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPUDEAL ON BARS.DPU_DEAL (KF, DPU_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I4_DPUDEAL ***
begin   
 execute immediate '
  CREATE INDEX BARS.I4_DPUDEAL ON BARS.DPU_DEAL (DAT_END, CLOSED) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK2_DPUDEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK2_DPUDEAL ON BARS.DPU_DEAL (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_DPUDEAL ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_DPUDEAL ON BARS.DPU_DEAL (NVL(DPU_GEN,0)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_DEAL ***
grant SELECT                                                                 on DPU_DEAL        to BARSREADER_ROLE;
grant SELECT                                                                 on DPU_DEAL        to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEAL        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_DEAL        to BARS_DM;
grant SELECT                                                                 on DPU_DEAL        to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEAL        to DPT_ROLE;
grant SELECT                                                                 on DPU_DEAL        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_DEAL        to WR_ALL_RIGHTS;
grant SELECT,UPDATE                                                          on DPU_DEAL        to WR_DEPOSIT_U;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_DEAL.sql =========*** End *** ====
PROMPT ===================================================================================== 
