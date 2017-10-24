

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FGV_TEMP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FGV_TEMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FGV_TEMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FGV_TEMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FGV_TEMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.FGV_TEMP 
   (	REP_DATE DATE, 
	FIO VARCHAR2(50), 
	OKPO VARCHAR2(10), 
	OBL VARCHAR2(30), 
	DST VARCHAR2(60), 
	TOWN VARCHAR2(60), 
	ADR VARCHAR2(100), 
	PASP_SN VARCHAR2(20), 
	ORGAN VARCHAR2(100), 
	PDATE DATE, 
	DATZ DATE, 
	DAT_END DATE, 
	ND VARCHAR2(20), 
	NLS VARCHAR2(14), 
	OST_DEP NUMBER(16,0), 
	OST_INT NUMBER(16,0), 
	OSTQ_DEP NUMBER(16,0), 
	OSTQ_INT NUMBER(16,0), 
	RATE NUMBER(9,4), 
	KV NUMBER(3,0), 
	PLEDGE NUMBER(1,0), 
	RNK NUMBER(38,0), 
	ACCC NUMBER(38,0), 
	NBS VARCHAR2(4), 
	BRANCH VARCHAR2(30), 
	SOURCE VARCHAR2(5)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FGV_TEMP ***
 exec bpa.alter_policies('FGV_TEMP');


COMMENT ON TABLE BARS.FGV_TEMP IS '������� ��� ������� ����� ��� ��� �� ������� ������';
COMMENT ON COLUMN BARS.FGV_TEMP.REP_DATE IS '����� ����';
COMMENT ON COLUMN BARS.FGV_TEMP.FIO IS '�.�.�. ���������';
COMMENT ON COLUMN BARS.FGV_TEMP.OKPO IS '������������ ����� ������� ������ �������� �������';
COMMENT ON COLUMN BARS.FGV_TEMP.OBL IS '̳��� ���������� (�������)';
COMMENT ON COLUMN BARS.FGV_TEMP.DST IS '̳��� ���������� (�����)';
COMMENT ON COLUMN BARS.FGV_TEMP.TOWN IS '̳��� ���������� (��������� �����)';
COMMENT ON COLUMN BARS.FGV_TEMP.ADR IS '̳��� ���������� (������, �������, ��������)';
COMMENT ON COLUMN BARS.FGV_TEMP.PASP_SN IS '�������� ��� (���� + �����)';
COMMENT ON COLUMN BARS.FGV_TEMP.ORGAN IS '�������� ��� (��� �������)';
COMMENT ON COLUMN BARS.FGV_TEMP.PDATE IS '�������� ��� (���� ������)';
COMMENT ON COLUMN BARS.FGV_TEMP.DATZ IS '������ (���� ���������)';
COMMENT ON COLUMN BARS.FGV_TEMP.DAT_END IS '������ (���� ����������)';
COMMENT ON COLUMN BARS.FGV_TEMP.ND IS '������ (�����)';
COMMENT ON COLUMN BARS.FGV_TEMP.NLS IS '����� ��������� �������';
COMMENT ON COLUMN BARS.FGV_TEMP.OST_DEP IS '������� ����� �� ������� �������� (������)';
COMMENT ON COLUMN BARS.FGV_TEMP.OST_INT IS '������� ����� �� ������� ������� (������)';
COMMENT ON COLUMN BARS.FGV_TEMP.OSTQ_DEP IS '������� ����� �� ������� �������� (���������)';
COMMENT ON COLUMN BARS.FGV_TEMP.OSTQ_INT IS '������� ����� �� ������� ������� (���������)';
COMMENT ON COLUMN BARS.FGV_TEMP.RATE IS '��������� ������';
COMMENT ON COLUMN BARS.FGV_TEMP.KV IS '��� ������';
COMMENT ON COLUMN BARS.FGV_TEMP.PLEDGE IS '������ ������, �� � ��������� �������';
COMMENT ON COLUMN BARS.FGV_TEMP.RNK IS '';
COMMENT ON COLUMN BARS.FGV_TEMP.ACCC IS 'ACC ��������������� �������';
COMMENT ON COLUMN BARS.FGV_TEMP.NBS IS '';
COMMENT ON COLUMN BARS.FGV_TEMP.BRANCH IS '��� �������� ��������';
COMMENT ON COLUMN BARS.FGV_TEMP.SOURCE IS '������� ���������� ��� ���';




PROMPT *** Create  constraint FGVTEMP_DOCMUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FGV_TEMP MODIFY (PASP_SN CONSTRAINT FGVTEMP_DOCMUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FGVTEMP_DOCORG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FGV_TEMP MODIFY (ORGAN CONSTRAINT FGVTEMP_DOCORG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FGVTEMP_ADR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FGV_TEMP MODIFY (ADR CONSTRAINT FGVTEMP_ADR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FGVTEMP_TOWN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FGV_TEMP MODIFY (TOWN CONSTRAINT FGVTEMP_TOWN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FGVTEMP_OKPO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FGV_TEMP MODIFY (OKPO CONSTRAINT FGVTEMP_OKPO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FGVTEMP_FIO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FGV_TEMP MODIFY (FIO CONSTRAINT FGVTEMP_FIO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FGVTEMP_REPDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FGV_TEMP MODIFY (REP_DATE CONSTRAINT FGVTEMP_REPDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FGVTEMP_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FGV_TEMP MODIFY (KV CONSTRAINT FGVTEMP_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FGVTEMP_RATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FGV_TEMP MODIFY (RATE CONSTRAINT FGVTEMP_RATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FGVTEMP_OSTINT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FGV_TEMP MODIFY (OST_INT CONSTRAINT FGVTEMP_OSTINT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FGVTEMP_OSTDEP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FGV_TEMP MODIFY (OST_DEP CONSTRAINT FGVTEMP_OSTDEP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FGVTEMP_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FGV_TEMP MODIFY (NLS CONSTRAINT FGVTEMP_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FGVTEMP_DATZ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FGV_TEMP MODIFY (DATZ CONSTRAINT FGVTEMP_DATZ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FGVTEMP_DOCDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FGV_TEMP MODIFY (PDATE CONSTRAINT FGVTEMP_DOCDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FGV_TEMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FGV_TEMP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FGV_TEMP        to BARS_DM;
grant SELECT                                                                 on FGV_TEMP        to RPBN001;
grant DELETE,INSERT,SELECT,UPDATE                                            on FGV_TEMP        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FGV_TEMP        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to FGV_TEMP ***

  CREATE OR REPLACE PUBLIC SYNONYM FGV_TEMP FOR BARS.FGV_TEMP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FGV_TEMP.sql =========*** End *** ====
PROMPT ===================================================================================== 
