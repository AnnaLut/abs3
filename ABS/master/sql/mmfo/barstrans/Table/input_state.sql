

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Table/INPUT_STATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table INPUT_STATE ***
begin 
  execute immediate '
  CREATE TABLE BARSTRANS.INPUT_STATE 
   (	ID NUMBER, 
	CONST_N VARCHAR2(255), 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSTRANS.INPUT_STATE IS '������� ��������� ������';
COMMENT ON COLUMN BARSTRANS.INPUT_STATE.ID IS '�� �������';
COMMENT ON COLUMN BARSTRANS.INPUT_STATE.CONST_N IS '��� ���������';
COMMENT ON COLUMN BARSTRANS.INPUT_STATE.NAME IS '���� �������';




PROMPT *** Create  constraint PK_INPUT_STATE ***
begin   
 execute immediate '
  ALTER TABLE BARSTRANS.INPUT_STATE ADD CONSTRAINT PK_INPUT_STATE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INPUT_STATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSTRANS.PK_INPUT_STATE ON BARSTRANS.INPUT_STATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Table/INPUT_STATE.sql =========*** End 
PROMPT ===================================================================================== 

