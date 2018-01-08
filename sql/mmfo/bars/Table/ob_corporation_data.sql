

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION_DATA.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORPORATION_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORPORATION_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORPORATION_DATA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OB_CORPORATION_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORPORATION_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORPORATION_DATA 
   (	CORPORATION_ID NUMBER(5,0), 
	FILE_DATE DATE, 
	ROWTYPE NUMBER, 
	KF VARCHAR2(6), 
	NLS VARCHAR2(14), 
	KV NUMBER, 
	OKPO VARCHAR2(14), 
	OBDB NUMBER, 
	OBDBQ NUMBER, 
	OBKR NUMBER, 
	OBKRQ NUMBER, 
	OST NUMBER, 
	OSTQ NUMBER, 
	KOD_CORP NUMBER, 
	KOD_USTAN NUMBER, 
	KOD_ANALYT VARCHAR2(4), 
	DAPP DATE, 
	POSTDAT DATE, 
	DOCDAT DATE, 
	VALDAT DATE, 
	ND VARCHAR2(10), 
	VOB NUMBER, 
	DK NUMBER, 
	MFOA VARCHAR2(6), 
	NLSA VARCHAR2(14), 
	KVA NUMBER, 
	NAMA VARCHAR2(70), 
	OKPOA VARCHAR2(14), 
	MFOB VARCHAR2(6), 
	NLSB VARCHAR2(14), 
	KVB NUMBER, 
	NAMB VARCHAR2(70), 
	OKPOB VARCHAR2(14), 
	S NUMBER, 
	DOCKV NUMBER, 
	SQ NUMBER, 
	NAZN VARCHAR2(160), 
	DOCTYPE NUMBER, 
	POSTTIME DATE, 
	NAMK VARCHAR2(70), 
	NMS VARCHAR2(70), 
	TT VARCHAR2(3), 
	SESSION_ID NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OB_CORPORATION_DATA ***
 exec bpa.alter_policies('OB_CORPORATION_DATA');


COMMENT ON TABLE BARS.OB_CORPORATION_DATA IS 'Централізоване сховище прийнятих К-файлів в ЦА';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.CORPORATION_ID IS 'Ідентифікатор корпорації';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.FILE_DATE IS 'Дата, за яку сформовані відомості по корпорації';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.ROWTYPE IS 'Ознака Рахунок/документ/пiдсумок';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.KF IS 'МФО банку';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.NLS IS 'Особовий рахунок (кількість рахунків  для підсумкового рядку)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.KV IS 'Валюта рахунку';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.OKPO IS 'Код ОКПО';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.OBDB IS 'Дебетові обороти в валюті';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.OBDBQ IS 'Дебетові обороти (еквівалент в національній валюті)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.OBKR IS 'Кредитові обороти в валюті';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.OBKRQ IS 'Кредитові обороти (еквівалент в національній валюті)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.OST IS 'Вихідний залишок в валюті';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.OSTQ IS 'Вихідний залишок (еквівалент в національній валюті)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.KOD_CORP IS 'Код корпоративного клієнта';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.KOD_USTAN IS 'Код установи корпоративного клієнта';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.KOD_ANALYT IS 'Код аналітичного обліку';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.DAPP IS 'Дата попереднього руху по рахунку';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.POSTDAT IS 'Дата проведення в ОДБ (дата руху по рахунку для стрычки по рахунку)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.DOCDAT IS 'Дата документу';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.VALDAT IS 'Дата валютування';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.ND IS 'Номер документу';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.VOB IS 'Вид документу';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.DK IS 'Дебет/Кредит';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.MFOA IS 'МФО банку платника';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.NLSA IS 'Особовий рахунок платника';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.KVA IS 'Валюта особового рахунку платника';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.NAMA IS 'Найменування клієнта платника';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.OKPOA IS 'Ідентифікатор клієнта платника';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.MFOB IS 'МФО банку отримувача';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.NLSB IS 'Особовий рахунок отримувача';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.KVB IS 'Валюта особового рахунку отримувача';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.NAMB IS 'Найменування клієнта отримувача';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.OKPOB IS 'Ідентифікатор клієнта отримувача';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.S IS 'Сума платежу в валюті';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.DOCKV IS 'Валюта платежу';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.SQ IS 'Сума платежу (еквівалент в національній валюті)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.NAZN IS 'Призначення платежу';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.DOCTYPE IS 'Ознака проводки';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.POSTTIME IS 'Час проведення в ОДБ';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.NAMK IS 'Найменування клієнта';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.NMS IS 'Найменування рахунку';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.TT IS 'Код операции';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA.SESSION_ID IS 'Ідентифікатор сесії завантаження даних з РУ';




PROMPT *** Create  constraint SYS_C00109858 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_DATA MODIFY (CORPORATION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109859 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_DATA MODIFY (FILE_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109860 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_DATA MODIFY (SESSION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index OB_CORP_DATA_IDXIDCORP ***
begin   
 execute immediate '
  CREATE INDEX BARS.OB_CORP_DATA_IDXIDCORP ON BARS.OB_CORPORATION_DATA (CORPORATION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OB_CORP_DATA_IDXIDSESS ***
begin   
 execute immediate '
  CREATE INDEX BARS.OB_CORP_DATA_IDXIDSESS ON BARS.OB_CORPORATION_DATA (SESSION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OB_CORP_DATA_IDXKF ***
begin   
 execute immediate '
  CREATE INDEX BARS.OB_CORP_DATA_IDXKF ON BARS.OB_CORPORATION_DATA (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OB_CORP_DATA_IDOKPO ***
begin   
 execute immediate '
  CREATE INDEX BARS.OB_CORP_DATA_IDOKPO ON BARS.OB_CORPORATION_DATA (OKPO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OB_CORPORATION_DATA ***
grant SELECT                                                                 on OB_CORPORATION_DATA to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on OB_CORPORATION_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OB_CORPORATION_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION_DATA.sql =========*** E
PROMPT ===================================================================================== 
