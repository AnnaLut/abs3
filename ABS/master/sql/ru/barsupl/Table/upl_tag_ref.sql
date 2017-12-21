PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_TAG_REF.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_TAG_REF ***
begin
  --execute immediate 'ALTER TABLE BARSUPL.UPL_TAG_REF DROP PRIMARY KEY CASCADE';
  --execute immediate 'DROP TABLE BARSUPL.UPL_TAG_REF CASCADE CONSTRAINTS';

  execute immediate '
  CREATE TABLE BARSUPL.UPL_TAG_REF
  ( REF_ID        NUMBER(5),
    FILE_ID       NUMBER,
    DESCRIPTION   VARCHAR2(255)
  )
 SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING TABLESPACE BRSUPLD ';
exception when others then
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Create  index PK_UPLTAGREF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLTAGREF ON BARSUPL.UPL_TAG_REF (REF_ID)
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_UPLTAGREF ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_TAG_REF   ADD CONSTRAINT PK_UPLTAGREF PRIMARY KEY (REF_ID)
  USING INDEX BARSUPL.PK_UPLTAGREF ENABLE VALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

COMMENT ON TABLE  BARSUPL.UPL_TAG_REF IS 'Справочники к значениям тегов';
COMMENT ON COLUMN BARSUPL.UPL_TAG_REF.REF_ID IS 'ID справочника';
COMMENT ON COLUMN BARSUPL.UPL_TAG_REF.FILE_ID IS 'ID файла выгрузки справочника';
COMMENT ON COLUMN BARSUPL.UPL_TAG_REF.DESCRIPTION IS 'Описание';


PROMPT *** Create  grants  UPL_TAG_REF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_TAG_REF   to BARS;
grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_TAG_REF   to UPLD;
--grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_TAG_REF   to BARS_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_TAG_REF.sql =========*** End 
PROMPT ===================================================================================== 

