

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BILLS/Table/OPERS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  table OPERS ***
begin 
  execute immediate '
  CREATE TABLE BILLS.OPERS 
   (	ID NUMBER(*,0), 
	OPER_DT DATE, 
	DBT VARCHAR2(14), 
	CRD VARCHAR2(14), 
	AMOUNT NUMBER, 
	STATE VARCHAR2(2), 
	DOC_REF NUMBER, 
	CUR_CODE VARCHAR2(3), 
	PURPOSE VARCHAR2(160), 
	MFO NUMBER, 
	MESSAGE VARCHAR2(1000), 
	USER_REF VARCHAR2(30), 
	LAST_DT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BILLS.OPERS IS '';
COMMENT ON COLUMN BILLS.OPERS.ID IS 'id запису';
COMMENT ON COLUMN BILLS.OPERS.OPER_DT IS 'Дата операції';
COMMENT ON COLUMN BILLS.OPERS.DBT IS 'Дебет';
COMMENT ON COLUMN BILLS.OPERS.CRD IS 'Кредит';
COMMENT ON COLUMN BILLS.OPERS.AMOUNT IS 'Сума';
COMMENT ON COLUMN BILLS.OPERS.STATE IS 'Статус операції';
COMMENT ON COLUMN BILLS.OPERS.MESSAGE IS 'Повідомлення про обробку';
COMMENT ON COLUMN BILLS.OPERS.DOC_REF IS 'Посилання на документ в АБС';
COMMENT ON COLUMN BILLS.OPERS.CUR_CODE IS 'Валюта';
COMMENT ON COLUMN BILLS.OPERS.PURPOSE IS 'Призначення платежу';
COMMENT ON COLUMN BILLS.OPERS.MFO IS 'МФО';
COMMENT ON COLUMN BILLS.OPERS.USER_REF IS 'Користувач, який створив/оновив запис';
COMMENT ON COLUMN BILLS.OPERS.LAST_DT IS 'Остання дата оновлення';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BILLS/Table/OPERS.sql =========*** End *** ======
PROMPT ===================================================================================== 
