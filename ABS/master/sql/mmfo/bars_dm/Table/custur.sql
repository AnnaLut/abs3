

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/CUSTUR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  table CUSTUR ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.CUSTUR 
   (	PER_ID NUMBER, 
	KF VARCHAR2(6), 
	RNK NUMBER(15,0), 
	BRANCH VARCHAR2(30), 
	NMK VARCHAR2(70), 
	NMKK VARCHAR2(38), 
	RUK VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	E_MAIL VARCHAR2(100), 
	TELR VARCHAR2(20), 
	TELB VARCHAR2(20), 
	TEL_FAX VARCHAR2(20), 
	DATE_ON DATE, 
	DATE_OFF DATE, 
	AU_CONTRY NUMBER, 
	AU_ZIP VARCHAR2(20), 
	AU_DOMAIN VARCHAR2(30), 
	AU_REGION VARCHAR2(30), 
	AU_LOCALITY_TYPE NUMBER, 
	AU_LOCALITY VARCHAR2(30), 
	AU_ADRESS VARCHAR2(100), 
	AU_STREET_TYPE NUMBER, 
	AU_STREET VARCHAR2(100), 
	AU_HOME_TYPE NUMBER, 
	AU_HOME VARCHAR2(100), 
	AU_HOMEPART_TYPE NUMBER, 
	AU_HOMEPART VARCHAR2(100), 
	AU_ROOM_TYPE NUMBER, 
	AU_ROOM VARCHAR2(100), 
	AF_CONTRY NUMBER, 
	AF_ZIP VARCHAR2(20), 
	AF_DOMAIN VARCHAR2(30), 
	AF_REGION VARCHAR2(30), 
	AF_LOCALITY_TYPE NUMBER, 
	AF_LOCALITY VARCHAR2(30), 
	AF_ADRESS VARCHAR2(100), 
	AF_STREET_TYPE NUMBER, 
	AF_STREET VARCHAR2(100), 
	AF_HOME_TYPE NUMBER, 
	AF_HOME VARCHAR2(100), 
	AF_HOMEPART_TYPE NUMBER, 
	AF_HOMEPART VARCHAR2(100), 
	AF_ROOM_TYPE NUMBER, 
	AF_ROOM VARCHAR2(100), 
	FSDRY VARCHAR2(500), 
	FSKPR VARCHAR2(500), 
	VED VARCHAR2(5), 
	IDPIB VARCHAR2(500), 
	UUDV VARCHAR2(500), 
	KVPKK VARCHAR2(500), 
	OE VARCHAR2(5), 
	ISE VARCHAR2(5), 
	FS VARCHAR2(2), 
	SED VARCHAR2(4), 
	REZID NUMBER, 
	AINAB VARCHAR2(500), 
	FSVED VARCHAR2(500), 
	KBFL NUMBER(1,0), 
	PRINSIDER NUMBER(38,0), 
	COUNTRY NUMBER(3,0), 
	CUSTTYPE NUMBER(1,0), 
	LASTCHANGEDT DATE, 
	GCIF VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
tablespace BRSDMIMP
PARTITION BY LIST (PER_ID) SUBPARTITION by list (KF)
SUBPARTITION TEMPLATE
         (SUBPARTITION KF_300465 VALUES (''300465''),
            SUBPARTITION KF_302076 VALUES (''302076''),
            SUBPARTITION KF_303398 VALUES (''303398''),
            SUBPARTITION KF_304665 VALUES (''304665''),
            SUBPARTITION KF_305482 VALUES (''305482''),
            SUBPARTITION KF_311647 VALUES (''311647''),
            SUBPARTITION KF_312356 VALUES (''312356''),
            SUBPARTITION KF_313957 VALUES (''313957''),
            SUBPARTITION KF_315784 VALUES (''315784''),
            SUBPARTITION KF_322669 VALUES (''322669''),
            SUBPARTITION KF_323475 VALUES (''323475''),
            SUBPARTITION KF_324805 VALUES (''324805''),
            SUBPARTITION KF_325796 VALUES (''325796''),
            SUBPARTITION KF_326461 VALUES (''326461''),
            SUBPARTITION KF_328845 VALUES (''328845''),
            SUBPARTITION KF_331467 VALUES (''331467''),
            SUBPARTITION KF_333368 VALUES (''333368''),
            SUBPARTITION KF_335106 VALUES (''335106''),
            SUBPARTITION KF_336503 VALUES (''336503''),
            SUBPARTITION KF_337568 VALUES (''337568''),
            SUBPARTITION KF_338545 VALUES (''338545''),
            SUBPARTITION KF_351823 VALUES (''351823''),
            SUBPARTITION KF_352457 VALUES (''352457''),
            SUBPARTITION KF_353553 VALUES (''353553''),
            SUBPARTITION KF_354507 VALUES (''354507''),
            SUBPARTITION KF_356334 VALUES (''356334'')
          )
(PARTITION INITIAL_PARTITION VALUES (0)) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.CUSTUR IS '�������� �����';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_ADRESS IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_STREET_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_STREET IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_HOME_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_HOME IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_HOMEPART_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_HOMEPART IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_ROOM_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_ROOM IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_CONTRY IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_ZIP IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_DOMAIN IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_REGION IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_LOCALITY_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_LOCALITY IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_ADRESS IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_STREET_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_STREET IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_HOME_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_HOME IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_HOMEPART_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_HOMEPART IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_ROOM_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AF_ROOM IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.FSDRY IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.FSKPR IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.VED IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.IDPIB IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.UUDV IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.KVPKK IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.OE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.ISE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.FS IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.SED IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.REZID IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AINAB IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.FSVED IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.KBFL IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.PRINSIDER IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.COUNTRY IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.CUSTTYPE IS '��� �볺���';
COMMENT ON COLUMN BARS_DM.CUSTUR.LASTCHANGEDT IS '���� ������������ (�������� ����)';
COMMENT ON COLUMN BARS_DM.CUSTUR.GCIF IS 'GCIF';
COMMENT ON COLUMN BARS_DM.CUSTUR.PER_ID IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.KF IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.RNK IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.BRANCH IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.NMK IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.NMKK IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.RUK IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.OKPO IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.E_MAIL IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.TELR IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.TELB IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.TEL_FAX IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.DATE_ON IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.DATE_OFF IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_CONTRY IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_ZIP IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_DOMAIN IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_REGION IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_LOCALITY_TYPE IS '';
COMMENT ON COLUMN BARS_DM.CUSTUR.AU_LOCALITY IS '';




PROMPT *** Create  index I_CUSTUR_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_CUSTUR_PERID ON BARS_DM.CUSTUR (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTUR ***
grant SELECT                                                                 on CUSTUR          to BARS;
grant SELECT                                                                 on CUSTUR          to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTUR          to BARSUPL;
grant SELECT                                                                 on CUSTUR          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/CUSTUR.sql =========*** End *** ===
PROMPT ===================================================================================== 
