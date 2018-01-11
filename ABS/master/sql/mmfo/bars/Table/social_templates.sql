

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SOCIAL_TEMPLATES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SOCIAL_TEMPLATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SOCIAL_TEMPLATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_TEMPLATES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_TEMPLATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SOCIAL_TEMPLATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SOCIAL_TEMPLATES 
   (	TYPE_ID NUMBER(38,0), 
	TEMPLATE_ID VARCHAR2(35), 
	FLAG_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SOCIAL_TEMPLATES ***
 exec bpa.alter_policies('SOCIAL_TEMPLATES');


COMMENT ON TABLE BARS.SOCIAL_TEMPLATES IS 'Шаблоны договоров для пенсионеров и безработных';
COMMENT ON COLUMN BARS.SOCIAL_TEMPLATES.TYPE_ID IS 'Тип договора';
COMMENT ON COLUMN BARS.SOCIAL_TEMPLATES.TEMPLATE_ID IS 'Название шаблона';
COMMENT ON COLUMN BARS.SOCIAL_TEMPLATES.FLAG_ID IS 'Флаг шаблона';




PROMPT *** Create  constraint PK_SOCTEMPLATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TEMPLATES ADD CONSTRAINT PK_SOCTEMPLATES PRIMARY KEY (TYPE_ID, TEMPLATE_ID, FLAG_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCTEMPLATES_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TEMPLATES MODIFY (TYPE_ID CONSTRAINT CC_SOCTEMPLATES_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCTEMPLATES_TEMPLATEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TEMPLATES MODIFY (TEMPLATE_ID CONSTRAINT CC_SOCTEMPLATES_TEMPLATEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCTEMPLATES_FLAGID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_TEMPLATES MODIFY (FLAG_ID CONSTRAINT CC_SOCTEMPLATES_FLAGID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOCTEMPLATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOCTEMPLATES ON BARS.SOCIAL_TEMPLATES (TYPE_ID, TEMPLATE_ID, FLAG_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SOCIAL_TEMPLATES ***
grant SELECT                                                                 on SOCIAL_TEMPLATES to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_TEMPLATES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SOCIAL_TEMPLATES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SOCIAL_TEMPLATES to DPT_ADMIN;
grant SELECT                                                                 on SOCIAL_TEMPLATES to DPT_ROLE;
grant SELECT                                                                 on SOCIAL_TEMPLATES to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_TEMPLATES to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SOCIAL_TEMPLATES to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SOCIAL_TEMPLATES.sql =========*** End 
PROMPT ===================================================================================== 
