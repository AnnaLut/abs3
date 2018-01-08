

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/F98.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to F98 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''F98'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''F98'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''F98'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table F98 ***
begin 
  execute immediate '
  CREATE TABLE BARS.F98 
   (	NP NUMBER, 
	DAT DATE, 
	EK_POK CHAR(5), 
	KO VARCHAR2(3), 
	MFO VARCHAR2(12), 
	KU VARCHAR2(3), 
	REZID NUMBER(1,0), 
	V_SANK NUMBER(1,0), 
	RNK NUMBER, 
	OBL VARCHAR2(3), 
	NMK VARCHAR2(100), 
	ADR VARCHAR2(100), 
	OKPO VARCHAR2(10), 
	SOUR_ON VARCHAR2(20), 
	TYPE_ON VARCHAR2(20), 
	DATE_ON DATE, 
	NAME_ON VARCHAR2(50), 
	SOUR_OFF VARCHAR2(20), 
	DATE_OFF DATE, 
	NAME_OFF VARCHAR2(50), 
	SANK VARCHAR2(5), 
	SANK_ON DATE, 
	SANK_OFF DATE, 
	BENEF VARCHAR2(100), 
	KV NUMBER, 
	DEBT_SUM NUMBER, 
	COUNTRY NUMBER, 
	REC_DAT DATE, 
	ND VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to F98 ***
 exec bpa.alter_policies('F98');


COMMENT ON TABLE BARS.F98 IS 'База санкций Министерства Экономики в отношении (не)резидентов';
COMMENT ON COLUMN BARS.F98.NP IS 'Номер периода';
COMMENT ON COLUMN BARS.F98.DAT IS 'Дата';
COMMENT ON COLUMN BARS.F98.EK_POK IS 'Эконом.показатель';
COMMENT ON COLUMN BARS.F98.KO IS 'Код обл.';
COMMENT ON COLUMN BARS.F98.MFO IS 'МФО банка';
COMMENT ON COLUMN BARS.F98.KU IS 'Код управления';
COMMENT ON COLUMN BARS.F98.REZID IS 'Санкции к резид(1)/нерезид(2)';
COMMENT ON COLUMN BARS.F98.V_SANK IS 'Санкции актив.(1)/отмен(2)';
COMMENT ON COLUMN BARS.F98.RNK IS 'Регистрац.№ клиента';
COMMENT ON COLUMN BARS.F98.OBL IS 'Код обл.резидента';
COMMENT ON COLUMN BARS.F98.NMK IS 'Наименование резидента';
COMMENT ON COLUMN BARS.F98.ADR IS 'Адрес резидента';
COMMENT ON COLUMN BARS.F98.OKPO IS 'Код ОКПО резидента';
COMMENT ON COLUMN BARS.F98.SOUR_ON IS 'Инициатор применения санкций';
COMMENT ON COLUMN BARS.F98.TYPE_ON IS 'Тип (применение,приостановка,отмена)';
COMMENT ON COLUMN BARS.F98.DATE_ON IS 'Дата приказа о применении санкций';
COMMENT ON COLUMN BARS.F98.NAME_ON IS '№ приказа о применении санкций';
COMMENT ON COLUMN BARS.F98.SOUR_OFF IS 'Инициатор отмены санкций';
COMMENT ON COLUMN BARS.F98.DATE_OFF IS 'Дата приказа об отмене санкций';
COMMENT ON COLUMN BARS.F98.NAME_OFF IS '№ приказа об отмене санкций';
COMMENT ON COLUMN BARS.F98.SANK IS 'Вид санкции';
COMMENT ON COLUMN BARS.F98.SANK_ON IS 'Дата начала действия санкции';
COMMENT ON COLUMN BARS.F98.SANK_OFF IS 'Дата окончания действия санкции';
COMMENT ON COLUMN BARS.F98.BENEF IS 'Наименование нерезидента';
COMMENT ON COLUMN BARS.F98.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.F98.DEBT_SUM IS 'Сумма долга';
COMMENT ON COLUMN BARS.F98.COUNTRY IS 'Код страны нерезидента';
COMMENT ON COLUMN BARS.F98.REC_DAT IS 'Дата записи инф-ции в БД';
COMMENT ON COLUMN BARS.F98.ND IS '';



PROMPT *** Create  grants  F98 ***
grant SELECT                                                                 on F98             to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on F98             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on F98             to BARS_DM;
grant DELETE,INSERT,SELECT                                                   on F98             to F_500;
grant SELECT                                                                 on F98             to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on F98             to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/F98.sql =========*** End *** =========
PROMPT ===================================================================================== 
