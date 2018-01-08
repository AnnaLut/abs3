

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION_DATA_TMP.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORPORATION_DATA_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORPORATION_DATA_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORPORATION_DATA_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORPORATION_DATA_TMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORPORATION_DATA_TMP 
   (	CORPORATION_ID NUMBER(5,0), 
	FILE_DATE DATE, 
	ROWTYPE NUMBER, 
	OURMFO VARCHAR2(6), 
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




PROMPT *** ALTER_POLICIES to OB_CORPORATION_DATA_TMP ***
 exec bpa.alter_policies('OB_CORPORATION_DATA_TMP');


COMMENT ON TABLE BARS.OB_CORPORATION_DATA_TMP IS 'Централізоване сховище прийнятих К-файлів в ЦА';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.CORPORATION_ID IS 'Ідентифікатор корпорації';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.FILE_DATE IS 'Дата, за яку сформовані відомості по корпорації';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.ROWTYPE IS 'Ознака Рахунок/документ/пiдсумок';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OURMFO IS 'МФО банку';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NLS IS 'Особовий рахунок (кількість рахунків  для підсумкового рядку)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.KV IS 'Валюта рахунку';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OKPO IS 'Код ОКПО';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OBDB IS 'Дебетові обороти в валюті';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OBDBQ IS 'Дебетові обороти (еквівалент в національній валюті)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OBKR IS 'Кредитові обороти в валюті';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OBKRQ IS 'Кредитові обороти (еквівалент в національній валюті)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OST IS 'Вихідний залишок в валюті';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OSTQ IS 'Вихідний залишок (еквівалент в національній валюті)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.KOD_CORP IS 'Код корпоративного клієнта';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.KOD_USTAN IS 'Код установи корпоративного клієнта';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.KOD_ANALYT IS 'Код аналітичного обліку';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.DAPP IS 'Дата попереднього руху по рахунку';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.POSTDAT IS 'Дата проведення в ОДБ (дата руху по рахунку для стрычки по рахунку)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.DOCDAT IS 'Дата документу';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.VALDAT IS 'Дата валютування';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.ND IS 'Номер документу';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.VOB IS 'Вид документу';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.DK IS 'Дебет/Кредит';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.MFOA IS 'МФО банку платника';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NLSA IS 'Особовий рахунок платника';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.KVA IS 'Валюта особового рахунку платника';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NAMA IS 'Найменування клієнта платника';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OKPOA IS 'Ідентифікатор клієнта платника';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.MFOB IS 'МФО банку отримувача';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NLSB IS 'Особовий рахунок отримувача';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.KVB IS 'Валюта особового рахунку отримувача';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NAMB IS 'Найменування клієнта отримувача';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.OKPOB IS 'Ідентифікатор клієнта отримувача';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.S IS 'Сума платежу в валюті';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.DOCKV IS 'Валюта платежу';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.SQ IS 'Сума платежу (еквівалент в національній валюті)';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NAZN IS 'Призначення платежу';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.DOCTYPE IS 'Ознака проводки';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.POSTTIME IS 'Час проведення в ОДБ';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NAMK IS 'Найменування клієнта';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.NMS IS 'Найменування рахунку';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.TT IS 'Код операции';
COMMENT ON COLUMN BARS.OB_CORPORATION_DATA_TMP.SESSION_ID IS 'Ідентифікатор сесії завантаження даних з РУ';




PROMPT *** Create  constraint SYS_C00109843 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_DATA_TMP MODIFY (CORPORATION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109844 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_DATA_TMP MODIFY (FILE_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109845 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_DATA_TMP MODIFY (SESSION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index OB_CORP_DATA_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.OB_CORP_DATA_IDX ON BARS.OB_CORPORATION_DATA_TMP (CORPORATION_ID, FILE_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OB_CORP_DATA_IDX2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.OB_CORP_DATA_IDX2 ON BARS.OB_CORPORATION_DATA_TMP (SESSION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OB_CORPORATION_DATA_TMP ***
grant SELECT                                                                 on OB_CORPORATION_DATA_TMP to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on OB_CORPORATION_DATA_TMP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OB_CORPORATION_DATA_TMP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION_DATA_TMP.sql =========*
PROMPT ===================================================================================== 
