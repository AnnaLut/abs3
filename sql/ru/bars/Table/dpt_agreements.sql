

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_AGREEMENTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_AGREEMENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_AGREEMENTS'', ''FILIAL'' , ''M'', ''M'', ''M'', null);
               bpa.alter_policy_info(''DPT_AGREEMENTS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_AGREEMENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_AGREEMENTS 
   (	AGRMNT_ID NUMBER(38,0), 
	AGRMNT_DATE DATE, 
	AGRMNT_NUM NUMBER(10,0), 
	AGRMNT_TYPE NUMBER(38,0), 
	DPT_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
	CUST_ID NUMBER(38,0), 
	BANKDATE DATE, 
	TEMPLATE_ID VARCHAR2(35), 
	TRUSTEE_ID NUMBER(38,0), 
	TRANSFER_BANK VARCHAR2(12), 
	TRANSFER_ACCOUNT VARCHAR2(14), 
	AMOUNT_CASH NUMBER(38,0), 
	AMOUNT_CASHLESS NUMBER(38,0), 
	AMOUNT_INTEREST NUMBER(38,0), 
	DATE_BEGIN DATE, 
	DATE_END DATE, 
	DENOM_AMOUNT NUMBER(38,0), 
	DENOM_COUNT NUMBER(38,0), 
	DENOM_REF NUMBER(38,0), 
	AGRMNT_STATE NUMBER(1,0), 
	COMISS_REF NUMBER(38,0), 
	UNDO_ID NUMBER(38,0), 
	TRANSFDPT CLOB, 
	TRANSFINT CLOB, 
	DOC_REF NUMBER(38,0), 
	RATE_REQID NUMBER(38,0), 
	COMISS_REQID NUMBER(38,0), 
	RATE_VALUE NUMBER(30,8), 
	RATE_DATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (TRANSFDPT) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (TRANSFINT) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_AGREEMENTS ***
 exec bpa.alter_policies('DPT_AGREEMENTS');


COMMENT ON TABLE BARS.DPT_AGREEMENTS IS '��������� �������������� ���������� (��) � ���.��������� ��';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AGRMNT_ID IS '���������� ����� ��';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AGRMNT_DATE IS '���� ���������� �� (�����������)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AGRMNT_NUM IS '����� ��';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AGRMNT_TYPE IS '��� ��';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.DPT_ID IS '� ������';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.BRANCH IS '������������� �����';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.CUST_ID IS '����.� ��������� ������';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.BANKDATE IS '���� ���������� �� (����������)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.TEMPLATE_ID IS '������ ��';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.TRUSTEE_ID IS '� �� � 3-�� �����';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.TRANSFER_BANK IS '��� ����� ��� ������������ �������� � ���������';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.TRANSFER_ACCOUNT IS '����� ����� ��� ������������ �������� � ���������';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AMOUNT_CASH IS '����� ��������� (�� �� ��������� ����� ������)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AMOUNT_CASHLESS IS '����� ������������ (�� �� ��������� ����� ������)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AMOUNT_INTEREST IS '����� ��������� � ������� (�� �� ��������� ����� ������)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.DATE_BEGIN IS '����� ���� ������ ������ (�� �� ��������� ������) ��� ���� ������ �������� ������������';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.DATE_END IS '����� ���� ��������� ������ (�� �� ��������� ������) ��� ���� ��������� �������� ������������';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.DENOM_AMOUNT IS '����� ����� ������ ����� (�� � ������ ������ �����)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.DENOM_COUNT IS '����� �������� ��� ��������� ����������� (�� � ������ ������ �����)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.DENOM_REF IS '���.���-�� �� ��������� ������� (�� � ������ ������ �����)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.AGRMNT_STATE IS '������ ��: ������./�������.';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.COMISS_REF IS '�������� ��������� - �������� �� ���������� ��';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.UNDO_ID IS '��. ���. ����������, ������� �������� ������';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.TRANSFDPT IS '����� ������������ ��������';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.TRANSFINT IS '����� ������������ ���������';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.DOC_REF IS '�������� ���������� ���������� / ���������� ������';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.RATE_REQID IS '��� ������� �� ��������� ������';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.COMISS_REQID IS '';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.RATE_VALUE IS '����� �������� ���������� ������ (�� �� ��������� ������)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.RATE_DATE IS '���� ������ �������� ���������� ������ (�� �� ��������� ������)';
COMMENT ON COLUMN BARS.DPT_AGREEMENTS.KF IS '';




PROMPT *** Create  constraint FK_DPTAGRMNTS_DPTTRUSTEE2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_DPTTRUSTEE2 FOREIGN KEY (KF, TRUSTEE_ID)
	  REFERENCES BARS.DPT_TRUSTEE (KF, ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_DPTREQS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_DPTREQS FOREIGN KEY (KF, RATE_REQID)
	  REFERENCES BARS.DPT_REQUESTS (KF, REQ_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_DPTREQS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_DPTREQS3 FOREIGN KEY (KF, COMISS_REQID)
	  REFERENCES BARS.DPT_REQUESTS (KF, REQ_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_DPTDPTALL2 FOREIGN KEY (KF, DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_OPER2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_OPER2 FOREIGN KEY (KF, DENOM_REF)
	  REFERENCES BARS.OPER (KF, REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_OPER3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_OPER3 FOREIGN KEY (KF, COMISS_REF)
	  REFERENCES BARS.OPER (KF, REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_OPER4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_OPER4 FOREIGN KEY (KF, DOC_REF)
	  REFERENCES BARS.OPER (KF, REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_BANKS FOREIGN KEY (TRANSFER_BANK)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_DOCSCHEME FOREIGN KEY (TEMPLATE_ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_DPTVIDDFLAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_DPTVIDDFLAGS FOREIGN KEY (AGRMNT_TYPE)
	  REFERENCES BARS.DPT_VIDD_FLAGS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_CUSTOMER FOREIGN KEY (CUST_ID)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTAGRMNTS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT FK_DPTAGRMNTS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_STATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT CC_DPTAGRMNTS_STATES CHECK (agrmnt_state IN (0,1,-1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPTAGRMNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT UK_DPTAGRMNTS UNIQUE (DPT_ID, AGRMNT_NUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTAGRMNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT PK_DPTAGRMNTS PRIMARY KEY (AGRMNT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (KF CONSTRAINT CC_DPTAGRMNTS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_AGRMNTSTATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (AGRMNT_STATE CONSTRAINT CC_DPTAGRMNTS_AGRMNTSTATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_TEMPLATEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (TEMPLATE_ID CONSTRAINT CC_DPTAGRMNTS_TEMPLATEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_BANKDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (BANKDATE CONSTRAINT CC_DPTAGRMNTS_BANKDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_CUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (CUST_ID CONSTRAINT CC_DPTAGRMNTS_CUSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (BRANCH CONSTRAINT CC_DPTAGRMNTS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (DPT_ID CONSTRAINT CC_DPTAGRMNTS_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_AGRMNTTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (AGRMNT_TYPE CONSTRAINT CC_DPTAGRMNTS_AGRMNTTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_AGRMNTNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (AGRMNT_NUM CONSTRAINT CC_DPTAGRMNTS_AGRMNTNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_AGRMNTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (AGRMNT_DATE CONSTRAINT CC_DPTAGRMNTS_AGRMNTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_AGRMNTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS MODIFY (AGRMNT_ID CONSTRAINT CC_DPTAGRMNTS_AGRMNTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTAGRMNTS_DATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGREEMENTS ADD CONSTRAINT CC_DPTAGRMNTS_DATES CHECK (date_begin is null or date_end is null or date_begin < date_end) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_DPTAGRMNTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_DPTAGRMNTS ON BARS.DPT_AGREEMENTS (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_DPTAGRMNTS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_DPTAGRMNTS ON BARS.DPT_AGREEMENTS (DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTAGRMNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTAGRMNTS ON BARS.DPT_AGREEMENTS (AGRMNT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTAGRMNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTAGRMNTS ON BARS.DPT_AGREEMENTS (DPT_ID, AGRMNT_NUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_AGREEMENTS ***
grant SELECT                                                                 on DPT_AGREEMENTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_AGREEMENTS  to DPT_ROLE;
grant SELECT                                                                 on DPT_AGREEMENTS  to KLBX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_AGREEMENTS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_AGREEMENTS.sql =========*** End **
PROMPT ===================================================================================== 
