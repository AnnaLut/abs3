
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_OBJECT_LISTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_OBJECT_LISTS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_OBJECT_LISTS
  ( TYPE_ID         NUMBER             CONSTRAINT UPL_OBJLST_TYPEID_NN NOT NULL,
    TYPE_CODE       VARCHAR2(30 CHAR),
    TYPE_NAME       VARCHAR2(300 CHAR) CONSTRAINT UPL_OBJLST_NAME_NN NOT NULL,
    IS_ACTIVE       CHAR(1 CHAR)       DEFAULT ''Y'' CONSTRAINT UPL_OBJLST_ACTIVE_NN NOT NULL)
  TABLESPACE BRSUPLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** Create  index PK_UPL_OBJECT_LISTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPL_OBJECT_LISTS ON BARSUPL.UPL_OBJECT_LISTS (TYPE_CODE)
  COMPUTE STATISTICS
  TABLESPACE BRSUPLD';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_UPL_OBJECT_LISTS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_OBJECT_LISTS ADD CONSTRAINT PK_UPL_OBJECT_LISTS PRIMARY KEY (TYPE_CODE)
  USING INDEX PK_UPL_OBJECT_LISTS ENABLE VALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


COMMENT ON TABLE BARSUPL.UPL_OBJECT_LISTS IS 'Типи об''єктів АБС. (OBJECT_TYPE)';
COMMENT ON COLUMN BARSUPL.UPL_OBJECT_LISTS.TYPE_ID IS 'Тип договору ХД (по файлу вивантаження ARR_TYPES)';
COMMENT ON COLUMN BARSUPL.UPL_OBJECT_LISTS.TYPE_CODE IS 'Текстовый код объекта (OBJECT_TYPE.TYPE_CODE)';
COMMENT ON COLUMN BARSUPL.UPL_OBJECT_LISTS.TYPE_NAME IS 'Описание объекта (OBJECT_TYPE.TYPE_NAME)';
COMMENT ON COLUMN BARSUPL.UPL_OBJECT_LISTS.IS_ACTIVE IS '"Y" - используется для выгрузки';

PROMPT *** Create  grants  UPL_OBJECT_LISTS ***
grant SELECT                             on BARSUPL.UPL_OBJECT_LISTS   to BARS;
grant DELETE,INSERT,SELECT,UPDATE        on BARSUPL.UPL_OBJECT_LISTS   to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_OBJECT_LISTS.sql =========*** End 
PROMPT ===================================================================================== 
