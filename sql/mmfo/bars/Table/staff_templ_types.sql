

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_TEMPL_TYPES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_TEMPL_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_TEMPL_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_TEMPL_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_TEMPL_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_TEMPL_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_TEMPL_TYPES 
   (	TEMPLTYPE_ID NUMBER(38,0), 
	TEMPLTYPE_NAME VARCHAR2(100), 
	PARENT_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_TEMPL_TYPES ***
 exec bpa.alter_policies('STAFF_TEMPL_TYPES');


COMMENT ON TABLE BARS.STAFF_TEMPL_TYPES IS 'Типы шаблонов пользователей';
COMMENT ON COLUMN BARS.STAFF_TEMPL_TYPES.TEMPLTYPE_ID IS 'Ид. типа шаблона';
COMMENT ON COLUMN BARS.STAFF_TEMPL_TYPES.TEMPLTYPE_NAME IS 'Наименование типа шаблона';
COMMENT ON COLUMN BARS.STAFF_TEMPL_TYPES.PARENT_ID IS 'Ид. родительского типа шаблона';




PROMPT *** Create  constraint PK_TEMPLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPL_TYPES ADD CONSTRAINT PK_TEMPLTYPES PRIMARY KEY (TEMPLTYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TEMPLTYPES_TEMPLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPL_TYPES ADD CONSTRAINT FK_TEMPLTYPES_TEMPLTYPES FOREIGN KEY (PARENT_ID)
	  REFERENCES BARS.STAFF_TEMPL_TYPES (TEMPLTYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TEMPLTYPES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPL_TYPES MODIFY (TEMPLTYPE_ID CONSTRAINT CC_TEMPLTYPES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TEMPLTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPL_TYPES MODIFY (TEMPLTYPE_NAME CONSTRAINT CC_TEMPLTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TEMPLTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TEMPLTYPES ON BARS.STAFF_TEMPL_TYPES (TEMPLTYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_TEMPL_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_TEMPL_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_TEMPL_TYPES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_TEMPL_TYPES to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_TEMPL_TYPES.sql =========*** End
PROMPT ===================================================================================== 
