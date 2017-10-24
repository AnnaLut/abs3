

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEAL_CHECK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEAL_CHECK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEAL_CHECK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DEAL_CHECK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEAL_CHECK ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEAL_CHECK 
   (	ID NUMBER(5,0), 
	CHECK_NAME VARCHAR2(300 CHAR), 
	FUNCTION_NAME VARCHAR2(100 CHAR), 
	IS_ACTIVE CHAR(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEAL_CHECK ***
 exec bpa.alter_policies('DEAL_CHECK');


COMMENT ON TABLE BARS.DEAL_CHECK IS 'Довідник перевірок бізнес-правил, при встановленні/зміні значень атрибутів угод';
COMMENT ON COLUMN BARS.DEAL_CHECK.ID IS 'Ідентифікатор перевірки';
COMMENT ON COLUMN BARS.DEAL_CHECK.CHECK_NAME IS 'Назва перевірки';
COMMENT ON COLUMN BARS.DEAL_CHECK.FUNCTION_NAME IS 'PL\SQL-функція, що реалізує перевірку';
COMMENT ON COLUMN BARS.DEAL_CHECK.IS_ACTIVE IS 'Ознака активності перевірки - неактивні перевірки не виконуються';




PROMPT *** Create  constraint PK_DEAL_CHECK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_CHECK ADD CONSTRAINT PK_DEAL_CHECK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187821 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_CHECK MODIFY (IS_ACTIVE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187820 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_CHECK MODIFY (FUNCTION_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187819 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_CHECK MODIFY (CHECK_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187818 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_CHECK MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEAL_CHECK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEAL_CHECK ON BARS.DEAL_CHECK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEAL_CHECK.sql =========*** End *** ==
PROMPT ===================================================================================== 
