

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_ACC_UPDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_ACC_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_ACC_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_ACC_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_ACC_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_ACC_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ACC_PK NUMBER(38,0), 
	ACC_OVR NUMBER(38,0), 
	ACC_9129 NUMBER(38,0), 
	ACC_TOVR NUMBER(38,0), 
	KF VARCHAR2(6), 
	ACC_3570 NUMBER(38,0), 
	ACC_2208 NUMBER(38,0), 
	ND NUMBER(10,0), 
	PRODUCT_ID NUMBER(38,0), 
	ACC_2207 NUMBER(38,0), 
	ACC_3579 NUMBER(38,0), 
	ACC_2209 NUMBER(38,0), 
	FIN23 NUMBER(*,0), 
	OBS23 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	K23 NUMBER, 
	ACC_W4 NUMBER, 
	DAT_END DATE, 
	FIN NUMBER(*,0), 
	KOL_SP NUMBER, 
	S250 VARCHAR2(1), 
	GRP NUMBER(*,0), 
	GLOBAL_BDATE DATE, 
	DAT_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_ACC_UPDATE ***
 exec bpa.alter_policies('BPK_ACC_UPDATE');


COMMENT ON TABLE BARS.BPK_ACC_UPDATE IS '������ ���: ���. ������� ������';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.FIN23 IS '�i����� �� ���-23';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.OBS23 IS '����.����� �� ���-23';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.KAT23 IS '�������i� �����i �� �������� �� ���-23';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.K23 IS '����.�������� ������ �� ���-23';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.DAT_END IS '���� �������� ���.2625 ACC_PK';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.FIN IS '';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.KOL_SP IS '�-�� ���� ��������� �� ��������';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.S250 IS '����������� ����� (8)';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_W4 IS '';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.GLOBAL_BDATE IS '���������� ���������� ���� ���������';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.DAT_CLOSE IS '���� �������� ��������';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.GRP IS '����� ������ ������������ ������';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.IDUPD IS '��������� ���� ��� ������� ����������';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.CHGACTION IS '��� ���������� (I/U/D)';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.EFFECTDATE IS '���������� ���� ������ �������� ����������';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.CHGDATE IS '���������� ���� ����������';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.DONEBY IS '��� ������������. ��� ���� ����������';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_PK IS '��������� ���� 2625-��/2605-��';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_OVR IS '����. ��� 2202(2203)-��/2062(2063)-��';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_9129 IS '���������. ����� 9129';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_TOVR IS '���� ����. ����������';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.KF IS '��� �������';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_3570 IS '���� ��������';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_2208 IS '���� ����.������� �� ����������� �������� 2208-��/2268-��';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ND IS '����� ��������';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.PRODUCT_ID IS '';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_2207 IS '';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_3579 IS '';
COMMENT ON COLUMN BARS.BPK_ACC_UPDATE.ACC_2209 IS '';




PROMPT *** Create  constraint PK_BPKACC_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC_UPDATE ADD CONSTRAINT PK_BPKACC_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001955636 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC_UPDATE MODIFY (ACC_PK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKACCUPD_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_ACC_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_BPKACCUPD_GLOBALBD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_BPKACCUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_BPKACCUPD_GLBDT_EFFDT ON BARS.BPK_ACC_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKACC_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKACC_UPDATE ON BARS.BPK_ACC_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_BPKACC_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_BPKACC_UPDATEEFFDAT ON BARS.BPK_ACC_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_BPKACC_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_BPKACC_UPDATEPK ON BARS.BPK_ACC_UPDATE (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_ACC_UPDATE ***
grant SELECT                                                                 on BPK_ACC_UPDATE  to BARSUPL;
grant SELECT                                                                 on BPK_ACC_UPDATE  to BARS_SUP;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_ACC_UPDATE.sql =========*** End **
PROMPT ===================================================================================== 
