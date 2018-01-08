

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_TEMPLATES.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_TEMPLATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_TEMPLATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_TEMPLATES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_TEMPLATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_TEMPLATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_TEMPLATES 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	TEMPLATE_ID VARCHAR2(35), 
	PRINT_STATE_ID VARCHAR2(100), 
	IS_SCAN_REQUIRED NUMBER DEFAULT 0, 
	SCAN_QID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_TEMPLATES ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_TEMPLATES');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_TEMPLATES IS 'Шаблоны субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_TEMPLATES.SUBPRODUCT_ID IS 'Идентификатор субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_TEMPLATES.TEMPLATE_ID IS 'Идентификатор шаблона';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_TEMPLATES.PRINT_STATE_ID IS 'Идентификатор этапа печати';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_TEMPLATES.IS_SCAN_REQUIRED IS 'Обязательно ли сканирование отпечатаного шаблона';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_TEMPLATES.SCAN_QID IS 'Идентификатор вопроса-сканкопии печатного документа';




PROMPT *** Create  constraint PK_SBPTMPLS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_TEMPLATES ADD CONSTRAINT PK_SBPTMPLS PRIMARY KEY (SUBPRODUCT_ID, TEMPLATE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SBPTMPLS_ISSCANREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_TEMPLATES ADD CONSTRAINT CC_SBPTMPLS_ISSCANREQ CHECK (is_scan_required in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPTMPLS_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_TEMPLATES ADD CONSTRAINT FK_SBPTMPLS_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPTMPLS_TID_TMPLS_TID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_TEMPLATES ADD CONSTRAINT FK_SBPTMPLS_TID_TMPLS_TID FOREIGN KEY (TEMPLATE_ID)
	  REFERENCES BARS.WCS_TEMPLATES (TEMPLATE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPTMPLS_PSID_PRNSTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_TEMPLATES ADD CONSTRAINT FK_SBPTMPLS_PSID_PRNSTS_ID FOREIGN KEY (PRINT_STATE_ID)
	  REFERENCES BARS.WCS_PRINT_STATES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPTMPLS_SQID_QUESTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_TEMPLATES ADD CONSTRAINT FK_SBPTMPLS_SQID_QUESTS_ID FOREIGN KEY (SCAN_QID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SBPTMPLS_SQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_TEMPLATES MODIFY (SCAN_QID CONSTRAINT CC_SBPTMPLS_SQID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SBPTMPLS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SBPTMPLS ON BARS.WCS_SUBPRODUCT_TEMPLATES (SUBPRODUCT_ID, TEMPLATE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_TEMPLATES ***
grant SELECT                                                                 on WCS_SUBPRODUCT_TEMPLATES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_TEMPLATES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_TEMPLATES.sql =========
PROMPT ===================================================================================== 
