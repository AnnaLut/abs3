

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CORPS_UPDATE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CORPS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CORPS_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CORPS_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CORPS_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CORPS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CORPS_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	RNK NUMBER(38,0), 
	NMKU VARCHAR2(250), 
	RUK VARCHAR2(70), 
	TELR VARCHAR2(20), 
	BUH VARCHAR2(70), 
	TELB VARCHAR2(20), 
	DOV VARCHAR2(35), 
	BDOV DATE, 
	EDOV DATE, 
	NLSNEW VARCHAR2(15), 
	MAINNLS VARCHAR2(15), 
	MAINMFO VARCHAR2(12), 
	MFONEW VARCHAR2(12), 
	TEL_FAX VARCHAR2(20), 
	E_MAIL VARCHAR2(100), 
	SEAL_ID NUMBER(38,0), 
	NMK VARCHAR2(182), 
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




PROMPT *** ALTER_POLICIES to CORPS_UPDATE ***
 exec bpa.alter_policies('CORPS_UPDATE');


COMMENT ON TABLE BARS.CORPS_UPDATE IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.GLOBAL_BDATE IS '��������� ��������� ����';
COMMENT ON COLUMN BARS.CORPS_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.IDUPD IS '��������� ���� ��� ������� ����������';
COMMENT ON COLUMN BARS.CORPS_UPDATE.CHGACTION IS '��� ���������� (I/U/D)';
COMMENT ON COLUMN BARS.CORPS_UPDATE.EFFECTDATE IS '���������� ���� ������ �������� ����������';
COMMENT ON COLUMN BARS.CORPS_UPDATE.CHGDATE IS '���������� ���� ����������';
COMMENT ON COLUMN BARS.CORPS_UPDATE.DONEBY IS '��� ������������. ��� ���� ����������(���� � ������� ��� ���� ��������� ���������� - �������� ������ ���������)';
COMMENT ON COLUMN BARS.CORPS_UPDATE.RNK IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.NMKU IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.RUK IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.TELR IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.BUH IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.TELB IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.DOV IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.BDOV IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.EDOV IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.NLSNEW IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.MAINNLS IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.MAINMFO IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.MFONEW IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.TEL_FAX IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.E_MAIL IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.SEAL_ID IS '';
COMMENT ON COLUMN BARS.CORPS_UPDATE.NMK IS '';




PROMPT *** Create  constraint CC_CORPSUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS_UPDATE MODIFY (KF CONSTRAINT CC_CORPSUPDATE_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CORPSUPDATE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS_UPDATE ADD CONSTRAINT FK_CORPSUPDATE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0085165 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS_UPDATE MODIFY (GLOBAL_BDATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005692 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS_UPDATE MODIFY (RNK NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CORPS_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CORPS_UPDATE ADD CONSTRAINT PK_CORPS_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CORPSUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CORPSUPD_GLBDT_EFFDT ON BARS.CORPS_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CORPS_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CORPS_UPDATEPK ON BARS.CORPS_UPDATE (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CORPS_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CORPS_UPDATEEFFDAT ON BARS.CORPS_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CORPS_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CORPS_UPDATE ON BARS.CORPS_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CORPS_UPDATE ***
grant SELECT                                                                 on CORPS_UPDATE    to BARSUPL;
grant SELECT                                                                 on CORPS_UPDATE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CORPS_UPDATE    to BARS_DM;
grant SELECT                                                                 on CORPS_UPDATE    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CORPS_UPDATE.sql =========*** End *** 
PROMPT ===================================================================================== 
