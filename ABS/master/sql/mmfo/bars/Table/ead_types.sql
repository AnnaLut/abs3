

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EAD_TYPES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EAD_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EAD_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EAD_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.EAD_TYPES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(300), 
	METHOD VARCHAR2(300), 
	MSG_LIFETIME NUMBER DEFAULT 4320, 
	MSG_RETRY_INTERVAL NUMBER DEFAULT 5
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EAD_TYPES ***
 exec bpa.alter_policies('EAD_TYPES');


COMMENT ON TABLE BARS.EAD_TYPES IS 'Типи повідомлень для передачі у ЕА';
COMMENT ON COLUMN BARS.EAD_TYPES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.EAD_TYPES.NAME IS 'Найменування';
COMMENT ON COLUMN BARS.EAD_TYPES.METHOD IS 'JSON RPC метод';
COMMENT ON COLUMN BARS.EAD_TYPES.MSG_LIFETIME IS 'Термін актуальності повідомлення (хв.)';
COMMENT ON COLUMN BARS.EAD_TYPES.MSG_RETRY_INTERVAL IS 'Інтервал повторної відправки повідомлення (хв.), множиться на кіл-ть невдалих спроб';




PROMPT *** Create  constraint PK_EADTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_TYPES ADD CONSTRAINT PK_EADTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADTYPES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_TYPES MODIFY (ID CONSTRAINT CC_EADTYPES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_TYPES MODIFY (NAME CONSTRAINT CC_EADTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADTYPES_MTH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_TYPES MODIFY (METHOD CONSTRAINT CC_EADTYPES_MTH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADTYPES_MLT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_TYPES MODIFY (MSG_LIFETIME CONSTRAINT CC_EADTYPES_MLT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADTYPES_MRI_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_TYPES MODIFY (MSG_RETRY_INTERVAL CONSTRAINT CC_EADTYPES_MRI_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EADTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EADTYPES ON BARS.EAD_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EAD_TYPES ***
grant SELECT                                                                 on EAD_TYPES       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EAD_TYPES       to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_TYPES.sql =========*** End *** ===
PROMPT ===================================================================================== 
