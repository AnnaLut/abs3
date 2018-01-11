

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/TMP_DOC_IMPORT_PROPS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_DOC_IMPORT_PROPS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSAQ.TMP_DOC_IMPORT_PROPS 
   (	EXT_REF VARCHAR2(40), 
	TAG CHAR(5), 
	VALUE VARCHAR2(200)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.TMP_DOC_IMPORT_PROPS IS 'Дополнительные реквизиты импортируемых документов';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT_PROPS.EXT_REF IS 'External reference';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT_PROPS.TAG IS 'Тег реквизита (наименования тегов см. V_OP_FIELD)';
COMMENT ON COLUMN BARSAQ.TMP_DOC_IMPORT_PROPS.VALUE IS 'Значение реквизита';




PROMPT *** Create  constraint PK_TMPDOCIMPORTPROPS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT_PROPS ADD CONSTRAINT PK_TMPDOCIMPORTPROPS PRIMARY KEY (EXT_REF, TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORTPROPS_EXTREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT_PROPS MODIFY (EXT_REF CONSTRAINT CC_TMPDOCIMPORTPROPS_EXTREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORTPROPS_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT_PROPS MODIFY (TAG CONSTRAINT CC_TMPDOCIMPORTPROPS_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDOCIMPORTPROPS_VALUE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.TMP_DOC_IMPORT_PROPS MODIFY (VALUE CONSTRAINT CC_TMPDOCIMPORTPROPS_VALUE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPDOCIMPORTPROPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_TMPDOCIMPORTPROPS ON BARSAQ.TMP_DOC_IMPORT_PROPS (EXT_REF, TAG) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DOC_IMPORT_PROPS ***
grant SELECT                                                                 on TMP_DOC_IMPORT_PROPS to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_DOC_IMPORT_PROPS to REFSYNC_USR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/TMP_DOC_IMPORT_PROPS.sql =========**
PROMPT ===================================================================================== 
