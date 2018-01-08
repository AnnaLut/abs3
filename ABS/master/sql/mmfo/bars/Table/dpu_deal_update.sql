

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_DEAL_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_DEAL_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_DEAL_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPU_DEAL_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPU_DEAL_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_DEAL_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_DEAL_UPDATE 
   (	IDU NUMBER(38,0), 
	USERU NUMBER(38,0), 
	DATEU DATE, 
	TYPEU NUMBER(1,0), 
	DPU_ID NUMBER(38,0), 
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
	CLOSED NUMBER(1,0), 
	COMPROC NUMBER(1,0), 
	DPU_GEN NUMBER(38,0), 
	DPU_ADD NUMBER(38,0), 
	MIN_SUM NUMBER(24,0), 
	ID_STOP NUMBER(38,0), 
	BRANCH VARCHAR2(30) DEFAULT NULL, 
	TRUSTEE_ID NUMBER(38,0), 
	ACC2 NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT NULL, 
	BDATE DATE, 
	CNT_DUBL NUMBER(10,0), 
	OKPO_P VARCHAR2(14), 
	EFFECTDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_DEAL_UPDATE ***
 exec bpa.alter_policies('DPU_DEAL_UPDATE');


COMMENT ON TABLE BARS.DPU_DEAL_UPDATE IS 'Архив изменений депозитного портфеля ЮЛ';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.IDU IS 'Идентификатор изменения';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.USERU IS 'Код пользователя';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.DATEU IS 'Дата изменения';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.TYPEU IS 'Тип изменения';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.DPU_ID IS 'Идентификатор договора';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.ND IS 'Номер договора';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.VIDD IS 'Код вида депозитного договора';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.RNK IS 'Рег.№ клиента';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.ACC IS 'Основной счет';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.USER_ID IS 'Инспектор договора';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.FREQV IS 'Периодичность выплаты %%';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.SUM IS 'Сумма договора';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.DAT_BEGIN IS 'Дата начала договора';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.DAT_END IS 'Дата окончания договора';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.DATZ IS 'Дата заключения договора';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.DATV IS 'Дата возврата договора';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.MFO_D IS 'МФО для возврата депозита';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.NLS_D IS 'Счет для возврата депозита';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.NMS_D IS 'Получатель для возврата депозита';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.MFO_P IS 'МФО для выплаты %%';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.NLS_P IS 'Счет для выплаты %%';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.NMS_P IS 'Получатель для выплаты %%';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.COMMENTS IS 'Коментарий';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.CLOSED IS 'Флаг активности';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.COMPROC IS 'Флаг капитализации %%';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.DPU_GEN IS 'Референс генерального договора';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.DPU_ADD IS '№ доп.соглашения';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.MIN_SUM IS 'Неснижаемый остаток';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.ID_STOP IS 'Код штрафа';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.TRUSTEE_ID IS 'Идентификатор ответ.лица клиента';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.ACC2 IS 'АСС счета до востребования (для комб.вкладов)';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.BDATE IS 'Банківська дата змін параметрів договору';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.CNT_DUBL IS 'Порядковий номер пролонгації договору';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.OKPO_P IS 'Код ЄДРПОУ для виплати відсотків';
COMMENT ON COLUMN BARS.DPU_DEAL_UPDATE.EFFECTDATE IS 'банковская дата изменения';




PROMPT *** Create  constraint CC_DPUDEALUPD_TYPEU ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT CC_DPUDEALUPD_TYPEU CHECK (typeu in (0,1,2,3,4,9)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUDEALUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT PK_DPUDEALUPD PRIMARY KEY (IDU)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_CLOSED ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT CC_DPUDEALUPD_CLOSED CHECK (closed in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_COMPROC ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE ADD CONSTRAINT CC_DPUDEALUPD_COMPROC CHECK (comproc in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_IDU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (IDU CONSTRAINT CC_DPUDEALUPD_IDU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_USERU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (USERU CONSTRAINT CC_DPUDEALUPD_USERU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_DATEU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (DATEU CONSTRAINT CC_DPUDEALUPD_DATEU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_TYPEU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (TYPEU CONSTRAINT CC_DPUDEALUPD_TYPEU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_DPUID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (DPU_ID CONSTRAINT CC_DPUDEALUPD_DPUID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (VIDD CONSTRAINT CC_DPUDEALUPD_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (RNK CONSTRAINT CC_DPUDEALUPD_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (ACC CONSTRAINT CC_DPUDEALUPD_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (USER_ID CONSTRAINT CC_DPUDEALUPD_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_FREQV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (FREQV CONSTRAINT CC_DPUDEALUPD_FREQV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_DATBEGIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (DAT_BEGIN CONSTRAINT CC_DPUDEALUPD_DATBEGIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_DATZ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (DATZ CONSTRAINT CC_DPUDEALUPD_DATZ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_CLOSED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (CLOSED CONSTRAINT CC_DPUDEALUPD_CLOSED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_COMPROC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (COMPROC CONSTRAINT CC_DPUDEALUPD_COMPROC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_IDSTOP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (ID_STOP CONSTRAINT CC_DPUDEALUPD_IDSTOP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (BRANCH CONSTRAINT CC_DPUDEALUPD_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_TRUSTEEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (TRUSTEE_ID CONSTRAINT CC_DPUDEALUPD_TRUSTEEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (KF CONSTRAINT CC_DPUDEALUPD_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALUPD_BDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEAL_UPDATE MODIFY (BDATE CONSTRAINT CC_DPUDEALUPD_BDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUDEALUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUDEALUPD ON BARS.DPU_DEAL_UPDATE (IDU) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPUDEALUPD_DPUID_BDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPUDEALUPD_DPUID_BDATE ON BARS.DPU_DEAL_UPDATE (DPU_ID, BDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPUDEALUPD_EFFECTDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPUDEALUPD_EFFECTDATE ON BARS.DPU_DEAL_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_DEAL_UPDATE ***
grant SELECT                                                                 on DPU_DEAL_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on DPU_DEAL_UPDATE to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEAL_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_DEAL_UPDATE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEAL_UPDATE to DPT_ROLE;
grant SELECT                                                                 on DPU_DEAL_UPDATE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_DEAL_UPDATE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_DEAL_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
