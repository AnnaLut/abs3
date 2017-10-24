

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_ZPROD.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_ZPROD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_ZPROD'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP_ZPROD'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_ZPROD'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_ZPROD ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_ZPROD 
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
	RAHVAL VARCHAR2(96), 
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




PROMPT *** ALTER_POLICIES to KLP_ZPROD ***
 exec bpa.alter_policies('KLP_ZPROD');


COMMENT ON TABLE BARS.KLP_ZPROD IS '������������ - ����� �� ������ ������';
COMMENT ON COLUMN BARS.KLP_ZPROD.ID IS '�������������';
COMMENT ON COLUMN BARS.KLP_ZPROD.FL IS '���� ���������';
COMMENT ON COLUMN BARS.KLP_ZPROD.NAMEF IS '';
COMMENT ON COLUMN BARS.KLP_ZPROD.FIO1 IS '';
COMMENT ON COLUMN BARS.KLP_ZPROD.FIO2 IS '';
COMMENT ON COLUMN BARS.KLP_ZPROD.I_VA IS '����� ������� �������� ������ ��� ���������� ������, ��� ������';
COMMENT ON COLUMN BARS.KLP_ZPROD.SUMVAL IS '����� ������� �������� ������ ��� ���������� ������, ���� ������ ��� ���� ���������� ������';
COMMENT ON COLUMN BARS.KLP_ZPROD.KURS IS '����� ������� �������� ������ ��� ���������� ������, ���� ������� � �������';
COMMENT ON COLUMN BARS.KLP_ZPROD.SUMKURS IS '����� ������� �������� ������ ��� ���������� ������, ���� � ������� �������� �� �����';
COMMENT ON COLUMN BARS.KLP_ZPROD.RAHBANK IS '�����'������ �� ���������, ���� �������� ������, �� ������ ������� ������������ �� �������';
COMMENT ON COLUMN BARS.KLP_ZPROD.RAHPOT IS '�����'������ �� ���������, ��������� ��������� ������� �������� ������ ������������ �� �������� �������';
COMMENT ON COLUMN BARS.KLP_ZPROD.KOMIS IS '�����'������ �� ���������, ��������� ������� ���������� � ���. (%)';
COMMENT ON COLUMN BARS.KLP_ZPROD.RAHPOTVAL IS '�����'������ �� ���������, ��������� �������� ������ �� �������';
COMMENT ON COLUMN BARS.KLP_ZPROD.RAHVAL IS '������� � �������� ����� ��� ���������� ������';
COMMENT ON COLUMN BARS.KLP_ZPROD.PS_NUMBER IS '����� ��� ������ ������ ��� ���������� ������ ��������� ���, ��������� N%';
COMMENT ON COLUMN BARS.KLP_ZPROD.DATETIMEPICKER1 IS '��';
COMMENT ON COLUMN BARS.KLP_ZPROD.NAME IS '�������� �����, ���������, ������������ �볺��� / �.�.�.';
COMMENT ON COLUMN BARS.KLP_ZPROD.POSTIND IS '̳�������������� / ���� ����������, ������';
COMMENT ON COLUMN BARS.KLP_ZPROD.RAYON IS '̳�������������� / ���� ����������, �����';
COMMENT ON COLUMN BARS.KLP_ZPROD.CITY IS '̳�������������� / ���� ����������, ̳���';
COMMENT ON COLUMN BARS.KLP_ZPROD.STREET IS '̳�������������� / ���� ����������, ������';
COMMENT ON COLUMN BARS.KLP_ZPROD.HOUSE IS '̳�������������� / ���� ����������, �������';
COMMENT ON COLUMN BARS.KLP_ZPROD.APARTMENT IS '̳�������������� / ���� ����������, ʳ����� / ���� / ��.';
COMMENT ON COLUMN BARS.KLP_ZPROD.FONFAX IS '̳�������������� / ���� ����������, ������� / ����';
COMMENT ON COLUMN BARS.KLP_ZPROD.REGION IS '̳�������������� / ���� ����������, �������';
COMMENT ON COLUMN BARS.KLP_ZPROD.NAMEUP IS '������������� ���������, �.�.�.';
COMMENT ON COLUMN BARS.KLP_ZPROD.TELUP IS '������������� ���������, �������';
COMMENT ON COLUMN BARS.KLP_ZPROD.KF IS '';
COMMENT ON COLUMN BARS.KLP_ZPROD.DATEDOKKB IS '';




PROMPT *** Create  constraint KLP_ZPROD_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZPROD ADD CONSTRAINT KLP_ZPROD_PK PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPZPROD_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZPROD ADD CONSTRAINT FK_KLPZPROD_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPZPROD_FL ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZPROD ADD CONSTRAINT FK_KLPZPROD_FL FOREIGN KEY (FL)
	  REFERENCES BARS.KLP_FL (FL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPZPROD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ZPROD MODIFY (KF CONSTRAINT CC_KLPZPROD_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index KLP_ZPROD_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.KLP_ZPROD_PK ON BARS.KLP_ZPROD (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_ZPROD ***
grant SELECT                                                                 on KLP_ZPROD       to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_ZPROD       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on KLP_ZPROD       to PYOD001;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_ZPROD       to TECH_MOM1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_ZPROD.sql =========*** End *** ===
PROMPT ===================================================================================== 
