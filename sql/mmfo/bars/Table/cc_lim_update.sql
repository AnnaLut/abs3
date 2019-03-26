

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_LIM_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_LIM_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_LIM_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_LIM_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_LIM_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_LIM_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_LIM_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ND NUMBER(38,0), 
	FDAT DATE, 
	LIM2 NUMBER(38,0), 
	ACC NUMBER(*,0), 
	NOT_9129 NUMBER(*,0), 
	SUMG NUMBER(38,0), 
	SUMO NUMBER(38,0), 
	OTM NUMBER(*,0), 
	KF VARCHAR2(6), 
	SUMK NUMBER, 
	NOT_SN NUMBER(*,0)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255  NOLOGGING 
  TABLESPACE BRSBIGD 
  PARTITION BY LIST (KF) 
 (PARTITION P_01_300465  VALUES (''300465'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_02_324805  VALUES (''324805'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_03_302076  VALUES (''302076'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_04_303398  VALUES (''303398'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_05_305482  VALUES (''305482'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_06_335106  VALUES (''335106'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_07_311647  VALUES (''311647'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_08_312356  VALUES (''312356'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_09_313957  VALUES (''313957'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_10_336503  VALUES (''336503'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_11_322669  VALUES (''322669'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_12_323475  VALUES (''323475'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_13_304665  VALUES (''304665'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_14_325796  VALUES (''325796'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_15_326461  VALUES (''326461'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_16_328845  VALUES (''328845'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_17_331467  VALUES (''331467'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_18_333368  VALUES (''333368'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_19_337568  VALUES (''337568'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_20_338545  VALUES (''338545'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_21_351823  VALUES (''351823'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_22_352457  VALUES (''352457'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_23_315784  VALUES (''315784'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_24_354507  VALUES (''354507'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_25_356334  VALUES (''356334'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_26_353553  VALUES (''353553'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING 
  TABLESPACE BRSBIGD ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_LIM_UPDATE ***
 exec bpa.alter_policies('CC_LIM_UPDATE');


COMMENT ON TABLE BARS.CC_LIM_UPDATE IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.CHGACTION IS '��� ���������� (I/U/D)';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.EFFECTDATE IS '���������� ���� ������ �������� ����������';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.CHGDATE IS '���������� ���� ����������';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.DONEBY IS '��� ������������. ��� ���� ����������(���� � ������� ��� ���� ��������� ���������� - �������� ������ ���������)';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.ND IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.FDAT IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.LIM2 IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.NOT_9129 IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.SUMG IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.SUMO IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.OTM IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.SUMK IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.NOT_SN IS '';
COMMENT ON COLUMN BARS.CC_LIM_UPDATE.IDUPD IS '��������� ���� ��� ������� ����������';




PROMPT *** Create  constraint SYS_C0034029 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_UPDATE MODIFY (KF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CCLIM_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_UPDATE ADD CONSTRAINT PK_CCLIM_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCLIM_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCLIM_UPDATEEFFDAT ON BARS.CC_LIM_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION P_01_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_02_324805 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_03_302076 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_04_303398 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_05_305482 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_06_335106 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_07_311647 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_08_312356 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_09_313957 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_10_336503 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_11_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_12_323475 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_13_304665 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_14_325796 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_15_326461 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_16_328845 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_17_331467 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_18_333368 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_19_337568 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_20_338545 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_21_351823 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_22_352457 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_23_315784 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_24_354507 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_25_356334 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_26_353553 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CCLIM_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CCLIM_UPDATEPK ON BARS.CC_LIM_UPDATE (ND, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE BRSBIGI  LOCAL
 (PARTITION P_01_300465 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_02_324805 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_03_302076 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_04_303398 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_05_305482 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_06_335106 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_07_311647 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_08_312356 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_09_313957 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_10_336503 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_11_322669 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_12_323475 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_13_304665 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_14_325796 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_15_326461 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_16_328845 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_17_331467 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_18_333368 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_19_337568 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_20_338545 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_21_351823 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_22_352457 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_23_315784 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_24_354507 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_25_356334 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI , 
 PARTITION P_26_353553 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSBIGI ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCLIM_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCLIM_UPDATE ON BARS.CC_LIM_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_LIM_UPDATE ***
grant SELECT                                                                 on CC_LIM_UPDATE   to BARSREADER_ROLE;
grant SELECT                                                                 on CC_LIM_UPDATE   to BARSUPL;
grant SELECT                                                                 on CC_LIM_UPDATE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_LIM_UPDATE   to BARS_DM;
grant SELECT                                                                 on CC_LIM_UPDATE   to KLBX;
grant SELECT                                                                 on CC_LIM_UPDATE   to START1;
grant SELECT                                                                 on CC_LIM_UPDATE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_LIM_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 