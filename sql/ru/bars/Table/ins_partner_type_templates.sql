

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_TEMPLATES.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_PARTNER_TYPE_TEMPLATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_PARTNER_TYPE_TEMPLATES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_PARTNER_TYPE_TEMPLATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_PARTNER_TYPE_TEMPLATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_PARTNER_TYPE_TEMPLATES 
   (	ID NUMBER, 
	TEMPLATE_ID VARCHAR2(100), 
	PARTNER_ID NUMBER, 
	TYPE_ID NUMBER, 
	PRT_FORMAT VARCHAR2(1) DEFAULT ''P''
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_PARTNER_TYPE_TEMPLATES ***
 exec bpa.alter_policies('INS_PARTNER_TYPE_TEMPLATES');


COMMENT ON TABLE BARS.INS_PARTNER_TYPE_TEMPLATES IS 'Шаблони СК та типів СД';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_TEMPLATES.TYPE_ID IS 'Ідентифікатор типу страхового договору';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_TEMPLATES.PRT_FORMAT IS 'Формат друку (P - PDF, W - word, E - excel)';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_TEMPLATES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_TEMPLATES.TEMPLATE_ID IS 'Код шаблону';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_TEMPLATES.PARTNER_ID IS 'Ідентифікатор СК';




PROMPT *** Create  constraint FK_PTNTYPETPLS_TID_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_TEMPLATES ADD CONSTRAINT FK_PTNTYPETPLS_TID_TYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.INS_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPETPLS_PID_PARTNERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_TEMPLATES ADD CONSTRAINT FK_PTNTYPETPLS_PID_PARTNERS FOREIGN KEY (PARTNER_ID)
	  REFERENCES BARS.INS_PARTNERS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPETPLS_AID_ATTRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_TEMPLATES ADD CONSTRAINT FK_PTNTYPETPLS_AID_ATTRS FOREIGN KEY (TEMPLATE_ID)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPETPLS_PFRMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_TEMPLATES ADD CONSTRAINT CC_PTNTYPETPLS_PFRMT CHECK (prt_format in (''P'', ''W'', ''E'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_PTNTYPETPLS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_TEMPLATES ADD CONSTRAINT UK_PTNTYPETPLS UNIQUE (TEMPLATE_ID, PARTNER_ID, TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PTNTYPETPLS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_TEMPLATES ADD CONSTRAINT PK_PTNTYPETPLS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPETPLS_PFRMT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_TEMPLATES MODIFY (PRT_FORMAT CONSTRAINT CC_PTNTYPETPLS_PFRMT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPETPLS_BRH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_TEMPLATES MODIFY (TEMPLATE_ID CONSTRAINT CC_PTNTYPETPLS_BRH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003101278 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_TEMPLATES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PTNTYPETPLS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PTNTYPETPLS ON BARS.INS_PARTNER_TYPE_TEMPLATES (TEMPLATE_ID, PARTNER_ID, TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PTNTYPETPLS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PTNTYPETPLS ON BARS.INS_PARTNER_TYPE_TEMPLATES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_TEMPLATES.sql =======
PROMPT ===================================================================================== 
