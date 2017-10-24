

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEAL_ACCOUNT_TYPE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEAL_ACCOUNT_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEAL_ACCOUNT_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DEAL_ACCOUNT_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEAL_ACCOUNT_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEAL_ACCOUNT_TYPE 
   (	ID NUMBER(5,0), 
	DEAL_TYPE_ID NUMBER(5,0), 
	ACCOUNT_TYPE_CODE VARCHAR2(30 CHAR), 
	ACCOUNT_TYPE_NAME VARCHAR2(300 CHAR)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEAL_ACCOUNT_TYPE ***
 exec bpa.alter_policies('DEAL_ACCOUNT_TYPE');


COMMENT ON TABLE BARS.DEAL_ACCOUNT_TYPE IS 'Типи рахунків в рамках модуля обліку угод (ролі, які виконують рахунки в рамках угоди)';
COMMENT ON COLUMN BARS.DEAL_ACCOUNT_TYPE.ID IS 'Ідентифікатор типу рахунків по угодах';
COMMENT ON COLUMN BARS.DEAL_ACCOUNT_TYPE.DEAL_TYPE_ID IS 'Тип угод, до якого належить даний тип рахунків';
COMMENT ON COLUMN BARS.DEAL_ACCOUNT_TYPE.ACCOUNT_TYPE_CODE IS 'Унікальний код типу рахунків';
COMMENT ON COLUMN BARS.DEAL_ACCOUNT_TYPE.ACCOUNT_TYPE_NAME IS 'Назва типу рахунків';




PROMPT *** Create  constraint FK_DEAL_ACC_REFERENCE_OBJECT_T ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_ACCOUNT_TYPE ADD CONSTRAINT FK_DEAL_ACC_REFERENCE_OBJECT_T FOREIGN KEY (DEAL_TYPE_ID)
	  REFERENCES BARS.OBJECT_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DEAL_ACCOUNT_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_ACCOUNT_TYPE ADD CONSTRAINT PK_DEAL_ACCOUNT_TYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187795 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_ACCOUNT_TYPE MODIFY (ACCOUNT_TYPE_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187794 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_ACCOUNT_TYPE MODIFY (ACCOUNT_TYPE_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187793 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_ACCOUNT_TYPE MODIFY (DEAL_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187792 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_ACCOUNT_TYPE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEAL_ACCOUNT_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEAL_ACCOUNT_TYPE ON BARS.DEAL_ACCOUNT_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DEAL_ACCOUNT_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DEAL_ACCOUNT_TYPE ON BARS.DEAL_ACCOUNT_TYPE (DEAL_TYPE_ID, ACCOUNT_TYPE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEAL_ACCOUNT_TYPE.sql =========*** End
PROMPT ===================================================================================== 
