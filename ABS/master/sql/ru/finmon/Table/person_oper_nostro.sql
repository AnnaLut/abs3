

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/PERSON_OPER_NOSTRO.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table PERSON_OPER_NOSTRO ***
begin 
  execute immediate '
  CREATE TABLE FINMON.PERSON_OPER_NOSTRO 
   (	OPER_ID VARCHAR2(15), 
	PERSON_ID VARCHAR2(15), 
	CL_TYPE VARCHAR2(2), 
	PBANK_ID VARCHAR2(15), 
	ACCOUNT VARCHAR2(35), 
	BRANCH_ID VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.PERSON_OPER_NOSTRO IS '�������� �������� � ����������';
COMMENT ON COLUMN FINMON.PERSON_OPER_NOSTRO.OPER_ID IS '������������� ��������';
COMMENT ON COLUMN FINMON.PERSON_OPER_NOSTRO.PERSON_ID IS '������������� ���������';
COMMENT ON COLUMN FINMON.PERSON_OPER_NOSTRO.CL_TYPE IS '��� ������� � ��������';
COMMENT ON COLUMN FINMON.PERSON_OPER_NOSTRO.PBANK_ID IS '����-������������';
COMMENT ON COLUMN FINMON.PERSON_OPER_NOSTRO.ACCOUNT IS '����.����';
COMMENT ON COLUMN FINMON.PERSON_OPER_NOSTRO.BRANCH_ID IS '';




PROMPT *** Create  constraint R_POPERN_BANK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON_OPER_NOSTRO ADD CONSTRAINT R_POPERN_BANK FOREIGN KEY (BRANCH_ID)
	  REFERENCES FINMON.BANK (ID) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_POPERN_POPER ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON_OPER_NOSTRO ADD CONSTRAINT R_POPERN_POPER FOREIGN KEY (OPER_ID, PERSON_ID, BRANCH_ID, CL_TYPE)
	  REFERENCES FINMON.PERSON_OPER (OPER_ID, PERSON_ID, BRANCH_ID, CL_TYPE) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_POPERN_PBANK ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON_OPER_NOSTRO ADD CONSTRAINT R_POPERN_PBANK FOREIGN KEY (PBANK_ID)
	  REFERENCES FINMON.PERSON_BANK (ID) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_PERSON_OPER_NOSTRO ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON_OPER_NOSTRO ADD CONSTRAINT XPK_PERSON_OPER_NOSTRO PRIMARY KEY (OPER_ID, PERSON_ID, BRANCH_ID, PBANK_ID, ACCOUNT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE SYSTEM  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_POPERN_BRANCH_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.PERSON_OPER_NOSTRO ADD CONSTRAINT NK_POPERN_BRANCH_ID CHECK (branch_id is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PERSON_OPER_NOSTRO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_PERSON_OPER_NOSTRO ON FINMON.PERSON_OPER_NOSTRO (OPER_ID, PERSON_ID, BRANCH_ID, PBANK_ID, ACCOUNT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE SYSTEM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/PERSON_OPER_NOSTRO.sql =========*** 
PROMPT ===================================================================================== 
