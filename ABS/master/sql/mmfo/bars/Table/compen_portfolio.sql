

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/COMPEN_PORTFOLIO.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to COMPEN_PORTFOLIO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''COMPEN_PORTFOLIO'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''COMPEN_PORTFOLIO'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''COMPEN_PORTFOLIO'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table COMPEN_PORTFOLIO ***
begin 
  execute immediate '
  CREATE TABLE BARS.COMPEN_PORTFOLIO 
   (	ID NUMBER(14,0), 
	FIO VARCHAR2(256), 
	COUNTRY NUMBER(*,0), 
	POSTINDEX VARCHAR2(256), 
	OBL VARCHAR2(256), 
	RAJON VARCHAR2(256), 
	CITY VARCHAR2(256), 
	ADDRESS VARCHAR2(512), 
	FULLADDRESS VARCHAR2(999), 
	ICOD VARCHAR2(128), 
	DOCTYPE NUMBER(*,0), 
	DOCSERIAL VARCHAR2(16), 
	DOCNUMBER VARCHAR2(32), 
	DOCORG VARCHAR2(256), 
	DOCDATE DATE, 
	CLIENTBDATE DATE, 
	CLIENTBPLACE VARCHAR2(256), 
	CLIENTSEX CHAR(1), 
	CLIENTPHONE VARCHAR2(128), 
	REGISTRYDATE DATE, 
	NSC VARCHAR2(32), 
	IDA VARCHAR2(32), 
	ND VARCHAR2(256), 
	SUM NUMBER, 
	OST NUMBER, 
	DATO DATE, 
	DATL DATE, 
	ATTR VARCHAR2(10), 
	CARD NUMBER(2,0), 
	DATN DATE, 
	VER NUMBER(4,0), 
	STAT VARCHAR2(6), 
	TVBV CHAR(3), 
	BRANCH VARCHAR2(30), 
	KV NUMBER(6,0), 
	STATUS NUMBER(*,0), 
	DATE_IMPORT DATE, 
	DBCODE VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to COMPEN_PORTFOLIO ***
 exec bpa.alter_policies('COMPEN_PORTFOLIO');


COMMENT ON TABLE BARS.COMPEN_PORTFOLIO IS '������������ ������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.RAJON IS '�����';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.CITY IS '��������� �����';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.ADDRESS IS '������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.FULLADDRESS IS '����� ������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.ICOD IS '��� ����';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.DOCTYPE IS '��� ���������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.DOCSERIAL IS '���� ���������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.DOCNUMBER IS '����� ���������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.DOCORG IS '�����, �� ����� ��������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.DOCDATE IS '���� ������ ���������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.CLIENTBDATE IS '���� ����������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.CLIENTBPLACE IS '̳��� ����������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.CLIENTSEX IS '����� (1-�,2-�,0-�)';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.CLIENTPHONE IS '�������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.REGISTRYDATE IS '���� ���������� �������� (datp)';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.NSC IS '����� ������� ����';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.IDA IS 'I������i����� ������� ����';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.ND IS '��� = kkmark_tvbv_id_file_nsc';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.SUM IS '����� ������ (sum*100)';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.OST IS '����� ������ (ost*100)';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.DATO IS '���� �������� ������ (dato)';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.DATL IS '���� �������� �������� (datl)';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.ATTR IS '������ ���i�� � ����� ��������� ����';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.CARD IS '���������� ����� ������ ����';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.DATN IS '���� ����������� �������i�';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.VER IS '����i� ������� ����';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.STAT IS '���������� �����';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.TVBV IS '��� ���� ����';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.BRANCH IS '�����';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.KV IS '��� ������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.STATUS IS '������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.DATE_IMPORT IS '���� �������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.DBCODE IS '����� ��� �������������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.ID IS 'PK (min m_f_o_00000001 - max m_f_o_99999999)';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.FIO IS 'ϲ�';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.COUNTRY IS '��� �����';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.POSTINDEX IS '�������� ������';
COMMENT ON COLUMN BARS.COMPEN_PORTFOLIO.OBL IS '�������';




PROMPT *** Create  constraint PK_COMPEN_PORTFOLIO ***
begin   
 execute immediate '
  ALTER TABLE BARS.COMPEN_PORTFOLIO ADD CONSTRAINT PK_COMPEN_PORTFOLIO PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_COMPEN_PORTFOLIO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_COMPEN_PORTFOLIO ON BARS.COMPEN_PORTFOLIO (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  COMPEN_PORTFOLIO ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on COMPEN_PORTFOLIO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on COMPEN_PORTFOLIO to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on COMPEN_PORTFOLIO to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on COMPEN_PORTFOLIO to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/COMPEN_PORTFOLIO.sql =========*** End 
PROMPT ===================================================================================== 
