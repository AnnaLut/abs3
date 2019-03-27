PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_ACC_INST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_ACC_INST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_ACC_INST'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''W4_ACC_INST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''W4_ACC_INST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_ACC_INST ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_ACC_INST 
   (ND NUMBER, 
	ACC_PK NUMBER, 
	CHAIN_IDT NUMBER, 
	TRANS_MASK VARCHAR2(15), 
	ACC NUMBER,
    CRT_BD DATE,
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSMDLD 
  PARTITION BY LIST (KF) 
 (PARTITION P_01_300465  VALUES (''300465'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_02_324805  VALUES (''324805'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_03_302076  VALUES (''302076'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_04_303398  VALUES (''303398'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_05_305482  VALUES (''305482'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_06_335106  VALUES (''335106'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_07_311647  VALUES (''311647'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_08_312356  VALUES (''312356'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_09_313957  VALUES (''313957'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_10_336503  VALUES (''336503'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_11_322669  VALUES (''322669'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_12_323475  VALUES (''323475'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_13_304665  VALUES (''304665'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_14_325796  VALUES (''325796'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_15_326461  VALUES (''326461'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_16_328845  VALUES (''328845'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_17_331467  VALUES (''331467'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_18_333368  VALUES (''333368'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_19_337568  VALUES (''337568'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_20_338545  VALUES (''338545'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_21_351823  VALUES (''351823'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_22_352457  VALUES (''352457'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_23_315784  VALUES (''315784'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_24_354507  VALUES (''354507'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_25_356334  VALUES (''356334'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_26_353553  VALUES (''353553'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_ACC_INST ***
 exec bpa.alter_policies('W4_ACC_INST');


COMMENT ON TABLE BARS.W4_ACC_INST IS 'OW. ������� ������ �� ������� Instolment';
COMMENT ON COLUMN BARS.W4_ACC_INST.ND IS '����� ���������� ��������';
COMMENT ON COLUMN BARS.W4_ACC_INST.ACC_PK IS '�������� ��������� �������';
COMMENT ON COLUMN BARS.W4_ACC_INST.CHAIN_IDT IS '����� �������� Instolment';
COMMENT ON COLUMN BARS.W4_ACC_INST.TRANS_MASK IS '����� �������';
COMMENT ON COLUMN BARS.W4_ACC_INST.ACC IS '����� �������';
COMMENT ON COLUMN BARS.W4_ACC_INST.KF IS '';




PROMPT *** Create  constraint PK_W4_ACC_INST ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_INST ADD CONSTRAINT PK_W4_ACC_INST PRIMARY KEY (ACC_PK, CHAIN_IDT, TRANS_MASK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index IND_W4_ACC_INST_CH_IDT ***
begin   
 execute immediate '
  CREATE INDEX IND_W4_ACC_INST_CH_IDT ON W4_ACC_INST(KF, CHAIN_IDT, ACC) LOCAL
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index PK_W4_ACC_INST ***
begin   
 execute immediate '
  CREATE INDEX BARS.IND_W4_ACC_INST_ND ON BARS.W4_ACC_INST (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_ACC_INST.sql =========*** End *** =
PROMPT ===================================================================================== 