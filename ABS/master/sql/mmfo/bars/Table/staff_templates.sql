

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_TEMPLATES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_TEMPLATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_TEMPLATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_TEMPLATES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_TEMPLATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_TEMPLATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_TEMPLATES 
   (	TEMPL_ID NUMBER(38,0), 
	TEMPL_NAME VARCHAR2(100), 
	TEMPLTYPE_ID NUMBER(38,0), 
	TEMPL_ISGEN CHAR(1) DEFAULT ''N'', 
	SCHEME_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_TEMPLATES ***
 exec bpa.alter_policies('STAFF_TEMPLATES');


COMMENT ON TABLE BARS.STAFF_TEMPLATES IS 'Шаблоны пользователей';
COMMENT ON COLUMN BARS.STAFF_TEMPLATES.TEMPL_ID IS 'Ид. шаблона пользователя';
COMMENT ON COLUMN BARS.STAFF_TEMPLATES.TEMPL_NAME IS 'Наименование шаблона пользователя';
COMMENT ON COLUMN BARS.STAFF_TEMPLATES.TEMPLTYPE_ID IS 'Ид. типа шаблона пользователя';
COMMENT ON COLUMN BARS.STAFF_TEMPLATES.TEMPL_ISGEN IS 'Признак автоматически созданного шаблона';
COMMENT ON COLUMN BARS.STAFF_TEMPLATES.SCHEME_ID IS 'Ид. общей схемы';




PROMPT *** Create  constraint CC_STAFFTEMPL_ISGEN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPLATES ADD CONSTRAINT CC_STAFFTEMPL_ISGEN CHECK (templ_isgen in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STAFFTEMPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPLATES ADD CONSTRAINT PK_STAFFTEMPL PRIMARY KEY (TEMPL_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTEMPL_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPLATES MODIFY (TEMPL_ID CONSTRAINT CC_STAFFTEMPL_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTEMPL_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPLATES MODIFY (TEMPL_NAME CONSTRAINT CC_STAFFTEMPL_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTEMPL_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPLATES MODIFY (TEMPLTYPE_ID CONSTRAINT CC_STAFFTEMPL_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTEMPL_ISGEN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPLATES MODIFY (TEMPL_ISGEN CONSTRAINT CC_STAFFTEMPL_ISGEN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTEMPL_SCHEMEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPLATES MODIFY (SCHEME_ID CONSTRAINT CC_STAFFTEMPL_SCHEMEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFTEMPL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFTEMPL ON BARS.STAFF_TEMPLATES (TEMPL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_TEMPLATES ***
grant SELECT                                                                 on STAFF_TEMPLATES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_TEMPLATES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_TEMPLATES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_TEMPLATES to START1;
grant SELECT                                                                 on STAFF_TEMPLATES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_TEMPLATES.sql =========*** End *
PROMPT ===================================================================================== 
