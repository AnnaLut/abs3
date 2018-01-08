

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_AGREEMENTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_AGREEMENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_AGREEMENTS'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_AGREEMENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_AGREEMENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_AGREEMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_AGREEMENTS 
   (	AGRMNT_ID NUMBER(38,0), 
	AGRMNT_DATE DATE, 
	AGRMNT_NUM NUMBER(10,0), 
	AGRMNT_TYPE NUMBER(38,0), 
	DPT_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
	CUST_ID NUMBER(38,0), 
	BANKDATE DATE, 
	TEMPLATE_ID VARCHAR2(35), 
	TRUSTEE_ID NUMBER(38,0), 
	TRANSFER_BANK VARCHAR2(12), 
	TRANSFER_ACCOUNT VARCHAR2(14), 
	AMOUNT_CASH NUMBER(38,0), 
	AMOUNT_CASHLESS NUMBER(38,0), 
	AMOUNT_INTEREST NUMBER(38,0), 
	DATE_BEGIN DATE, 
	DATE_END DATE, 
	DENOM_AMOUNT NUMBER(38,0), 
	DENOM_COUNT NUMBER(38,0), 
	DENOM_REF NUMBER(38,0), 
	AGRMNT_STATE NUMBER(1,0), 
	COMISS_REF NUMBER(38,0), 
	UNDO_ID NUMBER(38,0), 
	TRANSFDPT CLOB, 
	TRANSFINT CLOB, 
	DOC_REF NUMBER(38,0), 
	RATE_REQID NUMBER(38,0), 
	COMISS_REQID NUMBER(38,0), 
	RATE_VALUE NUMBER(30,8), 
	RATE_DATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (TRANSFDPT) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (TRANSFINT) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_AGREEMENTS ***
 exec bpa.alter_policies('DPT_AGREEMENTS');


COMMENT ON TABLE BARS.DPT_AGREEMENTS IS 'Хранилище дополнительных соглашений (ДС) к деп.договорам ФЛ';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.TRANSFER_ACCOUNT IS 'Номер счета для перечисления депозита и процентов';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AMOUNT_CASH IS 'Сумма наличными (ДС об изменении суммы вклада)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AMOUNT_CASHLESS IS 'Сумма безналичными (ДС об изменении суммы вклада)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AMOUNT_INTEREST IS 'Сумма процентов к выплате (ДС об изменении суммы вклада)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.DATE_BEGIN IS 'Новая дата начала вклада (ДС об изменении сроков) или Дата начала действия доверенности';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.DATE_END IS 'Новая дата окончания вклада (ДС об изменении сроков) или Дата окончания действия доверенности';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.DENOM_AMOUNT IS 'Общая сумма ветхих купюр (ДС о приеме ветхих купюр)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.DENOM_COUNT IS 'Сумма комиссии при досрочном расторжении (ДС о приеме ветхих купюр)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.DENOM_REF IS 'Реф.док-та по взысканию комисии (ДС о приеме ветхих купюр)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AGRMNT_STATE IS 'Статус ДС: активн./аннулир.';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.COMISS_REF IS 'Референс документа - комиссии за оформление ДС';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.UNDO_ID IS 'Ид. доп. соглашения, которое отменило данное';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.TRANSFDPT IS 'Счета перечисления депозита';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.TRANSFINT IS 'Счета перечисления процентов';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.DOC_REF IS 'Референс документов пополнения / частичного снятия';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.RATE_REQID IS 'Коз запроса на изменение ставки';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.COMISS_REQID IS '';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.RATE_VALUE IS 'Новое значение процентной ставки (ДС об изменении ставки)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.RATE_DATE IS 'Дата начала действия процентной ставки (ДС об изменении ставки)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.KF IS '';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AGRMNT_ID IS 'Уникальный номер ДС';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AGRMNT_DATE IS 'Дата заключения ДС (календарная)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AGRMNT_NUM IS 'Номер ДС';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AGRMNT_TYPE IS 'Тип ДС';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.DPT_ID IS '№ вклада';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.BRANCH IS 'Подразделение банка';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.CUST_ID IS 'Уник.№ владельца вклада';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.BANKDATE IS 'Дата заключения ДС (банковская)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.TEMPLATE_ID IS 'Шаблон ДС';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.TRUSTEE_ID IS '№ ДС о 3-их лицах';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.TRANSFER_BANK IS 'МФО банка для перечисления депозита и процентов';




PROMPT *** Create  constraint CC_DPTAGRMNTS_DATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT CC_DPTAGRMNTS_DATES CHECK (date_begin is null or date_end is null or date_begin < date_end) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTAGRMNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT PK_DPTAGRMNTS PRIMARY KEY (AGRMNT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPTAGRMNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT UK_DPTAGRMNTS UNIQUE (DPT_ID, AGRMNT_NUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_STATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT CC_DPTAGRMNTS_STATES CHECK (agrmnt_state IN (0,1,-1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_CUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (CUST_ID CONSTRAINT CC_DPTAGRMNTS_CUSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_AGRMNTSTATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (AGRMNT_STATE CONSTRAINT CC_DPTAGRMNTS_AGRMNTSTATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (KF CONSTRAINT CC_DPTAGRMNTS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_AGRMNTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (AGRMNT_ID CONSTRAINT CC_DPTAGRMNTS_AGRMNTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_AGRMNTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (AGRMNT_DATE CONSTRAINT CC_DPTAGRMNTS_AGRMNTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_AGRMNTNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (AGRMNT_NUM CONSTRAINT CC_DPTAGRMNTS_AGRMNTNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_AGRMNTTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (AGRMNT_TYPE CONSTRAINT CC_DPTAGRMNTS_AGRMNTTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (DPT_ID CONSTRAINT CC_DPTAGRMNTS_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (BRANCH CONSTRAINT CC_DPTAGRMNTS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_BANKDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (BANKDATE CONSTRAINT CC_DPTAGRMNTS_BANKDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_TEMPLATEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (TEMPLATE_ID CONSTRAINT CC_DPTAGRMNTS_TEMPLATEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTAGRMNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTAGRMNTS ON BARS.DPT_AGREEMENTS (AGRMNT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTAGRMNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTAGRMNTS ON BARS.DPT_AGREEMENTS (DPT_ID, AGRMNT_NUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_DPTAGRMNTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_DPTAGRMNTS ON BARS.DPT_AGREEMENTS (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_DPTAGRMNTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_DPTAGRMNTS ON BARS.DPT_AGREEMENTS (DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_AGREEMENTS ***
grant SELECT                                                                 on DPT_AGREEMENTS  to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_AGREEMENTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_AGREEMENTS  to BARS_DM;
grant SELECT                                                                 on DPT_AGREEMENTS  to DPT_ROLE;
grant SELECT                                                                 on DPT_AGREEMENTS  to KLBX;
grant SELECT                                                                 on DPT_AGREEMENTS  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_AGREEMENTS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_AGREEMENTS.sql =========*** End **
PROMPT ===================================================================================== 
