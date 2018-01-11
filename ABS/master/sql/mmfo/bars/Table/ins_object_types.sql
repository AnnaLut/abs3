

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_OBJECT_TYPES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_OBJECT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_OBJECT_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_OBJECT_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_OBJECT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_OBJECT_TYPES 
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




PROMPT *** ALTER_POLICIES to INS_OBJECT_TYPES ***
 exec bpa.alter_policies('INS_OBJECT_TYPES');


COMMENT ON TABLE BARS.INS_OBJECT_TYPES IS 'Типи обєктів страхування';
COMMENT ON COLUMN BARS.INS_OBJECT_TYPES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_OBJECT_TYPES.NAME IS 'Найменування';




PROMPT *** Create  constraint CC_INSOBJTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_OBJECT_TYPES MODIFY (NAME CONSTRAINT CC_INSOBJTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSOBJTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_OBJECT_TYPES ADD CONSTRAINT PK_INSOBJTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSOBJTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSOBJTYPES ON BARS.INS_OBJECT_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_OBJECT_TYPES ***
grant SELECT                                                                 on INS_OBJECT_TYPES to BARSREADER_ROLE;
grant SELECT                                                                 on INS_OBJECT_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_OBJECT_TYPES.sql =========*** End 
PROMPT ===================================================================================== 
