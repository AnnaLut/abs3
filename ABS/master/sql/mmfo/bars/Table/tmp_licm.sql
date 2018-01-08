

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_LICM.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_LICM ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_LICM ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_LICM 
   (	FDAT DATE, 
	TIP CHAR(3), 
	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER(38,0), 
	NMS VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	NMK VARCHAR2(70), 
	DAPP DATE, 
	ISP NUMBER, 
	OSTF NUMBER, 
	OSTFQ NUMBER, 
	OSTFR NUMBER, 
	DOS NUMBER, 
	KOS NUMBER, 
	DOSQ NUMBER, 
	KOSQ NUMBER, 
	DOSR NUMBER, 
	KOSR NUMBER, 
	REF NUMBER, 
	NLS2 VARCHAR2(14), 
	MFO2 VARCHAR2(6), 
	NB2 VARCHAR2(38), 
	NMK2 VARCHAR2(70), 
	OKPO2 VARCHAR2(14), 
	S NUMBER(24,0), 
	SQ NUMBER(24,0), 
	ND VARCHAR2(10), 
	NAZN VARCHAR2(230), 
	TT CHAR(3), 
	SK NUMBER, 
	VOB NUMBER, 
	BIS NUMBER, 
	DK NUMBER, 
	DATD DATE, 
	DATP DATE, 
	VDAT DATE, 
	USERID NUMBER, 
	BRANCH VARCHAR2(30), 
	ROWTYPE NUMBER, 
	GRPLIST VARCHAR2(70), 
	D_REC VARCHAR2(60), 
	REFNLS VARCHAR2(14), 
	NLSALT VARCHAR2(15)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_LICM ***
 exec bpa.alter_policies('TMP_LICM');


COMMENT ON TABLE BARS.TMP_LICM IS 'Временная таблица для отчетности по выпискам';
COMMENT ON COLUMN BARS.TMP_LICM.NLSALT IS 'Альтернативный номер счета';
COMMENT ON COLUMN BARS.TMP_LICM.FDAT IS 'Дата движения по счету';
COMMENT ON COLUMN BARS.TMP_LICM.TIP IS 'тип  счета';
COMMENT ON COLUMN BARS.TMP_LICM.ACC IS 'acc счета';
COMMENT ON COLUMN BARS.TMP_LICM.NLS IS 'Лицевой счет выписки';
COMMENT ON COLUMN BARS.TMP_LICM.KV IS 'Валюта счета выписки';
COMMENT ON COLUMN BARS.TMP_LICM.NMS IS 'Наименование счет выписки';
COMMENT ON COLUMN BARS.TMP_LICM.OKPO IS 'ОКПО клиента счета';
COMMENT ON COLUMN BARS.TMP_LICM.NMK IS 'Наименовнаие клиента счета';
COMMENT ON COLUMN BARS.TMP_LICM.DAPP IS 'Датат пред. движения по счету выписки';
COMMENT ON COLUMN BARS.TMP_LICM.ISP IS 'Исполнитель счета';
COMMENT ON COLUMN BARS.TMP_LICM.OSTF IS 'Входящий остаток на дату движения';
COMMENT ON COLUMN BARS.TMP_LICM.OSTFQ IS 'Входящий остаток(эквив) на дату движения';
COMMENT ON COLUMN BARS.TMP_LICM.OSTFR IS 'Входящий остаток(с переоценкой) на дату движения';
COMMENT ON COLUMN BARS.TMP_LICM.DOS IS 'Обороты дебет';
COMMENT ON COLUMN BARS.TMP_LICM.KOS IS 'Обороты кредит';
COMMENT ON COLUMN BARS.TMP_LICM.DOSQ IS 'Обороты дебет (эквив)';
COMMENT ON COLUMN BARS.TMP_LICM.KOSQ IS 'Обороты кредит (эквив)';
COMMENT ON COLUMN BARS.TMP_LICM.DOSR IS 'Обороты дебет (с переоценкой)';
COMMENT ON COLUMN BARS.TMP_LICM.KOSR IS 'Обороты кредит (с переоценкой)';
COMMENT ON COLUMN BARS.TMP_LICM.REF IS 'Реф. документа';
COMMENT ON COLUMN BARS.TMP_LICM.NLS2 IS 'Счет корреспондента';
COMMENT ON COLUMN BARS.TMP_LICM.MFO2 IS 'МФО корреспондента';
COMMENT ON COLUMN BARS.TMP_LICM.NB2 IS 'Наименование банка корреспондента';
COMMENT ON COLUMN BARS.TMP_LICM.NMK2 IS 'Наименование корреспондента';
COMMENT ON COLUMN BARS.TMP_LICM.OKPO2 IS 'ОКПО корреспондента';
COMMENT ON COLUMN BARS.TMP_LICM.S IS 'Сумма док-та';
COMMENT ON COLUMN BARS.TMP_LICM.SQ IS 'Эквивалент суммы док-та';
COMMENT ON COLUMN BARS.TMP_LICM.ND IS '№ документа';
COMMENT ON COLUMN BARS.TMP_LICM.NAZN IS 'Назначение';
COMMENT ON COLUMN BARS.TMP_LICM.TT IS 'Код операции';
COMMENT ON COLUMN BARS.TMP_LICM.SK IS 'Символ касс. плана';
COMMENT ON COLUMN BARS.TMP_LICM.VOB IS 'Вид обработки';
COMMENT ON COLUMN BARS.TMP_LICM.BIS IS 'Номер бис строки';
COMMENT ON COLUMN BARS.TMP_LICM.DK IS 'Признак ДК (0-списанеи со счета, 1-зачисление на счет, >1-информационные строки(расшивровку смотри в процедуре bars_rptlic.get_inform_docs))';
COMMENT ON COLUMN BARS.TMP_LICM.DATD IS 'Дата ввода документа';
COMMENT ON COLUMN BARS.TMP_LICM.DATP IS 'Дата оплаты документа';
COMMENT ON COLUMN BARS.TMP_LICM.VDAT IS '';
COMMENT ON COLUMN BARS.TMP_LICM.USERID IS 'Код исполниетля документа';
COMMENT ON COLUMN BARS.TMP_LICM.BRANCH IS 'Оделение, в кот. был создан док-т';
COMMENT ON COLUMN BARS.TMP_LICM.ROWTYPE IS '';
COMMENT ON COLUMN BARS.TMP_LICM.GRPLIST IS 'Список отчетных групп в кот. входит счет';
COMMENT ON COLUMN BARS.TMP_LICM.D_REC IS '';
COMMENT ON COLUMN BARS.TMP_LICM.REFNLS IS 'Лицевой счет по которому был выполнен платеж(если выписка делается по родительскому счету - не дочернему)';



PROMPT *** Create  grants  TMP_LICM ***
grant SELECT                                                                 on TMP_LICM        to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_LICM        to BARS_ACCESS_DEFROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_LICM        to RPBN001;
grant SELECT                                                                 on TMP_LICM        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_LICM.sql =========*** End *** ====
PROMPT ===================================================================================== 
