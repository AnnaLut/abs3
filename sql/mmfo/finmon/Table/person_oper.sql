

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/PERSON_OPER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  table PERSON_OPER ***
begin 
  execute immediate '
  CREATE TABLE FINMON.PERSON_OPER 
   (	OPER_ID VARCHAR2(15), 
	PERSON_ID VARCHAR2(15), 
	CL_TYPE VARCHAR2(2), 
	DOC_OSN VARCHAR2(254), 
	PBANK_ID VARCHAR2(15), 
	ACCOUNT VARCHAR2(35), 
	BRANCH_ID VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.PERSON_OPER IS '�������� �������� � ����������';
COMMENT ON COLUMN FINMON.PERSON_OPER.CL_TYPE IS '��� ������� � ��������';
COMMENT ON COLUMN FINMON.PERSON_OPER.DOC_OSN IS '��������-��������� ������� � ��������';
COMMENT ON COLUMN FINMON.PERSON_OPER.PBANK_ID IS '����, ���� �������� ���������� � ��������';
COMMENT ON COLUMN FINMON.PERSON_OPER.ACCOUNT IS '����� �����, �������������� ��� ��������';
COMMENT ON COLUMN FINMON.PERSON_OPER.BRANCH_ID IS '';
COMMENT ON COLUMN FINMON.PERSON_OPER.OPER_ID IS '������������� ��������';
COMMENT ON COLUMN FINMON.PERSON_OPER.PERSON_ID IS '������������� ���������';




PROMPT *** Create  constraint XPK_PERSON_OPER ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON_OPER ADD CONSTRAINT XPK_PERSON_OPER PRIMARY KEY (OPER_ID, PERSON_ID, BRANCH_ID, CL_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PERSON_OPER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_PERSON_OPER ON FINMON.PERSON_OPER (OPER_ID, PERSON_ID, BRANCH_ID, CL_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PERSON_OPER ***
grant SELECT                                                                 on PERSON_OPER     to BARS;
grant SELECT                                                                 on PERSON_OPER     to BARSREADER_ROLE;



PROMPT *** Create SYNONYM  to PERSON_OPER ***

  CREATE OR REPLACE PUBLIC SYNONYM PERSON_OPER FOR FINMON.PERSON_OPER;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/PERSON_OPER.sql =========*** End ***
PROMPT ===================================================================================== 
