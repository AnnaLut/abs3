

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_SYNC_TYPES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_SYNC_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_SYNC_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_SYNC_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_SYNC_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_SYNC_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_SYNC_TYPES 
   (	TYPE_ID NUMBER(4,0), 
	TYPE_NAME VARCHAR2(64)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_SYNC_TYPES ***
 exec bpa.alter_policies('CIG_SYNC_TYPES');


COMMENT ON TABLE BARS.CIG_SYNC_TYPES IS 'Довідник типів синхронізації';
COMMENT ON COLUMN BARS.CIG_SYNC_TYPES.TYPE_ID IS 'Код типу';
COMMENT ON COLUMN BARS.CIG_SYNC_TYPES.TYPE_NAME IS 'Назва';




PROMPT *** Create  constraint CC_CIGSYNCTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_SYNC_TYPES MODIFY (TYPE_NAME CONSTRAINT CC_CIGSYNCTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIGSYNCTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_SYNC_TYPES ADD CONSTRAINT PK_CIGSYNCTYPES PRIMARY KEY (TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGSYNCTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGSYNCTYPES ON BARS.CIG_SYNC_TYPES (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_SYNC_TYPES ***
grant SELECT                                                                 on CIG_SYNC_TYPES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_SYNC_TYPES  to BARS_DM;
grant SELECT                                                                 on CIG_SYNC_TYPES  to CIG_ROLE;



PROMPT *** Create SYNONYM  to CIG_SYNC_TYPES ***

  CREATE OR REPLACE PUBLIC SYNONYM CIG_SYNC_TYPES FOR BARS.CIG_SYNC_TYPES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_SYNC_TYPES.sql =========*** End **
PROMPT ===================================================================================== 
