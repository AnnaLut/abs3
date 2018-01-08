

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_COL_TYPES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_COL_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_COL_TYPES 
   (	TYPE_CODE VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_COL_TYPES IS '';
COMMENT ON COLUMN BARSUPL.UPL_COL_TYPES.TYPE_CODE IS '';




PROMPT *** Create  constraint PK_UPLCOLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_COL_TYPES ADD CONSTRAINT PK_UPLCOLTYPES PRIMARY KEY (TYPE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLCOLTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLCOLTYPES ON BARSUPL.UPL_COL_TYPES (TYPE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_COL_TYPES ***
grant SELECT                                                                 on UPL_COL_TYPES   to BARSREADER_ROLE;
grant SELECT                                                                 on UPL_COL_TYPES   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_COL_TYPES.sql =========*** End 
PROMPT ===================================================================================== 
