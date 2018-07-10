

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_FILE_PARAM_VALUES.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_FILE_PARAM_VALUES ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_FILE_PARAM_VALUES
   (FILE_ID NUMBER, 
	PARAM VARCHAR2(20), 
	VALUE VARCHAR2(500)
   )
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

COMMENT ON TABLE  BARSUPL.UPL_FILE_PARAM_VALUES          IS 'Доп. параметры файлов выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_FILE_PARAM_VALUES.FILE_ID  IS 'ID файла выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_FILE_PARAM_VALUES.PARAM    IS 'Параметр';
COMMENT ON COLUMN BARSUPL.UPL_FILE_PARAM_VALUES.VALUE    IS 'Значение параметра';


PROMPT *** Create  constraint PK_UPLFILEPARAMVALUES ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILE_PARAM_VALUES ADD CONSTRAINT PK_UPLFILEPARAMVALUES PRIMARY KEY (FILE_ID, PARAM)
  USING INDEX COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_UPLFILEPARAMVALUES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLFILEPARAMVALUES ON BARSUPL.UPL_FILE_PARAM_VALUES (FILE_ID, PARAM) 
  COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint FK_FPARVALUE_FPARAM ***
begin   
 execute immediate '
ALTER TABLE BARSUPL.UPL_FILE_PARAM_VALUES ADD (
  CONSTRAINT FK_FPARVALUE_FPARAM
  FOREIGN KEY (PARAM) 
  REFERENCES BARSUPL.UPL_FILE_PARAM (PARAM)
  ENABLE VALIDATE)';
exception when others then
  if  sqlcode=-955 or sqlcode=-2264 or sqlcode=-2275 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint FK_FPARVALUE_FILES ***
begin   
 execute immediate '
ALTER TABLE BARSUPL.UPL_FILE_PARAM_VALUES ADD (
  CONSTRAINT FK_FPARVALUE_FILES
  FOREIGN KEY (FILE_ID) 
  REFERENCES BARSUPL.UPL_FILES (FILE_ID)
  ENABLE VALIDATE)';
exception when others then
  if  sqlcode=-955 or sqlcode=-2264 or sqlcode=-2275 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  UPL_FILE_PARAM_VALUES ***
grant SELECT                           on UPL_FILE_PARAM_VALUES to BARS;
grant SELECT                           on UPL_FILE_PARAM_VALUES to BARS_ACCESS_USER;
grant SELECT                           on UPL_FILE_PARAM_VALUES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE      on UPL_FILE_PARAM_VALUES to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_FILE_PARAM_VALUES.sql ======
PROMPT ===================================================================================== 
