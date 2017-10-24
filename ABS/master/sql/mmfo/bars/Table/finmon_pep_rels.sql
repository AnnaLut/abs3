

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_PEP_RELS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_PEP_RELS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_PEP_RELS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_PEP_RELS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_PEP_RELS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_PEP_RELS 
   (	ID NUMBER(6,0), 
	IDCODE VARCHAR2(10), 
	NAME VARCHAR2(300), 
	PEP VARCHAR2(300), 
	BDATE DATE, 
	DOCT NUMBER(2,0), 
	DOCS VARCHAR2(10), 
	DOCN NUMBER(10,0), 
	CATEGORY VARCHAR2(300), 
	EDATE DATE, 
	BRANCH VARCHAR2(6), 
	PERMIT NUMBER(1,0), 
	REMDOC NUMBER(1,0), 
	COMMENTS VARCHAR2(300), 
	PTYPE NUMBER(1,0), 
	PRES NUMBER(1,0), 
	MDATE DATE, 
	DOCALL VARCHAR2(50)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINMON_PEP_RELS ***
 exec bpa.alter_policies('FINMON_PEP_RELS');


COMMENT ON TABLE BARS.FINMON_PEP_RELS IS '������ ��� �˲����';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.ID IS '��������� ���';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.IDCODE IS '���';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.NAME IS '�������, ��� �� �� ������� �� ��� ����� ��';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.PEP IS '�������� � �� ������� �����';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.BDATE IS '���� ����������';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.DOCT IS '��� ���������';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.DOCS IS '���� ���������';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.DOCN IS '����� ���������';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.CATEGORY IS '�������� ���';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.EDATE IS '���� ������ ������ ���';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.BRANCH IS '��� ��볿 ����� (���)';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.PERMIT IS '����� �� ������������ ������ �������';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.REMDOC IS '���������� �� ������ ���������';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.COMMENTS IS '�������';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.PTYPE IS '��� ����� (1-��,2-��,3-���)';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.PRES IS '������������';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.MDATE IS '���� ������� ��� � �����';
COMMENT ON COLUMN BARS.FINMON_PEP_RELS.DOCALL IS '��������� ���� ��� ��, ������� ��� ������';




PROMPT *** Create  constraint CK_PERMIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_PEP_RELS ADD CONSTRAINT CK_PERMIT CHECK (PERMIT IN (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CK_REMDOC ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_PEP_RELS ADD CONSTRAINT CK_REMDOC CHECK (REMDOC IN (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0035419 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_PEP_RELS ADD PRIMARY KEY (IDCODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CK_PRES ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_PEP_RELS ADD CONSTRAINT CK_PRES CHECK (PRES IN (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CK_PTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_PEP_RELS ADD CONSTRAINT CK_PTYPE CHECK (PTYPE IN (1,2,3)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0035419 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0035419 ON BARS.FINMON_PEP_RELS (IDCODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FINMON_PEP_RELS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FINMON_PEP_RELS to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on FINMON_PEP_RELS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_PEP_RELS.sql =========*** End *
PROMPT ===================================================================================== 
