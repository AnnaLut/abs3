

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/UPL_SOURCES.sql =========*** Run *
PROMPT ===================================================================================== 

PROMPT *** Create  table UPL_SOURCES ***
begin 
  execute immediate '
CREATE TABLE BARSUPL.UPL_SOURCES
( OWNER          VARCHAR2(30 BYTE)  CONSTRAINT UPL_SSO_OWNER_NN         NOT NULL,
  OBJECT_NAME    VARCHAR2(30 BYTE)  CONSTRAINT UPL_SSO_OBJECT_NAME_NN   NOT NULL,
  OBJECT_TYPE    VARCHAR2(19 BYTE)  CONSTRAINT UPL_SSO_OBJECT_TYPE_NN   NOT NULL,
  USED_IN_UPOAD  VARCHAR2(1 BYTE)   CONSTRAINT UPL_SSO_USED_IN_UPOAD_NN NOT NULL,
  CHECKED        VARCHAR2(1 BYTE)   CONSTRAINT UPL_SSO_CHECKED_NN       NOT NULL
) TABLESPACE BRSUPLD';

exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end;
/

COMMENT ON TABLE  BARSUPL.UPL_SOURCES IS 'Перечеь объектов для контроля изменений структуры';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES.OWNER IS 'Схема объекта';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES.OBJECT_NAME IS 'Имя объекта';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES.OBJECT_TYPE IS 'Тип объекта';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES.USED_IN_UPOAD IS 'Используется в выгрузке Y/N';
COMMENT ON COLUMN BARSUPL.UPL_SOURCES.CHECKED IS 'Контролировать структуру Y/N';

PROMPT *** Create  index  PK_UPL_SOURCES***
begin   
 execute immediate 'CREATE UNIQUE INDEX BARSUPL.PK_UPL_SOURCES ON BARSUPL.UPL_SOURCES (OWNER, OBJECT_NAME) TABLESPACE BRSUPLD';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_UPL_SOURCES ***
begin   
 execute immediate '
ALTER TABLE BARSUPL.UPL_SOURCES ADD (
  CONSTRAINT PK_UPL_SOURCES PRIMARY KEY (OWNER, OBJECT_NAME) USING INDEX BARSUPL.PK_UPL_SOURCES ENABLE VALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  grants   ***
grant SELECT                                                                 on UPL_SOURCES to BARSUPL;
grant SELECT                                                                 on UPL_SOURCES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on UPL_SOURCES to START1;
grant SELECT                                                                 on UPL_SOURCES to BARS_DM;
grant SELECT                                                                 on UPL_SOURCES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/UPL_SOURCES.sql =========*** End *
PROMPT ===================================================================================== 
  