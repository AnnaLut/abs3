

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_PAYMENTS_BOUND.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_PAYMENTS_BOUND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_PAYMENTS_BOUND'', ''CENTER'' , null, null, null, null);
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
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	BORG_REASON NUMBER
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


COMMENT ON TABLE BARS.CIM_PAYMENTS_BOUND IS 'Прив''язки реальних платежів до контрактів v1.0';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.BOUND_ID IS 'Ідентифікатор привязки';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.DIRECT IS 'Напрям платежу (0 - вхідні, 1 - вихідні)';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.REF IS 'Референс документу';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.CONTR_ID IS 'Ідентифікатор контракту';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.PAY_FLAG IS 'Класифікатор платежу (0..3)';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.S IS 'Сума при`язки у валюті платежу';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.S_CV IS 'Сума при`язки у валюті контракту';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.RATE IS 'Курс валют';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.COMISS IS 'Комісія';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.COMMENTS IS 'Коментар';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.JOURNAL_ID IS 'Номер журналу';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.JOURNAL_NUM IS 'Номер у журналі';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.CREATE_DATE IS 'Банківська дата створення';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.MODIFY_DATE IS 'Банківська дата останньої модифікації';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.DELETE_DATE IS 'Дата видалення привязки';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.UID_DEL_BOUND IS 'ID користувача, який видалив зв`язок';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.UID_DEL_JOURNAL IS 'ID користувача, який видалив запис з журналу';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.BRANCH IS 'Номер відділеня';
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.BORG_REASON IS 'Причина заборгованості';




PROMPT *** Create  constraint PK_PAYMENTSBOUND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND ADD CONSTRAINT PK_PAYMENTSBOUND PRIMARY KEY (BOUND_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYMENTSBOUND_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND MODIFY (BOUND_ID CONSTRAINT CC_CIMPAYMENTSBOUND_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYMENTSBOUND_DIR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND MODIFY (DIRECT CONSTRAINT CC_CIMPAYMENTSBOUND_DIR_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYMENTSBOUND_PAYFLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND MODIFY (PAY_FLAG CONSTRAINT CC_CIMPAYMENTSBOUND_PAYFLAG_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYMENTSBOUND_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND MODIFY (S CONSTRAINT CC_CIMPAYMENTSBOUND_S_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYMENTSBOUND_CDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND MODIFY (CREATE_DATE CONSTRAINT CC_CIMPAYMENTSBOUND_CDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYMENTSBOUND_MDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND MODIFY (MODIFY_DATE CONSTRAINT CC_CIMPAYMENTSBOUND_MDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMPAYMENTSBOUND_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND MODIFY (BRANCH CONSTRAINT CC_CIMPAYMENTSBOUND_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
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

PROMPT *** Create  index IDX_CIMPAYMENTS_CONTRID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CIMPAYMENTS_CONTRID ON BARS.CIM_PAYMENTS_BOUND (CONTR_ID)';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint FK_CIMPAYMENTS_CONTRID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_PAYMENTS_BOUND ADD CONSTRAINT FK_CIMPAYMENTS_CONTRID FOREIGN KEY (CONTR_ID)
	  REFERENCES BARS.CIM_CONTRACTS (CONTR_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin
    execute immediate 'alter table bars.CIM_PAYMENTS_BOUND add (DEADLINE NUMBER)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.DEADLINE IS 'Контрольний строк по документу';

begin
    execute immediate 'alter table bars.CIM_PAYMENTS_BOUND add (IS_DOC NUMBER(1) default 0)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_PAYMENTS_BOUND.IS_DOC IS 'Наявність документів у Банку:  1 - Так';

PROMPT *** Create  index IDX_CIMPAYMENTS_ISDOC ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CIMPAYMENTS_ISDOC ON BARS.CIM_PAYMENTS_BOUND (DECODE(IS_DOC,1,''Так'',''Ні''))';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_PAYMENTS_BOUND ***
grant SELECT                                                                 on CIM_PAYMENTS_BOUND to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_PAYMENTS_BOUND to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_PAYMENTS_BOUND to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_PAYMENTS_BOUND to CIM_ROLE;
grant SELECT                                                                 on CIM_PAYMENTS_BOUND to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_PAYMENTS_BOUND.sql =========*** En
PROMPT ===================================================================================== 
