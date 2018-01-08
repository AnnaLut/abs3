

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_IMP_PROECT_DATA.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_IMP_PROECT_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_IMP_PROECT_DATA'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_IMP_PROECT_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_IMP_PROECT_DATA'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_IMP_PROECT_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_IMP_PROECT_DATA 
   (	ID NUMBER(22,0), 
	IDN NUMBER(22,0), 
	NAME VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	ADR_PCODE VARCHAR2(20), 
	ADR_DOMAIN VARCHAR2(30), 
	ADR_REGION VARCHAR2(30), 
	ADR_CITY VARCHAR2(30), 
	ADR_STREET VARCHAR2(100), 
	PASSP_SER VARCHAR2(10), 
	PASSP_NUMDOC VARCHAR2(20), 
	PASSP_ORGAN VARCHAR2(50), 
	PASSP_DATE DATE, 
	BDAY DATE, 
	BPLACE VARCHAR2(70), 
	MNAME VARCHAR2(20), 
	WORK_PLACE VARCHAR2(30), 
	WORK_OFFICE VARCHAR2(25), 
	WORK_PHONE VARCHAR2(11), 
	WORK_PCODE VARCHAR2(6), 
	WORK_CITY VARCHAR2(15), 
	WORK_STREET VARCHAR2(30), 
	STR_ERR VARCHAR2(254), 
	RNK NUMBER(22,0), 
	ND NUMBER(22,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_IMP_PROECT_DATA ***
 exec bpa.alter_policies('BPK_IMP_PROECT_DATA');


COMMENT ON TABLE BARS.BPK_IMP_PROECT_DATA IS '������� �������� ��� ����������� ���';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.ID IS '��. �����';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.IDN IS '� ������ � �����';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.NAME IS '������������ �������';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.OKPO IS '����';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.ADR_PCODE IS '�����. ������';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.ADR_DOMAIN IS '�����. �������';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.ADR_REGION IS '�����. �����';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.ADR_CITY IS '�����. ��������� �����';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.ADR_STREET IS '�����. �����, ���, ��.';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.PASSP_SER IS '����� ��������';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.PASSP_NUMDOC IS '����� ��������';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.PASSP_ORGAN IS '��� �����';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.PASSP_DATE IS '����� �����';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.BDAY IS '���� ��������';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.BPLACE IS '����� ��������';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.MNAME IS '������� ������� ������';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.WORK_PLACE IS '����� ������';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.WORK_OFFICE IS '���������';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.WORK_PHONE IS '�������';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.WORK_PCODE IS '�������� ������';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.WORK_CITY IS '�����';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.WORK_STREET IS '�����';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.STR_ERR IS '����� ������';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.RNK IS '���';
COMMENT ON COLUMN BARS.BPK_IMP_PROECT_DATA.ND IS '� ��������';




PROMPT *** Create  constraint PK_BPKIMPPROECTDATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_IMP_PROECT_DATA ADD CONSTRAINT PK_BPKIMPPROECTDATA PRIMARY KEY (ID, IDN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BPKIMPPROECTDATA_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_IMP_PROECT_DATA ADD CONSTRAINT FK_BPKIMPPROECTDATA_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKIMPPROECTDATA_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_IMP_PROECT_DATA MODIFY (ID CONSTRAINT CC_BPKIMPPROECTDATA_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKIMPPROECTDATA_IDN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_IMP_PROECT_DATA MODIFY (IDN CONSTRAINT CC_BPKIMPPROECTDATA_IDN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKIMPPROECTDATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKIMPPROECTDATA ON BARS.BPK_IMP_PROECT_DATA (ID, IDN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_IMP_PROECT_DATA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_IMP_PROECT_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_IMP_PROECT_DATA to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_IMP_PROECT_DATA to OBPC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_IMP_PROECT_DATA.sql =========*** E
PROMPT ===================================================================================== 
