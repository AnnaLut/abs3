

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_ACC_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_ACC_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_ACC_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''W4_ACC_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''W4_ACC_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_ACC_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_ACC_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ND NUMBER(22,0), 
	ACC_PK NUMBER(22,0), 
	ACC_OVR NUMBER(22,0), 
	ACC_9129 NUMBER(22,0), 
	ACC_3570 NUMBER(22,0), 
	ACC_2208 NUMBER(22,0), 
	ACC_2627 NUMBER(22,0), 
	ACC_2207 NUMBER(22,0), 
	ACC_3579 NUMBER(22,0), 
	ACC_2209 NUMBER(22,0), 
	CARD_CODE VARCHAR2(32), 
	ACC_2625X NUMBER(22,0), 
	ACC_2627X NUMBER(22,0), 
	ACC_2625D NUMBER(22,0), 
	ACC_2628 NUMBER(22,0), 
	ACC_2203 NUMBER(22,0), 
	FIN NUMBER(*,0), 
	FIN23 NUMBER(*,0), 
	OBS23 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	DAT_CLOSE DATE, 
	PASS_DATE DATE, 
	PASS_STATE NUMBER(10,0), 
	KOL_SP NUMBER, 
	S250 VARCHAR2(1), 
	GRP NUMBER(*,0), 
	GLOBAL_BDATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_ACC_UPDATE ***
 exec bpa.alter_policies('W4_ACC_UPDATE');


COMMENT ON TABLE BARS.W4_ACC_UPDATE IS '������ ���: OW. �������� ��������� ���� ��� ���';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.FIN23 IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.OBS23 IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.KAT23 IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.K23 IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.DAT_BEGIN IS '���� ������� 䳿 ���������� ��������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.DAT_END IS '���� ��������� 䳿 ���������� ��������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.DAT_CLOSE IS '���� �������� �������� W4_ACC';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.PASS_DATE IS '���� �������� ������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.PASS_STATE IS '���� �������� ����� �� ���-�����: 1-��������, 2-���������, 3-��������� �� �������������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.KOL_SP IS '�-�� ���� ��������� �� ��������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.S250 IS '����������� ����� (8)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.GRP IS '����� ������ ������������ ������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.GLOBAL_BDATE IS '���������� ���������� ���� ���������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.IDUPD IS '��������� ���� ��� ������� ����������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.CHGACTION IS '��� ���������� (I/U/D)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.EFFECTDATE IS '���������� ���� ������ �������� ����������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.CHGDATE IS '���������� ���� ����������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.DONEBY IS '��� ������������. ��� ���� ����������(���� � ������� ��� ���� ��������� ���������� - �������� ������ ���������)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ND IS '����� ��������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_PK IS '�������� ��������� �������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_OVR IS '����. ���';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_9129 IS '�������������� ���';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_3570 IS '��������� ������ (����)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2208 IS '���� ����.������� �� ����������� ��������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2627 IS '��������� ������ �� ��������� ���������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2207 IS '����������� ������������� �� ��������� ';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_3579 IS '���������� ��������� ������ (����)';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2209 IS '���������� ��������� ������ �� ��������� ';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.CARD_CODE IS '��� �����';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2625X IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2627X IS '��������� ������ �� ���������������� ���������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2625D IS '����� �� ������ ��������';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2628 IS '��������� ������� �� ������� �� ������ ';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.ACC_2203 IS '';
COMMENT ON COLUMN BARS.W4_ACC_UPDATE.FIN IS '';




PROMPT *** Create  constraint PK_W4ACC_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_UPDATE ADD CONSTRAINT PK_W4ACC_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4ACCUPD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_UPDATE MODIFY (KF CONSTRAINT CC_W4ACCUPD_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007567 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_UPDATE MODIFY (ND NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007568 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_UPDATE MODIFY (ACC_PK NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007569 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_UPDATE MODIFY (CARD_CODE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4ACCUPD_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_ACC_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_W4ACCUPD_GLOBALBD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_W4ACC_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_W4ACC_UPDATEPK ON BARS.W4_ACC_UPDATE (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_W4ACC_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_W4ACC_UPDATEEFFDAT ON BARS.W4_ACC_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4ACC_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4ACC_UPDATE ON BARS.W4_ACC_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_W4ACCUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_W4ACCUPD_GLBDT_EFFDT ON BARS.W4_ACC_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_ACC_UPDATE ***
grant SELECT                                                                 on W4_ACC_UPDATE   to BARSUPL;
grant SELECT                                                                 on W4_ACC_UPDATE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_ACC_UPDATE   to BARS_DM;
grant SELECT                                                                 on W4_ACC_UPDATE   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_ACC_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
