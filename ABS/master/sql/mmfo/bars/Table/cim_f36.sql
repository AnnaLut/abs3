

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_F36.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_F36 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_F36'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_F36 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_F36 
   (	B041 VARCHAR2(12), 
	K020 VARCHAR2(10), 
	P17 VARCHAR2(35), 
	P16 DATE, 
	DOC_DATE VARCHAR2(8), 
	P21 DATE, 
	P14 VARCHAR2(3), 
	P01 NUMBER(1,0), 
	P22 NUMBER(1,0), 
	P02 VARCHAR2(2), 
	P02_OLD VARCHAR2(2), 
	P06 VARCHAR2(135), 
	P06_OLD VARCHAR2(135), 
	P07 VARCHAR2(135), 
	P07_OLD VARCHAR2(135), 
	P08 VARCHAR2(135), 
	P08_OLD VARCHAR2(135), 
	P09 VARCHAR2(3), 
	P13 NUMBER(16,0), 
	P15 NUMBER(16,0), 
	P18 VARCHAR2(1), 
	P19 VARCHAR2(1), 
	P20 VARCHAR2(1), 
	P23 DATE, 
	P24 DATE, 
	P25 VARCHAR2(12), 
	CREATE_DATE DATE, 
	P27 VARCHAR2(3), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'', ''user_branch''), 
	P21_NEW DATE,
    RNK     NUMBER(38)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
  execute immediate 'ALTER TABLE BARS.CIM_F36 ADD (RNK     NUMBER(38))';
exception
    when others then 
        if sqlcode=-1430 then null; else raise; end if;
end;        
/


PROMPT *** ALTER_POLICIES to CIM_F36 ***
 exec bpa.alter_policies('CIM_F36');


COMMENT ON TABLE BARS.CIM_F36 IS '��������� ������ ����������';
COMMENT ON COLUMN BARS.CIM_F36.P21_NEW IS '��������� ���� ������� ��� ���������';
COMMENT ON COLUMN BARS.CIM_F36.BRANCH IS 'ϳ������';
COMMENT ON COLUMN BARS.CIM_F36.B041 IS '��� ��������';
COMMENT ON COLUMN BARS.CIM_F36.K020 IS '��� ����';
COMMENT ON COLUMN BARS.CIM_F36.P17 IS '� ���������';
COMMENT ON COLUMN BARS.CIM_F36.P16 IS '���� ���������';
COMMENT ON COLUMN BARS.CIM_F36.DOC_DATE IS '���� ���������';
COMMENT ON COLUMN BARS.CIM_F36.P21 IS '���� ������� ��� ���������';
COMMENT ON COLUMN BARS.CIM_F36.P14 IS '��� ������';
COMMENT ON COLUMN BARS.CIM_F36.P01 IS '��� ����������������� �������� 1 - ����, 2 - ���';
COMMENT ON COLUMN BARS.CIM_F36.P22 IS '��� 䳿';
COMMENT ON COLUMN BARS.CIM_F36.P02 IS '���';
COMMENT ON COLUMN BARS.CIM_F36.P02_OLD IS '��� (�����)';
COMMENT ON COLUMN BARS.CIM_F36.P06 IS '����� ���������';
COMMENT ON COLUMN BARS.CIM_F36.P06_OLD IS '����� ��������� (�����)';
COMMENT ON COLUMN BARS.CIM_F36.P07 IS '������ ���������';
COMMENT ON COLUMN BARS.CIM_F36.P07_OLD IS '������ ��������� (�����)';
COMMENT ON COLUMN BARS.CIM_F36.P08 IS '����� �����������';
COMMENT ON COLUMN BARS.CIM_F36.P08_OLD IS '����� ����������� (�����)';
COMMENT ON COLUMN BARS.CIM_F36.P09 IS '��� ����� �����������';
COMMENT ON COLUMN BARS.CIM_F36.P13 IS '���� ���.';
COMMENT ON COLUMN BARS.CIM_F36.P15 IS '���� ������';
COMMENT ON COLUMN BARS.CIM_F36.P18 IS '1 - �������� ������, 2 - ��������� �����';
COMMENT ON COLUMN BARS.CIM_F36.P19 IS '³����� ��� ��������� �������������';
COMMENT ON COLUMN BARS.CIM_F36.P20 IS '������� ���������� �������������';
COMMENT ON COLUMN BARS.CIM_F36.P23 IS '���� �������� ��� �� ���������� ��� ���������';
COMMENT ON COLUMN BARS.CIM_F36.P24 IS '���� ������ � �������� ���������';
COMMENT ON COLUMN BARS.CIM_F36.P25 IS '��� ��������, ���� ���������';
COMMENT ON COLUMN BARS.CIM_F36.CREATE_DATE IS '���� ���������';
COMMENT ON COLUMN BARS.CIM_F36.P27 IS '������� (���������� ����� ������ ��� ������ � ���������� �������� ��������� �� ������ ������� �����������)';
COMMENT ON COLUMN BARS.CIM_F36.RNK IS '��� �����������';




PROMPT *** Create  constraint PK_CIM_F36 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F36 ADD CONSTRAINT PK_CIM_F36 PRIMARY KEY (BRANCH, B041, K020, P17, P16, DOC_DATE, P21, P14, P01, CREATE_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048929 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F36 MODIFY (B041 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048930 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F36 MODIFY (K020 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048931 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F36 MODIFY (P16 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048932 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F36 MODIFY (DOC_DATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048933 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F36 MODIFY (P21 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048934 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F36 MODIFY (P14 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048935 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F36 MODIFY (P01 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048936 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F36 MODIFY (P22 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048937 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F36 MODIFY (P15 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0048938 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_F36 MODIFY (P18 NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIM_F36 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIM_F36 ON BARS.CIM_F36 (BRANCH, B041, K020, P17, P16, DOC_DATE, P21, P14, P01, CREATE_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_F36 ***
grant SELECT                                                                 on CIM_F36         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_F36         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_F36         to CIM_ROLE;
grant SELECT                                                                 on CIM_F36         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_F36.sql =========*** End *** =====
PROMPT ===================================================================================== 
