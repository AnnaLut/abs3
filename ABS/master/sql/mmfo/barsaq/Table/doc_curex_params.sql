

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/DOC_CUREX_PARAMS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  table DOC_CUREX_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.DOC_CUREX_PARAMS 
   (	PAR_ID VARCHAR2(8 CHAR), 
	PAR_VALUE VARCHAR2(255 CHAR), 
	PAR_COMMENT VARCHAR2(70 CHAR), 
	BANK_ID VARCHAR2(11 CHAR), 
	 CONSTRAINT PK_DOCCUREXPARAMS PRIMARY KEY (PAR_ID, BANK_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.DOC_CUREX_PARAMS IS 'Конфігураційні параметри модулів "Біржові операцій" та "Валютний контроль" version 1.0';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_PARAMS.PAR_ID IS 'Код параметра';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_PARAMS.PAR_VALUE IS 'Значення параметра';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_PARAMS.PAR_COMMENT IS 'Коментар';
COMMENT ON COLUMN BARSAQ.DOC_CUREX_PARAMS.BANK_ID IS '';




PROMPT *** Create  constraint CC_DOCCUREXPARAMS_PARID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_CUREX_PARAMS MODIFY (PAR_ID CONSTRAINT CC_DOCCUREXPARAMS_PARID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCCUREXPARAMS_VALUE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_CUREX_PARAMS MODIFY (PAR_VALUE CONSTRAINT CC_DOCCUREXPARAMS_VALUE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCCUREXPARAMS_COMMENT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_CUREX_PARAMS MODIFY (PAR_COMMENT CONSTRAINT CC_DOCCUREXPARAMS_COMMENT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCCUREXPARAMS_BANKID ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_CUREX_PARAMS MODIFY (BANK_ID CONSTRAINT CC_DOCCUREXPARAMS_BANKID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DOCCUREXPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_CUREX_PARAMS ADD CONSTRAINT PK_DOCCUREXPARAMS PRIMARY KEY (PAR_ID, BANK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCCUREXPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_DOCCUREXPARAMS ON BARSAQ.DOC_CUREX_PARAMS (PAR_ID, BANK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_CUREX_PARAMS ***
grant SELECT                                                                 on DOC_CUREX_PARAMS to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/DOC_CUREX_PARAMS.sql =========*** En
PROMPT ===================================================================================== 
