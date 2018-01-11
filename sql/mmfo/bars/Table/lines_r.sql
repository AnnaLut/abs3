

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LINES_R.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LINES_R ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LINES_R'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''LINES_R'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''LINES_R'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LINES_R ***
begin 
  execute immediate '
  CREATE TABLE BARS.LINES_R 
   (	FN VARCHAR2(30), 
	DAT DATE, 
	N NUMBER, 
	MFO VARCHAR2(6), 
	BANK_OKPO VARCHAR2(8), 
	OKPO VARCHAR2(14), 
	RTYPE NUMBER(1,0), 
	NMKK VARCHAR2(38), 
	ODATE DATE, 
	NLS VARCHAR2(14), 
	KV NUMBER(3,0), 
	RESID NUMBER(1,0), 
	DAT_IN_DPA DATE, 
	DAT_ACC_DPA DATE, 
	ID_PR NUMBER(2,0), 
	ID_DPA NUMBER(2,0), 
	ID_DPS NUMBER(2,0), 
	ID_REC VARCHAR2(24), 
	FN_F VARCHAR2(30), 
	N_F NUMBER(6,0), 
	ERR VARCHAR2(4), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LINES_R ***
 exec bpa.alter_policies('LINES_R');


COMMENT ON TABLE BARS.LINES_R IS '���������� � ������ @R, @D';
COMMENT ON COLUMN BARS.LINES_R.FN IS '';
COMMENT ON COLUMN BARS.LINES_R.DAT IS '';
COMMENT ON COLUMN BARS.LINES_R.N IS '';
COMMENT ON COLUMN BARS.LINES_R.MFO IS '��� �����, � ����� �������� �������';
COMMENT ON COLUMN BARS.LINES_R.BANK_OKPO IS '��� ��������� ��������, � ��� �������� �������';
COMMENT ON COLUMN BARS.LINES_R.OKPO IS '���������� ����� ��� ���� �� ����� �������� ';
COMMENT ON COLUMN BARS.LINES_R.RTYPE IS '�����, ����� �������� ���������� �����';
COMMENT ON COLUMN BARS.LINES_R.NMKK IS '��������� ������������ �볺��� ';
COMMENT ON COLUMN BARS.LINES_R.ODATE IS '���� ��������';
COMMENT ON COLUMN BARS.LINES_R.NLS IS '������� �볺���';
COMMENT ON COLUMN BARS.LINES_R.KV IS '������ �������';
COMMENT ON COLUMN BARS.LINES_R.RESID IS '������������ �볺���: 1 - ��������, 2 - ����������';
COMMENT ON COLUMN BARS.LINES_R.DAT_IN_DPA IS '���� ��������� ��� ������ �����������';
COMMENT ON COLUMN BARS.LINES_R.DAT_ACC_DPA IS '���� ������ ������� �� ���� � ����� ���';
COMMENT ON COLUMN BARS.LINES_R.ID_PR IS '��� ������� ������ � ����� �� ���� �������';
COMMENT ON COLUMN BARS.LINES_R.ID_DPA IS '��� ������ ��� ������������ ����';
COMMENT ON COLUMN BARS.LINES_R.ID_DPS IS '��� ������ ��� ��������� ����';
COMMENT ON COLUMN BARS.LINES_R.ID_REC IS '������������� ������';
COMMENT ON COLUMN BARS.LINES_R.FN_F IS '������������ ����� ���������� F, � ����� ���� ������ ���������� ��� �������';
COMMENT ON COLUMN BARS.LINES_R.N_F IS '���������� ����� �����������, �� ��� �������� �������, � ���� ���������� F';
COMMENT ON COLUMN BARS.LINES_R.ERR IS '��� �������';
COMMENT ON COLUMN BARS.LINES_R.KF IS '';




PROMPT *** Create  constraint PK_LINESR ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_R ADD CONSTRAINT PK_LINESR PRIMARY KEY (FN, DAT, N)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LINESR_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_R MODIFY (KF CONSTRAINT CC_LINESR_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_LINESR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_LINESR ON BARS.LINES_R (FN, DAT, N) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LINES_R ***
grant SELECT                                                                 on LINES_R         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_R         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LINES_R         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_R         to RPBN002;
grant SELECT                                                                 on LINES_R         to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on LINES_R         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to LINES_R ***

  CREATE OR REPLACE PUBLIC SYNONYM LINES_R FOR BARS.LINES_R;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LINES_R.sql =========*** End *** =====
PROMPT ===================================================================================== 
