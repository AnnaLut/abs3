

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SYNC_TYPES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SYNC_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SYNC_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SYNC_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SYNC_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SYNC_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SYNC_TYPES 
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




PROMPT *** ALTER_POLICIES to WCS_SYNC_TYPES ***
 exec bpa.alter_policies('WCS_SYNC_TYPES');


COMMENT ON TABLE BARS.WCS_SYNC_TYPES IS 'Типы событий синхронизации';
COMMENT ON COLUMN BARS.WCS_SYNC_TYPES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_SYNC_TYPES.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_WCSSYNCTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_TYPES ADD CONSTRAINT PK_WCSSYNCTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSYNCTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SYNC_TYPES MODIFY (NAME CONSTRAINT CC_WCSSYNCTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSSYNCTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSSYNCTYPES ON BARS.WCS_SYNC_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SYNC_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SYNC_TYPES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SYNC_TYPES  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SYNC_TYPES  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SYNC_TYPES.sql =========*** End **
PROMPT ===================================================================================== 
