PROMPT *** ALTER_POLICY_INFO to NOTARY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NOTARY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NOTARY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NOTARY ***
begin 
  execute immediate '
  CREATE TABLE BARS.NOTARY 
   (	ID NUMBER(10,0), 
	TIN VARCHAR2(10 CHAR), 
	FIRST_NAME VARCHAR2(100 CHAR), 
	MIDDLE_NAME VARCHAR2(100 CHAR), 
	LAST_NAME VARCHAR2(100 CHAR), 
	DATE_OF_BIRTH DATE, 
	PASSPORT_SERIES VARCHAR2(2 CHAR), 
	PASSPORT_NUMBER VARCHAR2(6 CHAR), 
	ADDRESS VARCHAR2(4000), 
	PASSPORT_ISSUER VARCHAR2(70), 
	PASSPORT_ISSUED DATE, 
	PHONE_NUMBER VARCHAR2(100 CHAR), 
	MOBILE_PHONE_NUMBER VARCHAR2(100 CHAR), 
	EMAIL VARCHAR2(100 CHAR), 
	NOTARY_TYPE NUMBER(5,0), 
	CERTIFICATE_NUMBER VARCHAR2(30 CHAR), 
	CERTIFICATE_ISSUE_DATE DATE, 
	CERTIFICATE_CANCELATION_DATE DATE, 
	STATE_ID NUMBER(5,0) DEFAULT 1,
	DOCUMENT_TYPE number(2) default 1 not null,
	IDCARD_DOCUMENT_NUMBER number(9),
	IDCARD_NOTATION_NUMBER VARCHAR2(14),
	PASSPORT_EXPIRY DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NOTARY ***
 exec bpa.alter_policies('NOTARY');


COMMENT ON TABLE BARS.NOTARY IS '�������������� ������� ��������, � ����� �������� �� ������� ��������';
COMMENT ON COLUMN BARS.NOTARY.ID IS '��������� ������������� ��������';
COMMENT ON COLUMN BARS.NOTARY.TIN IS '������������� ���������� ����� ��������';
COMMENT ON COLUMN BARS.NOTARY.FIRST_NAME IS '��''�';
COMMENT ON COLUMN BARS.NOTARY.MIDDLE_NAME IS '��-�������';
COMMENT ON COLUMN BARS.NOTARY.LAST_NAME IS '�������';
COMMENT ON COLUMN BARS.NOTARY.DATE_OF_BIRTH IS '���� ����������';
COMMENT ON COLUMN BARS.NOTARY.PASSPORT_SERIES IS '���� ��������';
COMMENT ON COLUMN BARS.NOTARY.PASSPORT_NUMBER IS '����� ��������';
COMMENT ON COLUMN BARS.NOTARY.ADDRESS IS '������ ��������� �������� � ���� ������������ ������';
COMMENT ON COLUMN BARS.NOTARY.PASSPORT_ISSUER IS '��� ������� ��������';
COMMENT ON COLUMN BARS.NOTARY.PASSPORT_ISSUED IS '���� ������ ���������';
COMMENT ON COLUMN BARS.NOTARY.PHONE_NUMBER IS '����� �������� ������������� ��''����';
COMMENT ON COLUMN BARS.NOTARY.MOBILE_PHONE_NUMBER IS '����� ��������� ��������';
COMMENT ON COLUMN BARS.NOTARY.EMAIL IS '������ ���������� ����� ��������';
COMMENT ON COLUMN BARS.NOTARY.NOTARY_TYPE IS '��� ��������� �������� (1 - ���������, 2 - ���������)';
COMMENT ON COLUMN BARS.NOTARY.CERTIFICATE_NUMBER IS '����� �������� ��� �������� ���������';
COMMENT ON COLUMN BARS.NOTARY.CERTIFICATE_ISSUE_DATE IS '���� ������ �������� ��� �������� ���������';
COMMENT ON COLUMN BARS.NOTARY.CERTIFICATE_CANCELATION_DATE IS '���� ���������� �������� ���������';
COMMENT ON COLUMN BARS.NOTARY.STATE_ID IS '���� ������ ��� �������� (1 - ��������, 2 - ������� ��������)';




PROMPT *** Create  constraint SYS_C005483 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTARY_FIRST_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY ADD CONSTRAINT CC_NOTARY_FIRST_NAME_NN CHECK (FIRST_NAME IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTARY_MIDDLE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY ADD CONSTRAINT CC_NOTARY_MIDDLE_NAME_NN CHECK (MIDDLE_NAME IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NOTARY_LAST_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY ADD CONSTRAINT CC_NOTARY_LAST_NAME_NN CHECK (LAST_NAME IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NOTARY ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY ADD CONSTRAINT PK_NOTARY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010636 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY ADD CHECK (STATE_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_NOTARY ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY ADD CONSTRAINT UK_NOTARY UNIQUE (CERTIFICATE_NUMBER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010635 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NOTARY ADD CHECK (STATE_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NOTARY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NOTARY ON BARS.NOTARY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NOTARY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NOTARY ON BARS.NOTARY (CERTIFICATE_NUMBER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index NOTARY_IDX2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.NOTARY_IDX2 ON BARS.NOTARY (TIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index NOTARY_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.NOTARY_IDX ON BARS.NOTARY (PASSPORT_NUMBER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin
    execute immediate 'alter table NOTARY add DOCUMENT_TYPE number(2) default 1 not null';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'alter table NOTARY add IDCARD_DOCUMENT_NUMBER number(9)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'alter table NOTARY add IDCARD_NOTATION_NUMBER VARCHAR2(14)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'alter table NOTARY add PASSPORT_EXPIRY DATE';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'alter table notary
  add constraint FK_NOTARY_PASSP foreign key (DOCUMENT_TYPE)
  references PASSP (PASSP)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/


PROMPT *** Create  grants  NOTARY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NOTARY          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NOTARY          to BARS_DM;
