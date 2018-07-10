

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_FILE_PARAM.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_FILE_PARAM ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_FILE_PARAM 
   (PARAM VARCHAR2(20),
	DEFVAL VARCHAR2(500),
	DESCRIPT VARCHAR2(200)
   )
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end;
/

COMMENT ON TABLE BARSUPL.UPL_FILE_PARAM           IS 'Справочник доп. параметров файлов выгрузки';
COMMENT ON COLUMN BARSUPL.UPL_FILE_PARAM.PARAM    IS 'Наименование параметра';
COMMENT ON COLUMN BARSUPL.UPL_FILE_PARAM.DEFVAL   IS 'Значение по умолчанию';
COMMENT ON COLUMN BARSUPL.UPL_FILE_PARAM.DESCRIPT IS 'Описание параметра';


PROMPT *** Create  constraint PK_UPLFILEPARAM ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_FILE_PARAM ADD CONSTRAINT PK_UPLFILEPARAM PRIMARY KEY (PARAM)
  USING INDEX COMPUTE STATISTICS
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLFILEPARAM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLFILEPARAM ON BARSUPL.UPL_FILE_PARAM (PARAM) 
  COMPUTE STATISTICS 
  TABLESPACE BRSUPLD';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_FILE_PARAM ***
grant SELECT                           on UPL_FILE_PARAM to BARS;
grant SELECT                           on UPL_FILE_PARAM to BARS_ACCESS_USER;
grant SELECT                           on UPL_FILE_PARAM to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE      on UPL_FILE_PARAM to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_FILE_PARAM.sql =========***
PROMPT ===================================================================================== 
