PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_OPERS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_OPERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_OPERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_OPERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_OPERS 
   (	USER_REF VARCHAR2(38), 
	OPER_REF CHAR(3), 
	EXEC_TIME DATE, 
	CUR_CODE NUMBER(3,0), 
	DBT VARCHAR2(14), 
	CRD VARCHAR2(14), 
	AMOUNT NUMBER, 
	AMOUNT_UAH NUMBER, 
	DOC_REF NUMBER, 
	IS_SW_OPER NUMBER(*,0), 
	STATE VARCHAR2(2), 
	REQ_REF NUMBER, 
	WORK_DATE DATE, 
	ID NUMBER, 
	ATM_AMOUNT SYS.XMLTYPE , 
	IS_WARNING NUMBER(1,0), 
	ACTIVE_CUR VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 XMLTYPE COLUMN ATM_AMOUNT STORE AS SECUREFILE BINARY XML (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ALLOW NONSCHEMA DISALLOW ANYSCHEMA ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_OPERS ***
 exec bpa.alter_policies('TELLER_OPERS');


COMMENT ON TABLE BARS.TELLER_OPERS IS '';
COMMENT ON COLUMN BARS.TELLER_OPERS.USER_REF IS 'Ід користувача';
COMMENT ON COLUMN BARS.TELLER_OPERS.OPER_REF IS 'Код операції (tt)';
COMMENT ON COLUMN BARS.TELLER_OPERS.EXEC_TIME IS 'Дата+час виконання операції';
COMMENT ON COLUMN BARS.TELLER_OPERS.CUR_CODE IS 'Валюта операції';
COMMENT ON COLUMN BARS.TELLER_OPERS.DBT IS 'Дебет';
COMMENT ON COLUMN BARS.TELLER_OPERS.CRD IS 'Кредит';
COMMENT ON COLUMN BARS.TELLER_OPERS.AMOUNT IS 'Сума в валюті операції';
COMMENT ON COLUMN BARS.TELLER_OPERS.AMOUNT_UAH IS 'Сума в гривні';
COMMENT ON COLUMN BARS.TELLER_OPERS.DOC_REF IS 'Ід операції в АБС';
COMMENT ON COLUMN BARS.TELLER_OPERS.IS_SW_OPER IS 'ознака SingleWindow';
COMMENT ON COLUMN BARS.TELLER_OPERS.STATE IS 'Поточний статус операції';
COMMENT ON COLUMN BARS.TELLER_OPERS.REQ_REF IS 'Посилання на веб-сервіс';
COMMENT ON COLUMN BARS.TELLER_OPERS.WORK_DATE IS 'Дата операційного дня операції';
COMMENT ON COLUMN BARS.TELLER_OPERS.ID IS 'ID операції  Теллера';
COMMENT ON COLUMN BARS.TELLER_OPERS.ATM_AMOUNT IS 'Відповідь від АТМ щодо залишку';
COMMENT ON COLUMN BARS.TELLER_OPERS.IS_WARNING IS 'Ознака попередження (1 - так, інше - ні)';
COMMENT ON COLUMN BARS.TELLER_OPERS.ACTIVE_CUR IS 'Код валюти для активної операції з АТМ';




PROMPT *** Create  constraint XPK_TELLER_OPERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_OPERS ADD CONSTRAINT XPK_TELLER_OPERS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TELLER_OPERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TELLER_OPERS ON BARS.TELLER_OPERS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_TELLER_OPERS_DOC_REF ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_TELLER_OPERS_DOC_REF ON BARS.TELLER_OPERS (DOC_REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_OPERS.sql =========*** End *** 
PROMPT ===================================================================================== 
