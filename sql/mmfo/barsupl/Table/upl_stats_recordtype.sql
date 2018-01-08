

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_STATS_RECORDTYPE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_STATS_RECORDTYPE ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_STATS_RECORDTYPE 
   (	REC_TYPE VARCHAR2(10), 
	REC_NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_STATS_RECORDTYPE IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS_RECORDTYPE.REC_TYPE IS '';
COMMENT ON COLUMN BARSUPL.UPL_STATS_RECORDTYPE.REC_NAME IS '';




PROMPT *** Create  constraint PK_UPLSTATSRECORDTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_STATS_RECORDTYPE ADD CONSTRAINT PK_UPLSTATSRECORDTYPE PRIMARY KEY (REC_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLSTATSRECORDTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLSTATSRECORDTYPE ON BARSUPL.UPL_STATS_RECORDTYPE (REC_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_STATS_RECORDTYPE.sql =========*
PROMPT ===================================================================================== 
