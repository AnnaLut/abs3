PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_ATM_OPERS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_ATM_OPERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_ATM_OPERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_ATM_OPERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_ATM_OPERS 
   (	EQ_IP VARCHAR2(20), 
	OPER_TIME DATE, 
	OPER_TYPE VARCHAR2(3), 
	OPER_REF NUMBER, 
	STATUS VARCHAR2(4), 
	CUR_CODE VARCHAR2(3), 
	AMOUNT NUMBER, 
	USER_REF NUMBER, 
	USER_IP VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_ATM_OPERS ***
 exec bpa.alter_policies('TELLER_ATM_OPERS');


COMMENT ON TABLE BARS.TELLER_ATM_OPERS IS '';
COMMENT ON COLUMN BARS.TELLER_ATM_OPERS.EQ_IP IS 'IP устройства';
COMMENT ON COLUMN BARS.TELLER_ATM_OPERS.OPER_TIME IS 'Время операции';
COMMENT ON COLUMN BARS.TELLER_ATM_OPERS.OPER_TYPE IS 'Тип операции';
COMMENT ON COLUMN BARS.TELLER_ATM_OPERS.OPER_REF IS 'Реф документа теллера';
COMMENT ON COLUMN BARS.TELLER_ATM_OPERS.STATUS IS 'Статус ';
COMMENT ON COLUMN BARS.TELLER_ATM_OPERS.CUR_CODE IS 'Валюта операции';
COMMENT ON COLUMN BARS.TELLER_ATM_OPERS.AMOUNT IS 'Сумма операции';
COMMENT ON COLUMN BARS.TELLER_ATM_OPERS.USER_REF IS 'ID пользователя';
COMMENT ON COLUMN BARS.TELLER_ATM_OPERS.USER_IP IS 'Имя рабочей станции';




PROMPT *** Create  constraint SYS_C0030871 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_ATM_OPERS MODIFY (EQ_IP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030872 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_ATM_OPERS MODIFY (OPER_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030873 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_ATM_OPERS MODIFY (USER_REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0030874 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_ATM_OPERS MODIFY (USER_IP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_ATM_OPERS.sql =========*** End 
PROMPT ===================================================================================== 
