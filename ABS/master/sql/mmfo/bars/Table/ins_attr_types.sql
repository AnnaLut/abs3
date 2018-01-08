

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_ATTR_TYPES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_ATTR_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_ATTR_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_ATTR_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_ATTR_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_ATTR_TYPES 
   (	ID VARCHAR2(1), 
	NAME VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_ATTR_TYPES ***
 exec bpa.alter_policies('INS_ATTR_TYPES');


COMMENT ON TABLE BARS.INS_ATTR_TYPES IS 'Типи атрибутів';
COMMENT ON COLUMN BARS.INS_ATTR_TYPES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_ATTR_TYPES.NAME IS 'Найменування';




PROMPT *** Create  constraint SYS_C0033266 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ATTR_TYPES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033267 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ATTR_TYPES MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSATTRTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ATTR_TYPES ADD CONSTRAINT PK_INSATTRTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSATTRTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSATTRTYPES ON BARS.INS_ATTR_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_ATTR_TYPES ***
grant SELECT                                                                 on INS_ATTR_TYPES  to BARSREADER_ROLE;
grant SELECT                                                                 on INS_ATTR_TYPES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INS_ATTR_TYPES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_ATTR_TYPES.sql =========*** End **
PROMPT ===================================================================================== 
