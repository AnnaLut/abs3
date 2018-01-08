

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SSP_V.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SSP_V ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SSP_V ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_SSP_V 
   (	MFOA VARCHAR2(12), 
	NLSA VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15), 
	DK NUMBER, 
	S NUMBER, 
	VOB NUMBER, 
	ND CHAR(10), 
	KV NUMBER, 
	DATD DATE, 
	DATP DATE, 
	NAM_A VARCHAR2(38), 
	NAM_B VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	D_REC VARCHAR2(60), 
	NAZNK CHAR(3), 
	NAZNS CHAR(2), 
	ID_A VARCHAR2(14), 
	ID_B VARCHAR2(14), 
	REF_A VARCHAR2(9), 
	ID_O VARCHAR2(6), 
	BIS NUMBER, 
	RESERVED VARCHAR2(8), 
	SIGN RAW(128), 
	TRANS_ID VARCHAR2(12), 
	TRANS_LN NUMBER(*,0), 
	SRC CHAR(1)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SSP_V ***
 exec bpa.alter_policies('TMP_SSP_V');


COMMENT ON TABLE BARS.TMP_SSP_V IS 'Таблиця для зв_рки платеж_в з виписки СТП';
COMMENT ON COLUMN BARS.TMP_SSP_V.MFOA IS 'Код банка А';
COMMENT ON COLUMN BARS.TMP_SSP_V.NLSA IS 'Рахунок кл_єнта банка А';
COMMENT ON COLUMN BARS.TMP_SSP_V.MFOB IS 'Код банка Б';
COMMENT ON COLUMN BARS.TMP_SSP_V.NLSB IS 'Рахунок кл_єнта банка Б';
COMMENT ON COLUMN BARS.TMP_SSP_V.DK IS 'Ознака "Дебет-кредит" документа';
COMMENT ON COLUMN BARS.TMP_SSP_V.S IS 'Сума платежу';
COMMENT ON COLUMN BARS.TMP_SSP_V.VOB IS 'Умовний числовий код документа';
COMMENT ON COLUMN BARS.TMP_SSP_V.ND IS 'Номер (операц_йний) платежу';
COMMENT ON COLUMN BARS.TMP_SSP_V.KV IS 'Валюта платежу';
COMMENT ON COLUMN BARS.TMP_SSP_V.DATD IS 'Дата плат_жного документа';
COMMENT ON COLUMN BARS.TMP_SSP_V.DATP IS 'Дата надходження плат_жного документа до банка А';
COMMENT ON COLUMN BARS.TMP_SSP_V.NAM_A IS 'Найменування кл_єнта А';
COMMENT ON COLUMN BARS.TMP_SSP_V.NAM_B IS 'Найменування кл_єнта Б';
COMMENT ON COLUMN BARS.TMP_SSP_V.NAZN IS 'Призначення платежу';
COMMENT ON COLUMN BARS.TMP_SSP_V.D_REC IS 'Допом_жн_ рекв_зити';
COMMENT ON COLUMN BARS.TMP_SSP_V.NAZNK IS 'Резерв';
COMMENT ON COLUMN BARS.TMP_SSP_V.NAZNS IS 'Спос_б заповнення рекв_зит_в 14-15';
COMMENT ON COLUMN BARS.TMP_SSP_V.ID_A IS '_дентиф_кац_йний код кл_єнта А';
COMMENT ON COLUMN BARS.TMP_SSP_V.ID_B IS '_дентиф_кац_йний код кл_єнта Б';
COMMENT ON COLUMN BARS.TMP_SSP_V.REF_A IS 'Ун_кальний _дентиф_катор документа в САБ';
COMMENT ON COLUMN BARS.TMP_SSP_V.ID_O IS '_дентиф_катор операц_он_ста банка А';
COMMENT ON COLUMN BARS.TMP_SSP_V.BIS IS 'Номер рядку Б_Р';
COMMENT ON COLUMN BARS.TMP_SSP_V.RESERVED IS 'Резерв';
COMMENT ON COLUMN BARS.TMP_SSP_V.SIGN IS 'ЕЦП основних рекв_зит_в платежу';
COMMENT ON COLUMN BARS.TMP_SSP_V.TRANS_ID IS '_дентиф_катор трансакц_ї';
COMMENT ON COLUMN BARS.TMP_SSP_V.TRANS_LN IS 'Порядковий номер _Р у пакет_ 1.08';
COMMENT ON COLUMN BARS.TMP_SSP_V.SRC IS 'Ознака джерела документа: A-поч.гол.,B-в_дп.гол.,a-поч.ф_л.,b-в_дп.ф_л.';




PROMPT *** Create  constraint CC_TMP_SSP_V_TRANS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SSP_V MODIFY (TRANS_ID CONSTRAINT CC_TMP_SSP_V_TRANS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMP_SSP_V_SRC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SSP_V MODIFY (SRC CONSTRAINT CC_TMP_SSP_V_SRC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMP_SSP_V_TRANS_LN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SSP_V MODIFY (TRANS_LN CONSTRAINT CC_TMP_SSP_V_TRANS_LN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SSP_V ***
grant INSERT                                                                 on TMP_SSP_V       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_SSP_V       to BARS_DM;
grant INSERT                                                                 on TMP_SSP_V       to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_SSP_V       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SSP_V.sql =========*** End *** ===
PROMPT ===================================================================================== 
