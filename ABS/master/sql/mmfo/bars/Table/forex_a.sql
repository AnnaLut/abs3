

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FOREX_A.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FOREX_A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FOREX_A'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FOREX_A'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FOREX_A'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FOREX_A ***
begin 
  execute immediate '
  CREATE TABLE BARS.FOREX_A 
   (	NTIK VARCHAR2(15), 
	DAT DATE, 
	RNK NUMBER, 
	DEAL_TAG NUMBER(*,0), 
	REFA NUMBER(*,0), 
	DAT_A DATE, 
	ACCA NUMBER(38,0), 
	KVA NUMBER(3,0), 
	NLSA VARCHAR2(15), 
	NETA NUMBER(*,0), 
	SA NUMBER, 
	DETALI VARCHAR2(20), 
	REFB NUMBER(*,0), 
	DAT_B DATE, 
	ACCB NUMBER(38,0), 
	KVB NUMBER(3,0), 
	NLSB VARCHAR2(15), 
	NETB NUMBER(*,0), 
	SB NUMBER, 
	FDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FOREX_A ***
 exec bpa.alter_policies('FOREX_A');


COMMENT ON TABLE BARS.FOREX_A IS '����� V_FOREX_NETTING �� ����.���� = fdat';
COMMENT ON COLUMN BARS.FOREX_A.NTIK IS '����� �_����';
COMMENT ON COLUMN BARS.FOREX_A.DAT IS '���� ����. �����';
COMMENT ON COLUMN BARS.FOREX_A.RNK IS '���';
COMMENT ON COLUMN BARS.FOREX_A.DEAL_TAG IS '_������_����� �����';
COMMENT ON COLUMN BARS.FOREX_A.REFA IS '�������� ��������� �� ��������� ���';
COMMENT ON COLUMN BARS.FOREX_A.DAT_A IS '���� ��������� ��� �(�������)';
COMMENT ON COLUMN BARS.FOREX_A.ACCA IS '��� ������� �� 3540 (�������)';
COMMENT ON COLUMN BARS.FOREX_A.KVA IS '������ ������� ';
COMMENT ON COLUMN BARS.FOREX_A.NLSA IS '������� �� 3540';
COMMENT ON COLUMN BARS.FOREX_A.NETA IS '';
COMMENT ON COLUMN BARS.FOREX_A.SA IS '���� �������(���)/100';
COMMENT ON COLUMN BARS.FOREX_A.DETALI IS '�����_ ?';
COMMENT ON COLUMN BARS.FOREX_A.REFB IS '�������� ��������� �� �_������� ��� ';
COMMENT ON COLUMN BARS.FOREX_A.DAT_B IS '���� �_������� ��� � (������)';
COMMENT ON COLUMN BARS.FOREX_A.ACCB IS '��� ������� �� 3540 (������)';
COMMENT ON COLUMN BARS.FOREX_A.KVB IS '������ �������';
COMMENT ON COLUMN BARS.FOREX_A.NLSB IS '������� �� 3640';
COMMENT ON COLUMN BARS.FOREX_A.NETB IS '';
COMMENT ON COLUMN BARS.FOREX_A.SB IS '���� �������(���)/100';
COMMENT ON COLUMN BARS.FOREX_A.FDAT IS '���� ���������� ���_��';




PROMPT *** Create  constraint PK_FOREX_A ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOREX_A ADD CONSTRAINT PK_FOREX_A PRIMARY KEY (FDAT, DEAL_TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009472 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOREX_A MODIFY (DEAL_TAG NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009473 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOREX_A MODIFY (ACCA NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009474 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOREX_A MODIFY (KVA NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009475 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOREX_A MODIFY (NLSA NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009476 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOREX_A MODIFY (ACCB NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009477 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOREX_A MODIFY (KVB NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009478 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOREX_A MODIFY (NLSB NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FOREX_A ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FOREX_A ON BARS.FOREX_A (FDAT, DEAL_TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FOREX_A ***
grant SELECT                                                                 on FOREX_A         to BARSREADER_ROLE;
grant SELECT                                                                 on FOREX_A         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FOREX_A         to BARS_DM;
grant SELECT                                                                 on FOREX_A         to START1;
grant SELECT                                                                 on FOREX_A         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FOREX_A.sql =========*** End *** =====
PROMPT ===================================================================================== 
