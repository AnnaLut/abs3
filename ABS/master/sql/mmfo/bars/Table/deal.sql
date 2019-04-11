BEGIN
    execute immediate
    'begin  
         bpa.alter_policy_info(''DEAL'', ''FILIAL'' , null, null, null, null);
         bpa.alter_policy_info(''DEAL'', ''WHOLE'' , null, null, null, null);
     end;';
END;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin 
    execute immediate
    'CREATE TABLE BARS.DEAL 
    (
            ID NUMBER(38,0), 
            DEAL_TYPE_ID NUMBER(38), 
            DEAL_NUMBER VARCHAR2(30 CHAR), 
            CUSTOMER_ID NUMBER(38), 
            PRODUCT_ID NUMBER(38), 
            START_DATE DATE, 
            EXPIRY_DATE DATE, 
            CLOSE_DATE DATE, 
            BRANCH_ID VARCHAR2(30 CHAR), 
            CURATOR_ID NUMBER(38)
    )
    TABLESPACE BRSMDLD';
exception
    when name_already_used then
         null;
end; 
/

COMMENT ON TABLE BARS.DEAL IS 'Угоди банку з клієнтами.';
COMMENT ON COLUMN BARS.DEAL.ID IS 'Ідентифікатор угоди';
COMMENT ON COLUMN BARS.DEAL.DEAL_TYPE_ID IS 'Ідентифікатор типу угоди';
COMMENT ON COLUMN BARS.DEAL.DEAL_NUMBER IS 'Зовнішній номер угоди, що може бути наданий клієнту';
COMMENT ON COLUMN BARS.DEAL.CUSTOMER_ID IS 'Ідентифікатор клієнта, з яким укладено угоду';
COMMENT ON COLUMN BARS.DEAL.PRODUCT_ID IS 'Банківський продукт, що надається за угодою';
COMMENT ON COLUMN BARS.DEAL.START_DATE IS 'Дата початку дії угоди';
COMMENT ON COLUMN BARS.DEAL.EXPIRY_DATE IS 'Дата завершення дії угоди';
COMMENT ON COLUMN BARS.DEAL.CLOSE_DATE IS 'Дата фактичного закриття угоди';
COMMENT ON COLUMN BARS.DEAL.BRANCH_ID IS 'Філіал заключення угоди';
COMMENT ON COLUMN BARS.DEAL.CURATOR_ID IS 'Ідентифікатор співробітника банку - куратора угоди';

begin
    execute immediate 'ALTER TABLE BARS.DEAL ADD CONSTRAINT CC_DEAL_CUSTOMER_ID_NN CHECK (CUSTOMER_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception
    when others then
         if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEAL_START_DATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL ADD CONSTRAINT CC_DEAL_START_DATE_NN CHECK (START_DATE IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEAL_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL ADD CONSTRAINT CC_DEAL_BRANCH_NN CHECK (BRANCH_ID IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL ADD CONSTRAINT PK_DEAL PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEAL_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL MODIFY (ID CONSTRAINT CC_DEAL_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEAL_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL MODIFY (DEAL_TYPE_ID CONSTRAINT CC_DEAL_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index DEAL_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.DEAL_IDX ON BARS.DEAL (CUSTOMER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index DEAL_IDX2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.DEAL_IDX2 ON BARS.DEAL (DEAL_NUMBER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEAL ON BARS.DEAL (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


declare
    name_already_used exception;
    such_constraint_already_exists exception;
    pragma exception_init(name_already_used, -955);
    pragma exception_init(such_constraint_already_exists, -2275);
begin
    execute immediate 'ALTER TABLE DEAL ADD CONSTRAINT FK_DEAL_REF_OBJECT FOREIGN KEY (ID) REFERENCES OBJECT (ID)';
exception
    when name_already_used or such_constraint_already_exists then
         null;
end;
/


PROMPT *** Create  grants  DEAL ***
grant SELECT                                                                 on DEAL            to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on DEAL            to BARS_DM;
grant SELECT                                                                 on DEAL            to UPLD;
