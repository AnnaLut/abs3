

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FOND_GAR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FOND_GAR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FOND_GAR ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_FOND_GAR 
   (	DAT DATE, 
	MFO CHAR(6), 
	FIO VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	OBL VARCHAR2(30), 
	DST VARCHAR2(30), 
	TOWN VARCHAR2(30), 
	ADR VARCHAR2(70), 
	PASP VARCHAR2(100), 
	DATZ DATE, 
	ND VARCHAR2(30), 
	OST NUMBER(19,0), 
	OSTN NUMBER(19,0), 
	NLS VARCHAR2(14), 
	GAR NUMBER(1,0), 
	KV NUMBER(3,0), 
	RNK NUMBER(38,0), 
	REZID NUMBER(1,0), 
	DPT_ID NUMBER(38,0), 
	NLSN VARCHAR2(14), 
	OST_NOM NUMBER(24,0), 
	OSTN_NOM NUMBER(24,0), 
	REC_ID NUMBER(38,0)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FOND_GAR ***
 exec bpa.alter_policies('TMP_FOND_GAR');


COMMENT ON TABLE BARS.TMP_FOND_GAR IS 'Вспомогат.таблица для формирования отчета для ФГ';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.DAT IS 'Дата';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.MFO IS 'МФО';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.FIO IS 'ФИО вкладчика';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.OKPO IS 'Код ОКПО';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.OBL IS '';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.DST IS '';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.TOWN IS 'Место расположения';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.ADR IS 'Адрес';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.PASP IS 'Тип документа';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.DATZ IS 'Дата закрытия';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.ND IS '';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.OST IS 'Остаток на счету';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.OSTN IS '';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.NLS IS 'Номер лицевого счета';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.GAR IS '';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.RNK IS 'РНК клиента';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.REZID IS '';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.DPT_ID IS 'ID депозита';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.NLSN IS 'Название счета';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.OST_NOM IS '';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.OSTN_NOM IS '';
COMMENT ON COLUMN BARS.TMP_FOND_GAR.REC_ID IS 'Уникальный номер записи';




PROMPT *** Create  constraint PK_TMPFONDGAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_FOND_GAR ADD CONSTRAINT PK_TMPFONDGAR PRIMARY KEY (REC_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPFONDGAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPFONDGAR ON BARS.TMP_FOND_GAR (REC_ID) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_FOND_GAR ***
grant SELECT                                                                 on TMP_FOND_GAR    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_FOND_GAR    to BARS_DM;
grant SELECT                                                                 on TMP_FOND_GAR    to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_FOND_GAR    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FOND_GAR.sql =========*** End *** 
PROMPT ===================================================================================== 
