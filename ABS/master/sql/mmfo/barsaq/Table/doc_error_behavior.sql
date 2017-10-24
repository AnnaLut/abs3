

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/DOC_ERROR_BEHAVIOR.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  table DOC_ERROR_BEHAVIOR ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.DOC_ERROR_BEHAVIOR 
   (	ORA_ERROR NUMBER(*,0), 
	APP_ERROR NUMBER(*,0), 
	IGNORE_COUNT NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.DOC_ERROR_BEHAVIOR IS 'Специальные ошибки при импорте документов';
COMMENT ON COLUMN BARSAQ.DOC_ERROR_BEHAVIOR.ORA_ERROR IS 'Код ошибки ORACLE';
COMMENT ON COLUMN BARSAQ.DOC_ERROR_BEHAVIOR.APP_ERROR IS 'Прикладной код ошибки';
COMMENT ON COLUMN BARSAQ.DOC_ERROR_BEHAVIOR.IGNORE_COUNT IS 'Количество попыток оплаты с игнорированием ошибки';




PROMPT *** Create  constraint PK_DOCERRBEHAVIOR ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_ERROR_BEHAVIOR ADD CONSTRAINT PK_DOCERRBEHAVIOR PRIMARY KEY (ORA_ERROR, APP_ERROR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCERRBEHAVIOR_ORAERR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_ERROR_BEHAVIOR MODIFY (ORA_ERROR CONSTRAINT CC_DOCERRBEHAVIOR_ORAERR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCERRBEHAVIOR_APPERR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_ERROR_BEHAVIOR MODIFY (APP_ERROR CONSTRAINT CC_DOCERRBEHAVIOR_APPERR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCERRBEHAVIOR_TRYCOUNT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_ERROR_BEHAVIOR MODIFY (IGNORE_COUNT CONSTRAINT CC_DOCERRBEHAVIOR_TRYCOUNT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCERRBEHAVIOR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_DOCERRBEHAVIOR ON BARSAQ.DOC_ERROR_BEHAVIOR (ORA_ERROR, APP_ERROR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/DOC_ERROR_BEHAVIOR.sql =========*** 
PROMPT ===================================================================================== 
