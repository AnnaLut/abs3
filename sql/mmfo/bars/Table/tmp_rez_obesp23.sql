

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REZ_OBESP23.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REZ_OBESP23 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_REZ_OBESP23'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_REZ_OBESP23'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TMP_REZ_OBESP23'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REZ_OBESP23 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REZ_OBESP23 
   (	DAT DATE, 
	USERID NUMBER, 
	ACCS NUMBER, 
	ACCZ NUMBER, 
	PAWN NUMBER, 
	S NUMBER, 
	PROC NUMBER, 
	SALL NUMBER, 
	ND NUMBER, 
	DAY_IMP NUMBER(*,0), 
	KV NUMBER(3,0), 
	GRP NUMBER, 
	ZPR NUMBER, 
	ZPRQ NUMBER, 
	S031 VARCHAR2(2), 
	PVZ NUMBER, 
	PVZQ NUMBER, 
	SQ NUMBER, 
	SALLQ NUMBER, 
	DAT_P DATE, 
	IRR0 NUMBER, 
	S_L NUMBER, 
	SQ_L NUMBER, 
	SUM_IMP NUMBER, 
	SUMQ_IMP NUMBER, 
	PV NUMBER, 
	K NUMBER, 
	PR_IMP NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	RPB NUMBER, 
	KPZ NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REZ_OBESP23 ***
 exec bpa.alter_policies('TMP_REZ_OBESP23');


COMMENT ON TABLE BARS.TMP_REZ_OBESP23 IS '����������� ����������� � ������� ��������� ������';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.KF IS '';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.RPB IS 'г���� �������� �����';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.KPZ IS '�������� ���������� �������� ����� �������������';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.DAT IS '���� �������';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.USERID IS '������������ ����������� ������ (rez.rez_risk)';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.ACCS IS 'acc ������� ����';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.ACCZ IS 'acc ���� ������';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.PAWN IS '��� ������';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.S IS '����� ����������� �� ������ (���)';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.PROC IS '������� �� ����������� ��� ������ ������� � ������';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.SALL IS '';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.ND IS '';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.DAY_IMP IS '�������� ���������� ���� ��� ���������� ������ ����� ����';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.KV IS '��� ��� ����� ������ ACCS';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.GRP IS '';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.ZPR IS '';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.ZPRQ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.S031 IS '��� ���� ������ �� ������������� ���';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.PVZ IS '��������� (������� ��� ��� �����.����) ������������, ��� � 1.00';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.PVZQ IS '��������� (������� ��� ��� �����.����) ������������, ��� � 1.00';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.SQ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.SALLQ IS '';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.DAT_P IS '���� ������';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.IRR0 IS '��. ������';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.S_L IS '���� ������ (���.)';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.SQ_L IS '���� ������ ��������� (���.)';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.SUM_IMP IS '���� ���������� ������ (���.)';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.SUMQ_IMP IS '���� ���������� ������ (���.)';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.PV IS '';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.K IS '����. �����';
COMMENT ON COLUMN BARS.TMP_REZ_OBESP23.PR_IMP IS '% ������ �� ����������';




PROMPT *** Create  constraint PK_TMP_REZ_OBESP23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_OBESP23 ADD CONSTRAINT PK_TMP_REZ_OBESP23 PRIMARY KEY (DAT, ND, ACCS, ACCZ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPREZOBESP23_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REZ_OBESP23 MODIFY (KF CONSTRAINT CC_TMPREZOBESP23_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_REZ_OBESP23 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_REZ_OBESP23 ON BARS.TMP_REZ_OBESP23 (DAT, ND, ACCS, ACCZ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REZ_OBESP23 ***
grant SELECT                                                                 on TMP_REZ_OBESP23 to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_REZ_OBESP23 to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_REZ_OBESP23 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_REZ_OBESP23 to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REZ_OBESP23 to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REZ_OBESP23 to START1;
grant SELECT                                                                 on TMP_REZ_OBESP23 to UPLD;
grant FLASHBACK,SELECT                                                       on TMP_REZ_OBESP23 to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REZ_OBESP23.sql =========*** End *
PROMPT ===================================================================================== 