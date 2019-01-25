PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_STATE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_STATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_STATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_STATE ***
declare
  v_num integer;
begin 
  select count(1) into v_num
    from user_tables 
    where table_name = 'TELLER_STATE';
  if v_num = 1 then
    execute immediate 'drop table TELLER_STATE';
  end if;
  execute immediate '
  CREATE TABLE BARS.TELLER_STATE 
   (	USER_REF NUMBER, 
	WORK_DATE DATE, 
	MAX_LIMIT NUMBER, 
	CURRENT_AMOUNT NUMBER, 
	OPER_COUNT NUMBER(*,0), 
	WARNINGS NUMBER(*,0), 
	STATUS VARCHAR2(1), 
	SESSION_ID VARCHAR2(100), 
	ACTIVE_OPER NUMBER, 
	START_OPER NUMBER, 
	EQ_TYPE VARCHAR2(1), 
	USER_IP VARCHAR2(50), 
	EQ_IP VARCHAR2(50), 
	BRANCH VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_STATE ***
 exec bpa.alter_policies('TELLER_STATE');


COMMENT ON TABLE BARS.TELLER_STATE IS '';
COMMENT ON COLUMN BARS.TELLER_STATE.EQ_TYPE IS 'Тип обладнання для роботи теллера';
COMMENT ON COLUMN BARS.TELLER_STATE.USER_IP IS 'адреса станції';
COMMENT ON COLUMN BARS.TELLER_STATE.EQ_IP IS 'Адреса обладнання';
COMMENT ON COLUMN BARS.TELLER_STATE.BRANCH IS 'Відділення, в якому працює користувач';
COMMENT ON COLUMN BARS.TELLER_STATE.USER_REF IS 'ІД користувача';
COMMENT ON COLUMN BARS.TELLER_STATE.WORK_DATE IS 'Банківська дата';
COMMENT ON COLUMN BARS.TELLER_STATE.MAX_LIMIT IS 'Максимальний ліміт залишку готівки (в грн)';
COMMENT ON COLUMN BARS.TELLER_STATE.CURRENT_AMOUNT IS 'поточний залишок готівки';
COMMENT ON COLUMN BARS.TELLER_STATE.OPER_COUNT IS 'Кількість операцій';
COMMENT ON COLUMN BARS.TELLER_STATE.WARNINGS IS 'Кількість попереджень щодо перевищення ліміту залишку готівки';
COMMENT ON COLUMN BARS.TELLER_STATE.STATUS IS 'Стан роботи теллера';
COMMENT ON COLUMN BARS.TELLER_STATE.SESSION_ID IS 'ID сесії для термінала';
COMMENT ON COLUMN BARS.TELLER_STATE.ACTIVE_OPER IS 'Операція теллера, яка виконується в поточний момент';
COMMENT ON COLUMN BARS.TELLER_STATE.START_OPER IS 'Операція теллера, з якої почався блок операцій';




PROMPT *** Create  constraint XPK_TELLER_STATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_STATE ADD CONSTRAINT XPK_TELLER_STATE PRIMARY KEY (USER_REF, WORK_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TELLER_STATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TELLER_STATE ON BARS.TELLER_STATE (USER_REF, WORK_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_STATE.sql =========*** End *** 
PROMPT ===================================================================================== 
