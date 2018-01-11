

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_DEPOSIT_CLOS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_DEPOSIT_CLOS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_DEPOSIT_CLOS'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_DEPOSIT_CLOS'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_DEPOSIT_CLOS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_DEPOSIT_CLOS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_DEPOSIT_CLOS 
   (	DEPOSIT_ID NUMBER(38,0), 
	VIDD NUMBER(38,0), 
	ACC NUMBER(38,0), 
	KV NUMBER(3,0), 
	RNK NUMBER(38,0), 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	COMMENTS VARCHAR2(128), 
	MFO_P VARCHAR2(12), 
	NLS_P VARCHAR2(15), 
	LIMIT NUMBER(24,0), 
	DEPOSIT_COD VARCHAR2(4), 
	NAME_P VARCHAR2(128), 
	ACTION_ID NUMBER(1,0), 
	ACTIION_AUTHOR NUMBER(38,0), 
	WHEN DATE, 
	OKPO_P VARCHAR2(15), 
	DATZ DATE, 
	FREQ NUMBER(3,0), 
	ND VARCHAR2(35), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	DPT_D NUMBER(38,0), 
	ACC_D NUMBER(38,0), 
	MFO_D VARCHAR2(12), 
	NLS_D VARCHAR2(15), 
	NMS_D VARCHAR2(38), 
	OKPO_D VARCHAR2(14), 
	IDUPD NUMBER(38,0), 
	BDATE DATE, 
	REF_DPS NUMBER(38,0), 
	DAT_END_ALT DATE, 
	STOP_ID NUMBER(38,0) DEFAULT 0, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	CNT_DUBL NUMBER(10,0), 
	CNT_EXT_INT NUMBER(10,0), 
	DAT_EXT_INT DATE, 
	USERID NUMBER(38,0), 
	ARCHDOC_ID NUMBER(38,0), 
	FORBID_EXTENSION NUMBER(1,0), 
	WB CHAR(1) DEFAULT ''N''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_DEPOSIT_CLOS ***
 exec bpa.alter_policies('DPT_DEPOSIT_CLOS');


COMMENT ON TABLE BARS.DPT_DEPOSIT_CLOS IS '����� ��������� ��';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.WB IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DEPOSIT_ID IS '������������� ����������� ��������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.VIDD IS '������������� ���� ���. ��������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.ACC IS '������������� ��������� �����';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.KV IS '��� ������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.RNK IS '������������� �������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DAT_BEGIN IS '���� ������ ��������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DAT_END IS '���� ���������� ��������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.COMMENTS IS '�����������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.MFO_P IS '��� ��� ����� ����������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.NLS_P IS '����� ����� ����������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.LIMIT IS '�����';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DEPOSIT_COD IS '��� ���� ��������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.NAME_P IS '������������ ����������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.ACTION_ID IS '��� ���������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.ACTIION_AUTHOR IS '��� �����, ������������ ���������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.WHEN IS '����/����� ���������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.OKPO_P IS '��� ���� ����������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DATZ IS '���� ���������� ��������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.FREQ IS '������������� ������� %%';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.ND IS '� ����������� �������� (��������������)';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.BRANCH IS '��� �������������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DPT_D IS '� ����.������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.ACC_D IS '�����.����� ����.�����';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.MFO_D IS '��� ����.�����';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.NLS_D IS '����.����';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.NMS_D IS '������������ ����.�����';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.OKPO_D IS '�����.��� ����.�����';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.IDUPD IS '������������� ������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.BDATE IS '���������� ����';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.REF_DPS IS '�������� ��������� �� ��������� ������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DAT_END_ALT IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.STOP_ID IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.KF IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.CNT_DUBL IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.CNT_EXT_INT IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.DAT_EXT_INT IS '';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.USERID IS '������������-��������� �������� ������';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.ARCHDOC_ID IS '������������� ����������� �������� � ���';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_CLOS.FORBID_EXTENSION IS '';




PROMPT *** Create  constraint PK_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT PK_DPTDEPOSITCLOS PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK2_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS ADD CONSTRAINT UK2_DPTDEPOSITCLOS UNIQUE (KF, IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_DEPOSITID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (DEPOSIT_ID CONSTRAINT CC_DPTDEPOSITCLOS_DEPOSITID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (VIDD CONSTRAINT CC_DPTDEPOSITCLOS_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (ACC CONSTRAINT CC_DPTDEPOSITCLOS_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (KV CONSTRAINT CC_DPTDEPOSITCLOS_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (RNK CONSTRAINT CC_DPTDEPOSITCLOS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_DATBEGIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (DAT_BEGIN CONSTRAINT CC_DPTDEPOSITCLOS_DATBEGIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_ACTIONID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (ACTION_ID CONSTRAINT CC_DPTDEPOSITCLOS_ACTIONID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_ACTUSER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (ACTIION_AUTHOR CONSTRAINT CC_DPTDEPOSITCLOS_ACTUSER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_DATZ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (DATZ CONSTRAINT CC_DPTDEPOSITCLOS_DATZ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (BRANCH CONSTRAINT CC_DPTDEPOSITCLOS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (IDUPD CONSTRAINT CC_DPTDEPOSITCLOS_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_STOPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (STOP_ID CONSTRAINT CC_DPTDEPOSITCLOS_STOPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (KF CONSTRAINT CC_DPTDEPOSITCLOS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPOSITCLOS_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_CLOS MODIFY (USERID CONSTRAINT CC_DPTDEPOSITCLOS_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK3_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK3_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (REF_DPS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I6_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I6_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK2_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK2_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (KF, IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I5_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I5_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (DEPOSIT_ID, BDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I4_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I4_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (ACTION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (BDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (DEPOSIT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTDEPOSITCLOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTDEPOSITCLOS ON BARS.DPT_DEPOSIT_CLOS (DECODE(ACTION_ID,0,DEPOSIT_ID,1,DEPOSIT_ID,2,DEPOSIT_ID,5,DEPOSIT_ID,NULL), DECODE(ACTION_ID,0,1,1,2,2,2,5,5,NULL)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_DEPOSIT_CLOS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT_CLOS to ABS_ADMIN;
grant SELECT                                                                 on DPT_DEPOSIT_CLOS to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_DEPOSIT_CLOS to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT_CLOS to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on DPT_DEPOSIT_CLOS to BARS_DM;
grant SELECT                                                                 on DPT_DEPOSIT_CLOS to CHCK;
grant SELECT,UPDATE                                                          on DPT_DEPOSIT_CLOS to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT_CLOS to DPT_ADMIN;
grant SELECT                                                                 on DPT_DEPOSIT_CLOS to RPBN001;
grant SELECT                                                                 on DPT_DEPOSIT_CLOS to START1;
grant SELECT                                                                 on DPT_DEPOSIT_CLOS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_DEPOSIT_CLOS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_DEPOSIT_CLOS.sql =========*** End 
PROMPT ===================================================================================== 
