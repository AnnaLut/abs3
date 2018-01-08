

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_TAG_TABLES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_TAG_TABLES ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_TAG_TABLES 
   (	TAG_TABLE VARCHAR2(20), 
	DESCRIPT VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_TAG_TABLES IS '';
COMMENT ON COLUMN BARSUPL.UPL_TAG_TABLES.TAG_TABLE IS '';
COMMENT ON COLUMN BARSUPL.UPL_TAG_TABLES.DESCRIPT IS '';




PROMPT *** Create  constraint PK_UPLTAGLISTTABLES ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_TAG_TABLES ADD CONSTRAINT PK_UPLTAGLISTTABLES PRIMARY KEY (TAG_TABLE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLTAGLISTTABLES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLTAGLISTTABLES ON BARSUPL.UPL_TAG_TABLES (TAG_TABLE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_TAG_TABLES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_TAG_TABLES  to BARS;
grant SELECT                                                                 on UPL_TAG_TABLES  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on UPL_TAG_TABLES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_TAG_TABLES.sql =========*** End
PROMPT ===================================================================================== 
