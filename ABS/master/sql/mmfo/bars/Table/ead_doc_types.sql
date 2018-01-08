

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EAD_DOC_TYPES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EAD_DOC_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EAD_DOC_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_DOC_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_DOC_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EAD_DOC_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.EAD_DOC_TYPES 
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




PROMPT *** ALTER_POLICIES to EAD_DOC_TYPES ***
 exec bpa.alter_policies('EAD_DOC_TYPES');


COMMENT ON TABLE BARS.EAD_DOC_TYPES IS 'Типи документів';
COMMENT ON COLUMN BARS.EAD_DOC_TYPES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.EAD_DOC_TYPES.NAME IS 'Найменування';




PROMPT *** Create  constraint PK_EADDOCTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOC_TYPES ADD CONSTRAINT PK_EADDOCTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCTYPES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOC_TYPES MODIFY (ID CONSTRAINT CC_EADDOCTYPES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOC_TYPES MODIFY (NAME CONSTRAINT CC_EADDOCTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EADDOCTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EADDOCTYPES ON BARS.EAD_DOC_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EAD_DOC_TYPES ***
grant SELECT                                                                 on EAD_DOC_TYPES   to BARSREADER_ROLE;
grant SELECT                                                                 on EAD_DOC_TYPES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EAD_DOC_TYPES   to BARS_DM;
grant SELECT                                                                 on EAD_DOC_TYPES   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_DOC_TYPES.sql =========*** End ***
PROMPT ===================================================================================== 
