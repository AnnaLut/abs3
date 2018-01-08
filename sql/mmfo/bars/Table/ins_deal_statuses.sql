

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_DEAL_STATUSES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_DEAL_STATUSES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_DEAL_STATUSES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_DEAL_STATUSES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_DEAL_STATUSES ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_DEAL_STATUSES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(300)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_DEAL_STATUSES ***
 exec bpa.alter_policies('INS_DEAL_STATUSES');


COMMENT ON TABLE BARS.INS_DEAL_STATUSES IS 'Статуси договорів страхування';
COMMENT ON COLUMN BARS.INS_DEAL_STATUSES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_DEAL_STATUSES.NAME IS 'Найменування';




PROMPT *** Create  constraint CC_INSDEALSTATUSES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_STATUSES MODIFY (NAME CONSTRAINT CC_INSDEALSTATUSES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSDEALSTATUSES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_STATUSES ADD CONSTRAINT PK_INSDEALSTATUSES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSDEALSTATUSES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSDEALSTATUSES ON BARS.INS_DEAL_STATUSES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_DEAL_STATUSES.sql =========*** End
PROMPT ===================================================================================== 
