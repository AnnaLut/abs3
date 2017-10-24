

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_FANTOMS_BOUND.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_FANTOMS_BOUND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_FANTOMS_BOUND'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_FANTOMS_BOUND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_FANTOMS_BOUND ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_FANTOMS_BOUND 
   (	BOUND_ID NUMBER, 
	DIRECT NUMBER, 
	FANTOM_ID NUMBER, 
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




PROMPT *** ALTER_POLICIES to CIM_FANTOMS_BOUND ***
 exec bpa.alter_policies('CIM_FANTOMS_BOUND');


COMMENT ON TABLE BARS.CIM_FANTOMS_BOUND IS 'Прив`язки фантомних платежів до контрактів v1.0';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.BOUND_ID IS 'Ідентифікатор прив`язки';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.DIRECT IS 'Напрям платежу (0 - вхідні, 1 - вихідні)';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.FANTOM_ID IS 'Ідентифікатор фантому';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.CONTR_ID IS 'Ідентифікатор контракту';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.PAY_FLAG IS 'Класифікатор платежу (0..3)';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.S IS 'Сума при`язки у валюті платежу';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.S_CV IS 'Сума при`язки у валюті контракту';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.RATE IS 'Курс валют';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.COMISS IS 'Комісія';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.COMMENTS IS 'Коментар';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.JOURNAL_ID IS 'Номер журналу';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.JOURNAL_NUM IS 'Номер у журналі';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.CREATE_DATE IS 'Банківська дата останньої модифікації';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.MODIFY_DATE IS '';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.DELETE_DATE IS 'Дата видалення привязки';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.UID_DEL_BOUND IS 'ID користувача, який видалив зв`язок';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.UID_DEL_JOURNAL IS 'ID користувача, який видалив запис з журналу';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.BORG_REASON IS 'Причина заборгованості';
COMMENT ON COLUMN BARS.CIM_FANTOMS_BOUND.BRANCH IS 'Номер відділеня';




PROMPT *** Create  constraint FK_FANTOMSBOUND_BORGREASON ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND ADD CONSTRAINT FK_FANTOMSBOUND_BORGREASON FOREIGN KEY (BORG_REASON)
	  REFERENCES BARS.CIM_BORG_REASON (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FANTOMSBOUND_PAYFLAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND ADD CONSTRAINT FK_FANTOMSBOUND_PAYFLAG FOREIGN KEY (PAY_FLAG)
	  REFERENCES BARS.CIM_PAYFLAG (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FANTOMSBOUND_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND ADD CONSTRAINT FK_FANTOMSBOUND_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FANTOMSBOUND_CONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND ADD CONSTRAINT FK_FANTOMSBOUND_CONTRACTS FOREIGN KEY (CONTR_ID)
	  REFERENCES BARS.CIM_CONTRACTS (CONTR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FANTOMSBOUND_FANTOMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND ADD CONSTRAINT FK_FANTOMSBOUND_FANTOMS FOREIGN KEY (FANTOM_ID)
	  REFERENCES BARS.CIM_FANTOM_PAYMENTS (FANTOM_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FANTOMSBOUND_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND ADD CONSTRAINT FK_FANTOMSBOUND_TYPES FOREIGN KEY (DIRECT)
	  REFERENCES BARS.CIM_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMFANTOMSBOUND_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND MODIFY (S CONSTRAINT CC_CIMFANTOMSBOUND_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMFANTOMSBOUND_PAYFLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND MODIFY (PAY_FLAG CONSTRAINT CC_CIMFANTOMSBOUND_PAYFLAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMFANTOMSBOUND_FANTOMID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND MODIFY (FANTOM_ID CONSTRAINT CC_CIMFANTOMSBOUND_FANTOMID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMFANTOMSBOUND_DIR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND MODIFY (DIRECT CONSTRAINT CC_CIMFANTOMSBOUND_DIR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMFANTOMSBOUND_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND MODIFY (BOUND_ID CONSTRAINT CC_CIMFANTOMSBOUND_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FANTOMSBOUND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND ADD CONSTRAINT PK_FANTOMSBOUND PRIMARY KEY (BOUND_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMFANTOMSBOUND_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND MODIFY (BRANCH CONSTRAINT CC_CIMFANTOMSBOUND_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMFANTOMSBOUND_MDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND MODIFY (MODIFY_DATE CONSTRAINT CC_CIMFANTOMSBOUND_MDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMFANTOMSBOUND_CDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_FANTOMS_BOUND MODIFY (CREATE_DATE CONSTRAINT CC_CIMFANTOMSBOUND_CDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FANTOMSBOUND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FANTOMSBOUND ON BARS.CIM_FANTOMS_BOUND (BOUND_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_FANTOMS_BOUND ***
grant SELECT                                                                 on CIM_FANTOMS_BOUND to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_FANTOMS_BOUND to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_FANTOMS_BOUND.sql =========*** End
PROMPT ===================================================================================== 
