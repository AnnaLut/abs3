

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CUSTOMER_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CUSTOMER_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_UPDATE 
   (	RNK NUMBER(38,0), 
	CUSTTYPE NUMBER(1,0), 
	COUNTRY NUMBER(3,0), 
	NMK VARCHAR2(70), 
	NMKV VARCHAR2(70), 
	NMKK VARCHAR2(38), 
	CODCAGENT NUMBER(1,0), 
	PRINSIDER NUMBER(38,0), 
	OKPO VARCHAR2(14), 
	ADR VARCHAR2(70), 
	SAB VARCHAR2(6), 
	C_REG NUMBER(2,0), 
	C_DST NUMBER(2,0), 
	RGTAX VARCHAR2(30), 
	DATET DATE, 
	ADM VARCHAR2(70), 
	DATEA DATE, 
	STMT NUMBER(5,0), 
	DATE_ON DATE, 
	DATE_OFF DATE, 
	NOTES VARCHAR2(140), 
	NOTESEC VARCHAR2(256), 
	CRISK NUMBER(38,0), 
	PINCODE VARCHAR2(10), 
	CHGDATE DATE, 
	CHGACTION NUMBER(1,0), 
	TGR NUMBER(1,0), 
	IDUPD NUMBER(38,0), 
	DONEBY VARCHAR2(30), 
	BRANCH VARCHAR2(30) DEFAULT NULL, 
	ND VARCHAR2(10), 
	RNKP NUMBER(38,0), 
	ISE CHAR(5), 
	FS CHAR(2), 
	OE CHAR(5), 
	VED CHAR(5), 
	SED CHAR(4), 
	LIM NUMBER(24,0), 
	MB CHAR(1), 
	RGADM VARCHAR2(30), 
	BC NUMBER(1,0), 
	TOBO VARCHAR2(30) DEFAULT NULL, 
	ISP NUMBER(38,0), 
	TAXF VARCHAR2(12), 
	NOMPDV VARCHAR2(9), 
	K050 CHAR(3), 
	EFFECTDATE DATE, 
	GLOBAL_BDATE DATE, 
	NREZID_CODE VARCHAR2(20), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_UPDATE ***
 exec bpa.alter_policies('CUSTOMER_UPDATE');


COMMENT ON TABLE BARS.CUSTOMER_UPDATE IS '������� ���������� ���������� ��������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.KF IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.RNK IS '��������������� �����';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.CUSTTYPE IS '���
 (1=��,2=��,3=��)';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.COUNTRY IS '��� ������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.NMK IS '������ ������������ �����������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.NMKV IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.NMKK IS '������� ������������ �����������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.CODCAGENT IS '���-��';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.PRINSIDER IS '��� ���������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.OKPO IS '��� ����';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.ADR IS '�����';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.SAB IS '��.���';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.C_REG IS '��� ���.��';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.C_DST IS '��� �����.��';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.RGTAX IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.DATET IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.ADM IS '�����.�����';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.DATEA IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.STMT IS '������ �������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.DATE_ON IS '���� ��������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.DATE_OFF IS '���� ��������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.NOTES IS '�����������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.NOTESEC IS '����������� ������ �������������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.CRISK IS '��������� �����';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.PINCODE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.CHGDATE IS '���� ���������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.CHGACTION IS '�������� ��������� (��� ��������)';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.TGR IS '���
(1=���.,2=���.,3=������)';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.DONEBY IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.BRANCH IS '��� �������������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.ND IS '� ���';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.RNKP IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.ISE IS '��� ������� ���������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.FS IS '����� �������������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.OE IS '������� ���������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.VED IS '��� ������������� ������������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.SED IS '��� ������� ���������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.LIM IS '�����';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.MB IS '�������������� � ������ �������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.RGADM IS '���.����� � �������������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.BC IS '������� ��������� ����� (1)';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.TOBO IS '��� ����';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.ISP IS '�������� ������� (�����. �����������)';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.TAXF IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.NOMPDV IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.K050 IS '';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.EFFECTDATE IS '���������� ���� ���������';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.GLOBAL_BDATE IS '��������� ��������� ���� ����';
COMMENT ON COLUMN BARS.CUSTOMER_UPDATE.NREZID_CODE IS '��� � ���� ��������� (��� �����������)';




PROMPT *** Create  constraint PK_CUSTOMERUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT PK_CUSTOMERUPD PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_DATEOFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT CC_CUSTOMERUPD_DATEOFF CHECK (date_off = trunc(date_off)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_BC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE ADD CONSTRAINT CC_CUSTOMERUPD_BC CHECK (bc in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (CHGDATE CONSTRAINT CC_CUSTOMERUPD_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (KF CONSTRAINT CC_CUSTOMERUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (RNK CONSTRAINT CC_CUSTOMERUPD_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_DATEON_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (DATE_ON CONSTRAINT CC_CUSTOMERUPD_DATEON_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (CHGACTION CONSTRAINT CC_CUSTOMERUPD_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (IDUPD CONSTRAINT CC_CUSTOMERUPD_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERUPD_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (DONEBY CONSTRAINT CC_CUSTOMERUPD_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMER_GLOBALBD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_UPDATE MODIFY (GLOBAL_BDATE CONSTRAINT CC_CUSTOMER_GLOBALBD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CUSTOMERUPD_GLBDT_EFFDT ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CUSTOMERUPD_GLBDT_EFFDT ON BARS.CUSTOMER_UPDATE (GLOBAL_BDATE, EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI 
  PARALLEL ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CUSTUPD_EFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CUSTUPD_EFFDAT ON BARS.CUSTOMER_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_CUSTOMERUPD_CHGDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_CUSTOMERUPD_CHGDATE ON BARS.CUSTOMER_UPDATE (CHGDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERUPD ON BARS.CUSTOMER_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_CUSTOMERUPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_CUSTOMERUPD ON BARS.CUSTOMER_UPDATE (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CUSTOMERUPD_KF_RNK_IDUPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CUSTOMERUPD_KF_RNK_IDUPD ON BARS.CUSTOMER_UPDATE (KF, RNK, IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_UPDATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_UPDATE to ABS_ADMIN;
grant SELECT                                                                 on CUSTOMER_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on CUSTOMER_UPDATE to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_UPDATE to BARS_DM;
grant INSERT                                                                 on CUSTOMER_UPDATE to CUST001;
grant SELECT                                                                 on CUSTOMER_UPDATE to KLBX;
grant SELECT                                                                 on CUSTOMER_UPDATE to START1;
grant SELECT                                                                 on CUSTOMER_UPDATE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_UPDATE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
