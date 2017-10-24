

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/ACC_TURNOVERS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  table ACC_TURNOVERS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.ACC_TURNOVERS 
   (	BANK_ID VARCHAR2(11), 
	ACC_NUM VARCHAR2(15), 
	CUR_ID NUMBER(3,0), 
	TURNS_DATE DATE, 
	PREV_TURNS_DATE DATE, 
	BALANCE NUMBER, 
	DEBIT_TURNS NUMBER, 
	CREDIT_TURNS NUMBER, 
	BALANCE_EQ NUMBER, 
	DEBIT_TURNS_EQ NUMBER, 
	CREDIT_TURNS_EQ NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.ACC_TURNOVERS IS '����� �������� �� ���� ������ �� ����� version 1.0';
COMMENT ON COLUMN BARSAQ.ACC_TURNOVERS.BANK_ID IS '��� ����� ��������� �����';
COMMENT ON COLUMN BARSAQ.ACC_TURNOVERS.ACC_NUM IS '����� �����';
COMMENT ON COLUMN BARSAQ.ACC_TURNOVERS.CUR_ID IS '��� ������';
COMMENT ON COLUMN BARSAQ.ACC_TURNOVERS.TURNS_DATE IS '���� ��������';
COMMENT ON COLUMN BARSAQ.ACC_TURNOVERS.PREV_TURNS_DATE IS '���� ���������� ��������';
COMMENT ON COLUMN BARSAQ.ACC_TURNOVERS.BALANCE IS '�������� ������� � ��������';
COMMENT ON COLUMN BARSAQ.ACC_TURNOVERS.DEBIT_TURNS IS '������� ����� � ��������';
COMMENT ON COLUMN BARSAQ.ACC_TURNOVERS.CREDIT_TURNS IS '������� ������ � ��������';
COMMENT ON COLUMN BARSAQ.ACC_TURNOVERS.BALANCE_EQ IS '�������� ������� � ���. ������';
COMMENT ON COLUMN BARSAQ.ACC_TURNOVERS.DEBIT_TURNS_EQ IS '������� ����� � ���. ������';
COMMENT ON COLUMN BARSAQ.ACC_TURNOVERS.CREDIT_TURNS_EQ IS '������� ������ � ���. ������';




PROMPT *** Create  constraint FK_ACCTURNOVERS_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TURNOVERS ADD CONSTRAINT FK_ACCTURNOVERS_TABVAL FOREIGN KEY (CUR_ID)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCTURNOVERS_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TURNOVERS ADD CONSTRAINT FK_ACCTURNOVERS_BANKS FOREIGN KEY (BANK_ID)
	  REFERENCES BARS.BANKS$BASE (MFO) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCTURNOVERS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TURNOVERS ADD CONSTRAINT PK_ACCTURNOVERS PRIMARY KEY (BANK_ID, ACC_NUM, CUR_ID, TURNS_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTURNOVERS_PREVTURNSDATE ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TURNOVERS ADD CONSTRAINT CC_ACCTURNOVERS_PREVTURNSDATE CHECK (prev_turns_date = trunc(prev_turns_date)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTURNOVERS_TURNSDATE ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TURNOVERS ADD CONSTRAINT CC_ACCTURNOVERS_TURNSDATE CHECK (turns_date = trunc(turns_date)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTURNOVERS_CRTURNS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TURNOVERS MODIFY (CREDIT_TURNS CONSTRAINT CC_ACCTURNOVERS_CRTURNS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTURNOVERS_DRTURNS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TURNOVERS MODIFY (DEBIT_TURNS CONSTRAINT CC_ACCTURNOVERS_DRTURNS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTURNOVERS_BALANCE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TURNOVERS MODIFY (BALANCE CONSTRAINT CC_ACCTURNOVERS_BALANCE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTURNOVERS_TURNSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TURNOVERS MODIFY (TURNS_DATE CONSTRAINT CC_ACCTURNOVERS_TURNSDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTURNOVERS_CURID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TURNOVERS MODIFY (CUR_ID CONSTRAINT CC_ACCTURNOVERS_CURID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTURNOVERS_ACCNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TURNOVERS MODIFY (ACC_NUM CONSTRAINT CC_ACCTURNOVERS_ACCNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCTURNOVERS_BANKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.ACC_TURNOVERS MODIFY (BANK_ID CONSTRAINT CC_ACCTURNOVERS_BANKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ACCTURNOVERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.I_ACCTURNOVERS ON BARSAQ.ACC_TURNOVERS (TURNS_DATE, BANK_ID, ACC_NUM, CUR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCTURNOVERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_ACCTURNOVERS ON BARSAQ.ACC_TURNOVERS (BANK_ID, ACC_NUM, CUR_ID, TURNS_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/ACC_TURNOVERS.sql =========*** End *
PROMPT ===================================================================================== 
