

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_F98.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_F98 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_F98'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_F98'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_F98'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_F98 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_F98 
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
	MODIFY_DATE DATE, 
	DELETE_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_F98 ***
 exec bpa.alter_policies('CIM_F98');


COMMENT ON TABLE BARS.CIM_F98 IS 'База санкций Министерства Экономики в отношении (не)резидентов';
COMMENT ON COLUMN BARS.CIM_F98.DATNAKSK IS 'Дата приказа об отмене санкций';
COMMENT ON COLUMN BARS.CIM_F98.NOMNAKSK IS '№ приказа об отмене санкций';
COMMENT ON COLUMN BARS.CIM_F98.SANKSIA1 IS 'Вид санкции';
COMMENT ON COLUMN BARS.CIM_F98.SRSANK11 IS 'Дата начала действия санкции';
COMMENT ON COLUMN BARS.CIM_F98.SRSANK12 IS 'Дата окончания действия санкции';
COMMENT ON COLUMN BARS.CIM_F98.R4 IS 'Наименование нерезидента';
COMMENT ON COLUMN BARS.CIM_F98.R030 IS 'Код валюты';
COMMENT ON COLUMN BARS.CIM_F98.T071 IS 'Сумма долга';
COMMENT ON COLUMN BARS.CIM_F98.K040 IS 'Код страны нерезидента';
COMMENT ON COLUMN BARS.CIM_F98.BANKIN IS '';
COMMENT ON COLUMN BARS.CIM_F98.ADRIN IS '';
COMMENT ON COLUMN BARS.CIM_F98.DATA_M IS 'Дата записи инф-ции в БД';
COMMENT ON COLUMN BARS.CIM_F98.LINE_HASH IS 'Хеш стрічки';
COMMENT ON COLUMN BARS.CIM_F98.MODIFY_DATE IS 'Дата модифікації стрічки';
COMMENT ON COLUMN BARS.CIM_F98.DELETE_DATE IS 'Дата видалення стрічки';
COMMENT ON COLUMN BARS.CIM_F98.NP IS 'Номер периода';
COMMENT ON COLUMN BARS.CIM_F98.DT IS 'Дата';
COMMENT ON COLUMN BARS.CIM_F98.EK_POK IS 'Эконом.показатель';
COMMENT ON COLUMN BARS.CIM_F98.KO IS 'Код обл.';
COMMENT ON COLUMN BARS.CIM_F98.MFO IS 'МФО банка';
COMMENT ON COLUMN BARS.CIM_F98.NKB IS '';
COMMENT ON COLUMN BARS.CIM_F98.KU IS 'Код управления';
COMMENT ON COLUMN BARS.CIM_F98.PRB IS '';
COMMENT ON COLUMN BARS.CIM_F98.K030 IS 'Санкции к резид(1)/нерезид(2)';
COMMENT ON COLUMN BARS.CIM_F98.V_SANK IS 'Санкции актив.(1)/отмен(2)';
COMMENT ON COLUMN BARS.CIM_F98.KO_1 IS 'Код обл.резидента';
COMMENT ON COLUMN BARS.CIM_F98.R1_1 IS 'Наименование резидента';
COMMENT ON COLUMN BARS.CIM_F98.R2_1 IS 'Адрес резидента';
COMMENT ON COLUMN BARS.CIM_F98.K020 IS 'Код ОКПО резидента';
COMMENT ON COLUMN BARS.CIM_F98.DATAPOD IS '';
COMMENT ON COLUMN BARS.CIM_F98.NOMPOD IS '';
COMMENT ON COLUMN BARS.CIM_F98.DJERPOD IS 'Инициатор применения санкций';
COMMENT ON COLUMN BARS.CIM_F98.NAKAZ IS 'Тип (применение,приостановка,отмена)';
COMMENT ON COLUMN BARS.CIM_F98.DATANAK IS 'Дата приказа о применении санкций';
COMMENT ON COLUMN BARS.CIM_F98.NOMNAK IS '№ приказа о применении санкций';
COMMENT ON COLUMN BARS.CIM_F98.DATPODSK IS '';
COMMENT ON COLUMN BARS.CIM_F98.NOMPODSK IS '';
COMMENT ON COLUMN BARS.CIM_F98.DJERPODS IS 'Инициатор отмены санкций';




PROMPT *** Create  constraint PK_CIMF98 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F98 ADD CONSTRAINT PK_CIMF98 PRIMARY KEY (LINE_HASH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CIMF98_R4 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CIMF98_R4 ON BARS.CIM_F98 (R4) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CIMF98_K020 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CIMF98_K020 ON BARS.CIM_F98 (K020) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMF98 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMF98 ON BARS.CIM_F98 (LINE_HASH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_F98 ***
grant SELECT                                                                 on CIM_F98         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_F98         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_F98         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_F98         to CIM_ROLE;
grant SELECT                                                                 on CIM_F98         to UPLD;
grant SELECT                                                                 on CIM_F98         to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_F98.sql =========*** End *** =====
PROMPT ===================================================================================== 
