

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SVOD.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SVOD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SVOD ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_SVOD 
   (	ID NUMBER(*,0), 
	USERID NUMBER(38,0), 
	FIO VARCHAR2(50), 
	KL CHAR(1), 
	KV1 NUMBER(38,0), 
	FDAT DATE, 
	TT VARCHAR2(5), 
	NAMTT VARCHAR2(30), 
	REF NUMBER(*,0), 
	STMT NUMBER(*,0), 
	KV NUMBER(38,0), 
	NLS VARCHAR2(15), 
	S NUMBER(38,0), 
	SQ NUMBER(38,0), 
	NAMEOT VARCHAR2(70), 
	PT VARCHAR2(30), 
	TECH NUMBER(38,0), 
	DK NUMBER(38,0), 
	NLSB VARCHAR2(15), 
	OTD VARCHAR2(30), 
	SK NUMBER(38,0), 
	SKK NUMBER(38,0), 
	SD NUMBER(38,0), 
	SDD NUMBER(38,0), 
	KAS NUMBER(38,0), 
	NAZN VARCHAR2(160)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SVOD ***
 exec bpa.alter_policies('TMP_SVOD');


COMMENT ON TABLE BARS.TMP_SVOD IS 'Временная по печатным отчетам свод документов дня';
COMMENT ON COLUMN BARS.TMP_SVOD.ID IS 'Код пользователя формирующего отчет';
COMMENT ON COLUMN BARS.TMP_SVOD.USERID IS 'Код пользователя, породившего проводку';
COMMENT ON COLUMN BARS.TMP_SVOD.FIO IS 'ФИО пользователя породившего проводку';
COMMENT ON COLUMN BARS.TMP_SVOD.KL IS 'Признак Б-9';
COMMENT ON COLUMN BARS.TMP_SVOD.KV1 IS 'Дополнительный признак =2 - валюта =1 -гривна';
COMMENT ON COLUMN BARS.TMP_SVOD.FDAT IS 'Дата за которую формируем';
COMMENT ON COLUMN BARS.TMP_SVOD.TT IS 'Код операции';
COMMENT ON COLUMN BARS.TMP_SVOD.NAMTT IS 'Название операции';
COMMENT ON COLUMN BARS.TMP_SVOD.REF IS 'Референс';
COMMENT ON COLUMN BARS.TMP_SVOD.STMT IS 'Внутренний код проводки';
COMMENT ON COLUMN BARS.TMP_SVOD.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.TMP_SVOD.NLS IS 'Номер счета';
COMMENT ON COLUMN BARS.TMP_SVOD.S IS 'Сумма в номинале';
COMMENT ON COLUMN BARS.TMP_SVOD.SQ IS 'Грн-эквивалент суммы';
COMMENT ON COLUMN BARS.TMP_SVOD.NAMEOT IS 'Название отдела';
COMMENT ON COLUMN BARS.TMP_SVOD.PT IS 'Название группы транзакций  (авто_процесинг)';
COMMENT ON COLUMN BARS.TMP_SVOD.TECH IS 'Признак для группировки по Технологическим';
COMMENT ON COLUMN BARS.TMP_SVOD.DK IS 'Дт-Кт';
COMMENT ON COLUMN BARS.TMP_SVOD.NLSB IS 'Счет- корреспондент для кассы';
COMMENT ON COLUMN BARS.TMP_SVOD.OTD IS 'Номер отдела';
COMMENT ON COLUMN BARS.TMP_SVOD.SK IS 'Общая сумма по ответным кредтовым';
COMMENT ON COLUMN BARS.TMP_SVOD.SKK IS 'Общее количество по ответным кредитовым';
COMMENT ON COLUMN BARS.TMP_SVOD.SD IS 'Общая сумма по ответным дебетовым';
COMMENT ON COLUMN BARS.TMP_SVOD.SDD IS 'Общее количество по ответным дебетовым';
COMMENT ON COLUMN BARS.TMP_SVOD.KAS IS 'Признак кас-некас проводка =1 не кас,=2 кас';
COMMENT ON COLUMN BARS.TMP_SVOD.NAZN IS 'Назначение платежа';



PROMPT *** Create  grants  TMP_SVOD ***
grant SELECT                                                                 on TMP_SVOD        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SVOD        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SVOD        to RPBN001;
grant SELECT                                                                 on TMP_SVOD        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_SVOD        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_SVOD ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_SVOD FOR BARS.TMP_SVOD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SVOD.sql =========*** End *** ====
PROMPT ===================================================================================== 
