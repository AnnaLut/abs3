

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_DOC_IMPORT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_DOC_IMPORT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_DOC_IMPORT 
   (	EXT_REF VARCHAR2(40), 
	REF NUMBER, 
	TT CHAR(3), 
	ND VARCHAR2(10), 
	VOB NUMBER, 
	VDAT DATE, 
	DATD DATE, 
	DATP DATE, 
	DK NUMBER, 
	KV NUMBER, 
	S NUMBER, 
	KV2 NUMBER, 
	S2 NUMBER, 
	SQ NUMBER, 
	SK NUMBER, 
	MFO_A VARCHAR2(6), 
	NAM_A VARCHAR2(38), 
	NLS_A VARCHAR2(14), 
	ID_A VARCHAR2(10), 
	MFO_B VARCHAR2(6), 
	NAM_B VARCHAR2(38), 
	NLS_B VARCHAR2(14), 
	ID_B VARCHAR2(10), 
	NAZN VARCHAR2(160), 
	USERID NUMBER, 
	ID_O VARCHAR2(6), 
	SIGN RAW(256), 
	ERR_LANG VARCHAR2(3), 
	ERR_USR_MSG VARCHAR2(4000), 
	ERR_APP_CODE VARCHAR2(9), 
	ERR_APP_MSG VARCHAR2(4000), 
	ERR_APP_ACT VARCHAR2(4000), 
	ERR_DB_CODE NUMBER, 
	ERR_DB_MSG VARCHAR2(4000)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_DOC_IMPORT IS 'Документы для импорта в АБС';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.EXT_REF IS 'External Reference';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.REF IS 'Референс документа в АБС';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.TT IS 'Код операции';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ND IS 'Операционный номер документа';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.VOB IS 'Вид документа';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.VDAT IS 'Дата валютирования';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.DATD IS 'Дата документа';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.DATP IS 'Дата поступления документа в банк';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.DK IS 'Признак дебет/кредит:
0 - прямое списание(direct debit),
1 - кредитовый документ,
2 - информационный запрос,
3 - информационное сообщение';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.KV IS 'Код валюты А';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.S IS 'Сумма А';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.KV2 IS 'Код валюты Б';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.S2 IS 'Сумма Б';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.SQ IS 'Эквивалент суммы А';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.SK IS 'Символ кассового плана';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.MFO_A IS 'Код банка плательщика(МФО)';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.NAM_A IS 'Наименование плательщика';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.NLS_A IS 'Счет плательщика';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ID_A IS 'Идент. код плательщика';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.MFO_B IS 'Код банка получателя(МФО)';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.NAM_B IS 'Наименование получателя';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.NLS_B IS 'Счет получателя';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ID_B IS 'Идент. код получателя';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.NAZN IS 'Назначение платежа';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.USERID IS 'ID пользователя - исполнителя';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ID_O IS 'Идентификатор ключа операциониста';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.SIGN IS 'ЭЦП документа';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ERR_LANG IS 'Язык, на котором должно быть сообщение об ошибке: ENG,RUS,UKR,...';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ERR_USR_MSG IS 'Сообщение об ошибке. Показывать пользователю всегда.';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ERR_APP_CODE IS 'Код прикладной ошибки. Необходимо сохранить в БД IBS. Показывать пользователю только в окне "Details"';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ERR_APP_MSG IS 'Описание прикладной ошибки. Необходимо сохранить в БД IBS. Показывать пользователю только в окне "Details"';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ERR_APP_ACT IS 'Действие по прикладной ошибке. Необходимо сохранить в БД IBS. Показывать пользователю только в окне "Details"';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ERR_DB_CODE IS 'Код ошибки БД АБС. Необходимо сохранить в БД IBS. Пользователю не показывать.';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT.ERR_DB_MSG IS 'Описание ошибки БД АБС. Необходимо сохранить в БД IBS. Пользователю не показывать.';




PROMPT *** Create  constraint PK_TMPDOCIMPORT ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT ADD CONSTRAINT PK_TMPDOCIMPORT PRIMARY KEY (EXT_REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_EXTREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (EXT_REF CONSTRAINT CC_TMPDOCIMPORT_EXTREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (TT CONSTRAINT CC_TMPDOCIMPORT_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (DK CONSTRAINT CC_TMPDOCIMPORT_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (KV CONSTRAINT CC_TMPDOCIMPORT_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (S CONSTRAINT CC_TMPDOCIMPORT_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_MFOA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (MFO_A CONSTRAINT CC_TMPDOCIMPORT_MFOA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_NAMA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (NAM_A CONSTRAINT CC_TMPDOCIMPORT_NAMA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_NLSA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (NLS_A CONSTRAINT CC_TMPDOCIMPORT_NLSA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_IDA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (ID_A CONSTRAINT CC_TMPDOCIMPORT_IDA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_MFOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (MFO_B CONSTRAINT CC_TMPDOCIMPORT_MFOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_NAMB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (NAM_B CONSTRAINT CC_TMPDOCIMPORT_NAMB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_NLSB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (NLS_B CONSTRAINT CC_TMPDOCIMPORT_NLSB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_IDB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (ID_B CONSTRAINT CC_TMPDOCIMPORT_IDB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORT_NAZN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT MODIFY (NAZN CONSTRAINT CC_TMPDOCIMPORT_NAZN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPDOCIMPORT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_TMPDOCIMPORT ON BARSAQ.TMP_DOC_IMPORT (EXT_REF) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DOC_IMPORT ***
grant SELECT                                                                 on TMP_DOC_IMPORT  to BARSREADER_ROLE;
grant INSERT,SELECT                                                          on TMP_DOC_IMPORT  to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_DOC_IMPORT.sql =========*** End 
PROMPT ===================================================================================== 
