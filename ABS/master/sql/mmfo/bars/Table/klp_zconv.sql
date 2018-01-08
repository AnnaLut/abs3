

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_ZCONV.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_ZCONV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_ZCONV'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP_ZCONV'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_ZCONV'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_ZCONV ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_ZCONV 
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
	I_VA_PROD VARCHAR2(16), 
	PS_NUMBER VARCHAR2(96), 
	DATETIMEPICKER1 VARCHAR2(16), 
	NAME VARCHAR2(254), 
	POSTIND VARCHAR2(32), 
	RAYON VARCHAR2(96), 
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
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_ZCONV ***
 exec bpa.alter_policies('KLP_ZCONV');


COMMENT ON TABLE BARS.KLP_ZCONV IS '������������ - ����� �� �������� ������';
COMMENT ON COLUMN BARS.KLP_ZCONV.SUMVAL IS '����� ����� �������� ������, ���� �����';
COMMENT ON COLUMN BARS.KLP_ZCONV.KURS IS '����� ����� �������� ������, ������������ ���� �����';
COMMENT ON COLUMN BARS.KLP_ZCONV.SUMKURS IS '����� ����� �������� ������, ���� � �������� ����� �� ����� ��������';
COMMENT ON COLUMN BARS.KLP_ZCONV.RAHBANK IS '�����'������ �� ���������, ����� ��� ����� ������ ������������ �� �������';
COMMENT ON COLUMN BARS.KLP_ZCONV.RAHPOT IS '�����'������ �� ���������, ������������ ����� ������������ �� �������� �������';
COMMENT ON COLUMN BARS.KLP_ZCONV.KOMIS IS '�����'������ �� ���������, ��������� ������� ���������� � ���. (%)';
COMMENT ON COLUMN BARS.KLP_ZCONV.RAHPOTVAL IS '�����'������ �� ���������, ������������ �������� ������ �� �������� ������� � �������� �����';
COMMENT ON COLUMN BARS.KLP_ZCONV.I_VA_PROD IS '����� ����� �������� ������, ����� ������, �� ���������, �� ���';
COMMENT ON COLUMN BARS.KLP_ZCONV.PS_NUMBER IS '����� ��� ������ �������� ������ (�� ��������� ���������� ��������) N%';
COMMENT ON COLUMN BARS.KLP_ZCONV.DATETIMEPICKER1 IS '��';
COMMENT ON COLUMN BARS.KLP_ZCONV.NAME IS '�������� �����, ���������, ������������ �볺��� / �.�.�.';
COMMENT ON COLUMN BARS.KLP_ZCONV.POSTIND IS '̳�������������� / ���� ����������, ������';
COMMENT ON COLUMN BARS.KLP_ZCONV.RAYON IS '̳�������������� / ���� ����������, �����';
COMMENT ON COLUMN BARS.KLP_ZCONV.CITY IS '̳�������������� / ���� ����������, ̳���';
COMMENT ON COLUMN BARS.KLP_ZCONV.STREET IS '̳�������������� / ���� ����������, ������';
COMMENT ON COLUMN BARS.KLP_ZCONV.HOUSE IS '̳�������������� / ���� ����������, �������';
COMMENT ON COLUMN BARS.KLP_ZCONV.APARTMENT IS '̳�������������� / ���� ����������, ʳ����� / ���� / ��.';
COMMENT ON COLUMN BARS.KLP_ZCONV.FONFAX IS '̳�������������� / ���� ����������, ������� / ����';
COMMENT ON COLUMN BARS.KLP_ZCONV.REGION IS '̳�������������� / ���� ����������, �������';
COMMENT ON COLUMN BARS.KLP_ZCONV.NAMEUP IS '������������� ���������, �.�.�.';
COMMENT ON COLUMN BARS.KLP_ZCONV.TELUP IS '������������� ���������, �������';
COMMENT ON COLUMN BARS.KLP_ZCONV.PIDSTAV IS 'ϳ������ ��� ����� ������';
COMMENT ON COLUMN BARS.KLP_ZCONV.KF IS '';
COMMENT ON COLUMN BARS.KLP_ZCONV.DATEDOKKB IS '';
COMMENT ON COLUMN BARS.KLP_ZCONV.ID IS '�������������';
COMMENT ON COLUMN BARS.KLP_ZCONV.FL IS '���� ���������';
COMMENT ON COLUMN BARS.KLP_ZCONV.NAMEF IS '';
COMMENT ON COLUMN BARS.KLP_ZCONV.FIO1 IS '';
COMMENT ON COLUMN BARS.KLP_ZCONV.FIO2 IS '';
COMMENT ON COLUMN BARS.KLP_ZCONV.I_VA IS '����� ����� �������� ������, ����� ������, �� ��������, �� ���';




PROMPT *** Create  constraint KLP_ZCONV_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZCONV ADD CONSTRAINT KLP_ZCONV_PK PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPZCONV_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZCONV ADD CONSTRAINT FK_KLPZCONV_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPZCONV_FL ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZCONV ADD CONSTRAINT FK_KLPZCONV_FL FOREIGN KEY (FL)
	  REFERENCES BARS.KLP_FL (FL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPZCONV_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZCONV MODIFY (KF CONSTRAINT CC_KLPZCONV_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index KLP_ZCONV_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.KLP_ZCONV_PK ON BARS.KLP_ZCONV (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_ZCONV ***
grant SELECT                                                                 on KLP_ZCONV       to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_ZCONV       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on KLP_ZCONV       to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_ZCONV       to TECH_MOM1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_ZCONV.sql =========*** End *** ===
PROMPT ===================================================================================== 
