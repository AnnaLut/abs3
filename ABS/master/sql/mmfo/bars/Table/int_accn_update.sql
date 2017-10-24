

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_ACCN_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_ACCN_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_ACCN_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INT_ACCN_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INT_ACCN_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_ACCN_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_ACCN_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ACC NUMBER(38,0), 
	ID NUMBER, 
	METR NUMBER, 
	BASEM NUMBER(*,0), 
	BASEY NUMBER(*,0), 
	FREQ NUMBER(3,0), 
	STP_DAT DATE, 
	ACR_DAT DATE, 
	APL_DAT DATE, 
	TT CHAR(3), 
	ACRA NUMBER(38,0), 
	ACRB NUMBER(38,0), 
	S NUMBER, 
	TTB CHAR(3), 
	KVB NUMBER(3,0), 
	NLSB VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	NAMB VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	IO NUMBER(1,0), 
	IDU NUMBER, 
	IDR NUMBER(*,0), 
	KF VARCHAR2(6), 
	OKPO VARCHAR2(14), 
	GLOBAL_BDATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_ACCN_UPDATE ***
 exec bpa.alter_policies('INT_ACCN_UPDATE');


COMMENT ON TABLE BARS.INT_ACCN_UPDATE IS '������� ��������� ���������� ������ �� ������';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.MFOB IS '��� ���������� ��� ������� %';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.NAMB IS '������������ ���������� ��� ������� %';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.NAZN IS '���������� �������';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.IO IS '��� ������� (�� ���-�� int_ion)';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.IDU IS '';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.IDR IS '����� ����� �������� % ������ ���������� (��� METR=7).';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.OKPO IS '����';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.GLOBAL_BDATE IS '���������� ���������� ���� ���������';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.IDUPD IS '��������� ���� ��� ������� ����������';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.CHGACTION IS '��� ���������� (I/U/D)';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.EFFECTDATE IS '���������� ���� ������ �������� ����������';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.CHGDATE IS '���������� ���� ����������';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.DONEBY IS '��� ������������. ��� ���� ����������(���� � ������� ��� ���� ��������� ���������� - �������� ������ ���������)';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.ACC IS '����� �����';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.ID IS 'ID';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.METR IS '����� ����������';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.BASEM IS '������� �����';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.BASEY IS '������� ���';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.FREQ IS '�������������';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.STP_DAT IS '���� ���������';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.ACR_DAT IS '���� ���������� ����������';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.APL_DAT IS '���� ��������� �������';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.TT IS '��� �������� ���������� ���������';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.ACRA IS '���� ���.%%';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.ACRB IS '��������� 6-7 ������';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.S IS '����� ���������';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.TTB IS '��� �������� ������� %';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.KVB IS '��� ������ ������� %';
COMMENT ON COLUMN BARS.INT_ACCN_UPDATE.NLSB IS '���� ���������� ��� ������� %';




PROMPT *** Create  constraint SYS_C005680 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN_UPDATE MODIFY (METR NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005679 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN_UPDATE MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005678 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN_UPDATE MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INTACCN_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN_UPDATE ADD CONSTRAINT PK_INTACCN_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005681 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN_UPDATE MODIFY (BASEY NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTACCNUPD_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_INTACCNUPD_GLOBALBD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005683 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN_UPDATE MODIFY (ACR_DAT NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005684 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN_UPDATE MODIFY (TT NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005685 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN_UPDATE MODIFY (S NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005686 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN_UPDATE MODIFY (IO NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005687 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN_UPDATE MODIFY (KF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005682 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ACCN_UPDATE MODIFY (FREQ NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTACCN_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTACCN_UPDATE ON BARS.INT_ACCN_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_INTACCN_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_INTACCN_UPDATEEFFDAT ON BARS.INT_ACCN_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_INTACCN_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_INTACCN_UPDATEPK ON BARS.INT_ACCN_UPDATE (ACC, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_INTACCNUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_INTACCNUPD_GLBDT_EFFDT ON BARS.INT_ACCN_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_ACCN_UPDATE ***
grant SELECT                                                                 on INT_ACCN_UPDATE to BARSUPL;
grant SELECT                                                                 on INT_ACCN_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_ACCN_UPDATE to BARS_DM;
grant SELECT                                                                 on INT_ACCN_UPDATE to START1;



PROMPT *** Create SYNONYM  to INT_ACCN_UPDATE ***

  CREATE OR REPLACE PUBLIC SYNONYM INT_ACCN_UPDATE FOR BARS.INT_ACCN_UPDATE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_ACCN_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
