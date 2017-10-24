

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_ZKUPP.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_ZKUPP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_ZKUPP'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_ZKUPP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_ZKUPP ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_ZKUPP 
   (	ID NUMBER, 
	FL NUMBER, 
	NAMEF VARCHAR2(12), 
	FIO1 VARCHAR2(96), 
	FIO2 VARCHAR2(96), 
	I_VA VARCHAR2(16), 
	SUMVAL VARCHAR2(96), 
	KURS VARCHAR2(32), 
	SUMKURS VARCHAR2(32), 
	RAHBANK VARCHAR2(96), 
	RAHPOT VARCHAR2(96), 
	KOMIS VARCHAR2(32), 
	RAHPOTVAL VARCHAR2(96), 
	PS_NUMBER VARCHAR2(96), 
	DATETIMEPICKER1 VARCHAR2(16), 
	NAME VARCHAR2(254), 
	POSTIND VARCHAR2(32), 
	CITY VARCHAR2(96), 
	STREET VARCHAR2(96), 
	HOUSE VARCHAR2(32), 
	APARTMENT VARCHAR2(32), 
	FONFAX VARCHAR2(96), 
	REGION VARCHAR2(96), 
	NAMEUP VARCHAR2(96), 
	TELUP VARCHAR2(96), 
	PIDSTAV VARCHAR2(254), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DATEDOKKB DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_ZKUPP ***
 exec bpa.alter_policies('KLP_ZKUPP');


COMMENT ON TABLE BARS.KLP_ZKUPP IS '������������ - ����� �� ������ ������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.DATEDOKKB IS '';
COMMENT ON COLUMN BARS.KLP_ZKUPP.ID IS '�������������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.FL IS '���� ���������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.NAMEF IS '';
COMMENT ON COLUMN BARS.KLP_ZKUPP.FIO1 IS '';
COMMENT ON COLUMN BARS.KLP_ZKUPP.FIO2 IS '';
COMMENT ON COLUMN BARS.KLP_ZKUPP.I_VA IS '����� ����� �������� ������ ��� ���������� ������, ��� ������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.SUMVAL IS '����� ����� �������� ������ ��� ���������� ������, ���� ������ ��� ���� ���������� ������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.KURS IS '����� ����� �������� ������ ��� ���������� ������, ���� � �������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.SUMKURS IS '����� ����� �������� ������ ��� ���������� ������, ���� � ������� �������� �� �����';
COMMENT ON COLUMN BARS.KLP_ZKUPP.RAHBANK IS '�����'������ �� ���������, ����� � ���. ��� ����� ������ ������������ �� �������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.RAHPOT IS '�����'������ �� ���������, ������������ ����� � ���. ������������ �� �������� �������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.KOMIS IS '�����'������ �� ���������, ��������� ������� ���������� � ���. (%)';
COMMENT ON COLUMN BARS.KLP_ZKUPP.RAHPOTVAL IS '�����'������ �� ���������, ������������ �������� ������ �� �������� ������� � �������� �����';
COMMENT ON COLUMN BARS.KLP_ZKUPP.PS_NUMBER IS '����� ��� ������ ������ ��� ���������� ������ ��������� ���, ���������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.DATETIMEPICKER1 IS '��';
COMMENT ON COLUMN BARS.KLP_ZKUPP.NAME IS '�������� �����, ���������, ������������ �볺��� / �.�.�.';
COMMENT ON COLUMN BARS.KLP_ZKUPP.POSTIND IS '̳�������������� / ���� ����������, ������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.CITY IS '̳�������������� / ���� ����������, ̳���';
COMMENT ON COLUMN BARS.KLP_ZKUPP.STREET IS '̳�������������� / ���� ����������, ������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.HOUSE IS '̳�������������� / ���� ����������, �������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.APARTMENT IS '̳�������������� / ���� ����������, ʳ����� / ���� / ��.';
COMMENT ON COLUMN BARS.KLP_ZKUPP.FONFAX IS '̳�������������� / ���� ����������, ������� / ����';
COMMENT ON COLUMN BARS.KLP_ZKUPP.REGION IS '̳�������������� / ���� ����������, �������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.NAMEUP IS '������������� ���������, �.�.�.';
COMMENT ON COLUMN BARS.KLP_ZKUPP.TELUP IS '������������� ���������, �������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.PIDSTAV IS 'ϳ������ ��� ����� ������';
COMMENT ON COLUMN BARS.KLP_ZKUPP.KF IS '';




PROMPT *** Create  constraint FK_KLPZKUPP_FL ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZKUPP ADD CONSTRAINT FK_KLPZKUPP_FL FOREIGN KEY (FL)
	  REFERENCES BARS.KLP_FL (FL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPZKUPP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZKUPP ADD CONSTRAINT FK_KLPZKUPP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint KLP_ZKUPP_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZKUPP ADD CONSTRAINT KLP_ZKUPP_PK PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPZKUPP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZKUPP MODIFY (KF CONSTRAINT CC_KLPZKUPP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index KLP_ZKUPP_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.KLP_ZKUPP_PK ON BARS.KLP_ZKUPP (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_ZKUPP ***
grant SELECT                                                                 on KLP_ZKUPP       to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_ZKUPP       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on KLP_ZKUPP       to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_ZKUPP       to TECH_MOM1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_ZKUPP.sql =========*** End *** ===
PROMPT ===================================================================================== 
