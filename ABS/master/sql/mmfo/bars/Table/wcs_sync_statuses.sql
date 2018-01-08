

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SYNC_STATUSES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SYNC_STATUSES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SYNC_STATUSES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SYNC_STATUSES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SYNC_STATUSES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SYNC_STATUSES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SYNC_STATUSES 
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




PROMPT *** ALTER_POLICIES to WCS_SYNC_STATUSES ***
 exec bpa.alter_policies('WCS_SYNC_STATUSES');


COMMENT ON TABLE BARS.WCS_SYNC_STATUSES IS 'Статусы синхронизации';
COMMENT ON COLUMN BARS.WCS_SYNC_STATUSES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_SYNC_STATUSES.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_WCSSYNCSTATUSES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_STATUSES ADD CONSTRAINT PK_WCSSYNCSTATUSES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSYNCSTATUSES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_STATUSES MODIFY (NAME CONSTRAINT CC_WCSSYNCSTATUSES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSSYNCSTATUSES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSSYNCSTATUSES ON BARS.WCS_SYNC_STATUSES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SYNC_STATUSES ***
grant SELECT                                                                 on WCS_SYNC_STATUSES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SYNC_STATUSES.sql =========*** End
PROMPT ===================================================================================== 
