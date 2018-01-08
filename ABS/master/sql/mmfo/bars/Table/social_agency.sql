

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SOCIAL_AGENCY.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SOCIAL_AGENCY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SOCIAL_AGENCY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_AGENCY'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''SOCIAL_AGENCY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SOCIAL_AGENCY ***
begin 
  execute immediate '
  CREATE TABLE BARS.SOCIAL_AGENCY 
   (	AGENCY_ID NUMBER(38,0), 
	NAME VARCHAR2(100), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	DEBIT_ACC NUMBER(38,0), 
	CREDIT_ACC NUMBER(38,0), 
	CARD_ACC NUMBER(38,0), 
	CONTRACT VARCHAR2(30), 
	DATE_ON DATE DEFAULT trunc(sysdate), 
	DATE_OFF DATE, 
	ADDRESS VARCHAR2(100), 
	PHONE VARCHAR2(20), 
	DETAILS VARCHAR2(100), 
	TYPE_ID NUMBER(38,0), 
	COMISS_ACC NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SOCIAL_AGENCY ***
 exec bpa.alter_policies('SOCIAL_AGENCY');


COMMENT ON TABLE BARS.SOCIAL_AGENCY IS 'Органы социальной защиты (ОСЗ)';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY.AGENCY_ID IS 'Уникальный номер ОСЗ';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY.NAME IS 'Название ОСЗ';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY.DEBIT_ACC IS 'Внутр. номер счета дебеторской задолженности';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY.CREDIT_ACC IS 'Внутр. номер счета кредиторской задолженности';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY.CARD_ACC IS 'Внутр. номер карточного счета';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY.CONTRACT IS '№ договора';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY.DATE_ON IS 'Дата начала действия договора';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY.DATE_OFF IS 'Дата завершения договора';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY.ADDRESS IS 'Адрес органа соц. защиты';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY.PHONE IS 'Телефон ОСЗ';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY.DETAILS IS 'Комментарии';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY.TYPE_ID IS 'Тип ОСЗ';
COMMENT ON COLUMN BARS.SOCIAL_AGENCY.COMISS_ACC IS 'Внутренний номер счета доходов от РКО';




PROMPT *** Create  constraint CC_SOCIALAGENCY_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY MODIFY (NAME CONSTRAINT CC_SOCIALAGENCY_NAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALAGENCY_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY MODIFY (BRANCH CONSTRAINT CC_SOCIALAGENCY_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALAGENCY_CREDITACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY MODIFY (CREDIT_ACC CONSTRAINT CC_SOCIALAGENCY_CREDITACC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALAGENCY_CARDACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY MODIFY (CARD_ACC CONSTRAINT CC_SOCIALAGENCY_CARDACC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALAGENCY_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY MODIFY (TYPE_ID CONSTRAINT CC_SOCIALAGENCY_TYPEID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALAGENCY_DATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY ADD CONSTRAINT CC_SOCIALAGENCY_DATES CHECK (date_on <= date_off) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SOCIALAGENCY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY ADD CONSTRAINT PK_SOCIALAGENCY PRIMARY KEY (AGENCY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOCIALAGENCY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOCIALAGENCY ON BARS.SOCIAL_AGENCY (AGENCY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_SOCIALAGENCY_TPID_BR ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_SOCIALAGENCY_TPID_BR ON BARS.SOCIAL_AGENCY (TYPE_ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SOCIAL_AGENCY ***
grant SELECT                                                                 on SOCIAL_AGENCY   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SOCIAL_AGENCY   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SOCIAL_AGENCY   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SOCIAL_AGENCY   to DPT_ROLE;
grant SELECT                                                                 on SOCIAL_AGENCY   to KLBX;
grant SELECT                                                                 on SOCIAL_AGENCY   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_AGENCY   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SOCIAL_AGENCY.sql =========*** End ***
PROMPT ===================================================================================== 
