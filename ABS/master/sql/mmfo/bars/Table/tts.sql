

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TTS.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TTS 
   (	TT CHAR(3), 
	NAME VARCHAR2(70), 
	DK NUMBER(1,0), 
	NLSM VARCHAR2(90), 
	KV NUMBER(3,0), 
	NLSK VARCHAR2(128), 
	KVK NUMBER(3,0), 
	NLSS VARCHAR2(15), 
	NLSA VARCHAR2(55), 
	NLSB VARCHAR2(55), 
	MFOB VARCHAR2(12), 
	FLC NUMBER(1,0) DEFAULT 0, 
	FLI NUMBER(1,0) DEFAULT 0, 
	FLV NUMBER(1,0) DEFAULT 0, 
	FLR NUMBER(1,0) DEFAULT 0, 
	S VARCHAR2(254), 
	S2 VARCHAR2(254), 
	SK NUMBER(24,0), 
	PROC NUMBER(7,2), 
	S3800 VARCHAR2(55), 
	S6201 NUMBER(38,0), 
	S7201 NUMBER(38,0), 
	RANG NUMBER(10,0), 
	FLAGS CHAR(64) DEFAULT ''0100000000000000000000000000000000000000000000000000000000000000'', 
	NAZN VARCHAR2(160), 
	ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD  ENABLE ROW MOVEMENT ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TTS ***
 exec bpa.alter_policies('TTS');


COMMENT ON TABLE BARS.TTS IS 'Справочник типов транзакций';
COMMENT ON COLUMN BARS.TTS.ID IS '';
COMMENT ON COLUMN BARS.TTS.TT IS 'Название и настройка операций';
COMMENT ON COLUMN BARS.TTS.NAME IS 'Наименование транзакции';
COMMENT ON COLUMN BARS.TTS.DK IS 'Признак дебета/кредита';
COMMENT ON COLUMN BARS.TTS.NLSM IS 'Счет основной для оплаты';
COMMENT ON COLUMN BARS.TTS.KV IS 'Код валюты1';
COMMENT ON COLUMN BARS.TTS.NLSK IS 'Счет корреспондента для оплаты';
COMMENT ON COLUMN BARS.TTS.KVK IS 'Код валюты2';
COMMENT ON COLUMN BARS.TTS.NLSS IS 'Счет SUSPEND (902)';
COMMENT ON COLUMN BARS.TTS.NLSA IS 'Счет основной для ввода';
COMMENT ON COLUMN BARS.TTS.NLSB IS 'Счет корреспондента для ввода';
COMMENT ON COLUMN BARS.TTS.MFOB IS 'МФО корреспондента';
COMMENT ON COLUMN BARS.TTS.FLC IS 'Признак Forced Payment';
COMMENT ON COLUMN BARS.TTS.FLI IS '0	Внутрибанковский
1	Межбанковский - СЭП НБУ
2	Межбанковский - SWIFT
3	Процессинг - СЭП НБУ';
COMMENT ON COLUMN BARS.TTS.FLV IS 'Признак мультивалютной операции';
COMMENT ON COLUMN BARS.TTS.FLR IS '';
COMMENT ON COLUMN BARS.TTS.S IS 'Формула суммы';
COMMENT ON COLUMN BARS.TTS.S2 IS 'Формула суммы 2';
COMMENT ON COLUMN BARS.TTS.SK IS 'Символ Касплана';
COMMENT ON COLUMN BARS.TTS.PROC IS '';
COMMENT ON COLUMN BARS.TTS.S3800 IS 'Cчет валютной позиции(ACC)';
COMMENT ON COLUMN BARS.TTS.S6201 IS 'Cчет маржинальных доходов(ACC)';
COMMENT ON COLUMN BARS.TTS.S7201 IS 'Cчет маржинальных расходов(ACC)';
COMMENT ON COLUMN BARS.TTS.RANG IS 'Приоритет';
COMMENT ON COLUMN BARS.TTS.FLAGS IS 'Настроечные технологические флаги';
COMMENT ON COLUMN BARS.TTS.NAZN IS 'Для дефолтного текста назначения платежа в карточке операции';




PROMPT *** Create  constraint UK_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS ADD CONSTRAINT UK_TTS UNIQUE (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTS_S6201_NULL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS ADD CONSTRAINT CC_TTS_S6201_NULL CHECK (s6201 is null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTS_S7201_NULL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS ADD CONSTRAINT CC_TTS_S7201_NULL CHECK (s7201 is null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTS_NLSM_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS ADD CONSTRAINT CC_TTS_NLSM_CC CHECK (nlsm is null or not regexp_like(nlsm,''^\d+$'')) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS ADD CONSTRAINT PK_TTS PRIMARY KEY (TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTS_FLC ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS ADD CONSTRAINT CC_TTS_FLC CHECK (flc in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTS_FLV ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS ADD CONSTRAINT CC_TTS_FLV CHECK (flv in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTS_FLR ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS ADD CONSTRAINT CC_TTS_FLR CHECK (flr in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTS_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS MODIFY (TT CONSTRAINT CC_TTS_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS MODIFY (NAME CONSTRAINT CC_TTS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTS_FLC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS MODIFY (FLC CONSTRAINT CC_TTS_FLC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTS_FLI_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS MODIFY (FLI CONSTRAINT CC_TTS_FLI_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTS_FLV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS MODIFY (FLV CONSTRAINT CC_TTS_FLV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTS_FLR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS MODIFY (FLR CONSTRAINT CC_TTS_FLR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTS_FLAGS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS MODIFY (FLAGS CONSTRAINT CC_TTS_FLAGS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_TTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_TTS ON BARS.TTS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TTS ON BARS.TTS (TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TTS             to ABS_ADMIN;
grant SELECT                                                                 on TTS             to BARS009;
grant REFERENCES,SELECT                                                      on TTS             to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on TTS             to BARSAQ_ADM with grant option;
grant SELECT                                                                 on TTS             to BARSREADER_ROLE;
grant SELECT                                                                 on TTS             to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TTS             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TTS             to BARS_DM;
grant SELECT                                                                 on TTS             to CHCK;
grant SELECT                                                                 on TTS             to CHCK002;
grant SELECT                                                                 on TTS             to DPT;
grant SELECT                                                                 on TTS             to DPT_ADMIN;
grant SELECT                                                                 on TTS             to OPERKKK;
grant SELECT                                                                 on TTS             to PYOD001;
grant SELECT                                                                 on TTS             to RPBN001;
grant SELECT                                                                 on TTS             to SBB_NC;
grant SELECT,UPDATE                                                          on TTS             to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on TTS             to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on TTS             to TTS;
grant SELECT                                                                 on TTS             to UPLD;
grant SELECT                                                                 on TTS             to USER100101;
grant SELECT                                                                 on TTS             to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TTS             to WR_ALL_RIGHTS;
grant SELECT                                                                 on TTS             to WR_CUSTLIST;
grant SELECT                                                                 on TTS             to WR_DEPOSIT_U;
grant SELECT                                                                 on TTS             to WR_DOC_INPUT;
grant SELECT                                                                 on TTS             to WR_IMPEXP;
grant SELECT                                                                 on TTS             to WR_KP;
grant SELECT                                                                 on TTS             to WR_ND_ACCOUNTS;
grant FLASHBACK,SELECT                                                       on TTS             to WR_REFREAD;
grant SELECT                                                                 on TTS             to WR_TOBO_ACCOUNTS_LIST;
grant SELECT                                                                 on TTS             to WR_USER_ACCOUNTS_LIST;



PROMPT *** Create SYNONYM  to TTS ***

  CREATE OR REPLACE PUBLIC SYNONYM S_TTS FOR BARS.TTS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TTS.sql =========*** End *** =========
PROMPT ===================================================================================== 
