

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_TEMPLATES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_TEMPLATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_TEMPLATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_TEMPLATES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_TEMPLATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_TEMPLATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_TEMPLATES 
   (	TEMPLATE_ID VARCHAR2(35), 
	DOCEXP_TYPE_ID VARCHAR2(100) DEFAULT ''PDF''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_TEMPLATES ***
 exec bpa.alter_policies('WCS_TEMPLATES');


COMMENT ON TABLE BARS.WCS_TEMPLATES IS 'Шаблоны';
COMMENT ON COLUMN BARS.WCS_TEMPLATES.TEMPLATE_ID IS 'Идентификатор шаблона';
COMMENT ON COLUMN BARS.WCS_TEMPLATES.DOCEXP_TYPE_ID IS 'Формат экспорта печатного шаблона';




PROMPT *** Create  constraint PK_WCSTEMPLATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_TEMPLATES ADD CONSTRAINT PK_WCSTEMPLATES PRIMARY KEY (TEMPLATE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSTMPS_TID_DOCSCHM_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_TEMPLATES ADD CONSTRAINT FK_WCSTMPS_TID_DOCSCHM_ID FOREIGN KEY (TEMPLATE_ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSTMPS_DETID_DOCEXPTPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_TEMPLATES ADD CONSTRAINT FK_WCSTMPS_DETID_DOCEXPTPS_ID FOREIGN KEY (DOCEXP_TYPE_ID)
	  REFERENCES BARS.WCS_DOCEXPORT_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSTEMPLATES_DETID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_TEMPLATES MODIFY (DOCEXP_TYPE_ID CONSTRAINT CC_WCSTEMPLATES_DETID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSTEMPLATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSTEMPLATES ON BARS.WCS_TEMPLATES (TEMPLATE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_TEMPLATES ***
grant SELECT                                                                 on WCS_TEMPLATES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_TEMPLATES   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_TEMPLATES.sql =========*** End ***
PROMPT ===================================================================================== 
