PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_CASH_OPERS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_CASH_OPERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_CASH_OPERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_CASH_OPERS ***
declare
  v_num integer;
begin 
  select count(1) into v_num
    from user_tables
      where table_name = 'TELLER_CASH_OPERS';
  if v_num = 1 then
    execute immediate 'drop table TELLER_CASH_OPERS';
  end if;
  execute immediate '
  CREATE TABLE BARS.TELLER_CASH_OPERS 
   (	DOC_REF NUMBER, 
	OP_TYPE VARCHAR2(5), 
	CUR_CODE VARCHAR2(3), 
	ATM_AMOUNT NUMBER, 
	NON_ATM_AMOUNT NUMBER, 
	LAST_DT DATE, 
	LAST_USER VARCHAR2(50), 
	ATM_STATUS NUMBER(*,0) DEFAULT 0, 
	OPER_AMOUNT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_CASH_OPERS ***
 exec bpa.alter_policies('TELLER_CASH_OPERS');


COMMENT ON TABLE BARS.TELLER_CASH_OPERS IS '';
COMMENT ON COLUMN BARS.TELLER_CASH_OPERS.OPER_AMOUNT IS 'Сума касової операції';
COMMENT ON COLUMN BARS.TELLER_CASH_OPERS.DOC_REF IS 'Посилання на teller_opers';
COMMENT ON COLUMN BARS.TELLER_CASH_OPERS.OP_TYPE IS 'Тип операції';
COMMENT ON COLUMN BARS.TELLER_CASH_OPERS.CUR_CODE IS 'Валюта операції';
COMMENT ON COLUMN BARS.TELLER_CASH_OPERS.ATM_AMOUNT IS 'Сума, що прийнято в АТМ';
COMMENT ON COLUMN BARS.TELLER_CASH_OPERS.NON_ATM_AMOUNT IS 'Сума, що прийнято в темпокасу';
COMMENT ON COLUMN BARS.TELLER_CASH_OPERS.LAST_DT IS 'Дата+час зміни';
COMMENT ON COLUMN BARS.TELLER_CASH_OPERS.LAST_USER IS 'Користувач, який виконав зміну';
COMMENT ON COLUMN BARS.TELLER_CASH_OPERS.ATM_STATUS IS 'Статус обробки в АТМ';






PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_CASH_OPERS.sql =========*** End
PROMPT ===================================================================================== 
