PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EDS_DECL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EDS_DECL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EDS_DECL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_DECL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_DECL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EDS_DECL ***
begin 
  execute immediate '
  CREATE TABLE BARS.EDS_DECL 
   (    ID VARCHAR2(36), 
    DECL_ID NUMBER, 
    CRT_DATE DATE, 
    STATE NUMBER(1,0), 
    OKPO VARCHAR2(10), 
    CUST_NAME VARCHAR2(255), 
    BIRTH_DATE DATE, 
    DOC_TYPE NUMBER(2,0), 
    DOC_SERIAL VARCHAR2(10), 
    DOC_NUMBER VARCHAR2(30), 
    DATE_FROM DATE, 
    DATE_TO DATE, 
    COMM VARCHAR2(255), 
    DONEBY NUMBER, 
    DONEBY_FIO VARCHAR2(60), 
    BRANCH VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EDS_DECL ***
 exec bpa.alter_policies('EDS_DECL');


COMMENT ON TABLE BARS.EDS_DECL IS '��� �-����������';
COMMENT ON COLUMN BARS.EDS_DECL.ID IS '�� ������ �� ���������';
COMMENT ON COLUMN BARS.EDS_DECL.DECL_ID IS '�� ����������';
COMMENT ON COLUMN BARS.EDS_DECL.CRT_DATE IS '���� ��������� ������';
COMMENT ON COLUMN BARS.EDS_DECL.STATE IS '���� ����������';
COMMENT ON COLUMN BARS.EDS_DECL.OKPO IS '����';
COMMENT ON COLUMN BARS.EDS_DECL.CUST_NAME IS '��� �볺���';
COMMENT ON COLUMN BARS.EDS_DECL.BIRTH_DATE IS '���� ���������� �볺���';
COMMENT ON COLUMN BARS.EDS_DECL.DOC_TYPE IS '��� ���������';
COMMENT ON COLUMN BARS.EDS_DECL.DOC_SERIAL IS '���� ���������';
COMMENT ON COLUMN BARS.EDS_DECL.DOC_NUMBER IS '����� ���������';
COMMENT ON COLUMN BARS.EDS_DECL.DATE_FROM IS '��������� ���� ����������';
COMMENT ON COLUMN BARS.EDS_DECL.DATE_TO IS 'ʳ����� ���� ����������';
COMMENT ON COLUMN BARS.EDS_DECL.COMM IS '��������(���)';
COMMENT ON COLUMN BARS.EDS_DECL.DONEBY IS '�� ����������, ���� ������� ����������';
COMMENT ON COLUMN BARS.EDS_DECL.DONEBY_FIO IS 'Բ� ����������, ���� ������� ����������';
COMMENT ON COLUMN BARS.EDS_DECL.BRANCH IS '����� ����������, ���� ������� ����������';




PROMPT *** Create  index PK_EDS_DECL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EDS_DECL ON BARS.EDS_DECL (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IND_EDS_DECL_DECL_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.IND_EDS_DECL_DECL_ID ON BARS.EDS_DECL (DECL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IND_EDS_DECL_OKPO ***
begin   
 execute immediate '
  CREATE INDEX BARS.IND_EDS_DECL_OKPO ON BARS.EDS_DECL (OKPO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint PK_EDS_DECL ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_DECL ADD CONSTRAINT PK_EDS_DECL PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EDS_DECL ***
grant SELECT on EDS_DECL to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EDS_DECL.sql =========*** End *** ====
PROMPT ===================================================================================== 

