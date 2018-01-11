

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_ACCN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_ACCN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_ACCN'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INT_ACCN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INT_ACCN'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_ACCN ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_ACCN 
   (	ACC NUMBER(38,0), 
	ID NUMBER, 
	METR NUMBER, 
	BASEM NUMBER(*,0), 
	BASEY NUMBER(*,0), 
	FREQ NUMBER(3,0), 
	STP_DAT DATE, 
	ACR_DAT DATE DEFAULT (trunc(sysdate)-1), 
	APL_DAT DATE, 
	TT CHAR(3) DEFAULT ''%%1'', 
	ACRA NUMBER(38,0), 
	ACRB NUMBER(38,0), 
	S NUMBER DEFAULT 0, 
	TTB CHAR(3), 
	KVB NUMBER(3,0), 
	NLSB VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	NAMB VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	IO NUMBER(1,0) DEFAULT 0, 
	IDU NUMBER, 
	IDR NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	OKPO VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_ACCN ***
 exec bpa.alter_policies('INT_ACCN');


COMMENT ON TABLE BARS.INT_ACCN IS 'Таблица процентных ставок по счетам';
COMMENT ON COLUMN BARS.INT_ACCN.ACC IS 'Номер счета';
COMMENT ON COLUMN BARS.INT_ACCN.ID IS 'ID';
COMMENT ON COLUMN BARS.INT_ACCN.METR IS 'Метод начисления';
COMMENT ON COLUMN BARS.INT_ACCN.BASEM IS 'Базовый месяц';
COMMENT ON COLUMN BARS.INT_ACCN.BASEY IS 'Базовый год';
COMMENT ON COLUMN BARS.INT_ACCN.FREQ IS 'Переодичность';
COMMENT ON COLUMN BARS.INT_ACCN.STP_DAT IS 'Дата окончания';
COMMENT ON COLUMN BARS.INT_ACCN.ACR_DAT IS 'Дата последнего начисления';
COMMENT ON COLUMN BARS.INT_ACCN.APL_DAT IS 'Дата последней выплаты';
COMMENT ON COLUMN BARS.INT_ACCN.TT IS 'Тип операции начисления процентов';
COMMENT ON COLUMN BARS.INT_ACCN.ACRA IS 'Счет нач.%%';
COMMENT ON COLUMN BARS.INT_ACCN.ACRB IS 'Контрсчет 6-7 класса';
COMMENT ON COLUMN BARS.INT_ACCN.S IS 'Сумма документа';
COMMENT ON COLUMN BARS.INT_ACCN.TTB IS 'Тип операции выплаты %';
COMMENT ON COLUMN BARS.INT_ACCN.KVB IS 'Код валюты выплаты %';
COMMENT ON COLUMN BARS.INT_ACCN.NLSB IS 'Счет получателя для выплаты %';
COMMENT ON COLUMN BARS.INT_ACCN.MFOB IS 'МФО получателя для выплаты %';
COMMENT ON COLUMN BARS.INT_ACCN.NAMB IS 'Наименование получателя для выплаты %';
COMMENT ON COLUMN BARS.INT_ACCN.NAZN IS 'Назначение платежа';
COMMENT ON COLUMN BARS.INT_ACCN.IO IS 'Тип остатка (из спр-ка int_ion)';
COMMENT ON COLUMN BARS.INT_ACCN.IDU IS '';
COMMENT ON COLUMN BARS.INT_ACCN.IDR IS 'Номер шкалы плаваючої % ставки Овердрафту (для METR=7).';
COMMENT ON COLUMN BARS.INT_ACCN.KF IS '';
COMMENT ON COLUMN BARS.INT_ACCN.OKPO IS 'ОКПО';




PROMPT *** Create  constraint CC_INTACCN_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN MODIFY (TT CONSTRAINT CC_INTACCN_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INTACCN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT PK_INTACCN PRIMARY KEY (ACC, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_INTACCN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN ADD CONSTRAINT UK_INTACCN UNIQUE (KF, ACC, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACCN_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN MODIFY (ACC CONSTRAINT CC_INTACCN_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACCN_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN MODIFY (ID CONSTRAINT CC_INTACCN_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACCN_METR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN MODIFY (METR CONSTRAINT CC_INTACCN_METR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACCN_BASEY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN MODIFY (BASEY CONSTRAINT CC_INTACCN_BASEY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACCN_FREQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN MODIFY (FREQ CONSTRAINT CC_INTACCN_FREQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACCN_ACRDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN MODIFY (ACR_DAT CONSTRAINT CC_INTACCN_ACRDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACCN_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN MODIFY (S CONSTRAINT CC_INTACCN_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACCN_IO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN MODIFY (IO CONSTRAINT CC_INTACCN_IO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACCN_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN MODIFY (KF CONSTRAINT CC_INTACCN_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_INTACCN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_INTACCN ON BARS.INT_ACCN (KF, ACC, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_INTACCN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_INTACCN ON BARS.INT_ACCN (ACRA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTACCN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTACCN ON BARS.INT_ACCN (ACC, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_INTACCN ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_INTACCN ON BARS.INT_ACCN (ACRB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_ACCN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_ACCN        to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_ACCN        to BARS009;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_ACCN        to BARS010;
grant SELECT                                                                 on INT_ACCN        to BARSREADER_ROLE;
grant SELECT                                                                 on INT_ACCN        to BARSUPL;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_ACCN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_ACCN        to BARS_DM;
grant SELECT                                                                 on INT_ACCN        to CC_DOC;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_ACCN        to CUST001;
grant SELECT                                                                 on INT_ACCN        to DPT;
grant SELECT                                                                 on INT_ACCN        to DPT_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_ACCN        to FOREX;
grant SELECT                                                                 on INT_ACCN        to KLBX;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_ACCN        to RCC_DEAL;
grant SELECT                                                                 on INT_ACCN        to RPBN001;
grant SELECT                                                                 on INT_ACCN        to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_ACCN        to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_ACCN        to TECH006;
grant SELECT                                                                 on INT_ACCN        to UPLD;
grant INSERT,SELECT,UPDATE                                                   on INT_ACCN        to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_ACCN        to WR_ALL_RIGHTS;
grant SELECT,UPDATE                                                          on INT_ACCN        to WR_DEPOSIT_U;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_ACCN        to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_ACCN.sql =========*** End *** ====
PROMPT ===================================================================================== 
