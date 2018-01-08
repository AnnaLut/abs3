

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_VOB96.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_VOB96 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_VOB96 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_VOB96 
   (	ID NUMBER(*,0), 
	REF NUMBER(*,0), 
	VDAT VARCHAR2(10), 
	FDAT DATE, 
	ND VARCHAR2(10), 
	NLSA VARCHAR2(15), 
	KVA NUMBER(*,0), 
	NAMA VARCHAR2(70), 
	NLSB VARCHAR2(15), 
	KVB NUMBER(*,0), 
	NAMB VARCHAR2(70), 
	SUMM NUMBER(24,0), 
	SQ NUMBER(24,0), 
	NAZN VARCHAR2(160), 
	ISP NUMBER(*,0), 
	JEAR VARCHAR2(10), 
	TT CHAR(3), 
	CC NUMBER(*,0), 
	D6 NUMBER(24,0), 
	K6 NUMBER(24,0), 
	D7 NUMBER(24,0), 
	K7 NUMBER(24,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_VOB96 ***
 exec bpa.alter_policies('TMP_VOB96');


COMMENT ON TABLE BARS.TMP_VOB96 IS 'Временная таблица для реестра кор проводок (vob=96,99)';
COMMENT ON COLUMN BARS.TMP_VOB96.ID IS '';
COMMENT ON COLUMN BARS.TMP_VOB96.REF IS 'Референс';
COMMENT ON COLUMN BARS.TMP_VOB96.VDAT IS 'Название месяца, за который проводки';
COMMENT ON COLUMN BARS.TMP_VOB96.FDAT IS 'Дата проводки';
COMMENT ON COLUMN BARS.TMP_VOB96.ND IS 'Номер документа';
COMMENT ON COLUMN BARS.TMP_VOB96.NLSA IS 'Счет по ДТ';
COMMENT ON COLUMN BARS.TMP_VOB96.KVA IS 'Валюта ДТ';
COMMENT ON COLUMN BARS.TMP_VOB96.NAMA IS 'Название счета ДТ';
COMMENT ON COLUMN BARS.TMP_VOB96.NLSB IS 'Счет КТ';
COMMENT ON COLUMN BARS.TMP_VOB96.KVB IS 'Валюта КТ';
COMMENT ON COLUMN BARS.TMP_VOB96.NAMB IS 'Названгие счета КТ';
COMMENT ON COLUMN BARS.TMP_VOB96.SUMM IS 'Сумма проводки в номинале';
COMMENT ON COLUMN BARS.TMP_VOB96.SQ IS 'Гривневый эквивалент суммы проводки';
COMMENT ON COLUMN BARS.TMP_VOB96.NAZN IS 'Назначение платежа';
COMMENT ON COLUMN BARS.TMP_VOB96.ISP IS 'Исполнитель по документу';
COMMENT ON COLUMN BARS.TMP_VOB96.JEAR IS 'Год';
COMMENT ON COLUMN BARS.TMP_VOB96.TT IS 'Код операции';
COMMENT ON COLUMN BARS.TMP_VOB96.CC IS 'Количество документов по исп';
COMMENT ON COLUMN BARS.TMP_VOB96.D6 IS 'Общая сумма по ДТ 6 кл по исп';
COMMENT ON COLUMN BARS.TMP_VOB96.K6 IS 'Общая сумма по КТ  6 кл по исп';
COMMENT ON COLUMN BARS.TMP_VOB96.D7 IS 'Общая сумма по ДТ7 кл  по исп';
COMMENT ON COLUMN BARS.TMP_VOB96.K7 IS 'Общая сумма по КТ 7 кл  по исп';



PROMPT *** Create  grants  TMP_VOB96 ***
grant SELECT                                                                 on TMP_VOB96       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_VOB96       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_VOB96       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_VOB96       to RPBN001;
grant SELECT                                                                 on TMP_VOB96       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_VOB96       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_VOB96.sql =========*** End *** ===
PROMPT ===================================================================================== 
