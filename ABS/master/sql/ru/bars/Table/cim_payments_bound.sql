

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_PAYMENTS_BOUND.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_PAYMENTS_BOUND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_PAYMENTS_BOUND'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_PAYMENTS_BOUND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_PAYMENTS_BOUND ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_PAYMENTS_BOUND 
   (	BOUND_ID NUMBER, 
	DIRECT NUMBER, 
	REF NUMBER, 
	CONTR_ID NUMBER, 
	PAY_FLAG NUMBER, 
	S NUMBER, 
	S_CV NUMBER, 
	RATE NUMBER(30,8), 
	COMISS NUMBER, 
	COMMENTS VARCHAR2(4000), 
	JOURNAL_ID NUMBER, 
	JOURNAL_NUM NUMBER, 
	CREATE_DATE DATE, 
	MODIFY_DATE DATE, 
	DELETE_DATE DATE, 
	UID_DEL_BOUND NUMBER, 
	UID_DEL_JOURNAL NUMBER, 
	BORG_REASON NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_PAYMENTS_BOUND ***
 exec bpa.alter_policies('CIM_PAYMENTS_BOUND');


COMMENT ON TABLE BARS.CIM_PAYMENTS_BOUND IS '����'���� �������� ������� �� ��������� v1.0';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.BOUND_ID IS '������������� ��������';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.DIRECT IS '������ ������� (0 - �����, 1 - ������)';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.REF IS '�������� ���������';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.CONTR_ID IS '������������� ���������';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.PAY_FLAG IS '������������ ������� (0..3)';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.S IS '���� ���`���� � ����� �������';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.S_CV IS '���� ���`���� � ����� ���������';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.RATE IS '���� �����';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.COMISS IS '�����';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.COMMENTS IS '��������';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.JOURNAL_ID IS '����� �������';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.JOURNAL_NUM IS '����� � ������';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.CREATE_DATE IS '��������� ���� ���������';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.MODIFY_DATE IS '��������� ���� �������� �����������';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.DELETE_DATE IS '���� ��������� ��������';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.UID_DEL_BOUND IS 'ID �����������, ���� ������� ��`����';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.UID_DEL_JOURNAL IS 'ID �����������, ���� ������� ����� � �������';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.BORG_REASON IS '������� �������������';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.BRANCH IS '����� �������';




PROMPT *** Create  constraint FK_PAYMENTSBOUND_BORGREASON ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND ADD CONSTRAINT FK_PAYMENTSBOUND_BORGREASON FOREIGN KEY (BORG_REASON)
	  REFERENCES BARS.CIM_BORG_REASON (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PAYMENTSBOUND_PAYFLAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND ADD CONSTRAINT FK_PAYMENTSBOUND_PAYFLAG FOREIGN KEY (PAY_FLAG)
	  REFERENCES BARS.CIM_PAYFLAG (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PAYMENTSBOUND_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND ADD CONSTRAINT FK_PAYMENTSBOUND_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PAYMENTSBOUND_CONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND ADD CONSTRAINT FK_PAYMENTSBOUND_CONTRACTS FOREIGN KEY (CONTR_ID)
	  REFERENCES BARS.CIM_CONTRACTS (CONTR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PAYMENTSBOUND_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND ADD CONSTRAINT FK_PAYMENTSBOUND_TYPES FOREIGN KEY (DIRECT)
	  REFERENCES BARS.CIM_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PAYMENTSBOUND_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND ADD CONSTRAINT FK_PAYMENTSBOUND_REF FOREIGN KEY (REF)
	  REFERENCES BARS.OPER (REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PAYMENTSBOUND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND ADD CONSTRAINT PK_PAYMENTSBOUND PRIMARY KEY (BOUND_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYMENTSBOUND_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND MODIFY (BRANCH CONSTRAINT CC_CIMPAYMENTSBOUND_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYMENTSBOUND_MDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND MODIFY (MODIFY_DATE CONSTRAINT CC_CIMPAYMENTSBOUND_MDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYMENTSBOUND_CDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND MODIFY (CREATE_DATE CONSTRAINT CC_CIMPAYMENTSBOUND_CDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYMENTSBOUND_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND MODIFY (S CONSTRAINT CC_CIMPAYMENTSBOUND_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYMENTSBOUND_PAYFLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND MODIFY (PAY_FLAG CONSTRAINT CC_CIMPAYMENTSBOUND_PAYFLAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYMENTSBOUND_DIR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND MODIFY (DIRECT CONSTRAINT CC_CIMPAYMENTSBOUND_DIR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYMENTSBOUND_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND MODIFY (BOUND_ID CONSTRAINT CC_CIMPAYMENTSBOUND_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PAYMENTSBOUND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PAYMENTSBOUND ON BARS.CIM_PAYMENTS_BOUND (BOUND_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_PAYMENTS_BOUND ***
grant SELECT                                                                 on CIM_PAYMENTS_BOUND to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_PAYMENTS_BOUND to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_PAYMENTS_BOUND.sql =========*** En
PROMPT ===================================================================================== 
