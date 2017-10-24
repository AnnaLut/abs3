

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/DOC_IMPORT_PROPS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  table DOC_IMPORT_PROPS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.DOC_IMPORT_PROPS 
   (	EXT_REF VARCHAR2(40), 
	TAG CHAR(5), 
	VALUE VARCHAR2(220)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.DOC_IMPORT_PROPS IS 'Дополнительные реквизиты импортируемых документов';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT_PROPS.EXT_REF IS 'External reference';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT_PROPS.TAG IS 'Тег реквизита (наименования тегов см. V_OP_FIELD)';
COMMENT ON COLUMN BARSAQ.DOC_IMPORT_PROPS.VALUE IS 'Значение реквизита';




PROMPT *** Create  constraint PK_DOCIMPORTPROPS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT_PROPS ADD CONSTRAINT PK_DOCIMPORTPROPS PRIMARY KEY (EXT_REF, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DOCIMPPROPS_DOCIMP ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT_PROPS ADD CONSTRAINT FK_DOCIMPPROPS_DOCIMP FOREIGN KEY (EXT_REF)
	  REFERENCES BARSAQ.DOC_IMPORT (EXT_REF) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DOCIMPPROPS_OPFILED ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT_PROPS ADD CONSTRAINT FK_DOCIMPPROPS_OPFILED FOREIGN KEY (TAG)
	  REFERENCES BARS.OP_FIELD (TAG) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORTPROPS_EXTREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT_PROPS MODIFY (EXT_REF CONSTRAINT CC_DOCIMPORTPROPS_EXTREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORTPROPS_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT_PROPS MODIFY (TAG CONSTRAINT CC_DOCIMPORTPROPS_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DOCIMPORTPROPS_VALUE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.DOC_IMPORT_PROPS MODIFY (VALUE CONSTRAINT CC_DOCIMPORTPROPS_VALUE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOCIMPORTPROPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_DOCIMPORTPROPS ON BARSAQ.DOC_IMPORT_PROPS (EXT_REF, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_IMPORT_PROPS ***
grant INSERT,SELECT                                                          on DOC_IMPORT_PROPS to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/DOC_IMPORT_PROPS.sql =========*** En
PROMPT ===================================================================================== 
