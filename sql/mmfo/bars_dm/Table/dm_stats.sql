

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/DM_STATS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table DM_STATS ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.DM_STATS 
   (	ID NUMBER, 
	ID_SESSION NUMBER, 
	OBJ VARCHAR2(30), 
	START_TIME DATE, 
	STOP_TIME DATE, 
	PER_ID NUMBER, 
	ROWS_OK NUMBER, 
	ROWS_ERR NUMBER, 
	STATUS VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.DM_STATS IS '';
COMMENT ON COLUMN BARS_DM.DM_STATS.ID IS '';
COMMENT ON COLUMN BARS_DM.DM_STATS.ID_SESSION IS '';
COMMENT ON COLUMN BARS_DM.DM_STATS.OBJ IS '';
COMMENT ON COLUMN BARS_DM.DM_STATS.START_TIME IS '';
COMMENT ON COLUMN BARS_DM.DM_STATS.STOP_TIME IS '';
COMMENT ON COLUMN BARS_DM.DM_STATS.PER_ID IS '';
COMMENT ON COLUMN BARS_DM.DM_STATS.ROWS_OK IS '';
COMMENT ON COLUMN BARS_DM.DM_STATS.ROWS_ERR IS '';
COMMENT ON COLUMN BARS_DM.DM_STATS.STATUS IS '';




PROMPT *** Create  constraint PK_STATS ***
begin   
 execute immediate '
  ALTER TABLE BARS_DM.DM_STATS ADD CONSTRAINT PK_STATS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STATS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS_DM.PK_STATS ON BARS_DM.DM_STATS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DMSTATS_SESSION ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_DMSTATS_SESSION ON BARS_DM.DM_STATS (ID_SESSION) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_DMSTATS_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_DMSTATS_PERID ON BARS_DM.DM_STATS (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DM_STATS ***
grant SELECT                                                                 on DM_STATS        to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/DM_STATS.sql =========*** End *** =
PROMPT ===================================================================================== 
