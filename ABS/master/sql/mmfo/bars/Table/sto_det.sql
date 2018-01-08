

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_DET.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_DET ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_DET'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STO_DET'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''STO_DET'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_DET ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_DET 
   (	IDS NUMBER(*,0), 
	VOB NUMBER(*,0) DEFAULT 1, 
	DK NUMBER(*,0) DEFAULT 1, 
	TT CHAR(3), 
	NLSA VARCHAR2(15), 
	KVA NUMBER(*,0), 
	NLSB VARCHAR2(15), 
	KVB NUMBER(*,0), 
	MFOB VARCHAR2(12), 
	POLU VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	FSUM VARCHAR2(100), 
	OKPO VARCHAR2(10), 
	DAT1 DATE, 
	DAT2 DATE, 
	FREQ NUMBER, 
	DAT0 DATE, 
	WEND NUMBER(*,0), 
	STMP DATE DEFAULT SYSDATE, 
	IDD NUMBER(*,0), 
	ORD NUMBER(38,0) DEFAULT 1, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DR VARCHAR2(9), 
	BRANCH VARCHAR2(30), 
	USERID_MADE NUMBER, 
	BRANCH_MADE VARCHAR2(30), 
	DATETIMESTAMP TIMESTAMP (6), 
	BRANCH_CARD VARCHAR2(30), 
	USERID NUMBER, 
	STATUS_ID NUMBER(*,0), 
	DISCLAIM_ID NUMBER(*,0), 
	STATUS_DATE DATE, 
	STATUS_UID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_DET ***
 exec bpa.alter_policies('STO_DET');


COMMENT ON TABLE BARS.STO_DET IS '';
COMMENT ON COLUMN BARS.STO_DET.KVA IS 'Валюта вiдправника';
COMMENT ON COLUMN BARS.STO_DET.NLSB IS 'Рахуноак отримувача';
COMMENT ON COLUMN BARS.STO_DET.KVB IS 'Валюта отримувача';
COMMENT ON COLUMN BARS.STO_DET.MFOB IS 'Банк отримувача';
COMMENT ON COLUMN BARS.STO_DET.POLU IS 'Назва отримувача';
COMMENT ON COLUMN BARS.STO_DET.NAZN IS 'Призначення платежу';
COMMENT ON COLUMN BARS.STO_DET.FSUM IS 'Формула суми';
COMMENT ON COLUMN BARS.STO_DET.OKPO IS 'ОКПО отримувача';
COMMENT ON COLUMN BARS.STO_DET.DAT1 IS 'Дата "С" ';
COMMENT ON COLUMN BARS.STO_DET.DAT2 IS 'Дата "По" ';
COMMENT ON COLUMN BARS.STO_DET.FREQ IS 'Периодичность';
COMMENT ON COLUMN BARS.STO_DET.DAT0 IS 'Дата пред.платежа';
COMMENT ON COLUMN BARS.STO_DET.WEND IS 'Вых.день(-1 или +1)';
COMMENT ON COLUMN BARS.STO_DET.STMP IS '';
COMMENT ON COLUMN BARS.STO_DET.IDD IS '';
COMMENT ON COLUMN BARS.STO_DET.ORD IS 'Порядок виконання';
COMMENT ON COLUMN BARS.STO_DET.KF IS '';
COMMENT ON COLUMN BARS.STO_DET.DR IS '';
COMMENT ON COLUMN BARS.STO_DET.BRANCH IS 'Бранч для бюджета';
COMMENT ON COLUMN BARS.STO_DET.USERID_MADE IS 'Номер користувача, що створив рег.плат';
COMMENT ON COLUMN BARS.STO_DET.BRANCH_MADE IS 'Відділення, де створено рег.плат';
COMMENT ON COLUMN BARS.STO_DET.DATETIMESTAMP IS 'Дата та час створення';
COMMENT ON COLUMN BARS.STO_DET.BRANCH_CARD IS 'Відділення карткового рахунку';
COMMENT ON COLUMN BARS.STO_DET.USERID IS '';
COMMENT ON COLUMN BARS.STO_DET.STATUS_ID IS 'Статус рег.плат';
COMMENT ON COLUMN BARS.STO_DET.DISCLAIM_ID IS 'Ідентифікатор відмови (0 - пітдверджено)';
COMMENT ON COLUMN BARS.STO_DET.STATUS_DATE IS 'Дата та час обробки в бек-офісі';
COMMENT ON COLUMN BARS.STO_DET.STATUS_UID IS 'Користувач, що обробив запит в бек-офісі';
COMMENT ON COLUMN BARS.STO_DET.IDS IS 'Код схеми';
COMMENT ON COLUMN BARS.STO_DET.VOB IS 'Вид документа';
COMMENT ON COLUMN BARS.STO_DET.DK IS 'Ознака Д/К';
COMMENT ON COLUMN BARS.STO_DET.TT IS 'Код операцiї';
COMMENT ON COLUMN BARS.STO_DET.NLSA IS 'Рахунок вiдправника';




PROMPT *** Create  constraint UK2_STODET ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT UK2_STODET UNIQUE (KF, IDD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_DATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT CC_STODET_DATES CHECK (dat1 <= dat2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_WEND ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT CC_STODET_WEND CHECK (wend in (-1, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_STODET ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT UK_STODET UNIQUE (IDS, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STODET ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET ADD CONSTRAINT PK_STODET PRIMARY KEY (IDD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_FREQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (FREQ CONSTRAINT CC_STODET_FREQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_IDS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (IDS CONSTRAINT CC_STODET_IDS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_VOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (VOB CONSTRAINT CC_STODET_VOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (DK CONSTRAINT CC_STODET_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (TT CONSTRAINT CC_STODET_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_NLSA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (NLSA CONSTRAINT CC_STODET_NLSA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_KVA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (KVA CONSTRAINT CC_STODET_KVA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_NLSB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (NLSB CONSTRAINT CC_STODET_NLSB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_KVB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (KVB CONSTRAINT CC_STODET_KVB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_MFOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (MFOB CONSTRAINT CC_STODET_MFOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_POLU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (POLU CONSTRAINT CC_STODET_POLU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_NAZN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (NAZN CONSTRAINT CC_STODET_NAZN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_OKPO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (OKPO CONSTRAINT CC_STODET_OKPO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_DAT1_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (DAT1 CONSTRAINT CC_STODET_DAT1_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_DAT2_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (DAT2 CONSTRAINT CC_STODET_DAT2_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_WEND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (WEND CONSTRAINT CC_STODET_WEND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_IDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (IDD CONSTRAINT CC_STODET_IDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (ORD CONSTRAINT CC_STODET_ORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODET_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DET MODIFY (KF CONSTRAINT CC_STODET_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_STODET_NLSB_KVB ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_STODET_NLSB_KVB ON BARS.STO_DET (NLSB, KVB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_STODET ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_STODET ON BARS.STO_DET (IDS, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STODET ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STODET ON BARS.STO_DET (IDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK2_STODET ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK2_STODET ON BARS.STO_DET (KF, IDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_DET ***
grant SELECT                                                                 on STO_DET         to BARSREADER_ROLE;
grant SELECT                                                                 on STO_DET         to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_DET         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_DET         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_DET         to STO;
grant SELECT                                                                 on STO_DET         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STO_DET         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_DET.sql =========*** End *** =====
PROMPT ===================================================================================== 
