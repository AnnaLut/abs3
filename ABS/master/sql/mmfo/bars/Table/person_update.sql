

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PERSON_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PERSON_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PERSON_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PERSON_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PERSON_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PERSON_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PERSON_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	RNK NUMBER(38,0), 
	SEX CHAR(1), 
	PASSP NUMBER(*,0), 
	SER VARCHAR2(10), 
	NUMDOC VARCHAR2(20), 
	PDATE DATE, 
	ORGAN VARCHAR2(70), 
	BDAY DATE, 
	BPLACE VARCHAR2(70), 
	TELD VARCHAR2(20), 
	TELW VARCHAR2(20), 
	CELLPHONE VARCHAR2(35), 
	BDOV DATE, 
	EDOV DATE, 
	DATE_PHOTO DATE, 
	ACTUAL_DATE DATE, 
	EDDR_ID VARCHAR2(20), 
	KF VARCHAR2(6) DEFAULT NULL, 
	GLOBAL_BDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PERSON_UPDATE ***
 exec bpa.alter_policies('PERSON_UPDATE');


COMMENT ON TABLE BARS.PERSON_UPDATE IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.GLOBAL_BDATE IS '��������� ��������� ����';
COMMENT ON COLUMN BARS.PERSON_UPDATE.IDUPD IS '��������� ���� ��� ������� ����������';
COMMENT ON COLUMN BARS.PERSON_UPDATE.CHGACTION IS '��� ���������� (I/U/D)';
COMMENT ON COLUMN BARS.PERSON_UPDATE.EFFECTDATE IS '���������� ���� ������ �������� ����������';
COMMENT ON COLUMN BARS.PERSON_UPDATE.CHGDATE IS '���������� ���� ����������';
COMMENT ON COLUMN BARS.PERSON_UPDATE.DONEBY IS '��� ������������. ��� ���� ����������(���� � ������� ��� ���� ��������� ���������� - �������� ������ ���������)';
COMMENT ON COLUMN BARS.PERSON_UPDATE.RNK IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.SEX IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.PASSP IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.SER IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.NUMDOC IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.PDATE IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.ORGAN IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.BDAY IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.BPLACE IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.TELD IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.TELW IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.CELLPHONE IS '����� ���.��������';
COMMENT ON COLUMN BARS.PERSON_UPDATE.BDOV IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.EDOV IS '';
COMMENT ON COLUMN BARS.PERSON_UPDATE.DATE_PHOTO IS '���� ���� ���� ������ ������� ���������� � �������';
COMMENT ON COLUMN BARS.PERSON_UPDATE.ACTUAL_DATE IS 'ĳ����� ��';
COMMENT ON COLUMN BARS.PERSON_UPDATE.EDDR_ID IS '��������� ����� ������ � ����';




PROMPT *** Create  constraint SYS_C006359 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON_UPDATE MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PERSONUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON_UPDATE MODIFY (KF CONSTRAINT CC_PERSONUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PERSONUPDATE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON_UPDATE ADD CONSTRAINT FK_PERSONUPDATE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0085166 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON_UPDATE MODIFY (GLOBAL_BDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PERSON_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PERSON_UPDATE ADD CONSTRAINT PK_PERSON_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_PERSON_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_PERSON_UPDATEPK ON BARS.PERSON_UPDATE (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_PERSON_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_PERSON_UPDATEEFFDAT ON BARS.PERSON_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PERSON_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PERSON_UPDATE ON BARS.PERSON_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_PERSONUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_PERSONUPD_GLBDT_EFFDT ON BARS.PERSON_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PERSON_UPDATE ***
grant SELECT                                                                 on PERSON_UPDATE   to BARSUPL;
grant SELECT                                                                 on PERSON_UPDATE   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PERSON_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
