

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_DUAL_OPLDOK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_DUAL_OPLDOK ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_DUAL_OPLDOK 
   (	ACTION CHAR(1), 
	REF NUMBER, 
	STMT NUMBER, 
	FDAT DATE, 
	TT CHAR(3), 
	S NUMBER, 
	KV NUMBER(*,0), 
	SQ NUMBER, 
	PDAT DATE, 
	VDAT DATE, 
	DATD DATE, 
	DATP DATE, 
	ND VARCHAR2(10), 
	DK NUMBER(*,0), 
	VOB NUMBER, 
	BRANCH VARCHAR2(30), 
	MFO_A VARCHAR2(12), 
	NLS_A VARCHAR2(15), 
	ID_A VARCHAR2(14), 
	NAME_A VARCHAR2(38), 
	MFO_B VARCHAR2(12), 
	NLS_B VARCHAR2(15), 
	ID_B VARCHAR2(14), 
	NAME_B VARCHAR2(38), 
	NARRATIVE VARCHAR2(160), 
	SYSTEM_CN NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_DUAL_OPLDOK IS 'Таблица проводок для экспорта';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.ACTION IS 'Действие по проводке: I,U,D';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.REF IS 'Референс документа';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.STMT IS 'Номер проводки';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.FDAT IS 'Дата(реальная) проведения по счетам';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.TT IS 'Код(внутренний) операции';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.S IS 'Сумма проводки в копейках';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.KV IS 'Код валюты(числовой)';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.SQ IS 'Сумма проводки в эквиваленте';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.PDAT IS 'Дата+время помещения документа в АБС';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.VDAT IS 'Дата валютирования(желаемая)';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.DATD IS 'Дата документа';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.DATP IS 'Дата поступления документа в банк';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.ND IS 'Номер(операционный) документа';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.DK IS 'Признак дебет/кредит: 0/1';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.VOB IS '';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.BRANCH IS 'В каком бранч был сформирован платеж';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.MFO_A IS 'Код банка отправителя';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.NLS_A IS 'Счет отправителя';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.ID_A IS 'Идент. код отправителя';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.NAME_A IS 'Наименование отправителя';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.MFO_B IS 'Код банка получателя';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.NLS_B IS 'Счет получателя';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.ID_B IS 'Идент. код получателя';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.NAME_B IS 'Наименование получателя';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.NARRATIVE IS 'Назначение платежа';
COMMENT ON COLUMN BARSAQ.TMP_DUAL_OPLDOK.SYSTEM_CN IS '';




PROMPT *** Create  constraint PK_TMPDUALOPLDOK ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DUAL_OPLDOK ADD CONSTRAINT PK_TMPDUALOPLDOK PRIMARY KEY (REF, STMT, ACTION) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDUALOPLDOK_STMT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DUAL_OPLDOK MODIFY (STMT CONSTRAINT CC_TMPDUALOPLDOK_STMT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDUALOPLDOK_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DUAL_OPLDOK MODIFY (REF CONSTRAINT CC_TMPDUALOPLDOK_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDUALOPLDOK_ACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DUAL_OPLDOK MODIFY (ACTION CONSTRAINT CC_TMPDUALOPLDOK_ACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPDUALOPLDOK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_TMPDUALOPLDOK ON BARSAQ.TMP_DUAL_OPLDOK (REF, STMT, ACTION) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DUAL_OPLDOK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_DUAL_OPLDOK to BARS;
grant SELECT                                                                 on TMP_DUAL_OPLDOK to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_DUAL_OPLDOK.sql =========*** End
PROMPT ===================================================================================== 
