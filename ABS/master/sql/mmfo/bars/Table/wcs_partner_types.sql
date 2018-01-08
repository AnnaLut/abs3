

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_PARTNER_TYPES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_PARTNER_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_PARTNER_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PARTNER_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_PARTNER_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_PARTNER_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_PARTNER_TYPES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_PARTNER_TYPES ***
 exec bpa.alter_policies('WCS_PARTNER_TYPES');


COMMENT ON TABLE BARS.WCS_PARTNER_TYPES IS 'Типы торговцев партнеров';
COMMENT ON COLUMN BARS.WCS_PARTNER_TYPES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_PARTNER_TYPES.NAME IS 'Наименование';




PROMPT *** Create  constraint CC_PARTNERTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PARTNER_TYPES MODIFY (NAME CONSTRAINT CC_PARTNERTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PARTNERTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_PARTNER_TYPES ADD CONSTRAINT PK_PARTNERTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PARTNERTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PARTNERTYPES ON BARS.WCS_PARTNER_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_PARTNER_TYPES ***
grant SELECT                                                                 on WCS_PARTNER_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_PARTNER_TYPES to BARS_DM;
grant SELECT                                                                 on WCS_PARTNER_TYPES to WCS_SYNC_USER;



PROMPT *** Create SYNONYM  to WCS_PARTNER_TYPES ***

  CREATE OR REPLACE PUBLIC SYNONYM WCS_PARTNER_TYPES FOR BARS.WCS_PARTNER_TYPES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_PARTNER_TYPES.sql =========*** End
PROMPT ===================================================================================== 
