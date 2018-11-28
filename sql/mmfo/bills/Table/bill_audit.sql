

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BILLS/Table/BILL_AUDIT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table BILL_AUDIT ***
begin 
  execute immediate '
  CREATE TABLE BILLS.BILL_AUDIT 
   (ID NUMBER, 
	REC_DATE DATE, 
	USER_REF VARCHAR2(38), 
	ACTION VARCHAR2(50), 
	KEY_ID NUMBER(*,0), 
	RESULT VARCHAR2(2000), 
	PARAM_STR VARCHAR2(2000),
    LOG_LEVEL VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Create  constraint SYS_C00748901 ***
begin   
 execute immediate '
  ALTER TABLE BILLS.BILL_AUDIT ADD LOG_LEVEL VARCHAR2(32)';
exception when others then
  if  sqlcode=-1430 then null; else raise; end if;
 end;
/

COMMENT ON TABLE BILLS.BILL_AUDIT IS 'протокол работ с системой';
COMMENT ON COLUMN BILLS.BILL_AUDIT.ID IS 'ід запису';
COMMENT ON COLUMN BILLS.BILL_AUDIT.REC_DATE IS 'Дата+час запису';
COMMENT ON COLUMN BILLS.BILL_AUDIT.USER_REF IS 'Користувач';
COMMENT ON COLUMN BILLS.BILL_AUDIT.ACTION IS 'Опис дії';
COMMENT ON COLUMN BILLS.BILL_AUDIT.KEY_ID IS 'ID отримувача';
COMMENT ON COLUMN BILLS.BILL_AUDIT.RESULT IS 'Результат ';
COMMENT ON COLUMN BILLS.BILL_AUDIT.PARAM_STR IS 'перелік параметрів виклику зовнішнього сервісу';




PROMPT *** Create  constraint SYS_C00748901 ***
begin   
 execute immediate '
  ALTER TABLE BILLS.BILL_AUDIT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00748902 ***
begin   
 execute immediate '
  ALTER TABLE BILLS.BILL_AUDIT MODIFY (REC_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BILL_AUD_ID ***
begin   
 execute immediate '
  ALTER TABLE BILLS.BILL_AUDIT ADD CONSTRAINT PK_BILL_AUD_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_BILL_AUD_EXP_ID ***
begin   
 execute immediate '
  CREATE INDEX BILLS.IDX_BILL_AUD_EXP_ID ON BILLS.BILL_AUDIT (KEY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BILL_AUD_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BILLS.PK_BILL_AUD_ID ON BILLS.BILL_AUDIT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BILLS/Table/BILL_AUDIT.sql =========*** End *** =
PROMPT ===================================================================================== 
