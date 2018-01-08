

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUST_ZAY.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUST_ZAY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUST_ZAY'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CUST_ZAY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CUST_ZAY'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUST_ZAY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUST_ZAY 
   (	RNK NUMBER(38,0), 
	NLS29 VARCHAR2(15), 
	NLS26 VARCHAR2(15), 
	MFOP VARCHAR2(12), 
	NLSP VARCHAR2(15), 
	KOM NUMBER(10,4), 
	MFO26 VARCHAR2(12), 
	OKPOP VARCHAR2(10), 
	OKPO26 VARCHAR2(10), 
	DK NUMBER, 
	NAL_NOTE VARCHAR2(20), 
	NAL_DATE DATE, 
	TEL VARCHAR2(20), 
	FIO VARCHAR2(70), 
	NAZN_PF VARCHAR2(160), 
	RNK_PF VARCHAR2(20), 
	KOM2 NUMBER(10,4), 
	FL_PF NUMBER DEFAULT 0, 
	MFOV VARCHAR2(12), 
	NLSV VARCHAR2(15), 
	NLS_KOM VARCHAR2(14), 
	NLS_KOM2 VARCHAR2(14), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	CUSTACC4CMS VARCHAR2(14), 
	KOM3 NUMBER(10,4), 
	NLS_PF VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUST_ZAY ***
 exec bpa.alter_policies('CUST_ZAY');


COMMENT ON TABLE BARS.CUST_ZAY IS '���-�� �������� ��� ����.������';
COMMENT ON COLUMN BARS.CUST_ZAY.RNK IS '���.����� �������';
COMMENT ON COLUMN BARS.CUST_ZAY.NLS29 IS '�������� ���� ��� ��������';
COMMENT ON COLUMN BARS.CUST_ZAY.NLS26 IS '��������� ���� ��� ����������';
COMMENT ON COLUMN BARS.CUST_ZAY.MFOP IS '��� ������� ��� ���������� � ��(�� ���.)';
COMMENT ON COLUMN BARS.CUST_ZAY.NLSP IS '�����. ���� ������� ��� ���������� � ��(�� ���.)';
COMMENT ON COLUMN BARS.CUST_ZAY.KOM IS '% �������� (�������)';
COMMENT ON COLUMN BARS.CUST_ZAY.MFO26 IS '��� ���������� �����';
COMMENT ON COLUMN BARS.CUST_ZAY.OKPOP IS '���� ������� ��� ���������� � ��(�� ���.)';
COMMENT ON COLUMN BARS.CUST_ZAY.OKPO26 IS '���� �������';
COMMENT ON COLUMN BARS.CUST_ZAY.DK IS '';
COMMENT ON COLUMN BARS.CUST_ZAY.NAL_NOTE IS '';
COMMENT ON COLUMN BARS.CUST_ZAY.NAL_DATE IS '';
COMMENT ON COLUMN BARS.CUST_ZAY.TEL IS '���������� �������';
COMMENT ON COLUMN BARS.CUST_ZAY.FIO IS '��� ����������� ����';
COMMENT ON COLUMN BARS.CUST_ZAY.NAZN_PF IS '����.������� ��� ���������� � ��(�� ���.)';
COMMENT ON COLUMN BARS.CUST_ZAY.RNK_PF IS '��� ������� ��� ���������� � ��(�� ���.)';
COMMENT ON COLUMN BARS.CUST_ZAY.KOM2 IS '% �������� (�������)';
COMMENT ON COLUMN BARS.CUST_ZAY.FL_PF IS '������� ������������ ������� � ��(�� ���)';
COMMENT ON COLUMN BARS.CUST_ZAY.MFOV IS '��� ����� ��� �������� ������� ���';
COMMENT ON COLUMN BARS.CUST_ZAY.NLSV IS '���� ������� ��� �������� ������� ���';
COMMENT ON COLUMN BARS.CUST_ZAY.NLS_KOM IS '���� �������� ����� (�������)';
COMMENT ON COLUMN BARS.CUST_ZAY.NLS_KOM2 IS '���� �������� ����� (�������)';
COMMENT ON COLUMN BARS.CUST_ZAY.KF IS '';
COMMENT ON COLUMN BARS.CUST_ZAY.CUSTACC4CMS IS '���������.���� ������� ��� �������� ��������';
COMMENT ON COLUMN BARS.CUST_ZAY.KOM3 IS '% �������� (���������)';
COMMENT ON COLUMN BARS.CUST_ZAY.NLS_PF IS '���� ������� ��� �������� ��';




PROMPT *** Create  constraint CC_CUSTZAY_FLPF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_ZAY ADD CONSTRAINT CC_CUSTZAY_FLPF CHECK (fl_pf in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUST_ZAY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_ZAY ADD CONSTRAINT PK_CUST_ZAY PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUST_ZAY_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_ZAY MODIFY (RNK CONSTRAINT CC_CUST_ZAY_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUST_ZAY_FL_PF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_ZAY MODIFY (FL_PF CONSTRAINT CC_CUST_ZAY_FL_PF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTZAY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_ZAY MODIFY (KF CONSTRAINT CC_CUSTZAY_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUST_ZAY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUST_ZAY ON BARS.CUST_ZAY (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUST_ZAY ***
grant FLASHBACK,SELECT                                                       on CUST_ZAY        to BARSAQ;
grant SELECT                                                                 on CUST_ZAY        to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CUST_ZAY        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUST_ZAY        to BARS_DM;
grant SELECT                                                                 on CUST_ZAY        to OPERKKK;
grant SELECT                                                                 on CUST_ZAY        to TECH_MOM1;
grant SELECT                                                                 on CUST_ZAY        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUST_ZAY        to WR_ALL_RIGHTS;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CUST_ZAY        to ZAY;



PROMPT *** Create SYNONYM  to CUST_ZAY ***

  CREATE OR REPLACE PUBLIC SYNONYM CUST_ZAY FOR BARS.CUST_ZAY;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUST_ZAY.sql =========*** End *** ====
PROMPT ===================================================================================== 
