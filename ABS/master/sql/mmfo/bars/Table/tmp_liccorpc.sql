

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_LICCORPC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_LICCORPC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_LICCORPC ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_LICCORPC 
   (	ROWTYPE NUMBER, 
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
	TT VARCHAR2(3)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_LICCORPC ***
 exec bpa.alter_policies('TMP_LICCORPC');


COMMENT ON TABLE BARS.TMP_LICCORPC IS 'Временная таблица для формирования выписко по корп. клиентам';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OBDB IS 'Дебетові обороти в валюті';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OBDBQ IS 'Дебетові обороти (еквівалент в національній валюті)';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OBKR IS 'Кредитові обороти в валюті';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OBKRQ IS 'Кредитові обороти (еквівалент в національній валюті)';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OST IS 'Вихідний залишок в валюті';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OSTQ IS 'Вихідний залишок (еквівалент в національній валюті)';
COMMENT ON COLUMN BARS.TMP_LICCORPC.KOD_CORP IS 'Код корпоративного клієнта';
COMMENT ON COLUMN BARS.TMP_LICCORPC.KOD_USTAN IS 'Код установи корпоративного клієнта';
COMMENT ON COLUMN BARS.TMP_LICCORPC.KOD_ANALYT IS 'Код аналітичного обліку';
COMMENT ON COLUMN BARS.TMP_LICCORPC.DAPP IS 'Дата попереднього руху по рахунку';
COMMENT ON COLUMN BARS.TMP_LICCORPC.POSTDAT IS 'Дата проведення в ОДБ (дата руху по рахунку для стрычки по рахунку)';
COMMENT ON COLUMN BARS.TMP_LICCORPC.DOCDAT IS 'Дата документу';
COMMENT ON COLUMN BARS.TMP_LICCORPC.VALDAT IS 'Дата валютування';
COMMENT ON COLUMN BARS.TMP_LICCORPC.ND IS 'Номер документу';
COMMENT ON COLUMN BARS.TMP_LICCORPC.VOB IS 'Вид документу';
COMMENT ON COLUMN BARS.TMP_LICCORPC.DK IS 'Дебет/Кредит';
COMMENT ON COLUMN BARS.TMP_LICCORPC.MFOA IS 'МФО банку платника';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NLSA IS 'Особовий рахунок платника';
COMMENT ON COLUMN BARS.TMP_LICCORPC.KVA IS 'Валюта особового рахунку платника';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NAMA IS 'Найменування клієнта платника';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OKPOA IS 'Ідентифікатор клієнта платника';
COMMENT ON COLUMN BARS.TMP_LICCORPC.MFOB IS 'МФО банку отримувача';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NLSB IS 'Особовий рахунок отримувача';
COMMENT ON COLUMN BARS.TMP_LICCORPC.KVB IS 'Валюта особового рахунку отримувача';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NAMB IS 'Найменування клієнта отримувача';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OKPOB IS 'Ідентифікатор клієнта отримувача';
COMMENT ON COLUMN BARS.TMP_LICCORPC.S IS 'Сума платежу в валюті';
COMMENT ON COLUMN BARS.TMP_LICCORPC.DOCKV IS 'Валюта платежу';
COMMENT ON COLUMN BARS.TMP_LICCORPC.SQ IS 'Сума платежу (еквівалент в національній валюті)';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NAZN IS 'Призначення платежу';
COMMENT ON COLUMN BARS.TMP_LICCORPC.DOCTYPE IS 'Ознака проводки';
COMMENT ON COLUMN BARS.TMP_LICCORPC.POSTTIME IS 'Час проведення в ОДБ ';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NAMK IS 'Найменування клієнта';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NMS IS 'Найменування рахунку';
COMMENT ON COLUMN BARS.TMP_LICCORPC.TT IS 'Код операции';
COMMENT ON COLUMN BARS.TMP_LICCORPC.ROWTYPE IS 'Ознака Рахунок/документ/пiдсумок ';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OURMFO IS 'МФО банку';
COMMENT ON COLUMN BARS.TMP_LICCORPC.NLS IS 'Особовий рахунок (кількість рахунків  для підсумкового рядку)';
COMMENT ON COLUMN BARS.TMP_LICCORPC.KV IS 'Валюта рахунку';
COMMENT ON COLUMN BARS.TMP_LICCORPC.OKPO IS 'Код ОКПО';



PROMPT *** Create  grants  TMP_LICCORPC ***
grant SELECT                                                                 on TMP_LICCORPC    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LICCORPC    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LICCORPC    to RPBN001;
grant SELECT                                                                 on TMP_LICCORPC    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_LICCORPC.sql =========*** End *** 
PROMPT ===================================================================================== 
