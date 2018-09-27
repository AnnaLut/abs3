

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACTS_CREDIT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONTRACTS_CREDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONTRACTS_CREDIT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACTS_CREDIT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACTS_CREDIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONTRACTS_CREDIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONTRACTS_CREDIT 
   (	CONTR_ID NUMBER, 
	PERCENT_NBU NUMBER, 
	S_LIMIT NUMBER, 
	CREDITOR_TYPE NUMBER, 
	BORROWER NUMBER, 
	CREDIT_TYPE NUMBER, 
	CREDIT_TERM NUMBER, 
	CREDIT_PREPAY NUMBER, 
	NAME VARCHAR2(64), 
	ADD_AGREE VARCHAR2(1024), 
	PERCENT_NBU_TYPE NUMBER, 
	PERCENT_NBU_INFO VARCHAR2(128), 
	R_AGREE_DATE DATE, 
	R_AGREE_NO VARCHAR2(32), 
	PREV_DOC_KEY NUMBER, 
	PREV_REESTR_ATTR VARCHAR2(256), 
	ENDING_DATE_INDIV DATE, 
	PARENT_CH_DATA VARCHAR2(128), 
	ENDING_DATE DATE, 
	DATE_TERM_CHANGE DATE, 
	F503_REASON NUMBER, 
	F503_STATE NUMBER, 
	F503_NOTE VARCHAR2(108), 
	F504_REASON NUMBER, 
	F504_NOTE VARCHAR2(108), 
	F503_PERCENT_TYPE NUMBER, 
	F503_PERCENT_BASE VARCHAR2(15), 
	F503_PERCENT_MARGIN NUMBER, 
	F503_PERCENT NUMBER, 
	F503_PURPOSE VARCHAR2(54), 
	F503_PERCENT_BASE_T VARCHAR2(3), 
	F503_CHANGE_INFO VARCHAR2(1), 
	F503_PERCENT_BASE_VAL VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CONTRACTS_CREDIT ***
 exec bpa.alter_policies('CIM_CONTRACTS_CREDIT');


COMMENT ON TABLE BARS.CIM_CONTRACTS_CREDIT IS 'Додаткові дані по кредитних контрактах';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.CONTR_ID IS 'ID контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.PERCENT_NBU IS 'Максимальна процентна ставка НБУ';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.S_LIMIT IS 'Ліміт заборгованості';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.CREDITOR_TYPE IS 'Тип кредитора';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.BORROWER IS 'Вид позичальника';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.CREDIT_TYPE IS 'Тип кредиту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.CREDIT_TERM IS 'Код строковості кредиту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.CREDIT_PREPAY IS 'Можливість дострокового погашення';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.NAME IS 'Назва договору';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.ADD_AGREE IS 'Додаткові угоди';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.PERCENT_NBU_TYPE IS 'Назва максимальної процентної ставки НБУ';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.PERCENT_NBU_INFO IS 'Додаткова інформація про максимальну процентну ставку НБУ';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.R_AGREE_DATE IS 'Дата реєстрації контракту (заповнюється при змінах)';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.R_AGREE_NO IS 'Номер реєстрації контракту (заповнюється при змінах)';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.PREV_DOC_KEY IS 'Реєстраційний серверний номер (заповнюється при змінах)';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.PREV_REESTR_ATTR IS 'Зміни до контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.ENDING_DATE_INDIV IS 'Кінцева дата індивідуального строку дії реєстрації контракту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.PARENT_CH_DATA IS 'Інформація про короткостроковий контракт (заповнюється при перереєстрації з короткострокового у довгостроковий)';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.ENDING_DATE IS 'Строк дії реєстрації контракту (заповнюється при продовженні строку)';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.DATE_TERM_CHANGE IS 'Дата зміни строковості кредиту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.F503_REASON IS 'Підстави подання звіту Ф503';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.F503_STATE IS 'Стан розрахунків за контрактом для звіту Ф503';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.F503_NOTE IS 'Примітка звіту Ф503';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.F504_REASON IS 'Підстави подання звіту Ф504';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.F504_NOTE IS 'Примітка звіту Ф504';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.F503_PERCENT_TYPE IS 'Тип процентної ставки';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.F503_PERCENT_BASE IS 'База процентної ставки (база)';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.F503_PERCENT_MARGIN IS 'Маржа процентної ставки';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.F503_PERCENT IS 'Процентна ставка за основною сумою боргу';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.F503_PURPOSE IS 'Ціль використання кредиту';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.F503_PERCENT_BASE_T IS 'База процентної ставки (термін)';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.F503_CHANGE_INFO IS 'Інформація щодо внесення змін до договору';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.F503_PERCENT_BASE_VAL IS 'База процентної ставки (валюта)';




PROMPT *** Create  constraint CC_CIMCONTRCRED_F503REASON_C ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_CREDIT ADD CONSTRAINT CC_CIMCONTRCRED_F503REASON_C CHECK (f503_reason in (1,2) or f503_reason is null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRCRED_F503STATE_C ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_CREDIT ADD CONSTRAINT CC_CIMCONTRCRED_F503STATE_C CHECK (f503_state in (1,2,3,4,5) or f503_state is null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRCRED_F504REASON_C ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_CREDIT ADD CONSTRAINT CC_CIMCONTRCRED_F504REASON_C CHECK (f504_reason in (1,2) or f504_reason is null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRCRED_CONTRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_CREDIT MODIFY (CONTR_ID CONSTRAINT CC_CIMCONTRCRED_CONTRID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRCRED_PNBU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_CREDIT MODIFY (PERCENT_NBU CONSTRAINT CC_CIMCONTRCRED_PNBU_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRCRED_CREDTERM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_CREDIT MODIFY (CREDIT_TERM CONSTRAINT CC_CIMCONTRCRED_CREDTERM_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRCRED_PNBUT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_CREDIT MODIFY (PERCENT_NBU_TYPE CONSTRAINT CC_CIMCONTRCRED_PNBUT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin
    execute immediate 'alter table bars.CIM_CONTRACTS_CREDIT add (F057 CHAR(3))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 
COMMENT ON COLUMN BARS.CIM_CONTRACTS_CREDIT.F057 IS 'Вид запозичення';

PROMPT *** Create  constraint FK_CIM_CRED_F057 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_CREDIT ADD CONSTRAINT FK_CIM_CRED_F057 FOREIGN KEY (F057)
	  REFERENCES BARS.F057 (F057) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  CIM_CONTRACTS_CREDIT ***
grant SELECT                                                                 on CIM_CONTRACTS_CREDIT to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACTS_CREDIT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CONTRACTS_CREDIT to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACTS_CREDIT to CIM_ROLE;
grant SELECT                                                                 on CIM_CONTRACTS_CREDIT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACTS_CREDIT.sql =========*** 
PROMPT ===================================================================================== 
