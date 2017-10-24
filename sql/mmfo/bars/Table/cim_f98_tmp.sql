

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_F98_TMP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_F98_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_F98_TMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_F98_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_F98_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_F98_TMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.CIM_F98_TMP 
   (	NP VARCHAR2(2), 
	DT DATE, 
	EK_POK VARCHAR2(5), 
	KO VARCHAR2(3), 
	MFO VARCHAR2(6), 
	NKB VARCHAR2(3), 
	KU VARCHAR2(3), 
	PRB VARCHAR2(1), 
	K030 NUMBER(1,0), 
	V_SANK NUMBER(1,0), 
	KO_1 VARCHAR2(3), 
	R1_1 VARCHAR2(100), 
	R2_1 VARCHAR2(100), 
	K020 VARCHAR2(10), 
	DATAPOD DATE, 
	NOMPOD VARCHAR2(16), 
	DJERPOD VARCHAR2(20), 
	NAKAZ VARCHAR2(20), 
	DATANAK DATE, 
	NOMNAK VARCHAR2(16), 
	DATPODSK DATE, 
	NOMPODSK VARCHAR2(16), 
	DJERPODS VARCHAR2(20), 
	DATNAKSK DATE, 
	NOMNAKSK VARCHAR2(50), 
	SANKSIA1 VARCHAR2(5), 
	SRSANK11 DATE, 
	SRSANK12 DATE, 
	R4 VARCHAR2(100), 
	R030 VARCHAR2(3), 
	T071 NUMBER(16,0), 
	K040 VARCHAR2(3), 
	BANKIN VARCHAR2(200), 
	ADRIN VARCHAR2(200), 
	DATA_M DATE, 
	LINE_HASH RAW(20), 
	MODIFY_DATE DATE DEFAULT sysdate, 
	DELETE_DATE DATE
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_F98_TMP ***
 exec bpa.alter_policies('CIM_F98_TMP');


COMMENT ON TABLE BARS.CIM_F98_TMP IS 'Тимчасова таблиця санкцій мінекономіки';
COMMENT ON COLUMN BARS.CIM_F98_TMP.NP IS 'Номер периода';
COMMENT ON COLUMN BARS.CIM_F98_TMP.DT IS 'Дата';
COMMENT ON COLUMN BARS.CIM_F98_TMP.EK_POK IS 'Эконом.показатель';
COMMENT ON COLUMN BARS.CIM_F98_TMP.KO IS 'Код обл.';
COMMENT ON COLUMN BARS.CIM_F98_TMP.MFO IS 'МФО банка';
COMMENT ON COLUMN BARS.CIM_F98_TMP.NKB IS '';
COMMENT ON COLUMN BARS.CIM_F98_TMP.KU IS 'Код управления';
COMMENT ON COLUMN BARS.CIM_F98_TMP.PRB IS '';
COMMENT ON COLUMN BARS.CIM_F98_TMP.K030 IS 'Санкции к резид(1)/нерезид(2)';
COMMENT ON COLUMN BARS.CIM_F98_TMP.V_SANK IS 'Санкции актив.(1)/отмен(2)';
COMMENT ON COLUMN BARS.CIM_F98_TMP.KO_1 IS 'Код обл.резидента';
COMMENT ON COLUMN BARS.CIM_F98_TMP.R1_1 IS 'Наименование резидента';
COMMENT ON COLUMN BARS.CIM_F98_TMP.R2_1 IS 'Адрес резидента';
COMMENT ON COLUMN BARS.CIM_F98_TMP.K020 IS 'Код ОКПО резидента';
COMMENT ON COLUMN BARS.CIM_F98_TMP.DATAPOD IS '';
COMMENT ON COLUMN BARS.CIM_F98_TMP.NOMPOD IS '';
COMMENT ON COLUMN BARS.CIM_F98_TMP.DJERPOD IS 'Инициатор применения санкций';
COMMENT ON COLUMN BARS.CIM_F98_TMP.NAKAZ IS 'Тип (применение,приостановка,отмена)';
COMMENT ON COLUMN BARS.CIM_F98_TMP.DATANAK IS 'Дата приказа о применении санкций';
COMMENT ON COLUMN BARS.CIM_F98_TMP.NOMNAK IS '№ приказа о применении санкций';
COMMENT ON COLUMN BARS.CIM_F98_TMP.DATPODSK IS '';
COMMENT ON COLUMN BARS.CIM_F98_TMP.NOMPODSK IS '';
COMMENT ON COLUMN BARS.CIM_F98_TMP.DJERPODS IS 'Инициатор отмены санкций';
COMMENT ON COLUMN BARS.CIM_F98_TMP.DATNAKSK IS 'Дата приказа об отмене санкций';
COMMENT ON COLUMN BARS.CIM_F98_TMP.NOMNAKSK IS '№ приказа об отмене санкций';
COMMENT ON COLUMN BARS.CIM_F98_TMP.SANKSIA1 IS 'Вид санкции';
COMMENT ON COLUMN BARS.CIM_F98_TMP.SRSANK11 IS 'Дата начала действия санкции';
COMMENT ON COLUMN BARS.CIM_F98_TMP.SRSANK12 IS 'Дата окончания действия санкции';
COMMENT ON COLUMN BARS.CIM_F98_TMP.R4 IS 'Наименование нерезидента';
COMMENT ON COLUMN BARS.CIM_F98_TMP.R030 IS 'Код валюты';
COMMENT ON COLUMN BARS.CIM_F98_TMP.T071 IS 'Сумма долга';
COMMENT ON COLUMN BARS.CIM_F98_TMP.K040 IS 'Код страны нерезидента';
COMMENT ON COLUMN BARS.CIM_F98_TMP.BANKIN IS '';
COMMENT ON COLUMN BARS.CIM_F98_TMP.ADRIN IS '';
COMMENT ON COLUMN BARS.CIM_F98_TMP.DATA_M IS 'Дата записи инф-ции в БД';
COMMENT ON COLUMN BARS.CIM_F98_TMP.LINE_HASH IS 'Хеш стрічки';
COMMENT ON COLUMN BARS.CIM_F98_TMP.MODIFY_DATE IS 'Дата модифікації стрічки';
COMMENT ON COLUMN BARS.CIM_F98_TMP.DELETE_DATE IS 'Дата видалення стрічки';




PROMPT *** Create  constraint PK_CIMF98_TMP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F98_TMP ADD CONSTRAINT PK_CIMF98_TMP PRIMARY KEY (LINE_HASH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMF98_TMP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMF98_TMP ON BARS.CIM_F98_TMP (LINE_HASH) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_F98_TMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_F98_TMP     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_F98_TMP     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_F98_TMP     to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_F98_TMP.sql =========*** End *** =
PROMPT ===================================================================================== 
