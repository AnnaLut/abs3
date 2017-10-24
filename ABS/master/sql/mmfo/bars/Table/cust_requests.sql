

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUST_REQUESTS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUST_REQUESTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUST_REQUESTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUST_REQUESTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUST_REQUESTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUST_REQUESTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUST_REQUESTS 
   (	REQ_ID NUMBER(38,0), 
	REQ_TYPE NUMBER(1,0), 
	TRUSTEE_TYPE CHAR(1), 
	TRUSTEE_RNK NUMBER(38,0), 
	CERTIF_NUM VARCHAR2(50), 
	CERTIF_DATE DATE, 
	DATE_START DATE, 
	DATE_FINISH DATE, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	COMMENTS VARCHAR2(128), 
	REQ_BDATE DATE, 
	REQ_CRDATE DATE, 
	REQ_CRUSER NUMBER(38,0), 
	REQ_PRCDATE DATE, 
	REQ_PRCUSER NUMBER(38,0), 
	REQ_STATE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUST_REQUESTS ***
 exec bpa.alter_policies('CUST_REQUESTS');


COMMENT ON TABLE BARS.CUST_REQUESTS IS 'Запити про надання доступу через бек-офіс';
COMMENT ON COLUMN BARS.CUST_REQUESTS.REQ_ID IS 'Ідентифікатор запиту';
COMMENT ON COLUMN BARS.CUST_REQUESTS.REQ_TYPE IS 'Тип запиту (0 - картка клієнта / 1 - депозити / 2- дострокове вилучення невідкличних депозитів)';
COMMENT ON COLUMN BARS.CUST_REQUESTS.TRUSTEE_TYPE IS 'Тип особи якій надається доступ (власник / довірена особа / спадкоємець)';
COMMENT ON COLUMN BARS.CUST_REQUESTS.TRUSTEE_RNK IS 'РНК особи якій надається доступ';
COMMENT ON COLUMN BARS.CUST_REQUESTS.CERTIF_NUM IS 'Номер документу';
COMMENT ON COLUMN BARS.CUST_REQUESTS.CERTIF_DATE IS 'Дата  документу';
COMMENT ON COLUMN BARS.CUST_REQUESTS.DATE_START IS 'Дата потатку дії доручення (вступу в права)';
COMMENT ON COLUMN BARS.CUST_REQUESTS.DATE_FINISH IS 'Дата завершення дії доручення';
COMMENT ON COLUMN BARS.CUST_REQUESTS.BRANCH IS '';
COMMENT ON COLUMN BARS.CUST_REQUESTS.COMMENTS IS 'Коментар до запиту';
COMMENT ON COLUMN BARS.CUST_REQUESTS.REQ_BDATE IS 'Банківська дата створення запиту';
COMMENT ON COLUMN BARS.CUST_REQUESTS.REQ_CRDATE IS 'Дата створення запиту';
COMMENT ON COLUMN BARS.CUST_REQUESTS.REQ_CRUSER IS 'Ідентифікатор користувача, що створив запит';
COMMENT ON COLUMN BARS.CUST_REQUESTS.REQ_PRCDATE IS 'Дата обробки запиту';
COMMENT ON COLUMN BARS.CUST_REQUESTS.REQ_PRCUSER IS 'Ідентифікатор користувача, що обробив запит';
COMMENT ON COLUMN BARS.CUST_REQUESTS.REQ_STATE IS 'Статус запиту (0 - новий / 1 - оброблений / -1 - відхилений)';




PROMPT *** Create  constraint PK_CUSTREQS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQUESTS ADD CONSTRAINT PK_CUSTREQS PRIMARY KEY (REQ_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQS_REQTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQUESTS ADD CONSTRAINT CC_CUSTREQS_REQTYPE CHECK ( REQ_TYPE in ( 0, 1, 2 ) ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQS_REQSTATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQUESTS ADD CONSTRAINT CC_CUSTREQS_REQSTATE CHECK ( REQ_STATE in ( -1, 0, 1, 2 ) ) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQS_TRUSTEETYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQUESTS ADD CONSTRAINT CC_CUSTREQS_TRUSTEETYPE CHECK (TRUSTEE_TYPE in (''V'',''H'',''T'')) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQS_REQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQUESTS MODIFY (REQ_ID CONSTRAINT CC_CUSTREQS_REQID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQS_REQCRUSER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQUESTS MODIFY (REQ_CRUSER CONSTRAINT CC_CUSTREQS_REQCRUSER_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQS_TRUSTEETYP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQUESTS MODIFY (TRUSTEE_TYPE CONSTRAINT CC_CUSTREQS_TRUSTEETYP_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQS_TRUSTEERNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQUESTS MODIFY (TRUSTEE_RNK CONSTRAINT CC_CUSTREQS_TRUSTEERNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQUESTS MODIFY (BRANCH CONSTRAINT CC_CUSTREQS_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQS_REQBDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQUESTS MODIFY (REQ_BDATE CONSTRAINT CC_CUSTREQS_REQBDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQS_REQCRDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQUESTS MODIFY (REQ_CRDATE CONSTRAINT CC_CUSTREQS_REQCRDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTREQS_REQTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUST_REQUESTS MODIFY (REQ_TYPE CONSTRAINT CC_CUSTREQS_REQTYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTREQS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTREQS ON BARS.CUST_REQUESTS (REQ_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CUSTREQS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CUSTREQS ON BARS.CUST_REQUESTS (REQ_ID, REQ_STATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUST_REQUESTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_REQUESTS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUST_REQUESTS   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_REQUESTS   to DPT_ADMIN;
grant SELECT                                                                 on CUST_REQUESTS   to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUST_REQUESTS   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUST_REQUESTS.sql =========*** End ***
PROMPT ===================================================================================== 
