

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GRT_DEAL_STATUSES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GRT_DEAL_STATUSES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GRT_DEAL_STATUSES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_DEAL_STATUSES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GRT_DEAL_STATUSES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GRT_DEAL_STATUSES ***
begin 
  execute immediate '
  CREATE TABLE BARS.GRT_DEAL_STATUSES 
   (	STATUS_ID NUMBER(3,0), 
	STATUS_NAME VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GRT_DEAL_STATUSES ***
 exec bpa.alter_policies('GRT_DEAL_STATUSES');


COMMENT ON TABLE BARS.GRT_DEAL_STATUSES IS 'Статуси договорів забезпечення';
COMMENT ON COLUMN BARS.GRT_DEAL_STATUSES.STATUS_ID IS 'ID статусу';
COMMENT ON COLUMN BARS.GRT_DEAL_STATUSES.STATUS_NAME IS 'Статус';




PROMPT *** Create  constraint CC_GRTDEALSTATUSES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEAL_STATUSES MODIFY (STATUS_NAME CONSTRAINT CC_GRTDEALSTATUSES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_GRTDEALSTATUSES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEAL_STATUSES ADD CONSTRAINT PK_GRTDEALSTATUSES PRIMARY KEY (STATUS_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GRTDEALSTATUSES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GRTDEALSTATUSES ON BARS.GRT_DEAL_STATUSES (STATUS_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GRT_DEAL_STATUSES ***
grant SELECT                                                                 on GRT_DEAL_STATUSES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GRT_DEAL_STATUSES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GRT_DEAL_STATUSES.sql =========*** End
PROMPT ===================================================================================== 
